CREATE OR REPLACE FUNCTION transfer."invoicePayer.get" (
    "@invoicePayerId" BIGINT
)
RETURNS TABLE (
    "invoicePayerId" BIGINT,
    "invoiceId" INTEGER,
    "identifier" VARCHAR(25),
    "createdAt" TIMESTAMP,
    "isSingleResult" BOOLEAN
) AS
$body$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM transfer."invoicePayer" AS ip WHERE ip."invoicePayerId" = "@invoicePayerId") THEN
    RAISE EXCEPTION 'transfer.invoicePayerIdNotFound';
  END IF;
  RETURN QUERY
    SELECT
        ip."invoicePayerId" AS "invoicePayerId",
        ip."invoiceId" AS "invoiceId",
        ip."identifier" AS "identifier",
        ip."createdAt" AS "createdAt",
        true AS "isSingleResult"
    FROM
        transfer."invoicePayer" ip
    WHERE
        ip."invoicePayerId" = "@invoicePayerId";
END;
$body$
LANGUAGE 'plpgsql';
