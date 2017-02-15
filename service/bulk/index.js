// var error = require('./error')
var path = require('path')
module.exports = {
  schema: [{
    path: path.join(__dirname, 'schema'),
    linkSP: true
  }],
  'x': function (msg) {
    return [{
      paymentId: '1',
      queueId: 1
    }, {
      paymentId: '2',
      queueId: 1
    }, {
      paymentId: '3',
      queueId: 1
    }]
  },
  'y': function (msg) {
    return msg
  }
}
