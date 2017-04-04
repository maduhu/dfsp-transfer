var test = require('ut-run/test')
var config = require('../../lib/appConfig')
const TIMESTAMP = (new Date()).getTime()
const NAME = 'Batch-' + TIMESTAMP
const ACTOR_ID = '' + Math.floor(Math.random() * 10)
const FILE_NAME = 'File-' + TIMESTAMP
const ORIGINAL_FILE_NAME = 'OriginalFile-' + TIMESTAMP

test({
  type: 'integration',
  name: 'DFSP bulk fetch test',
  server: config.server,
  serverConfig: config.serverConfig,
  client: config.client,
  clientConfig: config.clientConfig,
  steps: function (test, bus, run) {
    return run(test, bus, [{
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
    },
    {
      name: 'Fetch batch by actorId',
      method: 'bulk.batch.fetch',
      params: (context) => {
        return {
          actorId: ACTOR_ID
        }
      },
      result: function (result, assert) {
        assert.true(Array.isArray(result), 'Check if the returned result is array')
        assert.true(result.length > 0, 'Check if the returned result is not empty')
      }
    },
    {
      name: 'Fetch batch by name',
      method: 'bulk.batch.fetch',
      params: (context) => {
        return {
          name: NAME
        }
      },
      result: (result, assert) => {
        assert.true(Array.isArray(result), 'Check if the returned result is array - original name')
        assert.true(result.length > 0, 'Check if the returned result is not empty - original name')
      }
    },
    {
      name: 'Fetch batch by name - case insensitive - name to uppercase',
      method: 'bulk.batch.fetch',
      params: (context) => {
        return {
          name: NAME.toUpperCase()
        }
      },
      result: (result, assert) => {
        assert.true(Array.isArray(result), 'Check if the returned result is array - name to uppercase')
        assert.true(result.length > 0, 'Check if the returned result is not empty - name to uppercase')
      }
    },
    {
      name: 'Fetch batch by name - case insensitive - name to lowercase',
      method: 'bulk.batch.fetch',
      params: (context) => {
        return {
          name: NAME.toLowerCase()
        }
      },
      result: function (result, assert) {
        assert.true(Array.isArray(result), 'Check if the returned result is array - name to lowercase')
        assert.true(result.length > 0, 'Check if the returned result is not empty - name to lowercase')
      }
    },
    {
      name: 'Fetch batch by inserted batch properties - name',
      method: 'bulk.batch.fetch',
      params: (context) => {
        return {
          name: context['Add new batch and check returned result types'].name
        }
      },
      result: function (result, assert) {
        assert.true(Array.isArray(result), 'Check if the returned result is array - inserted name')
        assert.true(result.length > 0, 'Check if the returned result is not empty - inserted name')
      }
    },
    {
      name: 'Fetch batch by inserted batch properties - name',
      method: 'bulk.batch.fetch',
      params: (context) => {
        return {
          batchStatusId: context['Add new batch and check returned result types'].batchStatusId
        }
      },
      result: function (result, assert) {
        assert.true(Array.isArray(result), 'Check if the returned result is array - inserted batchStatusId')
        assert.true(result.length > 0, 'Check if the returned result is not empty - inserted batchStatusId')
      }
    },
    {
      name: 'Fetch batch by fromDate',
      method: 'bulk.batch.fetch',
      params: (context) => {
        return {
          fromDate: (new Date().setDate((new Date().getDay() - 1))).getDay
        }
      },
      result: function (result, assert) {
        assert.true(Array.isArray(result), 'Check if the returned result is array - fromDate')
        assert.true(result.length > 0, 'Check if the returned result is not empty - fromDate')
      }
    },
    {
      name: 'Fetch batch by toDate',
      method: 'bulk.batch.fetch',
      params: (context) => {
        return {
          toDate: (new Date()).getDay
        }
      },
      result: function (result, assert) {
        assert.true(Array.isArray(result), 'Check if the returned result is array - toDate')
        assert.true(result.length > 0, 'Check if the returned result is not empty - toDate')
      }
    },
    {
      name: 'Fetch batch by (fromDate - toDate)',
      method: 'bulk.batch.fetch',
      params: (context) => {
        return {
          fromDate: (new Date().setDate((new Date().getDay() - 1))).getDay,
          toDate: (new Date()).getDay
        }
      },
      result: function (result, assert) {
        assert.true(Array.isArray(result), 'Check if the returned result is array - (fromDate - toDate)')
        assert.true(result.length > 0, 'Check if the returned result is not empty - (fromDate - toDate)')
      }
    }
    ])
  }
}, module.parent)
