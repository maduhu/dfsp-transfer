// var error = require('./error')
var path = require('path')
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
    return this.bus.importMethod('spsp/transfer.transfer.hold')({
      receiver: msg.destinationAccount,
      destinationAmount: msg.destinationAmount,
      sourceIdentifier: msg.sourceAccount || '001'
    }, $meta)
      .then((setupResult) => {
        return this.bus.importMethod('spsp/transfer.transfer.execute')(setupResult, $meta)
          .then((executeResult) => {
            return executeResult
          })
      })
  }
}
