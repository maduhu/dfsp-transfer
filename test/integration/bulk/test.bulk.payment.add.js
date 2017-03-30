var test = require('ut-run/test')
var utError = require('ut-error')
var config = require('../../lib/appConfig')
const TIMESTAMP = (new Date()).getTime()
const NAME = 'Batch-' + TIMESTAMP
const ACTOR_ID = '' + Math.floor(Math.random() * 10)
const FILE_NAME = 'File-' + TIMESTAMP
const ORIGINAL_FILE_NAME = 'OriginalFile-' + TIMESTAMP
const PAYMENTS = require('./data/payments.json')

test({
  type: 'integration',
  name: 'Bulk payment add test',
  server: config.server,
  serverConfig: config.serverConfig,
  client: config.client,
  clientConfig: config.clientConfig,
  steps: function (test, bus, run) {
    run(test, bus, [{
      name: 'Create batch to link payments with',
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
      name: 'Missing input params - Raise exception for missing actorId',
      method: 'bulk.payment.add',
      params: (context) => {
        return {
          payments: []
        }
      },
      error: (error, assert) => {
        assert.true(error instanceof utError.get('bulk.actorIdMissing'), error.errorPrint)
        assert.equal(error.errorPrint, 'Missing actorId', error.errorPrint)
      }
    },
    {
      name: 'Missing input params - Raise exception for missing batchId',
      method: 'bulk.payment.add',
      params: (context) => {
        return {
          payments: [],
          actorId: ACTOR_ID
        }
      },
      error: (error, assert) => {
        assert.true(error instanceof utError.get('bulk.batchIdMissing'), error.errorPrint)
        assert.equal(error.errorPrint, 'Missing batchId', error.errorPrint)
      }
    },
    {
      name: 'Missing input params - Raise exception for empty payments',
      method: 'bulk.payment.add',
      params: (context) => {
        return {
          payments: [],
          actorId: ACTOR_ID,
          batchId: context['Create batch to link payments with'].batchId
        }
      },
      error: (error, assert) => {
        assert.true(error instanceof utError.get('bulk.emptyPayments'), error.errorPrint)
        assert.equal(error.errorPrint, 'Empty list with payments', error.errorPrint)
      }
    },
    {
      name: 'Add payment',
      method: 'bulk.payment.add',
      params: (context) => {
        return {
          payments: JSON.stringify(PAYMENTS),
          actorId: ACTOR_ID,
          batchId: context['Create batch to link payments with'].batchId
        }
      },
      result: (result, assert) => {
        assert.equal(result.insertedRows, PAYMENTS.length, 'Check that all the payments were inserted')
      }
    }
    ])
  }
}, module.parent)
