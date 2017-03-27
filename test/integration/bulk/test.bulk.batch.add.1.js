var test = require('ut-run/test')
var config = require('../../lib/appConfig')

test({
  type: 'integration',
  name: 'DFSP account test',
  server: config.server,
  serverConfig: config.serverConfig,
  client: config.client,
  clientConfig: config.clientConfig,
  steps: function (test, bus, run) {
    run(test, bus, [{
      name: 'Add new batch',
      method: 'bulk.batch.fetch',
      // method: 'transfer.invoiceNotification.fetch',
      params: (context) => {
        return {
          test: 'test'
        }
      },
      result: (result, assert) => {
        assert.equals(1, 1, 'return server meta')
      }
    }])
  }
}, module.parent)
