CREATE OR REPLACE FUNCTION transfer."invoiceNotification.fetch" (
    "@userNumber" varchar
)
RETURNS TABLE (
    "invoiceNotificationId" integer,
    "invoiceUrl" varchar,
    "userNumber" varchar,
    "status" varchar,
    "memo" varchar
) AS
$body$
BEGIN
    RETURN QUERY
    SELECT
        tin."invoiceNotificationId" AS "invoiceNotificationId",
        tin."invoiceUrl" AS "invoiceUrl",
        tin."userNumber" AS "userNumber",
        tis."description" AS "status",
        tin."memo" AS "memo"
    FROM
        transfer."invoiceNotification" AS tin
    JOIN
        transfer."invoiceStatus" tis ON tin."statusCode" = tis."code"
    WHERE
        tin."userNumber" = "@userNumber";
END;
$body$
LANGUAGE 'plpgsql';
