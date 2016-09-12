var create = require('ut-error').define

var RPC = create('Transfer')

module.exports = {
  transfer: function (cause) {
    return new RPC(cause)
  }
}
