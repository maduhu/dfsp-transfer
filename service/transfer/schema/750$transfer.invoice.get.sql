CREATE OR REPLACE FUNCTION transfer."invoice.get" (
    "@invoiceId" integer
)
RETURNS TABLE (
    "invoiceId" integer,
    "account" varchar,
    "name" varchar,
    "currencyCode" varchar,
    "amount" numeric,
    "status" char,
    "invoiceInfo" varchar,
    "isSingleResult" boolean
) AS
$body$
BEGIN
  RETURN QUERY
    SELECT
        *,
        CAST(1 AS BOOLEAN) FROM transfer."invoice"
    WHERE
        "invoiceId" = "@invoiceId";
END;
$body$
LANGUAGE 'plpgsql';
