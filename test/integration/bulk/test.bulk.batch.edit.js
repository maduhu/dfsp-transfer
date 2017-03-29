var test = require('ut-run/test')
var utError = require('ut-error')
var config = require('../../lib/appConfig')
const TIMESTAMP = (new Date()).getTime()
const NAME = 'Batch-' + TIMESTAMP
const ACTOR_ID = '' + Math.floor(Math.random() * 10)
const FILE_NAME = 'File-' + TIMESTAMP
const ORIGINAL_FILE_NAME = 'OriginalFile-' + TIMESTAMP
const INCORRECT_BATCH_ID = -1
const INCORRECT_BATCH_STATUS_ID = -1
const BATCH_STATUS_ID_NEW = 3
const TEST_DATE = '2017-03-29T12:41:39.216Z'
const TEST_ACCOUNT = 'Test Account 0123456789 !@#$%^&*()_+'
const INFO = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque a elit mauris. Sed et tempor massa. Donec molestie non nisi et fringilla. Sed sit amet feugiat velit, vitae vestibulum diam. Sed vestibulum lorem eu ligula consectetur placerat. Proin consectetur ut urna eget scelerisque. Nam sit amet nisi sit amet massa hendrerit mattis at efficitur nisl. Cras a fringilla nisi, vitae semper tellus. Maecenas et orci id magna vulputate vulputate non in tortor.'

test({
  type: 'integration',
  name: 'DFSP bulk edit test',
  server: config.server,
  serverConfig: config.serverConfig,
  client: config.client,
  clientConfig: config.clientConfig,
  steps: function (test, bus, run) {
    run(test, bus, [{
      name: 'Add new batch in order to test edit batch',
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
      name: 'Bulk batch edit - missing all arguments',
      method: 'bulk.batch.edit',
      params: (context) => {
        return {}
      },
      error: (error, assert) => {
        assert.true(error instanceof utError.get('bulk.actorIdMissing'), error.errorPrint)
        assert.equal(error.errorPrint, 'Missing actorId', error.errorPrint)
      }
    },
    {
      name: 'Bulk batch edit - missing all arguments',
      method: 'bulk.batch.edit',
      params: (context) => {
        return {}
      },
      error: (error, assert) => {
        assert.true(error instanceof utError.get('bulk.actorIdMissing'), error.errorPrint)
        assert.equal(error.errorPrint, 'Missing actorId', error.errorPrint)
      }
    },
    {
      name: 'Check missing batchId exception',
      method: 'bulk.batch.edit',
      params: (context) => {
        return {
          actorId: ACTOR_ID
        }
      },
      error: (error, assert) => {
        assert.true(error instanceof utError.get('bulk.batchIdMissing'), error.errorPrint)
        assert.equal(error.errorPrint, 'Missing batchId', error.errorPrint)
      }
    },
    {
      name: 'Check batch not found exception',
      method: 'bulk.batch.edit',
      params: (context) => {
        return {
          actorId: ACTOR_ID,
          batchId: INCORRECT_BATCH_ID
        }
      },
      error: (error, assert) => {
        assert.true(error instanceof utError.get('bulk.batchNotFound'), error.errorPrint)
        assert.equal(error.errorPrint, 'Batch with the given batchId does not exist', error.errorPrint)
      }
    },
    {
      name: 'Check batchStatusId not found exception',
      method: 'bulk.batch.edit',
      params: (context) => {
        return {
          actorId: ACTOR_ID,
          batchId: context['Add new batch in order to test edit batch'].batchId,
          batchStatusId: INCORRECT_BATCH_STATUS_ID
        }
      },
      error: (error, assert) => {
        assert.true(error instanceof utError.get('bulk.batchStatusIdNotFound'), error.errorPrint)
        assert.equal(error.errorPrint, 'Batch status with the given batchStatusId does not exist', error.errorPrint)
      }
    },
    {
      name: 'Edit batchStatusId to: new',
      method: 'bulk.batch.edit',
      params: (context) => {
        return {
          actorId: ACTOR_ID,
          batchId: context['Add new batch in order to test edit batch'].batchId,
          batchStatusId: BATCH_STATUS_ID_NEW
        }
      },
      result: function (result, assert) {
        assert.true((result.account === null), 'Check account result value - null')

        assert.true((typeof result.actorId === 'string'), 'Check actorId result type - string')
        assert.true((result.actorId === ACTOR_ID), 'Check actorId result value')

        assert.true((typeof result.batchId === 'number'), 'Check batchId result type - number')
        assert.true((result.batchId === this['Add new batch in order to test edit batch'].batchId), 'Check batchId result value')

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
      name: 'Edit expirationDate',
      method: 'bulk.batch.edit',
      params: (context) => {
        return {
          actorId: ACTOR_ID,
          batchId: context['Add new batch in order to test edit batch'].batchId,
          expirationDate: TEST_DATE
        }
      },
      result: function (result, assert) {
        assert.true((result.account === null), 'Check account result value - null')

        assert.true((typeof result.actorId === 'string'), 'Check actorId result type - string')
        assert.true((result.actorId === ACTOR_ID), 'Check actorId result value')

        assert.true((typeof result.batchId === 'number'), 'Check batchId result type - number')
        assert.true((result.batchId === this['Add new batch in order to test edit batch'].batchId), 'Check batchId result value')

        assert.true((typeof result.batchInfo === 'string'), 'Check batchInfo result type - string')
        assert.true((result.batchInfo === ''), 'Check batchInfo result value - empty')

        assert.true((typeof result.batchStatusId === 'number'), 'Check batchStatusId result type - number')
        assert.true((result.batchStatusId === BATCH_STATUS_ID_NEW), 'Check batchStatusId result value - new=3')

        assert.false(isNaN(Date.parse(result.expirationDate)), 'Check if the returned result is a Date')

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
      name: 'Edit batch account',
      method: 'bulk.batch.edit',
      params: (context) => {
        return {
          actorId: ACTOR_ID,
          batchId: context['Add new batch in order to test edit batch'].batchId,
          account: TEST_ACCOUNT
        }
      },
      result: function (result, assert) {
        assert.true((typeof result.account === 'string'), 'Check account result type - string')
        assert.true((result.account === TEST_ACCOUNT), 'Check account result value')

        assert.true((typeof result.actorId === 'string'), 'Check actorId result type - string')
        assert.true((result.actorId === ACTOR_ID), 'Check actorId result value')

        assert.true((typeof result.batchId === 'number'), 'Check batchId result type - number')
        assert.true((result.batchId === this['Add new batch in order to test edit batch'].batchId), 'Check batchId result value')

        assert.true((typeof result.batchInfo === 'string'), 'Check batchInfo result type - string')
        assert.true((result.batchInfo === ''), 'Check batchInfo result value - empty')

        assert.true((typeof result.batchStatusId === 'number'), 'Check batchStatusId result type - number')
        assert.true((result.batchStatusId === BATCH_STATUS_ID_NEW), 'Check batchStatusId result value - new=3')

        assert.false(isNaN(Date.parse(result.expirationDate)), 'Check if the returned result is a Date')

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
      name: 'Edit batch info',
      method: 'bulk.batch.edit',
      params: (context) => {
        return {
          actorId: ACTOR_ID,
          batchId: context['Add new batch in order to test edit batch'].batchId,
          batchInfo: INFO
        }
      },
      result: function (result, assert) {
        assert.true((typeof result.account === 'string'), 'Check account result type - string')
        assert.true((result.account === TEST_ACCOUNT), 'Check account result value')

        assert.true((typeof result.actorId === 'string'), 'Check actorId result type - string')
        assert.true((result.actorId === ACTOR_ID), 'Check actorId result value')

        assert.true((typeof result.batchId === 'number'), 'Check batchId result type - number')
        assert.true((result.batchId === this['Add new batch in order to test edit batch'].batchId), 'Check batchId result value')

        assert.true((typeof result.batchInfo === 'string'), 'Check batchInfo result type - string')
        assert.true((result.batchInfo === INFO), 'Check batchInfo result value')

        assert.true((typeof result.batchStatusId === 'number'), 'Check batchStatusId result type - number')
        assert.true((result.batchStatusId === BATCH_STATUS_ID_NEW), 'Check batchStatusId result value - new=3')

        assert.false(isNaN(Date.parse(result.expirationDate)), 'Check if the returned result is a Date')

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
      name: 'Edit upload info',
      method: 'bulk.batch.edit',
      params: (context) => {
        return {
          actorId: ACTOR_ID,
          batchId: context['Add new batch in order to test edit batch'].batchId,
          uploadInfo: INFO
        }
      },
      result: function (result, assert) {
        assert.true((typeof result.account === 'string'), 'Check account result type - string')
        assert.true((result.account === TEST_ACCOUNT), 'Check account result value')

        assert.true((typeof result.actorId === 'string'), 'Check actorId result type - string')
        assert.true((result.actorId === ACTOR_ID), 'Check actorId result value')

        assert.true((typeof result.batchId === 'number'), 'Check batchId result type - number')
        assert.true((result.batchId === this['Add new batch in order to test edit batch'].batchId), 'Check batchId result value')

        assert.true((typeof result.batchInfo === 'string'), 'Check batchInfo result type - string')
        assert.true((result.batchInfo === INFO), 'Check batchInfo result value')

        assert.true((typeof result.batchStatusId === 'number'), 'Check batchStatusId result type - number')
        assert.true((result.batchStatusId === BATCH_STATUS_ID_NEW), 'Check batchStatusId result value - new=3')

        assert.false(isNaN(Date.parse(result.expirationDate)), 'Check if the returned result is a Date')

        assert.true(typeof result.fileName === 'string', 'Check the fileName type - string')
        assert.true(result.fileName === FILE_NAME, 'Check the fileName value')

        assert.true(typeof result.name === 'string', 'Check the name type - string')
        assert.true(result.name === NAME, 'Check the name value')

        assert.true(typeof result.originalFileName === 'string', 'Check the originalFileName type - string')
        assert.true(result.originalFileName === ORIGINAL_FILE_NAME, 'Check the originalFileName value')

        assert.true((typeof result.uploadInfo === 'string'), 'Check uploadInfo result type - string')
        assert.true((result.uploadInfo === INFO), 'Check uploadInfo result value - empty')

        assert.true(result.validatedAt === null, 'Check that validatedAt is not set')
      }
    }
    ])
  }
}, module.parent)
