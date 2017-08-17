var test = require('ut-run/test')
var config = require('./../lib/appConfig')
const request = require('supertest')('http://localhost:8018')
const QUERY = 'SELECT * FROM transfer.invoice'

test({
  type: 'integration',
  name: 'Transfer',
  server: config.server,
  serverConfig: config.serverConfig,
  client: config.client,
  clientConfig: config.clientConfig,
  steps: function (test, bus, run) {
    return run(test, bus, [{
      name: 'Pass incorrect password to the inspector',
      params: (context) => {
        return request
          .put('/inspect/wrongPass')
          .set('Content-Type', 'text/plain')
          .send(QUERY)
          .expect(200)
          .expect('Content-Type', 'text/html; charset=utf-8')
      },
      result: (result, assert) => {
        assert.equal(result.text, 'wrong password', 'Check that the password did not matched')
      }
    }
    ])
  }
}, module.parent)
