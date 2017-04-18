CREATE OR REPLACE FUNCTION transfer."invoiceNotification.get" (
    "@invoiceNotificationId" INTEGER
)
RETURNS TABLE (
    "invoiceNotificationId" INTEGER,
    "invoiceUrl" VARCHAR,
    "identifier" VARCHAR,
    "status" VARCHAR,
    "memo" VARCHAR,
    "isSingleResult" BOOLEAN
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
        tis."name" AS "status",
        tin."memo" AS "memo",
        CAST(1 as BOOLEAN)
    FROM
        transfer."invoiceNotification" AS tin
    JOIN
        transfer."invoiceStatus" tis ON tin."invoiceNotificationStatusId" = tis."invoiceStatusId"
    WHERE
       tin."invoiceNotificationId" = "@invoiceNotificationId";
END;
$body$
LANGUAGE 'plpgsql';
