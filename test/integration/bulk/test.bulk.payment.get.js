var test = require('ut-run/test')
var config = require('../../lib/appConfig')
const TIMESTAMP = (new Date()).getTime()
const NAME = 'Batch-' + TIMESTAMP
const ACTOR_ID = '' + Math.floor(Math.random() * 10)
const FILE_NAME = 'File-' + TIMESTAMP
const ORIGINAL_FILE_NAME = 'OriginalFile-' + TIMESTAMP
const PAYMENTS = require('./data/payments.json')

test({
  type: 'integration',
  name: 'Bulk payment get test',
  server: config.server,
  serverConfig: config.serverConfig,
  client: config.client,
  clientConfig: config.clientConfig,
  steps: function (test, bus, run) {
    return run(test, bus, [{
      name: 'Create batch to link the payments with - payment get',
      method: 'bulk.batch.add',
      params: (context) => {
        return {
          name: NAME,
          actorId: ACTOR_ID,
          fileName: FILE_NAME,
          originalFileName: ORIGINAL_FILE_NAME
        }
      },
      result: (result, assert) => {
        assert.true((typeof result.actorId === 'string'), 'Check actorId result type')
        assert.true((typeof result.batchId === 'number'), 'Check batchId result type')
        assert.true((typeof result.name === 'string'), 'Check name result type')
        assert.true((typeof result.batchStatusId === 'number'), 'Check batchStatusId result type')
      }
    },
    {
      name: 'Add payments',
      method: 'bulk.payment.add',
      params: (context) => {
        return {
          payments: JSON.stringify(PAYMENTS),
          actorId: ACTOR_ID,
          batchId: context['Create batch to link the payments with - payment get'].batchId
        }
      },
      result: (result, assert) => {
        assert.equal(result.insertedRows, PAYMENTS.length, 'Check that all the payments were inserted')
      }
    },
    {
      name: 'Fetch payments by batchId',
      method: 'bulk.payment.get',
      params: (context) => {
        return {
          paymentId: 1
        }
      },
      result: function (result, assert) {
        assert.true((typeof result.paymentId === 'string'), 'Check paymentId type')
        assert.true((typeof result.batchId === 'number'), 'Check batchId type')
        assert.true((typeof result.sequenceNumber === 'number'), 'Check sequenceNumber type')
        assert.true((typeof result.identifier === 'string'), 'Check identifier type')
        assert.true((typeof result.firstName === 'string'), 'Check firstName type')
        assert.true((typeof result.lastName === 'string'), 'Check lastName type')
        assert.false(isNaN(Date.parse(result.dob)), 'Check if the returned dob is a Date')
        assert.true((typeof result.nationalId === 'string'), 'Check nationalId type')
        assert.true((typeof result.amount === 'string'), 'Check amount type')
        assert.true((typeof result.paymentStatusId === 'number'), 'Check paymentStatusId type')
        assert.true((result.info === null), 'Check that payment info is not set')
        assert.true((typeof result.name === 'string'), 'Check the name type')
        assert.false(isNaN(Date.parse(result.createdAt)), 'Check if the returned createdAt is a Date')
        assert.false(isNaN(Date.parse(result.updatedAt)), 'Check if the returned updatedAt is a Date')
      }
    }
    ])
  }
}, module.parent)
