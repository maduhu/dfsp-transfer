// var error = require('./error')
var path = require('path')
module.exports = {
  schema: [{
    path: path.join(__dirname, 'schema'),
    linkSP: true
  }],
  'batch.process': function (msg, $meta) {
    var count = 0
    var pageNumber = 1
    var get = () => {
      return this.bus.importMethod('bulk.payment.fetch')({
        pageSize: 100,
        batchId: msg.batchId,
        actorId: msg.actorId,
        pageNumber: pageNumber++
      })
      .then((payments) => {
        if (!payments.length) {
          return count
        }
        return this.bus.importMethod('queue.queue.add')({
          actorId: msg.actorId,
          recordId: payments.map(payment => payment.paymentId)
        })
        .then((inserted) => {
          count += inserted
          return get()
        })
      })
    }
    return new Promise((resolve, reject) => {
      return get()
      .then(count => {
        return resolve(count)
      })
    })
  },
  'payment.getForProcessing': function (msg) {
    return this.bus.importMethod('queue.queue.fetch')({
      count: 100
    })
  },
  // actorId, paymentId
  'payment.preProcess': function (msg) {
    return this.bus.importMethod('bulk.payment.fetch')({
      paymentId: [msg.paymentId]
    })
    .then((payment) => {
      return this.bus.importMethod('queue.queue.update')({
        recordId: payment[0].paymentId
      })
      .then(() => payment)
    })
  },
  'payment.process': function (msg) { // actorId, paymentId, paymentStatusId, error
    return this.bus.importMethod('bulk.payment.edit')({
      actorId: msg.actorId,
      payments: [{
        paymentId: msg.paymentId,
        paymentStatusId: msg.paymentStatusId,
        info: msg.error
      }]
    })
    .then(() => {
      if (!msg.error) {
        return this.bus.importMethod('queue.queue.remove')({
          recordId: msg.paymentId
        })
      }
    })
  }
}
