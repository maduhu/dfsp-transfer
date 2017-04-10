CREATE OR REPLACE FUNCTION transfer."invoice.get" (
    "@invoiceId" integer
)
RETURNS TABLE (
    "type" varchar,
    "invoiceId" integer,
    "account" varchar,
    "name" varchar,
    "currencyCode" varchar,
    "currencySymbol" varchar,
    "amount" numeric,
    "status" varchar,
    "invoiceType" varchar,
    "merchantIdentifier" varchar,
    "invoiceInfo" varchar,
    "isSingleResult" boolean
) AS
$body$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM transfer."invoice" AS t WHERE t."invoiceId" = "@invoiceId") THEN
    RAISE EXCEPTION 'transfer.invoiceNotFound';
  END IF;
  RETURN QUERY
    SELECT
        CAST('invoice' AS varchar) AS "type",
        ti."invoiceId" AS "invoiceId",
        ti."account" AS "account",
        ti."name" AS "name",
        ti."currencyCode" AS "currencyCode",
        ti."currencySymbol" AS "currencySymbol",
        ti."amount" AS "amount",
        tis."description" AS "status",
        tit."name" AS "invoiceType",
        ti."identifier" AS "merchantIdentifier",
        ti."invoiceInfo" AS "invoiceInfo",
        CAST(1 AS BOOLEAN) AS "isSingleResult"
    FROM
        transfer."invoice" AS ti
    JOIN
        transfer."invoiceStatus" tis ON ti."statusCode" = tis."code"
    JOIN
        transfer."invoiceType" tit ON ti."invoiceTypeCode" = tit."invoiceTypeCode"
    WHERE
        ti."invoiceId" = "@invoiceId";
END;
$body$
LANGUAGE 'plpgsql';
