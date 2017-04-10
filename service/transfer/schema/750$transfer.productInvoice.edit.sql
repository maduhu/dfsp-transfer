CREATE OR REPLACE FUNCTION transfer."productInvoice.edit" (
    "@invoiceId" INTEGER,
    "@invoicePayerId" BIGINT
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
        "@invoiceStatusName" VARCHAR(50);
        "@invoiceTypeName" INTEGER;
BEGIN
    IF ("@invoicePayerId" IS NULL) THEN
         RAISE EXCEPTION 'transfer.invoicePayerIdMissing';
    END IF;

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
    JOIN
        transfer."invoicePayer" ip ON ip."invoiceId" = i."invoiceId"
    WHERE
        i."invoiceId" = "@invoiceId" AND ip."invoicePayerId" = "@invoicePayerId";

    IF ("@invoiceStatusName" IS NULL OR "@invoiceTypeName" IS NULL) THEN
         RAISE EXCEPTION 'transfer.invoicePayerMismatch';
    END IF;
    IF ("@invoiceStatusName" != 'pending') THEN
         RAISE EXCEPTION 'transfer.invoiceNotPending';
    END IF;
    IF ("@invoiceTypeName" != 'product') THEN
         RAISE EXCEPTION 'transfer.wrongInvoiceType';
    END IF;

    PERFORM transfer."invoicePayment.add" ("@invoicePayerId");

    RETURN QUERY
        SELECT * FROM  transfer."invoice.get"("@invoiceId");
END;
$body$
LANGUAGE 'plpgsql';
