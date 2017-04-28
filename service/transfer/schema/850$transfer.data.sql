  -- Insert invoice statuses
INSERT INTO
   transfer."invoiceStatus" ("invoiceStatusId", "name", "description")
VALUES
  (1, 'executed', 'Invoice has been executed by customer'),
  (2, 'approved', 'Invoice has been approved by customer'),
  (3, 'pending', 'Invoice is pending'),
  (4, 'rejected', 'Invoice has been rejected by customer'),
  (5, 'cancelled', 'Invoice has been cancelled by merchant')
ON CONFLICT ("invoiceStatusId") DO UPDATE SET "name" = EXCLUDED.name, "description" = EXCLUDED.description;

INSERT INTO
   transfer."invoiceType" ("invoiceTypeId", "name", "description")
VALUES
  (1, 'standard', 'Standard invoice'),
  (2, 'pending', 'Not assigned one-time invoice'),
  (3, 'product', 'Not assigned multi-payer invoice'),
  (4, 'cashOut', 'Cash-out')
ON CONFLICT ("invoiceTypeId") DO UPDATE SET "name" = EXCLUDED.name, "description" = EXCLUDED.description;
