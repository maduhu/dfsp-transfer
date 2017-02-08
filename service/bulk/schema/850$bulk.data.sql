INSERT INTO
   bulk."status" ("statusId", "name")
SELECT
  1, 'processing'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."status" WHERE "statusId"=1);

INSERT INTO
   bulk."status" ("statusId", "name")
SELECT
  2, 'pending'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."status" WHERE "statusId"=2);

INSERT INTO
   bulk."status" ("statusId", "name")
SELECT
  3, 'verified'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."status" WHERE "statusId"=3);

INSERT INTO
   bulk."status" ("statusId", "name")
SELECT
  4, 'rejected'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."status" WHERE "statusId"=4);

INSERT INTO
   bulk."status" ("statusId", "name")
SELECT
  5, 'returned'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."status" WHERE "statusId"=5);

INSERT INTO
   bulk."status" ("statusId", "name")
SELECT
  6, 'ready'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."status" WHERE "statusId"=6);

INSERT INTO
   bulk."status" ("statusId", "name")
SELECT
  7, 'sent'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."status" WHERE "statusId"=7);

INSERT INTO
   bulk."status" ("statusId", "name")
SELECT
  8, 'new'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."status" WHERE "statusId"=8);

INSERT INTO
   bulk."status" ("statusId", "name")
SELECT
  9, 'paid'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."status" WHERE "statusId"=9);

INSERT INTO
   bulk."status" ("statusId", "name")
SELECT
  10, 'disabled'
WHERE
  NOT EXISTS (SELECT 1 FROM bulk."status" WHERE "statusId"=10);
