var test = require('ut-run/test')
var config = require('../../lib/appConfig')
const TIMESTAMP = (new Date()).getTime()
const NAME = 'Batch-' + TIMESTAMP
const ACTOR_ID = '' + Math.floor(Math.random() * 10)
const FILE_NAME = 'File-' + TIMESTAMP
const ORIGINAL_FILE_NAME = 'OriginalFile-' + TIMESTAMP
const PAYMENTS = require('./data/payments.json')
const TEST_SEQUENCE_NUMBER = 11111
const TEST_IDENTIFIER = '22222'
const FIRST_NAME = 'First Name'
const LAST_NAME = 'Last Name'
const DOB = '1989-03-29T12:41:39.216Z'
const NATIONAL_ID = '33333'
const TEST_AMOUNT = 11.79
const PAYMET_STATUS_MODIFIED = 2
const INFO = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque a elit mauris. Sed et tempor massa. Donec molestie non nisi et fringilla. Sed sit amet feugiat velit, vitae vestibulum diam. Sed vestibulum lorem eu ligula consectetur placerat. Proin consectetur ut urna eget scelerisque. Nam sit amet nisi sit amet massa hendrerit mattis at efficitur nisl. Cras a fringilla nisi, vitae semper tellus. Maecenas et orci id magna vulputate vulputate non in tortor.'
var fetchedPayments

test({
  type: 'integration',
  name: 'Bulk payment edit test',
  server: config.server,
  serverConfig: config.serverConfig,
  client: config.client,
  clientConfig: config.clientConfig,
  steps: function (test, bus, run) {
    return run(test, bus, [{
      name: 'Create batch to link the payments with',
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
          batchId: context['Create batch to link the payments with'].batchId
        }
      },
      result: (result, assert) => {
        assert.equal(result.insertedRows, PAYMENTS.length, 'Check that all the payments were inserted')
      }
    },
    {
      name: 'Fetch payments',
      method: 'bulk.payment.fetch',
      params: (context) => {
        return {
          batchId: context['Create batch to link the payments with'].batchId
        }
      },
      result: function (result, assert) {
        fetchedPayments = result.data
        fetchedPayments.forEach((row) => {
          assert.true((typeof row.paymentId === 'number'), 'Check paymentId type')
          assert.true((typeof row.batchId === 'number'), 'Check batchId type')
          assert.equal(row.batchId, this['Create batch to link the payments with'].batchId, 'Check the batchId value')
          assert.true((typeof row.sequenceNumber === 'number'), 'Check sequenceNumber type')
          assert.true((typeof row.identifier === 'string'), 'Check identifier type')
          assert.true((typeof row.firstName === 'string'), 'Check firstName type')
          assert.true((typeof row.lastName === 'string'), 'Check lastName type')
          assert.false(isNaN(Date.parse(row.dob)), 'Check if the returned dob is a Date')
          assert.true((typeof row.nationalId === 'string'), 'Check nationalId type')
          assert.true((typeof row.amount === 'number'), 'Check amount type')
          assert.true((typeof row.paymentStatusId === 'number'), 'Check paymentStatusId type')
          assert.true((typeof row.status === 'string'), 'Check status type')
          assert.equal(row.info, null, 'Check that payment info is empty')
          assert.equal(row.name, NAME, 'Check batch name')
          assert.false(isNaN(Date.parse(row.createdAt)), 'Check if the returned createdAt is a Date')
          assert.false(isNaN(Date.parse(row.updatedAt)), 'Check if the returned updatedAt is a Date')
        })
      }
    },
    {
      name: 'Edit payments',
      method: 'bulk.payment.edit',
      params: (context) => {
        return {
          actorId: ACTOR_ID,
          payments: fetchedPayments.map((element) => {
            element.sequenceNumber = TEST_SEQUENCE_NUMBER
            element.identifier = TEST_IDENTIFIER
            element.firstName = FIRST_NAME
            element.lastName = LAST_NAME
            element.dob = DOB
            element.nationalId = NATIONAL_ID
            element.amount = TEST_AMOUNT
            element.paymentStatusId = PAYMET_STATUS_MODIFIED
            element.info = INFO
            return element
          })
        }
      },
      result: function (result, assert) {
        result[0].payments.forEach((row) => {
          assert.true((typeof row.paymentId === 'number'), 'Check paymentId type')
          assert.true((typeof row.batchId === 'number'), 'Check batchId type')
          assert.equal(row.batchId, this['Create batch to link the payments with'].batchId, 'Check the batchId value')

          assert.true((typeof row.sequenceNumber === 'number'), 'Check sequenceNumber type')
          assert.equal(row.sequenceNumber, TEST_SEQUENCE_NUMBER, 'Check sequenceNumber value')

          assert.true((typeof row.identifier === 'string'), 'Check identifier type')
          assert.equal(row.identifier, TEST_IDENTIFIER, 'Check identifier value')

          assert.true((typeof row.firstName === 'string'), 'Check firstName type')
          assert.equal(row.firstName, FIRST_NAME, 'Check firstName value')

          assert.true((typeof row.lastName === 'string'), 'Check lastName type')
          assert.equal(row.lastName, LAST_NAME, 'Check lastName value')

          assert.false(isNaN(Date.parse(row.dob)), 'Check if the returned dob is a Date')

          assert.true((typeof row.nationalId === 'string'), 'Check nationalId type')
          assert.equal(row.nationalId, NATIONAL_ID, 'Check nationalId value')

          assert.true((typeof row.amount === 'number'), 'Check amount type')
          assert.equal(row.amount, TEST_AMOUNT, 'Check amount value')

          assert.true((typeof row.paymentStatusId === 'number'), 'Check paymentStatusId type')
          assert.equal(row.paymentStatusId, PAYMET_STATUS_MODIFIED, 'Check paymentStatusId value')

          assert.true((typeof row.info === 'string'), 'Check payment info type')
          assert.equal(row.info, INFO, 'Check that payment info is set')

          assert.false(isNaN(Date.parse(row.createdAt)), 'Check if the returned createdAt is a Date')
          assert.false(isNaN(Date.parse(row.updatedAt)), 'Check if the returned updatedAt is a Date')
        })
      }
    }
    ])
  }
}, module.parent)
