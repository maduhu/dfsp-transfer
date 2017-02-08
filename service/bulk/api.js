var joi = require('joi')
module.exports = {
  'batch.add': {
    auth: false,
    description: 'Bulk batch add',
    notes: 'Bulk batch add',
    params: joi.any(),
    result: joi.any()
  }
}
