CREATE OR REPLACE FUNCTION transfer."invoiceNotification.fetch" (
    "@identifier" VARCHAR,
    "@status" VARCHAR
)
RETURNS TABLE (
    "invoiceNotificationId" INTEGER,
    "invoiceUrl" VARCHAR,
    "identifier" VARCHAR,
    "status" VARCHAR,
    "memo" VARCHAR
) AS
$body$
BEGIN
    RETURN QUERY
    SELECT
        tin."invoiceNotificationId" AS "invoiceNotificationId",
        tin."invoiceUrl" AS "invoiceUrl",
        tin."identifier" AS "identifier",
        tis."name" AS "status",
        tin."memo" AS "memo"
    FROM
        transfer."invoiceNotification" AS tin
    JOIN
        transfer."invoiceStatus" tis ON tin."invoiceNotificationStatusId" = tis."invoiceStatusId"
    WHERE
        tin."identifier" = "@identifier"
        AND ("@status" IS NULL OR tis."invoiceStatusId" = (SELECT s."invoiceStatusId" FROM transfer."invoiceStatus" s WHERE s."name" = "@status"));
END;
$body$
LANGUAGE 'plpgsql';
