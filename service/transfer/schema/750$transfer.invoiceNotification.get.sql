CREATE OR REPLACE FUNCTION transfer."invoiceNotification.get" (
    "@invoiceNotificationId" integer
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
    RETURN QUERY
    SELECT
        t.*,
        CAST(1 as BOOLEAN)
    FROM
        transfer."invoiceNotification" AS t
    WHERE
        t."invoiceNotificationId" = "@invoiceNotificationId";
END;
$body$
LANGUAGE 'plpgsql';
