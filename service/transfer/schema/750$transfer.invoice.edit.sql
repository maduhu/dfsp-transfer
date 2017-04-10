CREATE OR REPLACE FUNCTION transfer."invoice.edit" (
    "@invoiceId" INTEGER,
    "@invoiceStatusId" VARCHAR(50)
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
    IF "@invoiceId" IS NULL THEN
        RAISE EXCEPTION 'transfer.invoiceIdMissing';
    END IF;
    IF "@invoiceStatusId" IS NULL THEN
        RAISE EXCEPTION 'transfer.invoiceStatusIdMissing';
    END IF;

    UPDATE
        transfer."invoice" AS t
    SET
        "invoiceStatusId" = "@invoiceStatusId"
    WHERE
        t."invoiceId" = "@invoiceId";

    RETURN QUERY
        SELECT * FROM  transfer."invoice.get"("@invoiceId");
END;
$body$
LANGUAGE 'plpgsql';
