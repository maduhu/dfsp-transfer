CREATE OR REPLACE FUNCTION transfer."invoice.execute" (
    "@invoiceId" INTEGER
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
    RETURN QUERY
        SELECT * FROM  transfer."invoice.edit"(
            "@invoiceId",
             (SELECT is."invoiceStatusId" FROM transfer."invoiceStatus" is WHERE is."name" = 'executed')
        );
END;
$body$
LANGUAGE 'plpgsql';
