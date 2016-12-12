var joi = require('joi')
module.exports = {
  'push.execute': {
    // description: 'some description of the method',
    // notes: ['some notes about the method'],
    // tags: ['tag1', 'tag2'],
    description: 'Transfer push execute',
    notes: 'Transfer push execute',
    auth: false,
    params: joi.any(),
    result: joi.any()
  },
  'invoice.add': {
    auth: false,
    description: 'Transfer add invoice',
    notes: 'Transfer add invoice',
    params: joi.any(),
    result: joi.any()
  },
  'invoice.get': {
    auth: false,
    description: 'Get invoice',
    notes: 'Get invoice',
    params: joi.any(),
    result: joi.any()
  },
  'invoice.edit': {
    auth: false,
    description: 'Edit invoice',
    notes: 'Edit invoice',
    params: joi.any(),
    result: joi.any()
  },
  'invoiceNotification.add': {
    auth: false,
    description: 'Transfer add invoice',
    notes: 'Transfer add invoice',
    params: joi.any(),
    result: joi.any()
  },
  'invoiceNotification.fetch': {
    auth: false,
    description: 'Transfer invoiceNotification fetch',
    notes: 'TraTransfer invoiceNotification fetch',
    params: joi.any(),
    result: joi.any()
  },
  'invoiceNotification.edit': {
    auth: false,
    description: 'Transfer invoiceNotification edit',
    notes: 'TraTransfer invoiceNotification edit',
    params: joi.any(),
    result: joi.any()
  }
}
