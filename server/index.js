module.exports = {
  ports: [
    require('../db'),
    require('../httpserver'),
    require('../httpclient/spsp'),
    require('../script')
  ],
  modules: {
    identity: require('../service/identity'),
    transfer: require('../service/transfer')
  },
  validations: {
    transfer: require('../service/transfer/api')
  }
}
