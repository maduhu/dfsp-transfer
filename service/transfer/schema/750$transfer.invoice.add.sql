CREATE OR REPLACE FUNCTION transfer."invoice.add" (
    "@account" varchar,
    "@name" varchar,
    "@currencyCode" varchar,
    "@currencySymbol" varchar,
    "@amount" numeric,
    "@merchantIdentifier" varchar,
    "@invoiceTypeCode" varchar,
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
        RAISE EXCEPTION 'transfer.accountIsMissing';
    END IF;
    IF "@name" IS NULL THEN
        RAISE EXCEPTION 'transfer.nameIsMissing';
    END IF;
    IF "@currencyCode" IS NULL THEN
        RAISE EXCEPTION 'transfer.currencyCodeIsMissing';
    END IF;
    IF "@currencySymbol" IS NULL THEN
        RAISE EXCEPTION 'transfer.currencySymbolIsMissing';
    END IF;
    IF "@amount" IS NULL THEN
        RAISE EXCEPTION 'transfer.amountIsMissing';
    END IF;
    IF "@merchantIdentifier" IS NULL THEN
        RAISE EXCEPTION 'transfer.merchantIdentifierIsMissing';
    END IF;
    IF "@invoiceTypeCode" IS NULL THEN
        RAISE EXCEPTION 'transfer.invoiceTypeCodeIsMissing';
    END IF;
            INSERT INTO transfer.invoice (
            "account",
            "name",
            "currencyCode",
            "currencySymbol",
            "amount",
            "merchantIdentifier",
            "statusCode",
            "invoiceTypeCode",
            "invoiceInfo"
        )
        SELECT
            "@account"
            ,"@name"
            ,"@currencyCode"
            ,"@currencySymbol"
            ,"@amount"
            ,"@merchantIdentifier"
            ,'p'
            ,"@invoiceTypeCode"
            ,"@invoiceInfo";

        "@invoiceId" := (SELECT currval('transfer."invoice_invoiceId_seq"'));

        RETURN QUERY SELECT * FROM transfer."invoice.get" ("@invoiceId");
    END
$BODY$ LANGUAGE plpgsql
