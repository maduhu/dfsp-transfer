<a name="0.18.9"></a>
## [0.18.9](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.18.8...v0.18.9) (2017-04-03)


### Bug Fixes

* update ut-port-httpserver ([6fd7db7](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/6fd7db7))



<a name="0.18.8"></a>
## [0.18.8](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.18.7...v0.18.8) (2017-03-15)


### Bug Fixes

* add identifier types ([ce77cd6](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/ce77cd6))
* add possibility to inspect db ([b3d9de6](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/b3d9de6))



<a name="0.18.7"></a>
## [0.18.7](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.18.6...v0.18.7) (2017-03-09)


### Bug Fixes

* fix typo ([98000b3](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/98000b3))



<a name="0.18.6"></a>
## [0.18.6](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.18.5...v0.18.6) (2017-03-09)


### Bug Fixes

* prevent insertion of the disabled payments in the payments queue ([b69c300](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/b69c300))



<a name="0.18.5"></a>
## [0.18.5](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.18.4...v0.18.5) (2017-03-09)


### Bug Fixes

* bulk.payment.process to handle case when the [@error](https://github.com/error) is either null or empty string ([56c6601](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/56c6601))



<a name="0.18.4"></a>
## [0.18.4](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.18.3...v0.18.4) (2017-03-08)


### Bug Fixes

* typo ([a6fca61](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/a6fca61))



<a name="0.18.3"></a>
## [0.18.3](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.18.2...v0.18.3) (2017-03-07)


### Bug Fixes

* set bulk payment to paid in case [@error](https://github.com/error) is null or '' ([519cb67](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/519cb67))



<a name="0.18.2"></a>
## [0.18.2](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.18.1...v0.18.2) (2017-03-06)


### Bug Fixes

* update batch status after batch processing ([6018b1c](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/6018b1c))



<a name="0.18.1"></a>
## [0.18.1](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.18.0...v0.18.1) (2017-03-06)


### Bug Fixes

* add actorId in fetch query ([9fa1d56](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/9fa1d56))
* remove extra spaces on the line ([ca98af4](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/ca98af4))



<a name="0.18.0"></a>
# [0.18.0](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.17.0...v0.18.0) (2017-03-02)


### Features

* do no show deleted batches ([72b50c2](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/72b50c2))



<a name="0.17.0"></a>
# [0.17.0](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.16.4...v0.17.0) (2017-03-02)


### Features

* retry every monute for the purpose of demo and debug ([f7cd005](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/f7cd005))



<a name="0.16.4"></a>
## [0.16.4](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.16.3...v0.16.4) (2017-03-01)


### Bug Fixes

* batch payment functions - do not pay disabled or paid payments; fix successful payment edit ([40dd887](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/40dd887))



<a name="0.16.3"></a>
## [0.16.3](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.16.2...v0.16.3) (2017-03-01)


### Bug Fixes

* query references wrong schema ([46b4ded](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/46b4ded))



<a name="0.16.2"></a>
## [0.16.2](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.16.1...v0.16.2) (2017-03-01)


### Bug Fixes

* rework batch statuses ([cb74b6d](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/cb74b6d))



<a name="0.16.1"></a>
## [0.16.1](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.16.0...v0.16.1) (2017-02-28)


### Bug Fixes

* batch process queries ([76f304c](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/76f304c))
* move queue to bulk schema ([fc576cf](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/fc576cf))
* remove non existing api calls ([b1b55b8](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/b1b55b8))
* remove unused method ([2663506](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/2663506))
* rework payment and batch statuses ([69e14e6](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/69e14e6))
* update batch status to processing on batch pay ([66023f1](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/66023f1))



<a name="0.16.0"></a>
# [0.16.0](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.15.3...v0.16.0) (2017-02-24)


### Bug Fixes

* change retryId type to smallint ([f90a9ca](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/f90a9ca))
* rename accountNumber to account ([6d8b055](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/6d8b055))
* review comments: remove excess data from fetch and fix update query ([a814e9f](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/a814e9f))
* typo ([c8b9963](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/c8b9963))


### Features

* add bulk.payment.get method ([0ac4fa7](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/0ac4fa7))
* add queue schema ([267aef6](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/267aef6))
* add validations for bulk payment methods, improve bulk.batch.process and bulk.payment.process methods ([032d513](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/032d513))
* remove scheduler and add methods 'bulk.batch.process', 'bulk.payment.getForProcessing', 'bulk.payment.preProcess' and 'bulk.payment.process' ([7f9a1a8](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/7f9a1a8))



<a name="0.15.3"></a>
## [0.15.3](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.15.2...v0.15.3) (2017-02-23)


### Bug Fixes

* rework bulk.payment.fetch by name to search by payment first or last name ([0c7e86c](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/0c7e86c))



<a name="0.15.2"></a>
## [0.15.2](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.15.1...v0.15.2) (2017-02-22)


### Bug Fixes

* add default sorting to batch.fetch ([aac53be](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/aac53be))
* make search by name with pattern and case insensitive ([5b848ed](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/5b848ed))
* set last validated on only if the whole batch is being checked ([901419b](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/901419b))



<a name="0.15.1"></a>
## [0.15.1](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.15.0...v0.15.1) (2017-02-21)


### Bug Fixes

* add validatedAt row in batch and batchHistory table ([f7428a2](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/f7428a2))
* fix casting ([e6fc5e5](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/e6fc5e5))



<a name="0.15.0"></a>
# [0.15.0](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.14.0...v0.15.0) (2017-02-21)


### Bug Fixes

* get the info about the latest uploaded file ([6701d38](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/6701d38))
* last validated on date on batch.fetch ([c1b215d](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/c1b215d))
* procedures for get and fetch changes ([ea4cbff](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/ea4cbff))
* replace "lastValidation" with "updatedAt" ([c2319f7](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/c2319f7))


### Features

* add batch.ready function ([c9229c1](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/c9229c1))



<a name="0.14.0"></a>
# [0.14.0](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.13.4...v0.14.0) (2017-02-17)


### Bug Fixes

* add all data to batch table and use batchHistory as full copy ([d4cd1b3](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/d4cd1b3))
* add fileName in the return statement ([6d3a3d7](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/6d3a3d7))
* add httpserver validations skeleton ([dc79b0f](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/dc79b0f))
* add info column in payment and paymentHistory ([a048cf5](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/a048cf5))
* add input validations to the procedures ([e5abb08](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/e5abb08))
* add input verifications to the procedures ([3ce5e92](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/3ce5e92))
* add mismatch status for payments and define bulk.batch.revertStatus backend api method ([6971e7b](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/6971e7b))
* add original file name in return statement ([59edeb1](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/59edeb1))
* add originalFileName to batch.add ([5e8bc5e](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/5e8bc5e))
* add paging ([16babab](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/16babab))
* add paymentId:Array as input for payment fetch ([0aa1901](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/0aa1901))
* add revert batch status ([8b1df5b](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/8b1df5b))
* apply db structure changes to have different statuses for batch and payments ([dd37aec](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/dd37aec))
* bulk.batch.edit - move all data to batch table and make ull copy to history table on edit ([4bbac4e](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/4bbac4e))
* folder restructuring ([3b2e98f](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/3b2e98f))
* prepare cron ([324bdc3](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/324bdc3))
* refactor bulk.batch.edit procedure ([f9276eb](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/f9276eb))
* return single result from batch.edit ([43e3d8b](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/43e3d8b))
* update batch and payment status nomenclatures ([899dad1](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/899dad1))
* update upload where clause ([3c09697](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/3c09697))


### Features

* add bulk payment fetch procedure ([f74ce79](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/f74ce79))
* add bulk payment schema ([16943c2](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/16943c2))
* add bulk.batch.edit procedure ([a37b9ef](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/a37b9ef))
* add bulk.payment.edit function ([f796259](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/f796259))
* add payment status fetch function ([6d95369](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/6d95369))
* bulk payments - add batch.add function ([970b72f](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/970b72f))
* bulk payments - add batch.fetch function ([de3f9ec](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/de3f9ec))
* bulk payments - add batch.get function ([70cf109](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/70cf109))
* bulk payments - add payment.add function ([bfbbb4e](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/bfbbb4e))
* list bulk payments to admin view with filter functionality ([d6d7562](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/d6d7562))
* prepare bulk payment scheduler to initialize with configuration upon start ([6970a0d](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/6970a0d))



<a name="0.13.4"></a>
## [0.13.4](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.13.3...v0.13.4) (2017-01-31)


### Bug Fixes

* circleci settings and npm commands ([4d79739](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/4d79739))



<a name="0.13.3"></a>
## [0.13.3](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.13.2...v0.13.3) (2017-01-25)


### Bug Fixes

* add transfer.invoiceNotification.get method validation ([e78bb28](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/e78bb28))



<a name="0.13.2"></a>
## [0.13.2](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.13.1...v0.13.2) (2016-12-16)


### Bug Fixes

* update dependencies ([cc51fde](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/cc51fde))



<a name="0.13.1"></a>
## [0.13.1](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.13.0...v0.13.1) (2016-12-12)


### Bug Fixes

* add transfer.invoiceNotification.edit validation ([f8d3631](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/f8d3631))



<a name="0.13.0"></a>
# [0.13.0](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.12.3...v0.13.0) (2016-12-12)


### Features

* add statusCode parameter to transfer.invoiceNotification.fetch db function ([542c569](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/542c569))



<a name="0.12.3"></a>
## [0.12.3](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.12.2...v0.12.3) (2016-12-08)


### Bug Fixes

* temporarily set more loose validations ([3581dc9](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/3581dc9))



<a name="0.12.2"></a>
## [0.12.2](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.12.1...v0.12.2) (2016-12-08)


### Bug Fixes

* remove spsp and dfsp-rule http clients as they have been moved to dfsp-api for consistency ([795526a](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/795526a))



<a name="0.12.1"></a>
## [0.12.1](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.12.0...v0.12.1) (2016-12-07)


### Bug Fixes

* add utility function for converting snake_case to camelCase ([bd393ab](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/bd393ab))



<a name="0.12.0"></a>
# [0.12.0](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.11.1...v0.12.0) (2016-12-07)


### Features

* add utility methods for adding sample data ([12a7d64](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/12a7d64))



<a name="0.11.1"></a>
## [0.11.1](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.11.0...v0.11.1) (2016-11-30)


### Bug Fixes

* fix db functions to return invoice type ([07ceb2f](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/07ceb2f))



<a name="0.11.0"></a>
# [0.11.0](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.10.0...v0.11.0) (2016-11-30)


### Features

* add type property of GET receivers/invoices/:id ([6907ae2](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/6907ae2))



<a name="0.10.0"></a>
# [0.10.0](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.9.7...v0.10.0) (2016-11-30)


### Features

* add more detailed logging to http clients ([ab7027f](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/ab7027f))



<a name="0.9.7"></a>
## [0.9.7](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.9.6...v0.9.7) (2016-11-29)


### Bug Fixes

* improve consistency between mock and spsp-client ([d8b7cac](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/d8b7cac))



<a name="0.9.6"></a>
## [0.9.6](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.9.5...v0.9.6) (2016-11-29)


### Bug Fixes

* mock fix when obtaining info about pending transactions ([50d732a](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/50d732a))



<a name="0.9.5"></a>
## [0.9.5](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.9.4...v0.9.5) (2016-11-29)


### Bug Fixes

* change /receivers/invoices to /invoices ([d1d8f91](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/d1d8f91))



<a name="0.9.4"></a>
## [0.9.4](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.9.3...v0.9.4) (2016-11-28)


### Bug Fixes

* fix invoiceNotification method validation ([94487e4](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/94487e4))



<a name="0.9.3"></a>
## [0.9.3](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.9.2...v0.9.3) (2016-11-28)


### Bug Fixes

* submissionUrl ([44b355c](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/44b355c))



<a name="0.9.2"></a>
## [0.9.2](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.9.1...v0.9.2) (2016-11-28)


### Bug Fixes

* update dependencies ([029be4b](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/029be4b))



<a name="0.9.1"></a>
## [0.9.1](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.9.0...v0.9.1) (2016-11-28)


### Bug Fixes

* extra check for spsp configuration ([f717e62](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/f717e62))



<a name="0.9.0"></a>
# [0.9.0](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.8.4...v0.9.0) (2016-11-28)


### Features

* call spsp/transfer.invoiceNotification.add or directly transfer.invoiceNotification.add depending on cofiguration" ([5b01973](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/5b01973))



<a name="0.8.4"></a>
## [0.8.4](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.8.3...v0.8.4) (2016-11-25)


### Bug Fixes

* transfer.invoice.add and transfer.invoiceNotification.add fixes ([02c3423](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/02c3423))



<a name="0.8.3"></a>
## [0.8.3](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.8.2...v0.8.3) (2016-11-25)


### Bug Fixes

* change mock data ([2bbb3d4](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/2bbb3d4))



<a name="0.8.2"></a>
## [0.8.2](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.8.1...v0.8.2) (2016-11-24)


### Bug Fixes

* change clientUserNumber with senderIdentifier ([b5e8e90](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/b5e8e90))



<a name="0.8.1"></a>
## [0.8.1](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.8.0...v0.8.1) (2016-11-22)


### Bug Fixes

* typo ([8cbfee6](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/8cbfee6))



<a name="0.8.0"></a>
# [0.8.0](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.7.2...v0.8.0) (2016-11-22)


### Bug Fixes

* add invoice.edit method and fix db functions ([fd5bc21](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/fd5bc21))
* add mock config to external rc file ([be4a5d3](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/be4a5d3))
* changes for invoice.add method ([46763c1](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/46763c1))
* comment spsp mock back ([cb08e3a](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/cb08e3a))
* db structure refactoring ([a196b74](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/a196b74))
* issue [#283](https://github.com/LevelOneProject/dfsp-transfer/issues/283) - DFSP License files are incorrect ([f6f0130](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/f6f0130))
* lint errors ([a2be48f](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/a2be48f))
* prepare invoice notification integration with spsp ([8d714d3](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/8d714d3))
* refactor db ([f6f11e1](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/f6f11e1))
* transfer.invoiceNotification.fetch db function and backend method implemented ([98ee6d5](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/98ee6d5))
* typos ([9de76f9](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/9de76f9))
* update dependencies ([3fcfe1e](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/3fcfe1e))
* update spsp client endpoint ([c416816](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/c416816))
* validations ([11d7d15](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/11d7d15))


### Features

* add postgre functions initial version ([b0f8818](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/b0f8818))



<a name="0.7.2"></a>
## [0.7.2](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.7.1...v0.7.2) (2016-10-21)


### Bug Fixes

* disable repl and prepare mock configuration ([4178829](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/4178829))



<a name="0.7.1"></a>
## [0.7.1](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.7.0...v0.7.1) (2016-10-14)


### Bug Fixes

* fix publishing ([0a57f3a](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/0a57f3a))



<a name="0.7.0"></a>
# [0.7.0](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.6.1...v0.7.0) (2016-10-13)


### Features

* changes related to requiring peer implementations from tests ([b734758](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/b734758))



<a name="0.6.1"></a>
## [0.6.1](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.6.0...v0.6.1) (2016-10-13)


### Bug Fixes

* upgrade dependencies ([61867a6](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/61867a6))



<a name="0.6.0"></a>
# [0.6.0](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.5.0...v0.6.0) (2016-10-11)


### Bug Fixes

* add .npmrc ([5dfaa54](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/5dfaa54))


### Features

* automate build ([be84fcc](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/be84fcc))



<a name="0.5.0"></a>
# [0.5.0](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.4.5...v0.5.0) (2016-09-30)


### Bug Fixes

* change spsp URL ([af15604](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/af15604))
* fix circle ci build ([13676e0](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/13676e0))
* simplify socket client code ([1c3fb3b](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/1c3fb3b))


### Features

* add prepare websocket client subscriptions for transfers ([0d0550b](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/0d0550b))



<a name="0.4.5"></a>
## [0.4.5](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.4.4...v0.4.5) (2016-09-28)


### Bug Fixes

* add sourceAccount ([fd1b239](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/fd1b239))



<a name="0.4.4"></a>
## [0.4.4](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.4.3...v0.4.4) (2016-09-28)


### Bug Fixes

* fix transfer setup parameters ([f0b9835](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/f0b9835))



<a name="0.4.3"></a>
## [0.4.3](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.4.2...v0.4.3) (2016-09-27)


### Bug Fixes

* fix SPSP field names ([355efb6](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/355efb6))



<a name="0.4.2"></a>
## [0.4.2](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.4.1...v0.4.2) (2016-09-27)


### Bug Fixes

* fir SPSP URL ([3f3134d](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/3f3134d))



<a name="0.4.1"></a>
## [0.4.1](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.4.0...v0.4.1) (2016-09-27)


### Bug Fixes

* fix dependencies ([1e098dc](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/1e098dc))



<a name="0.4.0"></a>
# [0.4.0](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.3.2...v0.4.0) (2016-09-21)


### Features

* update transfer.push.execute method to use the spsp-client-proxy methods for setup/execute ([442985c](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/442985c))



<a name="0.3.2"></a>
## [0.3.2](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.3.1...v0.3.2) (2016-09-19)


### Bug Fixes

* fix console port settings ([317d54e](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/317d54e))



<a name="0.3.1"></a>
## [0.3.1](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.1.2...v0.3.1) (2016-09-19)


### Bug Fixes

* fix version ([c4d5010](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/c4d5010))



<a name="0.1.2"></a>
## [0.1.2](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.1.1...v0.1.2) (2016-09-19)


### Bug Fixes

* fix dependencies ([ccb4100](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/ccb4100))
* update configuration ([ed9401c](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/ed9401c))



<a name="0.1.1"></a>
## [0.1.1](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.2.0...v0.1.1) (2016-09-19)


### Bug Fixes

* update dependencies ([c5c23ac](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/c5c23ac))



<a name="0.2.0"></a>
# [0.2.0](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/compare/v0.1.0...v0.2.0) (2016-09-19)


### Features

* return connectorFee from transfer.rule.fetch ([23c205d](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/23c205d))



<a name="0.1.0"></a>
# 0.1.0 (2016-09-16)


### Bug Fixes

* integrate dfsp-transfer with spsp and ut-rule ([4eeb9b5](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/4eeb9b5))
* update dependencies ([fa73c43](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/fa73c43))


### Features

* add publish config ([5fa9180](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/5fa9180))
* implement transfer.push mock ([4bf01fa](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/4bf01fa))
* spsp http client initial ([b2354be](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/b2354be))
* spsp http client initial ([ade7d09](https://github.com/softwaregroup-bg/@leveloneproject/dfsp-transfer/commit/ade7d09))



