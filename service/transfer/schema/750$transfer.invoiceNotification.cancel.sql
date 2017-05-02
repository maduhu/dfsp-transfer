CREATE OR REPLACE FUNCTION transfer."invoiceNotification.cancel" (
    "@invoiceUrl" VARCHAR
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
    RETURN QUERY
    SELECT * FROM transfer."invoiceNotification.edit"(
        (
            SELECT
                tin."invoiceNotificationId"
            FROM
                transfer."invoiceNotification" tin
            WHERE
                tin."invoiceUrl" = "@invoiceUrl"
        ),
        (
            SELECT
                tis."invoiceStatusId"
            FROM
                transfer."invoiceStatus" tis
            WHERE
                tis."name" = 'cancelled'
        )
    );
END;
$body$
LANGUAGE 'plpgsql';
