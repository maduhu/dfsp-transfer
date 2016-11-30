var errors = require('./errors')

module.exports = {
  id: 'spsp',
  createPort: require('ut-port-http'),
  url: 'http://ec2-35-163-231-111.us-west-2.compute.amazonaws.com:8088/spsp/client/v1',
  namespace: ['spsp/rule', 'spsp/transfer'],
  raw: {
    json: true,
    jar: true,
    strictSSL: false
  },
  parseResponse: false,
  requestTimeout: 300000,
  logLevel: 'debug',
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
  'transfer.transfer.setup.request.send': function (msg, $meta) {
    var params = {
      uri: '/setup',
      httpMethod: 'post',
      payload: msg,
      headers: {
        'content-type': 'application/json'
      }
    }
    return params
  },
  'transfer.transfer.setup.response.receive': function (msg, $meta) {
    return msg.payload
  },
  'transfer.transfer.setup.error.receive': function (err, $meta) {
    throw err
  },
  'transfer.transfer.get.request.send': function (msg, $meta) {
    // /setup
  },
  'transfer.transfer.execute.request.send': function (msg, $meta) {
    var params = {
      uri: '/payments/' + msg.id,
      httpMethod: 'put',
      payload: msg,
      headers: {
        'content-type': 'application/json'
      }
    }
    return params
  },
  'transfer.transfer.execute.response.receive': function (msg, $meta) {
    return msg.payload
  },
  'transfer.transfer.execute.error.receive': function (err, $meta) {
    throw err
  },
  'transfer.invoiceNotification.add.request.send': function (msg, $meta) {
    var params = {
      uri: '/invoices',
      httpMethod: 'post',
      payload: msg,
      headers: {
        'content-type': 'application/json'
      }
    }
    return params
  },
  'transfer.invoiceNotification.add.response.receive': function (msg, $meta) {
    return msg.payload
  },
  'transfer.invoiceNotification.add.error.receive': function (err, $meta) {
    throw err
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
