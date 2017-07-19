CREATE OR REPLACE FUNCTION transfer."invoice.add" (
    "@account" varchar,
    "@name" varchar,
    "@currencyCode" varchar,
    "@currencySymbol" varchar,
    "@amount" numeric,
    "@merchantIdentifier" varchar,
    "@identifier" varchar,
    "@invoiceType" varchar,
    "@invoiceInfo" varchar
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
    "invoiceInfo" varchar,
    "isSingleResult" boolean
) AS
$BODY$

DECLARE "@invoiceId" int;

BEGIN
    IF "@account" IS NULL THEN
        RAISE EXCEPTION 'transfer.accountMissing';
    END IF;
    IF "@name" IS NULL THEN
        RAISE EXCEPTION 'transfer.nameMissing';
    END IF;
    IF "@currencyCode" IS NULL THEN
        RAISE EXCEPTION 'transfer.currencyCodeMissing';
    END IF;
    IF "@currencySymbol" IS NULL THEN
        RAISE EXCEPTION 'transfer.currencySymbolMissing';
    END IF;
    IF "@amount" IS NULL THEN
        RAISE EXCEPTION 'transfer.amountMissing';
    END IF;
    IF "@merchantIdentifier" IS NULL THEN
        RAISE EXCEPTION 'transfer.merchantIdentifierMissing';
    END IF;
    IF "@invoiceType" IS NULL THEN
        RAISE EXCEPTION 'transfer.invoiceTypeMissing';
    END IF;
    IF ("@invoiceType" = 'standard' AND "@identifier" IS NULL) THEN
        RAISE EXCEPTION 'transfer.identifierMissing';
    END IF;


    WITH
    ti AS (
        INSERT INTO transfer."invoice" (
            "account",
            "name",
            "currencyCode",
            "currencySymbol",
            "amount",
            "merchantIdentifier",
            "invoiceStatusId",
            "invoiceTypeId",
            "invoiceInfo",
            "createdAt"
        )
        VALUES (
            "@account",
            "@name",
            "@currencyCode",
            "@currencySymbol",
            "@amount",
            "@merchantIdentifier",
            (SELECT s."invoiceStatusId" FROM transfer."invoiceStatus" s WHERE s."name" = 'pending'),
            (SELECT it."invoiceTypeId" FROM transfer."invoiceType" it WHERE it."name" = "@invoiceType"),
            "@invoiceInfo",
            NOW()
        )
        RETURNING *
    )
    SELECT
        ti."invoiceId"
    INTO
        "@invoiceId"
    FROM
        ti;

    IF ("@invoiceType" = 'standard' OR "@invoiceType" = 'cashOut') THEN
        PERFORM transfer."invoicePayer.add"("@invoiceId", "@identifier");
    END IF;

    RETURN QUERY SELECT * FROM transfer."invoice.get" ("@invoiceId");
END
$BODY$ LANGUAGE plpgsql
