CREATE OR REPLACE FUNCTION transfer."invoicePayment.get" (
    "@invoicePayerId" BIGINT
)
RETURNS TABLE (
    "invoicePaymentId" BIGINT,
    "invoicePayerId" BIGINT,
    "createdAt" TIMESTAMP,
    "isSingleResult" BOOLEAN
) AS
$body$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM transfer."invoicePayment" AS ip WHERE ip."invoicePayerId" = "@invoicePayerId") THEN
    RAISE EXCEPTION 'transfer.invoicePayerIdNotFound';
  END IF;
  RETURN QUERY
    SELECT
        ip."invoicePaymentId" AS "invoicePaymentId",
         ip."invoicePayerId" AS "invoicePayerId",
         ip."createdAt" AS "createdAt",
        true AS "isSingleResult"
    FROM
        transfer."invoicePayment" ip
    WHERE
        ip."invoicePayerId" = "@invoicePayerId";
END;
$body$
LANGUAGE 'plpgsql';
