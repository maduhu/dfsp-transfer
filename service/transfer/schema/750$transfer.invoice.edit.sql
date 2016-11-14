CREATE OR REPLACE FUNCTION transfer."invoice.edit" (
    "@invoiceId" integer,
    "@status" char
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
    UPDATE
        transfer."invoice"
    SET
        "statusCode"="@status"
    WHERE 
        "invoiceId"="@invoiceId";

    RETURN QUERY
        SELECT * FROM  transfer."invoice.get"("@invoiceId");
END;
$body$
LANGUAGE 'plpgsql';
