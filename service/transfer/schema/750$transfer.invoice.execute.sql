CREATE OR REPLACE FUNCTION transfer."invoice.execute" (
    "@invoiceId" INTEGER,
    "@identifier" VARCHAR(25)
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
        "@invoiceTypeName" VARCHAR(50);
        "@invoicePayerId" BIGINT;
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

    IF ("@invoiceTypeName" = 'standard') THEN
        SELECT
            ip."invoicePayerId"
        INTO
            "@invoicePayerId"
        FROM
            transfer."invoicePayer" ip WHERE ip."invoiceId" = "@invoiceId";
    ELSE
        IF ("@identifier" IS NULL) THEN
            RAISE EXCEPTION 'transfer.identifierMissing';
        END IF;
        INSERT INTO
            "@invoicePayerId"
        SELECT
            i."invoicePayerId"
        FROM
            (SELECT * FROM transfer."invoicePayer.add" ("@invoiceId", "@identifier")) AS i;
    END IF;

    PERFORM transfer."invoicePayment.add" ("@invoicePayerId");

    IF ("@invoiceTypeName" != 'product') THEN
        PERFORM  transfer."invoice.edit"(
            "@invoiceId",
            (SELECT tis."invoiceStatusId" FROM transfer."invoiceStatus" tis WHERE tis."name" = 'executed')
        );
     END IF;

    RETURN QUERY SELECT * FROM transfer."invoice.get"("@invoiceId");
END;
$body$
LANGUAGE 'plpgsql';
