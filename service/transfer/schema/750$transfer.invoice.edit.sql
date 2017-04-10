CREATE OR REPLACE FUNCTION transfer."invoice.edit" (
    "@invoiceId" INTEGER,
    "@status" VARCHAR(50)
)
RETURNS TABLE (
    "type" VARCHAR,
    "invoiceId" INTEGER,
    "account" VARCHAR,
    "name" VARCHAR,
    "currencyCode" VARCHAR,
    "currencySymbol" VARCHAR,
    "amount" NUMERIC,
    "status" VARCHAR,
    "invoiceType" VARCHAR,
    "merchantIdentifier" VARCHAR,
    "invoiceInfo" VARCHAR,
    "isSingleResult" BOOLEAN
) AS
$body$
BEGIN
    UPDATE
        transfer."invoice" AS t
    SET
        "invoiceStatusId" = (SELECT s."invoiceStatusId" FROM transfer."invoiceStatus" s WHERE s."name" = "@status")
    WHERE
        t."invoiceId" = "@invoiceId";

    RETURN QUERY
        SELECT * FROM  transfer."invoice.get"("@invoiceId");
END;
$body$
LANGUAGE 'plpgsql';
