var joi = require('joi')
module.exports = {
  'queue.add': {
    auth: false,
    description: 'Queue add',
    notes: 'Queue add',
    params: joi.any(),
    result: joi.any()
  },
  'queue.fetch': {
    auth: false,
    description: 'Queue fetch',
    notes: 'Queue fetch',
    params: joi.any(),
    result: joi.any()
  },
  'queue.update': {
    auth: false,
    description: 'Queue update',
    notes: 'Queue update',
    params: joi.any(),
    result: joi.any()
  },
  'queue.remove': {
    auth: false,
    description: 'Queue remove',
    notes: 'Queue remove',
    params: joi.any(),
    result: joi.any()
  }
}
