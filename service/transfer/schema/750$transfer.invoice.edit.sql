CREATE OR REPLACE FUNCTION transfer."invoice.edit" (
    "@invoiceId" integer,
    "@status" char
)
RETURNS TABLE (
    "invoiceId" integer,
    "account" varchar,
    "name" varchar,
    "currencyCode" varchar,
    "currencySymbol" varchar,
    "amount" numeric,
    "status" char,
    "invoiceInfo" varchar,
    "isSingleResult" boolean
) AS
$body$
BEGIN
    UPDATE
        transfer."invoice"
    SET
        "status"="@status"
    WHERE
        "invoiceId"="@invoiceId";

    RETURN QUERY
        SELECT * FROM  transfer."invoice.get"("@invoiceId");
END;
$body$
LANGUAGE 'plpgsql';