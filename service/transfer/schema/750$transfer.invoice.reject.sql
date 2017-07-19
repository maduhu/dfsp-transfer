CREATE OR REPLACE FUNCTION transfer."invoice.reject" (
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
    DECLARE
        "@invoiceStatusName" VARCHAR;
        "@invoiceTypeName" VARCHAR;
    BEGIN
        SELECT
            tis."name",
            it."name"
        INTO
            "@invoiceStatusName",
            "@invoiceTypeName"
        FROM
            transfer."invoice" i
        JOIN
            transfer."invoiceStatus" tis ON i."invoiceStatusId" = tis."invoiceStatusId"
        JOIN
            transfer."invoiceType" it ON i."invoiceTypeId" = it."invoiceTypeId"
        WHERE
            i."invoiceId" = "@invoiceId";

        IF ("@invoiceStatusName" IS NULL OR "@invoiceTypeName" IS NULL) THEN
            RAISE EXCEPTION 'transfer.invoiceNotFound';
        END IF;
        IF ("@invoiceStatusName" != 'pending') THEN
            RAISE EXCEPTION 'transfer.invoiceNotPending';
        END IF;
        IF ("@invoiceTypeName" != 'standard' AND "@invoiceTypeName" != 'cashOut') THEN
            RAISE EXCEPTION 'transfer.invoiceNotStandard';
        END IF;

        RETURN QUERY
            SELECT * FROM  transfer."invoice.edit"(
                "@invoiceId",
                (SELECT tis."invoiceStatusId" FROM transfer."invoiceStatus" tis WHERE tis."name" = 'rejected')
            );
    END;
$body$
LANGUAGE 'plpgsql';
