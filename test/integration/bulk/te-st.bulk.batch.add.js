var test = require('ut-run/test')
var commonFunc = require('ut-test/lib/methods/commonFunc')
var number = 8
module.exports = function (opt, cache) {
  test({
    type: 'integration',
    name: 'Add bulk batch',
    server: opt.server,
    serverConfig: opt.serverConfig,
    client: opt.client,
    clientConfig: opt.clientConfig,
    steps: function (test, bus, run) {
      return run(test, bus, [
        commonFunc.createStep('bulk.batch.add', 'Add new batch with empty strings for params', (context) => {
          return {
            name: '',
            actorid: '',
            fileName: '',
            originalFileName: ''
          }
        }, (error, assert) => {
          assert.equals(error.message, 'Fill the error message here', 'bulk.batch.add failed with empty params')
        }),
        commonFunc.createStep('bulk.batch.add', 'Add new batch with invalid param type for name', (context) => {
          return {
            name: number,
            actorid: '',
            fileName: '',
            originalFileName: ''
          }
        }, (error, assert) => {
          assert.equals(error.message, 'Fill the error message here', 'bulk.batch.add failed  invalid param type for name')
        })
      ])

        // Procedure definition: bulk."batch.add" ("@name" varchar, "@actorId" varchar, "@fileName" varchar, "@originalFileName" varchar)
        // Test case 1: Try to add new batch with incorrect input types
        // 1. bulk."batch.add" (->number, "@actorId" varchar, "@fileName" varchar, "@originalFileName" varchar)
            // assert error
        // 2. bulk."batch.add" ("@name" varchar, ->number, "@fileName" varchar, "@originalFileName" varchar)
            // assert error
        // 3. bulk."batch.add" (->number, "@actorId" varchar, ->number, "@originalFileName" varchar)
            // assert error
        // 4. bulk."batch.add" (->number, "@actorId" varchar, "@fileName" varchar, ->number)
        // 5. bulk."batch.add" (->number, ->number, "@fileName" varchar, ->number)
        // 6. bulk."batch.add" (->number, "@actorId" varchar, ->number, "@originalFileName" varchar)
        // 7. bulk."batch.add" (->number, "@actorId" varchar, "@fileName" varchar, ->number)
        // 8. bulk."batch.add" ("@name" varchar, ->number, ->number, "@originalFileName" varchar)
        // 9. bulk."batch.add" ("@name" varchar, ->number, "@fileName" varchar, ->number)
        // 10. bulk."batch.add" ("@name" varchar, "@actorId" varchar, ->number, ->number)

        // 11. bulk."batch.add" (->number, ->number, ->number, "@originalFileName" varchar)
        // 12. bulk."batch.add" (->number, ->number, "@fileName" varchar, ->number)
        // 13. bulk."batch.add" (->number, "@actorId" varchar, ->number, ->number)
        // 14. bulk."batch.add" (->number, ->number, ->number, ->number)
        // 15. bulk."batch.add" (null, "@actorId" varchar, "@fileName" varchar, "@originalFileName" varchar)
        // 16. bulk."batch.add" ("@name" varchar, null, "@fileName" varchar, "@originalFileName" varchar)
        // 17. bulk."batch.add" ("@name" varchar, "@actorId" varchar, null, "@originalFileName" varchar)
        // 18. bulk."batch.add" ("@name" varchar, "@actorId" varchar, "@fileName" varchar, null)

        // 19. bulk."batch.add" (null, null, "@fileName" varchar, "@originalFileName" varchar)
        // 20. bulk."batch.add" (null, "@actorId" varchar, null, "@originalFileName" varchar)
        // 21. bulk."batch.add" (null, "@actorId" varchar, "@fileName" varchar, null)
        // 22. bulk."batch.add" (null, null, null, "@originalFileName" varchar)
        // 23. bulk."batch.add" (null, null, "@fileName" varchar, null)
        // 24. bulk."batch.add" ("@name" varchar, null, null, "@originalFileName" varchar)
        // 25. bulk."batch.add" ("@name" varchar, null, "@fileName" varchar, null)
        // 26. bulk."batch.add" ("@name" varchar, null, null, null)
        // 27. bulk."batch.add" ("@name" varchar, "@actorId" varchar, null, null)
        // 28. bulk."batch.add" (null, "@actorId" varchar, null, null)
        // 29. bulk."batch.add" (null, null, null, null)
    }
  }, cache)
}
