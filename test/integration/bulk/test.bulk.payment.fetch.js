var test = require('ut-run/test')
var config = require('../../lib/appConfig')
const TIMESTAMP = (new Date()).getTime()
const NAME = 'Batch-' + TIMESTAMP
const ACTOR_ID = '' + Math.floor(Math.random() * 10)
const FILE_NAME = 'File-' + TIMESTAMP
const ORIGINAL_FILE_NAME = 'OriginalFile-' + TIMESTAMP
const PAYMENTS = require('./data/payments.json')
const PAYMENT_STATUS_NEW = 1
const SEARCH_PATTERN_FIRST_NAME = 'bob'
const SEARCH_PATTERN_LAST_NAME = 'cooper'
const EXISTING_NATIONAL_ID = '123456789'

test({
  type: 'integration',
  name: 'Bulk payment fetch test',
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
      name: 'Fetch payments by batchId',
      method: 'bulk.payment.fetch',
      params: (context) => {
        return {
          batchId: context['Create batch to link the payments with'].batchId
        }
      },
      result: function (result, assert) {
        var recordsMap = new Map()
        result.forEach((element) => {
          recordsMap.set(element.identifier, element)
        })
        PAYMENTS.forEach((payment) => {
          let matchedResultPayment = recordsMap.get(payment.identifier)
          assert.true((typeof matchedResultPayment.paymentId === 'string'), 'Check paymentId type')
          assert.true((typeof matchedResultPayment.batchId === 'number'), 'Check batchId type')
          assert.equal(matchedResultPayment.batchId, this['Create batch to link the payments with'].batchId, 'Check the batchId value')

          assert.true((typeof matchedResultPayment.sequenceNumber === 'number'), 'Check sequenceNumber type')
          assert.equal(matchedResultPayment.sequenceNumber, payment.sequenceNumber, 'Check sequenceNumber value')

          assert.true((typeof matchedResultPayment.identifier === 'string'), 'Check identifier type')
          assert.equal(matchedResultPayment.identifier, payment.identifier, 'Check identifier value')

          assert.true((typeof matchedResultPayment.firstName === 'string'), 'Check firstName type')
          assert.equal(matchedResultPayment.firstName, payment.firstName, 'Check firstName value')

          assert.true((typeof matchedResultPayment.lastName === 'string'), 'Check lastName type')
          assert.equal(matchedResultPayment.lastName, payment.lastName, 'Check lastName value')

          assert.false(isNaN(Date.parse(matchedResultPayment.dob)), 'Check if the returned dob is a Date')

          assert.true((typeof matchedResultPayment.nationalId === 'string'), 'Check nationalId type')
          assert.equal(matchedResultPayment.nationalId, payment.nationalId, 'Check nationalId value')

          assert.true((typeof matchedResultPayment.amount === 'string'), 'Check amount type')
          assert.equal(matchedResultPayment.amount, payment.amount.toString(), 'Check amount value')

          assert.true((typeof matchedResultPayment.paymentStatusId === 'number'), 'Check paymentStatusId type')
          assert.equal(matchedResultPayment.paymentStatusId, PAYMENT_STATUS_NEW, 'Check paymentStatusId value')

          assert.true((matchedResultPayment.info === null), 'Check that payment info is not set')

          assert.false(isNaN(Date.parse(matchedResultPayment.createdAt)), 'Check if the returned createdAt is a Date')
          assert.false(isNaN(Date.parse(matchedResultPayment.updatedAt)), 'Check if the returned updatedAt is a Date')
        })
      }
    },
    {
      name: 'Fetch payments by first name',
      method: 'bulk.payment.fetch',
      params: (context) => {
        return {
          name: SEARCH_PATTERN_FIRST_NAME
        }
      },
      result: function (result, assert) {
        assert.true(result.length > 0, 'Check that there are results co-responding to the given search pattern')
        if (result.length > 0) {
          result.forEach((record) => {
            assert.true((typeof record.paymentId === 'string'), 'Check paymentId type')
            assert.true((typeof record.batchId === 'number'), 'Check batchId type')
            assert.true((typeof record.sequenceNumber === 'number'), 'Check sequenceNumber type')
            assert.true((typeof record.identifier === 'string'), 'Check identifier type')
            assert.true((typeof record.firstName === 'string'), 'Check firstName type')
            assert.true((typeof record.lastName === 'string'), 'Check lastName type')
            assert.false(isNaN(Date.parse(record.dob)), 'Check if the returned dob is a Date')
            assert.true((typeof record.nationalId === 'string'), 'Check nationalId type')
            assert.true((typeof record.amount === 'string'), 'Check amount type')
            assert.true((typeof record.paymentStatusId === 'number'), 'Check paymentStatusId type')
            assert.false(isNaN(Date.parse(record.createdAt)), 'Check if the returned createdAt is a Date')
            assert.false(isNaN(Date.parse(record.updatedAt)), 'Check if the returned updatedAt is a Date')
          })
        }
      }
    },
    {
      name: 'Fetch payments by last name',
      method: 'bulk.payment.fetch',
      params: (context) => {
        return {
          name: SEARCH_PATTERN_LAST_NAME
        }
      },
      result: function (result, assert) {
        assert.true(result.length > 0, 'Check that there are results co-responding to the given search pattern')
        if (result.length > 0) {
          result.forEach((record) => {
            assert.true((typeof record.paymentId === 'string'), 'Check paymentId type')
            assert.true((typeof record.batchId === 'number'), 'Check batchId type')
            assert.true((typeof record.sequenceNumber === 'number'), 'Check sequenceNumber type')
            assert.true((typeof record.identifier === 'string'), 'Check identifier type')
            assert.true((typeof record.firstName === 'string'), 'Check firstName type')
            assert.true((typeof record.lastName === 'string'), 'Check lastName type')
            assert.false(isNaN(Date.parse(record.dob)), 'Check if the returned dob is a Date')
            assert.true((typeof record.nationalId === 'string'), 'Check nationalId type')
            assert.true((typeof record.amount === 'string'), 'Check amount type')
            assert.true((typeof record.paymentStatusId === 'number'), 'Check paymentStatusId type')
            assert.false(isNaN(Date.parse(record.createdAt)), 'Check if the returned createdAt is a Date')
            assert.false(isNaN(Date.parse(record.updatedAt)), 'Check if the returned updatedAt is a Date')
          })
        }
      }
    },
    {
      name: 'Fetch payments by paymentId',
      method: 'bulk.payment.fetch',
      params: (context) => {
        return {
          paymentId: [1] // DB is recreating every time so payment table must have payment with id = 1
        }
      },
      result: function (result, assert) {
        assert.true(result.length === 1, 'Check that there is only one result matching to the given paymentId')
        if (result.length === 1) {
          let record = result[0]
          assert.true((typeof record.paymentId === 'string'), 'Check paymentId type')
          assert.true((typeof record.batchId === 'number'), 'Check batchId type')
          assert.true((typeof record.sequenceNumber === 'number'), 'Check sequenceNumber type')
          assert.true((typeof record.identifier === 'string'), 'Check identifier type')
          assert.true((typeof record.firstName === 'string'), 'Check firstName type')
          assert.true((typeof record.lastName === 'string'), 'Check lastName type')
          assert.false(isNaN(Date.parse(record.dob)), 'Check if the returned dob is a Date')
          assert.true((typeof record.nationalId === 'string'), 'Check nationalId type')
          assert.true((typeof record.amount === 'string'), 'Check amount type')
          assert.true((typeof record.paymentStatusId === 'number'), 'Check paymentStatusId type')
          assert.false(isNaN(Date.parse(record.createdAt)), 'Check if the returned createdAt is a Date')
          assert.false(isNaN(Date.parse(record.updatedAt)), 'Check if the returned updatedAt is a Date')
        }
      }
    },
    {
      name: 'Fetch payments by nationalId',
      method: 'bulk.payment.fetch',
      params: (context) => {
        return {
          nationalId: EXISTING_NATIONAL_ID
        }
      },
      result: function (result, assert) {
        assert.true(result.length > 0, 'Check that there is only one result matching to the given paymentId')
        if (result.length > 0) {
          let record = result[0]
          assert.true((typeof record.paymentId === 'string'), 'Check paymentId type')
          assert.true((typeof record.batchId === 'number'), 'Check batchId type')
          assert.true((typeof record.sequenceNumber === 'number'), 'Check sequenceNumber type')
          assert.true((typeof record.identifier === 'string'), 'Check identifier type')
          assert.true((typeof record.firstName === 'string'), 'Check firstName type')
          assert.true((typeof record.lastName === 'string'), 'Check lastName type')
          assert.false(isNaN(Date.parse(record.dob)), 'Check if the returned dob is a Date')
          assert.true((typeof record.nationalId === 'string'), 'Check nationalId type')
          assert.true((typeof record.amount === 'string'), 'Check amount type')
          assert.true((typeof record.paymentStatusId === 'number'), 'Check paymentStatusId type')
          assert.false(isNaN(Date.parse(record.createdAt)), 'Check if the returned createdAt is a Date')
          assert.false(isNaN(Date.parse(record.updatedAt)), 'Check if the returned updatedAt is a Date')
        }
      }
    },
    {
      name: 'Fetch payments by paymentStatusId',
      method: 'bulk.payment.fetch',
      params: (context) => {
        return {
          paymentStatusId: [PAYMENT_STATUS_NEW]
        }
      },
      result: function (result, assert) {
        assert.true(result.length > 0, 'Check that there is only one result matching to the given paymentId')
        if (result.length > 0) {
          let record = result[0]
          assert.true((typeof record.paymentId === 'string'), 'Check paymentId type')
          assert.true((typeof record.batchId === 'number'), 'Check batchId type')
          assert.true((typeof record.sequenceNumber === 'number'), 'Check sequenceNumber type')
          assert.true((typeof record.identifier === 'string'), 'Check identifier type')
          assert.true((typeof record.firstName === 'string'), 'Check firstName type')
          assert.true((typeof record.lastName === 'string'), 'Check lastName type')
          assert.false(isNaN(Date.parse(record.dob)), 'Check if the returned dob is a Date')
          assert.true((typeof record.nationalId === 'string'), 'Check nationalId type')
          assert.true((typeof record.amount === 'string'), 'Check amount type')
          assert.true((typeof record.paymentStatusId === 'number'), 'Check paymentStatusId type')
          assert.false(isNaN(Date.parse(record.createdAt)), 'Check if the returned createdAt is a Date')
          assert.false(isNaN(Date.parse(record.updatedAt)), 'Check if the returned updatedAt is a Date')
        }
      }
    },
    {
      name: 'Fetch payments by date period',
      method: 'bulk.payment.fetch',
      params: (context) => {
        let today = new Date()
        let yesterday = new Date()
        let tomorrow = new Date()
        yesterday.setDate(today.getDate() - 1)
        tomorrow.setDate(today.getDate() + 1)
        return {
          fromDate: yesterday,
          toDate: tomorrow
        }
      },
      result: function (result, assert) {
        assert.true(result.length > 0, 'Check that there are results matching to this date period')
        if (result.length > 0) {
          let record = result[0]
          assert.true((typeof record.paymentId === 'string'), 'Check paymentId type')
          assert.true((typeof record.batchId === 'number'), 'Check batchId type')
          assert.true((typeof record.sequenceNumber === 'number'), 'Check sequenceNumber type')
          assert.true((typeof record.identifier === 'string'), 'Check identifier type')
          assert.true((typeof record.firstName === 'string'), 'Check firstName type')
          assert.true((typeof record.lastName === 'string'), 'Check lastName type')
          assert.false(isNaN(Date.parse(record.dob)), 'Check if the returned dob is a Date')
          assert.true((typeof record.nationalId === 'string'), 'Check nationalId type')
          assert.true((typeof record.amount === 'string'), 'Check amount type')
          assert.true((typeof record.paymentStatusId === 'number'), 'Check paymentStatusId type')
          assert.false(isNaN(Date.parse(record.createdAt)), 'Check if the returned createdAt is a Date')
          assert.false(isNaN(Date.parse(record.updatedAt)), 'Check if the returned updatedAt is a Date')
        }
      }
    },
    {
      name: 'Add many payments to test ',
      method: 'bulk.payment.add',
      params: (context) => {
        var listPayments = PAYMENTS
        var generatedPayments = []
        let tmp
        for (let i = 1; i <= 10; i++) {
          if (i % 2 === 0) {
            tmp = JSON.parse(JSON.stringify(listPayments[1]))
            tmp.sequenceNumber = 10 + i
            generatedPayments.push(tmp)
          } else {
            tmp = JSON.parse(JSON.stringify(listPayments[0]))
            tmp.sequenceNumber = 10 + i
            generatedPayments.push(tmp)
          }
        }
        return {
          payments: JSON.stringify(generatedPayments),
          actorId: ACTOR_ID,
          batchId: context['Create batch to link the payments with'].batchId
        }
      },
      result: (result, assert) => {
        assert.equal(result.insertedRows, 10, 'Check that all the payments were inserted')
      }
    },
    {
      name: 'Fetch payments by batchId with paging - page 1',
      method: 'bulk.payment.fetch',
      params: (context) => {
        return {
          batchId: context['Create batch to link the payments with'].batchId,
          pageSize: 5,
          pageNumber: 1
        }
      },
      result: function (result, assert) {
        assert.equal(result.length, 5, 'Check that db returns correct page size')
      }
    },
    {
      name: 'Fetch payments by batchId with paging - page 2',
      method: 'bulk.payment.fetch',
      params: (context) => {
        return {
          batchId: context['Create batch to link the payments with'].batchId,
          pageSize: 5,
          pageNumber: 2
        }
      },
      result: function (result, assert) {
        assert.equal(result.length, 5, 'Check that db returns correct page size')
      }
    }
    ])
  }
}, module.parent)
