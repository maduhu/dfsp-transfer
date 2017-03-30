var create = require('ut-error').define
var defaultErrorCode = 400
module.exports = [
  {
    type: 'bulk',
    message: 'bulk error'
  },
  {
    id: 'ActorIdMissingError',
    type: 'bulk.actorIdMissing',
    message: 'Missing actorId',
    statusCode: 422
  },
  {
    id: 'BatchIdMissingError',
    type: 'bulk.batchIdMissing',
    message: 'Missing batchId',
    statusCode: 422
  },
  {
    id: 'BatchNotFoundError',
    type: 'bulk.batchNotFound',
    message: 'Batch with the given batchId does not exist',
    statusCode: 422
  },
  {
    id: 'StatusIdNotFoundError',
    type: 'bulk.batchStatusIdNotFound',
    message: 'Batch status with the given batchStatusId does not exist',
    statusCode: 422
  },
  {
    id: 'MissingFileName',
    type: 'bulk.missingFileName',
    message: 'Missing file name',
    statusCode: 422
  },
  {
    id: 'MissingOriginalFileName',
    type: 'bulk.missingOriginalFileName',
    message: 'Missing original file name',
    statusCode: 422
  },
  {
    id: 'MissingName',
    type: 'bulk.nameIsMissing',
    message: 'Missing input name',
    statusCode: 422
  },
  {
    id: 'MissingPayments',
    type: 'bulk.paymentsMissing',
    message: 'Missing input payments',
    statusCode: 422
  },
  {
    id: 'MissingBatchId',
    type: 'bulk.batchIdMissing',
    message: 'Missing input batchId',
    statusCode: 422
  },
  {
    id: 'EmptyListWithPayments',
    type: 'bulk.emptyPayments',
    message: 'Empty list with payments',
    statusCode: 422
  }
].reduce((exporting, error) => {
  var typePath = error.type.split('.')
  var Ctor = create(typePath.pop(), typePath.join('.'), error.message)
  /**
   * Exceptions thrown from the db procedures will not execute this function
   * It will only be executed if an error is throw from JS
   */
  exporting[error.type] = function (params) {
    return new Ctor({
      isJsError: true,
      params: params,
      statusCode: error.statusCode || defaultErrorCode,
      id: error.id || error.type
    })
  }
  return exporting
}, {})
