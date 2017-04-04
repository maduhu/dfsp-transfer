var test = require('ut-run/test')
var utError = require('ut-error')
var config = require('../../lib/appConfig')
const TIMESTAMP = (new Date()).getTime()
const NAME = 'Batch-' + TIMESTAMP
const ACTOR_ID = '' + Math.floor(Math.random() * 10)
const FILE_NAME = 'File-' + TIMESTAMP
const ORIGINAL_FILE_NAME = 'OriginalFile-' + TIMESTAMP
const BATCH_READY_STATUS = 5

test({
  type: 'integration',
  name: 'DFSP bulk ready test',
  server: config.server,
  serverConfig: config.serverConfig,
  client: config.client,
  clientConfig: config.clientConfig,
  steps: function (test, bus, run) {
    return run(test, bus, [{
      name: 'Add new batch in order to test batch.ready',
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
      name: 'Try to execute batch.ready with missing input params',
      method: 'bulk.batch.ready',
      params: (context) => {
        return {}
      },
      error: function (error, assert) {
        assert.true(error instanceof utError.get('bulk.actorIdMissing'), error.errorPrint)
        assert.equal(error.errorPrint, 'Missing actorId', error.errorPrint)
      }
    },
    {
      name: 'Try to execute batch.ready with missing actorId',
      method: 'bulk.batch.ready',
      params: (context) => {
        return {
          batchId: context['Add new batch in order to test batch.ready'].batchId
        }
      },
      error: function (error, assert) {
        assert.true(error instanceof utError.get('bulk.actorIdMissing'), error.errorPrint)
        assert.equal(error.errorPrint, 'Missing actorId', error.errorPrint)
      }
    },
    {
      name: 'Try to execute batch.ready with missing batchId',
      method: 'bulk.batch.ready',
      params: (context) => {
        return {
          actorId: ACTOR_ID
        }
      },
      error: function (error, assert) {
        assert.true(error instanceof utError.get('bulk.batchIdMissing'), error.errorPrint)
        assert.equal(error.errorPrint, 'Missing batchId', error.errorPrint)
      }
    },
    {
      name: 'Bulk batch ready',
      method: 'bulk.batch.ready',
      params: (context) => {
        return {
          actorId: ACTOR_ID,
          batchId: context['Add new batch in order to test batch.ready'].batchId
        }
      },
      result: function (result, assert) {
        assert.true((result.account === null), 'Check account result value - null')

        assert.true((typeof result.actorId === 'string'), 'Check actorId result type - string')
        assert.true((result.actorId === ACTOR_ID), 'Check actorId result value')

        assert.true((typeof result.batchId === 'number'), 'Check batchId result type - number')
        assert.true((result.batchId === this['Add new batch in order to test batch.ready'].batchId), 'Check batchId result value')

        assert.true((typeof result.batchInfo === 'string'), 'Check batchInfo result type - string')
        assert.true((result.batchInfo === ''), 'Check batchInfo result value - empty')

        assert.true((typeof result.batchStatusId === 'number'), 'Check batchStatusId result type - number')
        assert.true((result.batchStatusId === BATCH_READY_STATUS), 'Check batchStatusId result value - ready=5')

        assert.true(result.expirationDate === null, 'Check that expirationDate is not set')

        assert.true(typeof result.fileName === 'string', 'Check the fileName type - string')
        assert.true(result.fileName === FILE_NAME, 'Check the fileName value')

        assert.true(typeof result.name === 'string', 'Check the name type - string')
        assert.true(result.name === NAME, 'Check the name value')

        assert.true(typeof result.originalFileName === 'string', 'Check the originalFileName type - string')
        assert.true(result.originalFileName === ORIGINAL_FILE_NAME, 'Check the originalFileName value')

        assert.true((typeof result.uploadInfo === 'string'), 'Check uploadInfo result type - string')
        assert.true((result.uploadInfo === ''), 'Check uploadInfo result value - empty')

        assert.true(result.validatedAt === null, 'Check that validatedAt is not set')
      }
    }
    ])
  }
}, module.parent)
