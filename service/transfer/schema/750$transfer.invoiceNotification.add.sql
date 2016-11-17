CREATE OR REPLACE FUNCTION transfer."invoiceNotification.add" (
    "@invoiceUrl" varchar,
    "@userNumber" varchar,
    "@memo" varchar
)
RETURNS TABLE (
    "invoiceNotificationId" integer,
    "invoiceUrl" varchar,
    "userNumber" varchar,
    "status" varchar,
    "memo" varchar,
    "isSingleResult" boolean
) AS
$body$
	DECLARE
      "@invoiceNotificationId" int;
BEGIN
    INSERT INTO
    transfer."invoiceNotification" (
        "invoiceUrl",
        "userNumber",
        "status",
        "memo"
    )
    SELECT
        "@invoiceUrl"
        ,"@userNumber"
        ,'p'
        ,"@memo";

    "@invoiceNotificationId" := (SELECT currval('transfer."invoiceNotification_invoiceNotificationId_seq"'));

    RETURN QUERY
    SELECT * FROM transfer."invoiceNotification.get"("@invoiceNotificationId") ;
END;
$body$
LANGUAGE 'plpgsql';
