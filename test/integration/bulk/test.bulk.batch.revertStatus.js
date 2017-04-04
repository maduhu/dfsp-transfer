var test = require('ut-run/test')
var config = require('../../lib/appConfig')
const TIMESTAMP = (new Date()).getTime()
const NAME = 'Batch-' + TIMESTAMP
const ACTOR_ID = '' + Math.floor(Math.random() * 10)
const FILE_NAME = 'File-' + TIMESTAMP
const ORIGINAL_FILE_NAME = 'OriginalFile-' + TIMESTAMP
const BATCH_STATUS_ID_NEW = 3

test({
  type: 'integration',
  name: 'DFSP bulk batch revert test',
  server: config.server,
  serverConfig: config.serverConfig,
  client: config.client,
  clientConfig: config.clientConfig,
  steps: function (test, bus, run) {
    return run(test, bus, [{
      name: 'Add new batch - for bulk batch revert status',
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
      name: 'Change batchStatusId',
      method: 'bulk.batch.edit',
      params: (context) => {
        return {
          actorId: ACTOR_ID,
          batchId: context['Add new batch - for bulk batch revert status'].batchId,
          batchStatusId: BATCH_STATUS_ID_NEW
        }
      },
      result: function (result, assert) {
        assert.true((result.account === null), 'Check account result value - null')

        assert.true((typeof result.actorId === 'string'), 'Check actorId result type - string')
        assert.true((result.actorId === ACTOR_ID), 'Check actorId result value')

        assert.true((typeof result.batchId === 'number'), 'Check batchId result type - number')
        assert.true((result.batchId === this['Add new batch - for bulk batch revert status'].batchId), 'Check batchId result value')

        assert.true((typeof result.batchInfo === 'string'), 'Check batchInfo result type - string')
        assert.true((result.batchInfo === ''), 'Check batchInfo result value - empty')

        assert.true((typeof result.batchStatusId === 'number'), 'Check batchStatusId result type - number')
        assert.true((result.batchStatusId === BATCH_STATUS_ID_NEW), 'Check batchStatusId result value - new=3')

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
    },
    {
      name: 'Revert batch status - partial',
      method: 'bulk.batch.revertStatus',
      params: (context) => {
        return {
          actorId: ACTOR_ID,
          batchId: context['Add new batch - for bulk batch revert status'].batchId,
          partial: true
        }
      },
      result: function (result, assert) {
        assert.true((result.account === null), 'Check account result value - null')

        assert.true((typeof result.actorId === 'string'), 'Check actorId result type - string')
        assert.true((result.actorId === ACTOR_ID), 'Check actorId result value')

        assert.true((typeof result.batchId === 'number'), 'Check batchId result type - number')
        assert.true((result.batchId === this['Add new batch - for bulk batch revert status'].batchId), 'Check batchId result value')

        assert.true((typeof result.batchInfo === 'string'), 'Check batchInfo result type - string')
        assert.true((result.batchInfo === ''), 'Check batchInfo result value - empty')

        assert.true((typeof result.batchStatusId === 'number'), 'Check batchStatusId result type - number')
        assert.true((result.batchStatusId === this['Add new batch - for bulk batch revert status'].batchStatusId), 'Check that batchStatusId was reverted')

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
    },
    {
      name: 'Change batchStatusId before non partial revert',
      method: 'bulk.batch.edit',
      params: (context) => {
        return {
          actorId: ACTOR_ID,
          batchId: context['Add new batch - for bulk batch revert status'].batchId,
          batchStatusId: BATCH_STATUS_ID_NEW
        }
      },
      result: function (result, assert) {
        assert.true((result.account === null), 'Check account result value - null')

        assert.true((typeof result.actorId === 'string'), 'Check actorId result type - string')
        assert.true((result.actorId === ACTOR_ID), 'Check actorId result value')

        assert.true((typeof result.batchId === 'number'), 'Check batchId result type - number')
        assert.true((result.batchId === this['Add new batch - for bulk batch revert status'].batchId), 'Check batchId result value')

        assert.true((typeof result.batchInfo === 'string'), 'Check batchInfo result type - string')
        assert.true((result.batchInfo === ''), 'Check batchInfo result value - empty')

        assert.true((typeof result.batchStatusId === 'number'), 'Check batchStatusId result type - number')
        assert.true((result.batchStatusId === BATCH_STATUS_ID_NEW), 'Check batchStatusId result value - new=3')

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
    },
    {
      name: 'Revert batch status - not partial',
      method: 'bulk.batch.revertStatus',
      params: (context) => {
        return {
          actorId: ACTOR_ID,
          batchId: context['Add new batch - for bulk batch revert status'].batchId
        }
      },
      result: function (result, assert) {
        assert.true((result.account === null), 'Check account result value - null')

        assert.true((typeof result.actorId === 'string'), 'Check actorId result type - string')
        assert.true((result.actorId === ACTOR_ID), 'Check actorId result value')

        assert.true((typeof result.batchId === 'number'), 'Check batchId result type - number')
        assert.true((result.batchId === this['Add new batch - for bulk batch revert status'].batchId), 'Check batchId result value')

        assert.true((typeof result.batchInfo === 'string'), 'Check batchInfo result type - string')
        assert.true((result.batchInfo === ''), 'Check batchInfo result value - empty')

        assert.true((typeof result.batchStatusId === 'number'), 'Check batchStatusId result type - number')
        assert.true((result.batchStatusId === this['Add new batch - for bulk batch revert status'].batchStatusId), 'Check that batchStatusId was reverted')

        assert.true(result.expirationDate === null, 'Check that expirationDate is not set')

        assert.true(typeof result.fileName === 'string', 'Check the fileName type - string')
        assert.true(result.fileName === FILE_NAME, 'Check the fileName value')

        assert.true(typeof result.name === 'string', 'Check the name type - string')
        assert.true(result.name === NAME, 'Check the name value')

        assert.true(typeof result.originalFileName === 'string', 'Check the originalFileName type - string')
        assert.true(result.originalFileName === ORIGINAL_FILE_NAME, 'Check the originalFileName value')

        assert.true((typeof result.uploadInfo === 'string'), 'Check uploadInfo result type - string')
        assert.true((result.uploadInfo === ''), 'Check uploadInfo result value - empty')

        assert.false(isNaN(Date.parse(result.validatedAt)), 'Check that validatedAt is set since it was not partial')
      }
    }
    ])
  }
}, module.parent)
