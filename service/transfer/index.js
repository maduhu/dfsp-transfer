// var error = require('./error')
var path = require('path')
var Ws = require('ws')

module.exports = {
  schema: [{
    path: path.join(__dirname, 'schema'),
    linkSP: true
  }],
  'rule.fetch': function (msg, $meta) {
    return this.bus.importMethod('rule.decision.fetch')(msg, $meta)
      .then((resultLocal) => {
        return this.bus.importMethod('spsp/rule.decision.fetch')(msg, $meta)
          .then((resultRemote) => {
            try {
              resultLocal.connectorFee = resultRemote.sourceAmount - msg.amount
            } catch (e) {}
            return resultLocal
          })
      })
  },
  'push.execute': function (msg, $meta) {
    return this.bus.importMethod('spsp/transfer.transfer.setup')({
      receiver: msg.destinationAccount,
      sourceAccount: msg.sourceAccount,
      destinationAmount: msg.destinationAmount,
      memo: '',
      sourceIdentifier: msg.sourceName || ''
    }, $meta)
    .then((setupResult) => {
      return this.bus.importMethod('spsp/transfer.transfer.execute')(setupResult, $meta)
        .then((executeResult) => {
          return new Promise((resolve, reject) => {
            var socket = new Ws(msg.sourceAccount.replace(/^https?:\/\//, 'ws://') + '/transfers')
            var timeout = setTimeout(() => {
              socket && socket.terminate()
              resolve(executeResult)
            }, (this.bus.config.transfer && this.bus.config.transfer.socketTimeout) || 2222)
            socket.on('error', (err) => {
              if (err.code === 'ECONNREFUSED') {
                // do nothing for now
              }
            })
            socket.on('message', (data, flags) => {
              clearTimeout(timeout)
              socket.terminate()
              resolve(data)
            })
          })
        })
    })
  },
  'invoiceNotification.add.request.send': function (msg, $meta) {
    msg.userNumber = msg.senderIdentifier
    return msg
  },
  'invoice.add.request.send': function (msg, $meta) {
    $meta.submissionUrl = msg.submissionUrl
    return msg
  },
  'invoice.add.response.receive': function (msg, $meta) {
    // {
    // account:"http://localhost:8014/ledger/accounts/kkk"
    // amount:"32"
    // currencyCode:"USD"
    // currencySymbol:"$"
    // invoiceId:34
    // invoiceInfo:"Invoice from kkk for 32 USD"
    // name:"kkk"
    // status:"pending"
    // userNumber:"80989354"
    // }
    var params = {
      memo: 'Invoice from ' + msg.name + ' for ' + msg.amount + ' ' + msg.currencyCode,
      senderIdentifier: msg.userNumber,
      submissionUrl: $meta.submissionUrl + '/receivers/invoices'
    }
    if (this.bus.config.spsp && this.bus.config.spsp.url && this.bus.config.spsp.url.startsWith('http://localhost')) {
      $meta.method = 'transfer.invoiceNotification.add'
      params.invoiceUrl = 'http://localhost:8010/receivers/invoices/' + msg.invoiceId
    } else {
      $meta.method = 'spsp/transfer.invoiceNotification.add'
      params.invoiceId = '' + msg.invoiceId
    }
    return this.bus.importMethod($meta.method)(params, $meta)
  }
}
