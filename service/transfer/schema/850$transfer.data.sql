  -- Insert invoice statuses
INSERT INTO
   transfer."invoiceStatus" ("code", "description")
VALUES
  ('e', 'executed'),
  ('a', 'approved'),
  ('p', 'pending'),
  ('r', 'rejected')
ON CONFLICT ("code") DO UPDATE SET "description" = EXCLUDED.description;

INSERT INTO
   transfer."invoiceType" ("invoiceTypeCode", "name", "description")
VALUES
  ('t1', 'type1', 'Old invoices'),
  ('t2', 'type2', 'Not assigned one-time invoice'),
  ('t3', 'type3', 'Not assigned multi-payer invoice')
ON CONFLICT ("invoiceTypeCode") DO UPDATE SET "name" = EXCLUDED.name, "description" = EXCLUDED.description;