module.exports = require('ut-run')
.run({}, module)
.then(function (app) {
  return app;
  (function pay () {
    app.bus.importMethod('bulk.x')()
      .then(function (payments) {
        var promise = Promise.resolve()
        payments.forEach(function (payment) {
          promise = promise.then(function () {
            return app.bus.importMethod('bulk.y')(payment).catch(function () {})
          })
        })
        return promise
      })
      .then(function () {
        setTimeout(function () {
          pay()
        }, 10000)
      })
  })()
})
