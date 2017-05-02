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
  'invoice.execute': {
    auth: false,
    description: 'Transfer invoice execute',
    notes: 'Transfer invoice execute',
    params: joi.any(),
    result: joi.any()
  },
  'invoice.fetch': {
    auth: false,
    description: 'Transfer invoice fetch',
    notes: 'Transfer invoice fetch',
    params: joi.any(),
    result: joi.any()
  },
  'invoice.cancel': {
    auth: false,
    description: 'Transfer invoice cancel',
    notes: 'Transfer invoice cancel',
    params: joi.any(),
    result: joi.any()
  },
  'invoice.reject': {
    auth: false,
    description: 'Transfer invoice reject',
    notes: 'Transfer invoice reject',
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
    notes: 'Transfer invoiceNotification fetch',
    params: joi.any(),
    result: joi.any()
  },
  'invoiceNotification.edit': {
    auth: false,
    description: 'Transfer invoiceNotification edit',
    notes: 'Transfer invoiceNotification edit',
    params: joi.any(),
    result: joi.any()
  },
  'invoiceNotification.execute': {
    auth: false,
    description: 'Transfer invoiceNotification execute',
    notes: 'Transfer invoiceNotification execute',
    params: joi.any(),
    result: joi.any()
  },
  'invoiceNotification.reject': {
    auth: false,
    description: 'Transfer invoiceNotification reject',
    notes: 'Transfer invoiceNotification reject',
    params: joi.any(),
    result: joi.any()
  },
  'invoiceNotification.cancel': {
    auth: false,
    description: 'Transfer invoiceNotification cancel',
    notes: 'Transfer invoiceNotification cancel',
    params: joi.any(),
    result: joi.any()
  },
  'invoiceNotification.get': {
    auth: false,
    description: 'Transfer invoiceNotification get',
    notes: 'Transfer invoiceNotification get',
    params: joi.object().keys({
      invoiceNotificationId: joi.string().required()
    }),
    result: joi.any()
  },
  'invoicePayer.add': {
    auth: false,
    description: 'Transfer invoicePayer add',
    notes: 'Transfer invoicePayer add',
    params: joi.any(),
    result: joi.any()
  },
  'invoicePayer.fetch': {
    auth: false,
    description: 'Transfer invoicePayer fetch',
    notes: 'Transfer invoicePayer fetch',
    params: joi.any(),
    result: joi.any()
  },
  'invoicePayer.get': {
    auth: false,
    description: 'Transfer invoicePayer get',
    notes: 'Transfer invoicePayer get',
    params: joi.any(),
    result: joi.any()
  }
}
