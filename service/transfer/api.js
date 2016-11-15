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
  }
}
