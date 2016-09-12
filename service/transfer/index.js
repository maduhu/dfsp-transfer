// var error = require('./error')
var path = require('path')
module.exports = {
  schema: [{
    path: path.join(__dirname, 'schema'),
    linkSP: true
  }],
  'push.execute': function (params, $meta) {
    return {
      fulfillment: 'tx-mock'
    }
  }
}
