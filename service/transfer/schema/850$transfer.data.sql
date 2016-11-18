-- invoice status
INSERT INTO
  transfer."invoiceStatus" ("code", "description")
SELECT
  'e', 'executed'
WHERE
  NOT EXISTS (SELECT 1 FROM transfer."invoiceStatus" WHERE code='e');

INSERT INTO
  transfer."invoiceStatus" ("code", "description")
SELECT
  'a', 'approved'
WHERE
  NOT EXISTS (SELECT 1 FROM transfer."invoiceStatus" WHERE code='a');

INSERT INTO
  transfer."invoiceStatus" ("code", "description")
SELECT
  'p', 'pending'
WHERE
  NOT EXISTS (SELECT 1 FROM transfer."invoiceStatus" WHERE code='p');

INSERT INTO
  transfer."invoiceStatus" ("code", "description")
SELECT
  'r', 'rejected'
WHERE
  NOT EXISTS (SELECT 1 FROM transfer."invoiceStatus" WHERE code='r');