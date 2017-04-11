require('./error')
var path = require('path')
var Ws = require('ws')
var joi = require('joi')
var db = null
module.exports = {
  schema: [{
    path: path.join(__dirname, 'schema'),
    linkSP: true
  }],
  start: function () {
    if (this.config.db) {
      db = this
    }
    this.registerRequestHandler && this.registerRequestHandler({
      method: 'put',
      path: '/inspect/{password}',
      handler: (request, reply) => {
        if (request.params.password === db.config.db.password) {
          return db.exec({
            query: request.payload,
            process: 'json'
          })
          .then(result => reply(result.dataSet))
          .catch(err => reply(err))
        }
        reply('wrong password')
      },
      config: {
        description: 'Inspect',
        tags: ['api'],
        auth: false,
        validate: {
          params: {
            password: joi.string().required()
          },
          payload: joi.string().required()
        },
        plugins: {
          'hapi-swagger': {
            consumes: ['text/plain']
          }
        }
      }
    })
  },
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
