module.exports = {
  id: 'rule',
  createPort: require('ut-port-jsonrpc'),
  url: 'http://localhost:8016',
  namespace: ['rule'],
  logLevel: 'debug',
  method: 'post'
}
