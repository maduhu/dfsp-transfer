var test = require('ut-run/test')
var config = require('../../lib/appConfig')

test({
  type: 'integration',
  name: 'Bulk paymentStatus fetch test',
  server: config.server,
  serverConfig: config.serverConfig,
  client: config.client,
  clientConfig: config.clientConfig,
  steps: function (test, bus, run) {
    run(test, bus, [{
      name: 'Fetch batch statuses',
      method: 'bulk.paymentStatus.fetch',
      params: (context) => {
        return {}
      },
      result: (result, assert) => {
        result.forEach(function (row) {
          assert.true((typeof row.key === 'number'), 'Check key type')
          assert.true((typeof row.name === 'string'), 'Check name type')
          assert.true((typeof row.description === 'string'), 'Check description type')
        })
      }
    }
    ])
  }
}, module.parent)
