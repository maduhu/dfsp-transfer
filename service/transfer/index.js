// var error = require('./error')
var path = require('path')
var Ws = require('ws')

module.exports = {
  schema: [{
    path: path.join(__dirname, 'schema'),
    linkSP: true
  }],
  'push.execute': function (msg, $meta) {
    return new Promise((resolve, reject) => {
      var socket = new Ws(msg.sourceAccount.replace(/^https?:\/\//, 'ws://') + '/transfers')
      var timeout = setTimeout(() => {
        socket && socket.terminate()
        resolve(msg)
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
  }
}
