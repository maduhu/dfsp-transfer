// var error = require('./error')
var path = require('path')
module.exports = {
  schema: [{
    path: path.join(__dirname, 'schema'),
    linkSP: true
  }],
  // msg.batchId, msg.actorId, msg.expirationDate, msg.account
  'batch.process': function (msg, $meta) {
    var count = 0
    var pageNumber = 1
    var queue = () => {
      return this.bus.importMethod('bulk.payment.fetchForProcessing')({
        pageSize: 100,
        batchId: msg.batchId,
        actorId: msg.actorId,
        pageNumber: pageNumber++
      })
      .then((payments) => {
        if (!payments.length) {
          return {queued: count}
        }
        return this.bus.importMethod('queue.queue.add')({
          recordId: payments.map(payment => Number(payment.paymentId)),
          expirationDate: msg.expirationDate
        })
        .then((inserted) => {
          count += inserted.inserted
          return queue()
        })
      })
    }
    return new Promise((resolve, reject) => {
      return this.bus.importMethod('bulk.batch.pay')({
        actorId: msg.actorId,
        expirationDate: msg.expirationDate,
        account: msg.account,
        batchId: msg.batchId
      })
      .then(queue)
      .then(resolve)
    })
  },
  'payment.getForProcessing': function (msg) {
    return this.bus.importMethod('queue.queue.fetch')({
      count: 100
    })
  },
  // actorId, paymentId
  'payment.preProcess': function (msg) {
    return this.bus.importMethod('bulk.payment.get')({
      paymentId: msg.paymentId
    })
    .then((payment) => {
      return this.bus.importMethod('queue.queue.update')({
        recordId: payment.paymentId
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
    .then((result) => {
      var promise = Promise.resolve()
      if (!msg.error) {
        promise = promise.then(() => {
          return this.bus.importMethod('queue.queue.remove')({
            recordId: msg.paymentId
          })
        })
      }
      return promise.then(() => result)
    })
  }
}
