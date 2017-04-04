var test = require('ut-run/test')
var utError = require('ut-error')
var config = require('../../lib/appConfig')
const NAME = 'Batch-' + (new Date()).getTime()
const ACTOR_ID = '' + Math.floor(Math.random() * 10)
const FILE_NAME = 'File-' + (new Date()).getTime()
const ORIGINAL_FILE_NAME = 'OriginalFile-' + (new Date()).getTime()
const RANDOM_NUMBER = Math.floor(Math.random() * 10)

test({
  type: 'integration',
  name: 'Bulk batch add test',
  server: config.server,
  serverConfig: config.serverConfig,
  client: config.client,
  clientConfig: config.clientConfig,
  steps: function (test, bus, run) {
    return run(test, bus, [{
      name: 'Missing input params - Raise exception for missing name',
      method: 'bulk.batch.add',
      params: (context) => {
        return {}
      },
      error: (error, assert) => {
        assert.true(error instanceof utError.get('bulk.nameIsMissing'), error.errorPrint)
        assert.equal(error.errorPrint, 'Missing input name', error.errorPrint)
      }
    },
    {
      name: 'Missing input params - Raise exception for missing actorId',
      method: 'bulk.batch.add',
      params: (context) => {
        return {
          name: NAME
        }
      },
      error: (error, assert) => {
        assert.true(error instanceof utError.get('bulk.actorIdMissing'), error.errorPrint)
        assert.equal(error.errorPrint, 'Missing actorId', error.errorPrint)
      }
    },
    {
      name: 'Missing input params - Raise exception for missing fileName',
      method: 'bulk.batch.add',
      params: (context) => {
        return {
          name: NAME,
          actorId: ACTOR_ID
        }
      },
      error: (error, assert) => {
        assert.true(error instanceof utError.get('bulk.missingFileName'), error.errorPrint)
        assert.equal(error.errorPrint, 'Missing file name', error.errorPrint)
      }
    },
    {
      name: 'Missing input params - Raise exception for missing original fileName',
      method: 'bulk.batch.add',
      params: (context) => {
        return {
          name: NAME,
          actorId: ACTOR_ID,
          fileName: FILE_NAME
        }
      },
      error: (error, assert) => {
        assert.true(error instanceof utError.get('bulk.missingOriginalFileName'), error.errorPrint)
        assert.equal(error.errorPrint, 'Missing original file name', error.errorPrint)
      }
    },
    {
      name: 'Incorrect param type (name) - Raise exception (function does not exist)',
      method: 'bulk.batch.add',
      params: (context) => {
        return {
          name: RANDOM_NUMBER,
          actorId: ACTOR_ID,
          fileName: FILE_NAME,
          originalFileName: ORIGINAL_FILE_NAME
        }
      },
      error: (error, assert) => {
        assert.equal(error.errorPrint, 'function bulk.batch.add(integer, unknown, unknown, unknown) does not exist', error.errorPrint)
      }
    },
    {
      name: 'Incorrect param type (actorId) - Raise exception (function does not exist)',
      method: 'bulk.batch.add',
      params: (context) => {
        return {
          name: NAME,
          actorId: RANDOM_NUMBER,
          fileName: FILE_NAME,
          originalFileName: ORIGINAL_FILE_NAME
        }
      },
      error: (error, assert) => {
        assert.equal(error.errorPrint, 'function bulk.batch.add(unknown, integer, unknown, unknown) does not exist', error.errorPrint)
      }
    },
    {
      name: 'Incorrect param type (fileName) - Raise exception (function does not exist)',
      method: 'bulk.batch.add',
      params: (context) => {
        return {
          name: NAME,
          actorId: ACTOR_ID,
          fileName: RANDOM_NUMBER,
          originalFileName: ORIGINAL_FILE_NAME
        }
      },
      error: (error, assert) => {
        assert.equal(error.errorPrint, 'function bulk.batch.add(unknown, unknown, integer, unknown) does not exist', error.errorPrint)
      }
    },
    {
      name: 'Incorrect param type (originalFileName) - Raise exception (function does not exist)',
      method: 'bulk.batch.add',
      params: (context) => {
        return {
          name: NAME,
          actorId: ACTOR_ID,
          fileName: FILE_NAME,
          originalFileName: RANDOM_NUMBER
        }
      },
      error: (error, assert) => {
        assert.equal(error.errorPrint, 'function bulk.batch.add(unknown, unknown, unknown, integer) does not exist', error.errorPrint)
      }
    },
    {
      name: 'Add new batch and check returned result types',
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
    }
    ])
  }
}, module.parent)
