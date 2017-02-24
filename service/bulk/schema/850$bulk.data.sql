-- Insert batch statuses
INSERT INTO
   bulk."batchStatus" ("batchStatusId", "name", "description")
VALUES
  (1, 'uploading', 'Batch is uploading'),
  (2, 'invalid', 'Batch file is invalid'),
  (3, 'new', 'Batch is awating to be approved by maker'),
  (4, 'verifying', 'Batch file is in process of structure verification'),
  (5, 'ready', 'Batch has been approved from the maker and it is ready for the checker'),
  (6, 'rejected', 'Batch has been rejected to the maker for additional modifications'),
  (7, 'disabled', 'Batch has been disabled and can not be edited anymore'),
  (8, 'approved', 'Batch has been approved and it is ready for processing'),
  (9, 'processing', 'Batch is in process of processing the payments'),
  (10, 'done', 'All the necessary payments in the batch have been processedsa')
ON CONFLICT ("batchStatusId") DO UPDATE SET "name" = EXCLUDED.name, "description" = EXCLUDED.description;

-- insert payment statuses
INSERT INTO
   bulk."paymentStatus" ("paymentStatusId", "name", "description")
VALUES
  (1, 'new', 'Payment is newly created'),
  (2, 'modified', 'Payment has been modified - need additional checks'),
  (3, 'disabled', 'Payment has been disabled - will not be processed'),
  (4, 'verified', 'Payment has been verified and it is ready to be processed'),
  (5, 'paid', 'Payment is paid'),
  (6, 'failed', 'Payment failed'),
  (7, 'mismatch', 'Payment has mismatching properties')
ON CONFLICT ("paymentStatusId") DO UPDATE SET "name" = EXCLUDED.name, "description" = EXCLUDED.description;