CREATE OR REPLACE FUNCTION transfer."invoice.get" (
    "@invoiceId" integer
)
RETURNS TABLE (
    "invoiceId" integer,
    "account" varchar,
    "name" varchar,
    "currencyCode" varchar,
    "currencySymbol" varchar,
    "amount" numeric,
    "status" varchar,
    "userNumber" varchar,
    "invoiceInfo" varchar,
    "isSingleResult" boolean
) AS
$body$
BEGIN
  RETURN QUERY
    SELECT
        *,
        CAST(1 AS BOOLEAN)
    FROM transfer."invoice" AS t
    WHERE
        t."invoiceId" = "@invoiceId";
END;
$body$
LANGUAGE 'plpgsql';
