var create = require('ut-error').define
var defaultErrorCode = 400
module.exports = [
  {
    type: 'transfer',
    message: 'transfer error'
  },
  {
    id: 'AccountMissingError',
    type: 'transfer.accountMissing',
    message: 'Missing account',
    statusCode: 422
  },
  {
    id: 'NameMissingError',
    type: 'transfer.nameMissing',
    message: 'Missing name',
    statusCode: 422
  },
  {
    id: 'CurrencyCodeMissingError',
    type: 'transfer.currencyCodeMissing',
    message: 'Missing currency code',
    statusCode: 422
  },
  {
    id: 'CurrencySymbolMissingError',
    type: 'transfer.currencySymbolMissing',
    message: 'Missing currency symbol',
    statusCode: 422
  },
  {
    id: 'AmountMissingError',
    type: 'transfer.amountMissing',
    message: 'Missing amount',
    statusCode: 422
  },
  {
    id: 'MerchantIdentifierMissingError',
    type: 'transfer.merchantIdentifierMissing',
    message: 'Missing merchant identifier',
    statusCode: 422
  },
  {
    id: 'InvoiceTypeMissingError',
    type: 'transfer.invoiceTypeMissing',
    message: 'Missing invoice type',
    statusCode: 422
  },
  {
    id: 'IdentifierMissingError',
    type: 'transfer.identifierMissing',
    message: 'Missing identifier',
    statusCode: 422
  },
  {
    id: 'InvoiceIdMissingError',
    type: 'transfer.invoiceIdMissing',
    message: 'Missing invoice id',
    statusCode: 422
  },
  {
    id: 'InvoiceStatusIdMissingError',
    type: 'transfer.invoiceStatusIdMissing',
    message: 'Invoice status id is missing',
    statusCode: 422
  },
  {
    id: 'InvoiceNotFoundError',
    type: 'transfer.invoiceNotFound',
    message: 'Invoice was not found',
    statusCode: 422
  },
  {
    id: 'InvoiceNotPendingError',
    type: 'transfer.invoiceNotPending',
    message: 'Invoice is not in pending status',
    statusCode: 422
  },
  {
    id: 'InvoiceNotStandardError',
    type: 'transfer.invoiceNotStandard',
    message: 'Invoice is not standard type',
    statusCode: 422
  },
  {
    id: 'InvoiceNotificationIdMissingError',
    type: 'transfer.invoiceNotificationIdMissing',
    message: 'Invoice notification id is missing',
    statusCode: 422
  },
  {
    id: 'InvoicestatusIdMissingError',
    type: 'transfer.invoicestatusIdMissing',
    message: 'Invoice notification status id is missing',
    statusCode: 422
  },
  {
    id: 'InvoiceNotificationNotFoundError',
    type: 'transfer.invoiceNotificationNotFound',
    message: 'Invoice notification was not found',
    statusCode: 422
  },
  {
    id: 'InvoiceIdMissingError',
    type: 'transfer.invoiceIdMissing',
    message: 'Invoice id is missing',
    statusCode: 422
  },
  {
    id: 'InvoicePayerIdNotFoundError',
    type: 'transfer.invoicePayerIdNotFound',
    message: 'Invoice payer with such id was not found',
    statusCode: 422
  },
  {
    id: 'InvoicePayerIdMissingError',
    type: 'transfer.invoicePayerIdMissing',
    message: 'Invoice payer id is missing',
    statusCode: 422
  },
  {
    id: 'InvoicePayerMissmatchError',
    type: 'transfer.invoicePayerMismatch',
    message: 'Invoice payer missmatch',
    statusCode: 422
  },
  {
    id: 'WrongInvoiceTypeError',
    type: 'transfer.wrongInvoiceType',
    message: 'Invoice has wrong type',
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
