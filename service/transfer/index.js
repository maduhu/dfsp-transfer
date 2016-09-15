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
            // SPSP fee is (resultRemote.sourceAmount - msg.amount)
            return resultLocal
          })
      })
  },
  'push.execute': function (msg, $meta) {
    return {
      fulfillment: 'tx-mock'
    }
  }
}
