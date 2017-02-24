module.exports = {
  ports: [
    require('../db'),
    require('../httpserver'),
    require('../script')
  ],
  modules: {
    identity: require('../service/identity'),
    transfer: require('../service/transfer'),
    bulk: require('../service/bulk'),
    queue: require('../service/queue')
  },
  validations: {
    transfer: require('../service/transfer/api'),
    bulk: require('../service/bulk/api'),
    queue: require('../service/queue/api')
  }
}
