CREATE OR REPLACE FUNCTION transfer."invoice.fetch" (
    "@merchantIdentifier" varchar,
    "@account" varchar,
    "@status" varchar[],
    "@invoiceType" varchar[]
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
    "invoiceInfo" varchar
) AS
$body$
BEGIN
  RETURN QUERY
    SELECT
        CAST('invoice' AS varchar) AS "type",
        ti."invoiceId" AS "invoiceId",
        ti."account" AS "account",
        ti."name" AS "name",
        ti."currencyCode" AS "currencyCode",
        ti."currencySymbol" AS "currencySymbol",
        ti."amount" AS "amount",
        tis."name" AS "status",
        tit."name" AS "invoiceType",
        ti."merchantIdentifier" AS "merchantIdentifier",
        ti."invoiceInfo" AS "invoiceInfo"
    FROM
        transfer."invoice" AS ti
    JOIN
        transfer."invoiceStatus" tis ON ti."invoiceStatusId" = tis."invoiceStatusId"
    JOIN
        transfer."invoiceType" tit ON ti."invoiceTypeId" = tit."invoiceTypeId"
    WHERE
        ti."merchantIdentifier" = "@merchantIdentifier"
            AND
        ti."account" = "@account"
            AND
        ("@status" IS NULL OR tis."name" = ANY("@status"))
            AND
        ("@invoiceType" IS NULL OR tit."name" = ANY("@invoiceType"));
END;
$body$
LANGUAGE 'plpgsql';
