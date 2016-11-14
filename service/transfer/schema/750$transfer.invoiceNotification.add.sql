CREATE OR REPLACE FUNCTION transfer."invoiceNotification.add" (
    "@invoiceUrl" varchar,
    "@userNumber" varchar,
    "@memo" varchar
)
RETURNS TABLE (
    "invoiceNotificationId" integer,
    "invoiceUrl" varchar,
    "userNumber" varchar,
    "status" char,
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
        "statusCode",
        "memo"
    )
    SELECT
        "@invoiceUrl"
        ,"@userNumber"
        ,'p'
        ,"@memo";

    "@invoiceNotificationId" := (SELECT currval('transfer.invoicenotification_id_seq'));

    RETURN QUERY
    SELECT * FROM transfer."invoiceNotificationId.get"("@invoiceNotificationId") ;
END;
$body$
LANGUAGE 'plpgsql';
