var joi = require('joi')
module.exports = {
  'push.execute': {
    // description: 'some description of the method',
    // notes: ['some notes about the method'],
    // tags: ['tag1', 'tag2'],
    description: 'Transfer push execute',
    notes: 'Transfer push execute',
    params: joi.object({
      currency: joi.string().required(),
      destinationAccount: joi.string().required(),
      destinationAmount: joi.string().required(),
      fee: joi.number().required(),
      sourceAccount: joi.string().required()
    }),
    result: joi.object({
      fulfillment: joi.string().required()
    })
  }
}
