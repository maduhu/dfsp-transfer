var joi = require('joi')
module.exports = {
  'batch.add': {
    auth: false,
    description: 'Bulk batch add',
    notes: 'Bulk batch add',
    params: joi.any(),
    result: joi.any()
  },
  'batch.edit': {
    auth: false,
    description: 'Bulk batch add',
    notes: 'Bulk batch add',
    params: joi.any(),
    result: joi.any()
  },
  'batch.fetch': {
    auth: false,
    description: 'Bulk batch add',
    notes: 'Bulk batch add',
    params: joi.any(),
    result: joi.any()
  },
  'batch.get': {
    auth: false,
    description: 'Bulk batch add',
    notes: 'Bulk batch add',
    params: joi.any(),
    result: joi.any()
  },
  'batch.ready': {
    auth: false,
    description: 'Bulk batch ready',
    notes: 'Bulk batch ready',
    params: joi.any(),
    result: joi.any()
  },
  'batch.revertStatus': {
    auth: false,
    description: 'Bulk batch revert status',
    notes: 'Bulk batch revert status',
    params: joi.any(),
    result: joi.any()
  },
  'batch.process': {
    auth: false,
    description: 'Bulk batch process',
    notes: 'Bulk batch process',
    params: joi.any(),
    result: joi.any()
  },
  'batchStatus.fetch': {
    auth: false,
    description: 'Bulk batch status',
    notes: 'Bulk batch status',
    params: joi.any(),
    result: joi.any()
  },
  'payment.add': {
    auth: false,
    description: 'Bulk batch add',
    notes: 'Bulk batch add',
    params: joi.any(),
    result: joi.any()
  },
  'payment.edit': {
    auth: false,
    description: 'Bulk batch add',
    notes: 'Bulk batch add',
    params: joi.any(),
    result: joi.any()
  },
  'payment.fetch': {
    auth: false,
    description: 'Bulk payment fetch',
    notes: 'Bulk payment fetch',
    params: joi.any(),
    result: joi.any()
  },
  'payment.get': {
    auth: false,
    description: 'Bulk payment fetch',
    notes: 'Bulk payment fetch',
    params: joi.any(),
    result: joi.any()
  },
  'paymentStatus.fetch': {
    auth: false,
    description: 'Bulk payment status fetch',
    notes: 'Bulk payment status fetch',
    params: joi.any(),
    result: joi.any()
  },
  'payment.getForProcessing': {
    auth: false,
    description: 'Bulk payment getForProcessing',
    notes: 'Bulk payment getForProcessing',
    params: joi.any(),
    result: joi.any()
  },
  'payment.preProcess': {
    auth: false,
    description: 'Bulk payment preProcess',
    notes: 'Bulk payment preProcess',
    params: joi.any(),
    result: joi.any()
  },
  'payment.process': {
    auth: false,
    description: 'Bulk payment process',
    notes: 'Bulk payment process',
    params: joi.any(),
    result: joi.any()
  }
}
