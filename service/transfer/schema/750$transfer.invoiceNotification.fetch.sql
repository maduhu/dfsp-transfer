CREATE OR REPLACE FUNCTION transfer."invoiceNotification.fetch" (
    "@identifier" varchar,
    "@statusCode" varchar(5)
)
RETURNS TABLE (
    "invoiceNotificationId" integer,
    "invoiceUrl" varchar,
    "identifier" varchar,
    "status" varchar,
    "memo" varchar
) AS
$body$
BEGIN
    RETURN QUERY
    SELECT
        tin."invoiceNotificationId" AS "invoiceNotificationId",
        tin."invoiceUrl" AS "invoiceUrl",
        tin."identifier" AS "identifier",
        tis."description" AS "status",
        tin."memo" AS "memo"
    FROM
        transfer."invoiceNotification" AS tin
    JOIN
        transfer."invoiceStatus" tis ON tin."statusCode" = tis."code"
    WHERE
        tin."identifier" = "@identifier"
        AND ("@statusCode" IS NULL OR tis."code" = "@statusCode");
END;
$body$
LANGUAGE 'plpgsql';
