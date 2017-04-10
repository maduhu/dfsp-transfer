CREATE OR REPLACE FUNCTION transfer."invoiceNotification.reject" (
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
    SELECT * FROM transfer."invoiceNotification.edit"(
        "@invoiceNotificationId",
        (SELECT is."invoiceStatusId" FROM transfer."invoiceStatus" is WHERE is."name" = 'rejected')
    );
END;
$body$
LANGUAGE 'plpgsql';
