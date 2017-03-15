CREATE OR REPLACE FUNCTION transfer."invoice.edit" (
    "@invoiceId" integer,
    "@statusCode" char
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
    "identifier" varchar,
    "invoiceInfo" varchar,
    "isSingleResult" boolean
) AS
$body$
BEGIN
    UPDATE
        transfer."invoice" AS t
    SET
        "statusCode" = "@statusCode"
    WHERE
        t."invoiceId" = "@invoiceId";

    RETURN QUERY
        SELECT * FROM  transfer."invoice.get"("@invoiceId");
END;
$body$
LANGUAGE 'plpgsql';
