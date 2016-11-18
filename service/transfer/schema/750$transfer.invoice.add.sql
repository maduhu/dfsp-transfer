CREATE OR REPLACE FUNCTION transfer."invoice.add" (
    "@account" varchar,
    "@name" varchar,
    "@currencyCode" varchar,
    "@currencySymbol" varchar,
    "@amount" numeric,
    "@userNumber" varchar,
    "@invoiceInfo" varchar
)
RETURNS TABLE (
    "invoiceId" integer,
    "account" varchar,
    "name" varchar,
    "currencyCode" varchar,
    "currencySymbol" varchar,
    "amount" numeric,
    "status" varchar,
    "userNumber" varchar,
    "invoiceInfo" varchar,
    "isSingleResult" boolean
) AS
$BODY$
	DECLARE "@invoiceId" int;

    BEGIN
        INSERT INTO transfer.invoice (
            "account",
            "name",
            "currencyCode",
            "currencySymbol",
            "amount",
            "userNumber",
            "statusCode",
            "invoiceInfo"
        )
        SELECT
            "@account"
            ,"@name"
            ,"@currencyCode"
            ,"@currencySymbol"
            ,"@amount"
            ,"@userNumber"
            ,'p'
            ,"@invoiceInfo";

        "@invoiceId" := (SELECT currval('transfer."invoice_invoiceId_seq"'));

        RETURN QUERY SELECT * FROM transfer."invoice.get" ("@invoiceId");
    END
$BODY$ LANGUAGE plpgsql
