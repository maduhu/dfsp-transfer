  -- Insert invoice statuses
INSERT INTO
   transfer."invoiceStatus" ("invoiceStatusId", "name", "description")
VALUES
  (1, 'executed', 'Invoice has been executed'),
  (2, 'approved', 'Invoice has been approved'),
  (3, 'pending', 'Invoice is pending'),
  (4, 'rejected', 'Invoice has been rejected')
ON CONFLICT ("invoiceStatusId") DO UPDATE SET "name" = EXCLUDED.name, "description" = EXCLUDED.description;

INSERT INTO
   transfer."invoiceType" ("invoiceTypeId", "name", "description")
VALUES
  (1, 'type1', 'Old invoices'),
  (2, 'type2', 'Not assigned one-time invoice'),
  (3, 'type3', 'Not assigned multi-payer invoice')
ON CONFLICT ("invoiceTypeId") DO UPDATE SET "name" = EXCLUDED.name, "description" = EXCLUDED.description;
