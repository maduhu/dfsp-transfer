var create = require('ut-error').define
var defaultErrorCode = 400
module.exports = [
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
    type: 'bulk.statusIdNotFound',
    message: 'Status with the given statusId does not exist',
    statusCode: 422
  },
  {
    id: 'MissingOriginalFileName',
    type: 'bulk.missingOriginalFileName',
    message: 'Can not create new upload record without original file name',
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
