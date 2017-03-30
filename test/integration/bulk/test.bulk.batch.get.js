var test = require('ut-run/test')
var config = require('../../lib/appConfig')
var utError = require('ut-error')
const TIMESTAMP = (new Date()).getTime()
const NAME = 'Batch-' + TIMESTAMP
const ACTOR_ID = '' + Math.floor(Math.random() * 10)
const FILE_NAME = 'File-' + TIMESTAMP
const ORIGINAL_FILE_NAME = 'OriginalFile-' + TIMESTAMP
const BATCH_STATUS_UPLOADING = 'uploading'
const ZERO_PAYMENTS = '0'

test({
  type: 'integration',
  name: 'DFSP bulk get test',
  server: config.server,
  serverConfig: config.serverConfig,
  client: config.client,
  clientConfig: config.clientConfig,
  steps: function (test, bus, run) {
    run(test, bus, [{
      name: 'Add new batch - for bulk batch get',
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
      name: 'Get batch by batchId',
      method: 'bulk.batch.get',
      params: (context) => {
        return {
          batchId: context['Add new batch - for bulk batch get'].batchId
        }
      },
      result: function (result, assert) {
        assert.true(result.account === null, 'Check if the returned account is empty')
        assert.true(result.actorId === ACTOR_ID, 'Check if the returned actorId is stored corectly')
        assert.true(result.batchId === this['Add new batch - for bulk batch get'].batchId, 'Check the returned batchId')
        assert.true(result.batchStatusId === this['Add new batch - for bulk batch get'].batchStatusId, 'Check the returned batchStatusId')
        assert.false(isNaN(Date.parse(result.createdAt)), 'Check if the returned result is a Date')
        assert.true(result.expirationDate === null, 'Check that expirationDate is not set')
        assert.true(result.fileName === FILE_NAME, 'Check the fileName value')
        assert.true(result.info === '', 'Check that the info is empty')
        assert.true(result.name === NAME, 'Check the batch name')
        assert.true(result.originalFileName === ORIGINAL_FILE_NAME, 'Check the batch original fileName')
        assert.true(result.paymentsCount === ZERO_PAYMENTS, 'Check that there arent any asociated with this batch payments')
        assert.true(result.status === BATCH_STATUS_UPLOADING, 'Check the batch status')
        assert.true(result.updatedAt === null, 'Check that the batch has not been updated')
      }
    },
    {
      name: 'Get batch - missing batchId',
      method: 'bulk.batch.get',
      params: (context) => {
        return {}
      },
      error: function (error, assert) {
        assert.true(error instanceof utError.get('bulk.batchIdMissing'), error.errorPrint)
        assert.equal(error.errorPrint, 'Missing batchId', error.errorPrint)
      }
    }
    ])
  }
}, module.parent)
