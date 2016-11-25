var joi = require('joi')
module.exports = {
  'push.execute': {
    // description: 'some description of the method',
    // notes: ['some notes about the method'],
    // tags: ['tag1', 'tag2'],
    description: 'Transfer push execute',
    notes: 'Transfer push execute',
    auth: false,
    params: joi.object({
      currency: joi.string().required(),
      destinationAccount: joi.string().required(),
      destinationAmount: joi.string().required(),
      fee: joi.number().required(),
      sourceAccount: joi.string().required()
    }).unknown(),
    result: joi.object({
      fulfillment: joi.string().required()
    }).unknown()
  },
  'rule.fetch': {
    // description: 'some description of the method',
    // notes: ['some notes about the method'],
    // tags: ['tag1', 'tag2'],
    auth: false,
    description: 'Transfer rule fetch',
    notes: 'Transfer rule fetch',
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
    params: joi.object().keys({
      invoiceId: joi.string().required()
    }),
    result: joi.any()
  },
  'invoice.edit': {
    auth: false,
    description: 'Edit invoice',
    notes: 'Edit invoice',
    params: joi.object().keys({
      invoiceId: joi.string().required(),
      statusCode: joi.string().required()
    }),
    result: joi.any()
  },
  'invoiceNotification.add': {
    auth: false,
    description: 'Transfer add invoice',
    notes: 'Transfer add invoice',
    params: joi.object().keys({
      invoiceUrl: joi.string().required(),
      senderIdentifier: joi.string().required(),
      memo: joi.string().required()
    }),
    result: joi.any()
  },
  'invoiceNotification.fetch': {
    auth: false,
    description: 'Transfer invoiceNotification fetch',
    notes: 'TraTransfer invoiceNotification fetch',
    params: joi.object().keys({
      userNumber: joi.string().required()
    }),
    result: joi.any()
  }
}
