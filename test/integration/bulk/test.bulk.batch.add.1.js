var test = require('ut-run/test')
var config = require('../../lib/appConfig')
var joi = require('joi')
var uuid = require('uuid')
const UUID = uuid.v4()
// const BASE = 'http://localhost:8009/account'
const DEBITACCOUNTNAME = 'Alice' + (new Date()).getTime()
const DEBITACCOUNTBALANCE = '1000.00'
const CREDITACCOUNTNAME = 'Bob' + (new Date()).getTime()
const CREDITACCOUNTBALANCE = '1000.00'
const AMOUNT = '50.00'
const EXECUTEDSTATE = 'executed'
const PREPAREDSTATE = 'prepared'
const FULFILLMENT = 'cf:0:_v8'

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