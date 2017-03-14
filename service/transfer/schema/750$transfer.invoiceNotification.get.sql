CREATE OR REPLACE FUNCTION transfer."invoiceNotification.get" (
    "@invoiceNotificationId" integer
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
    IF NOT EXISTS (SELECT 1 FROM transfer."invoiceNotification" AS t WHERE t."invoiceNotificationId" = "@invoiceNotificationId") THEN
        RAISE EXCEPTION 'transfer.invoiceNotificationNotFound';
    END IF;
    RETURN QUERY
    SELECT
        tin."invoiceNotificationId" AS "invoiceNotificationId",
        tin."invoiceUrl" AS "invoiceUrl",
        tin."identifier" AS "identifier",
        tis."description" AS "status",
        tin."memo" AS "memo",
        CAST(1 as BOOLEAN)
    FROM
        transfer."invoiceNotification" AS tin
    JOIN
        transfer."invoiceStatus" tis ON tin."statusCode" = tis."code"
    WHERE
       tin."invoiceNotificationId" = "@invoiceNotificationId";
END;
$body$
LANGUAGE 'plpgsql';
