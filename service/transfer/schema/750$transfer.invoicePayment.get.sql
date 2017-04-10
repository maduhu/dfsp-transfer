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
        "invoicePaymentId" AS "invoicePaymentId",
        "invoicePayerId" AS "invoicePayerId",
        "createdAt" AS "createdAt",
        true AS "isSingleResult"
    FROM
        transfer."invoicePayment"
    WHERE
        "invoicePayerId" = "@invoicePayerId";
END;
$body$
LANGUAGE 'plpgsql';
