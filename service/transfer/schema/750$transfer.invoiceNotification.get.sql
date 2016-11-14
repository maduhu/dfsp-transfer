CREATE OR REPLACE FUNCTION transfer."invoiceNotification.get" (
    "@invoiceNotificationId" integer
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
BEGIN
    RETURN QUERY
    SELECT
        *,
        CAST(1 as BOOLEAN)
    FROM 
        transfer."invoiceNotification"
    WHERE
        "invoiceNotificationId" = "@invoiceNotificationId";
END;
$body$
LANGUAGE 'plpgsql':
