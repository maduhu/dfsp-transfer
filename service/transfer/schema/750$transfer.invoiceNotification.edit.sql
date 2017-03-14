CREATE OR REPLACE FUNCTION transfer."invoiceNotification.edit" (
    "@invoiceNotificationId" integer,
    "@statusCode" char
)
RETURNS TABLE (
    "invoiceNotificationId" integer,
    "invoiceUrl" varchar,
    "identifier" varchar,
    "status" varchar,
    "memo" varchar,
    "isSingleResult" boolean
) AS
$body$
BEGIN
    UPDATE
        transfer."invoiceNotification" AS t
    SET
        "statusCode" = "@statusCode"
    WHERE
        t."invoiceNotificationId" = "@invoiceNotificationId";

    RETURN QUERY
    SELECT * FROM transfer."invoiceNotification.get"("@invoiceNotificationId");
END;
$body$
LANGUAGE 'plpgsql';
