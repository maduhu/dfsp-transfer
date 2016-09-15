var errors = require('./errors')

module.exports = {
  id: 'ist',
  createPort: require('ut-port-http'),
  url: 'http://ec2-52-37-54-209.us-west-2.compute.amazonaws.com:8081/spsp-client/v1',
  namespace: ['ist/rule', 'interledger'],
  raw: {
    json: true,
    jar: true,
    strictSSL: false
  },
  parseResponse: false,
  requestTimeout: 300000,
  method: 'post',
  'rule.decision.fetch.request.send': function (msg, $meta) {
    var params = {
      httpMethod: 'get',
      qs: {
        receiver: msg.receiver
      }
    }
    if (msg.amount) {
      msg.destinationAmount = msg.amount
    }
    if (msg.sourceAmount) {
      params.uri = '/quoteSourceAmount'
      params.qs.sourceAmount = msg.sourceAmount
    } else if (msg.destinationAmount) {
      params.uri = '/quoteDestinationAmount'
      params.qs.destinationAmount = msg.destinationAmount
    }
    return params
  },
  'rule.decision.fetch.response.receive': function (msg, $meta) {
    return msg.payload
  },
  'rule.decision.fetch.error.receive': function (err, $meta) {
    throw err
  },
  'interledger.transfer.hold.request.send': function (msg, $meta) {
    // /setup
  },
  'interledger.transfer.get.request.send': function (msg, $meta) {
    // /setup
  },
  'interledger.transfer.execute.request.send': function (msg, $meta) {
    // /setup
  },
  'receive': function (msg, $meta) {
    if ($meta.mtid === 'error') {
      return msg
    }
    if (msg && msg.payload) {
      if (msg.payload.result) {
        return msg.payload.result
      } else if (msg.payload.error) {
        throw msg.payload.error
      }
      throw errors.wrongJsonRpcFormat(msg)
    }
    throw errors.generic(msg)
  }
}
