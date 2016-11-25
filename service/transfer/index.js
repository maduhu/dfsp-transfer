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
  'invoice.add.response.receive': function (msg, $meta) {
    // {
    //   "invoiceId": 3,
    //   "account": "http://localhost:8014/ledger/accounts/uuu",
    //   "name": "Chris Griffin",
    //   "currencyCode": "USD",
    //   "currencySymbol": "$",
    //   "amount": "123",
    //   "status": "pending",
    //   "userNumber": "qqq",
    //   "invoiceInfo": "Invoice from uuu for 123 USD"
    // }
    $meta.method = 'transfer.invoiceNotification.add'
    return this.bus.importMethod($meta.method)({
      invoiceUrl: 'http://localhost:8010/receivers/invoices/' + msg.invoiceId,
      memo: 'Invoice from ' + msg.name + ' for ' + msg.amount + ' ' + msg.currencyCode,
      userNumber: msg.userNumber
    }, $meta)
    // uncomment code below to integrate with spsp
    // return this.bus.importMethod('spsp/transfer.invoiceNotification.add')({
    //   invoiceId: msg.invoiceId,
    //   memo: 'Invoice from ' + msg.name + ' for ' + msg.amount + ' ' + msg.currencyCode,
    //   senderIdentifier: msg.userNumber
    // }, $meta)
  }
}
