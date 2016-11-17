CREATE OR REPLACE FUNCTION transfer."invoiceNotification.edit" (
    "@invoiceNotificationId" integer,
    "@status" char
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
BEGIN
    UPDATE
        transfer."invoiceNotification" AS t
    SET
        "status" = "@status"
    WHERE
        t."invoiceNotificationId" = "@invoiceNotificationId";

    RETURN QUERY
    SELECT * FROM transfer."invoiceNotification.get"("@invoiceNotificationId");
END;
$body$
LANGUAGE 'plpgsql';
