-- Insert batch statuses 
INSERT INTO
   bulk."batchStatus" ("batchStatusId", "name", "description")
SELECT
  1, 'uploading', 'Batch is uploading'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."batchStatus" WHERE "batchStatusId"=1);

INSERT INTO
   bulk."batchStatus" ("batchStatusId", "name", "description")
SELECT
  2, 'verifying', 'Batch file is in process of structure verification'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."batchStatus" WHERE "batchStatusId"=2);

INSERT INTO
   bulk."batchStatus" ("batchStatusId", "name", "description")
SELECT
  3, 'pending', 'Batch is awating to be approved by maker'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."batchStatus" WHERE "batchStatusId"=3);

INSERT INTO
   bulk."batchStatus" ("batchStatusId", "name", "description")
SELECT
  4, 'ready', 'Batch has been approved from the maker and it is ready for the checker'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."batchStatus" WHERE "batchStatusId"=4);

INSERT INTO
   bulk."batchStatus" ("batchStatusId", "name", "description")
SELECT
  5, 'rejected', 'Batch has been rejected from the checker'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."batchStatus" WHERE "batchStatusId"=5);

INSERT INTO
   bulk."batchStatus" ("batchStatusId", "name", "description")
SELECT
  6, 'returned', 'Batch has been returned to the maker for additional modifications'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."batchStatus" WHERE "batchStatusId"=6);

INSERT INTO
   bulk."batchStatus" ("batchStatusId", "name", "description")
SELECT
  7, 'approved', 'Batch has been approved and it is ready for processing'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."batchStatus" WHERE "batchStatusId"=7);

INSERT INTO
   bulk."batchStatus" ("batchStatusId", "name", "description")
SELECT
  8, 'processing', 'Batch is in process of processing the payments'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."batchStatus" WHERE "batchStatusId"=8);

INSERT INTO
   bulk."batchStatus" ("batchStatusId", "name", "description")
SELECT
  9, 'done', 'All the necessary payments in the batch have been processed'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."batchStatus" WHERE "batchStatusId"=9);

-- insert payment statuses

INSERT INTO
   bulk."paymentStatus" ("paymentStatusId", "name", "description")
SELECT
  1, 'new ', 'Payment is newly created'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."paymentStatus" WHERE "paymentStatusId"=1);

INSERT INTO
   bulk."paymentStatus" ("paymentStatusId", "name", "description")
SELECT
  2, 'modified', 'Payment has been modified - need additional checks'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."paymentStatus" WHERE "paymentStatusId"=1);

INSERT INTO
   bulk."paymentStatus" ("paymentStatusId", "name", "description")
SELECT
  3, 'disabled', 'Payment has been disabled - will not be processed'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."paymentStatus" WHERE "paymentStatusId"=1);

INSERT INTO
   bulk."paymentStatus" ("paymentStatusId", "name", "description")
SELECT
  4, 'verified', 'Payment has been verified and it is ready to be processed'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."paymentStatus" WHERE "paymentStatusId"=1);

INSERT INTO
   bulk."paymentStatus" ("paymentStatusId", "name", "description")
SELECT
  5, 'paid', 'Payment is paid'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."paymentStatus" WHERE "paymentStatusId"=1);

INSERT INTO
   bulk."paymentStatus" ("paymentStatusId", "name", "description")
SELECT
  6, 'failed', 'Payment failed'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."paymentStatus" WHERE "paymentStatusId"=1);