CREATE OR REPLACE FUNCTION transfer."invoice.add" (
    "@account" varchar,
    "@name" varchar,
    "@currencyCode" varchar,
    "@amount" numeric,
    "@invoiceInfo" varchar
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
	DECLARE "@invoiceId" int;

    BEGIN
        INSERT INTO transfer.invoice (
            account,
            name,
            "currencyCode",
            amount,
            "statusCode",
            invoiceinfo
        )
        SELECT
            "@account"
            ,"@name"
            ,"@currencyCode"
            ,"@amount"
            ,'p'
            ,"@invoiceInfo";

        "@invoiceId" := (SELECT currval('transfer."invoice_id_seq"'));

        RETURN QUERY SELECT * FROM transfer."invoice.get"  ("@invoiceId") ;
    END;
$body$
LANGUAGE 'plpgsql';
