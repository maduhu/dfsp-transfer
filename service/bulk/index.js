// var error = require('./error')
var path = require('path')

module.exports = {
  schema: [{
    path: path.join(__dirname, 'schema'),
    linkSP: true
  }]
}
