CREATE OR REPLACE FUNCTION transfer."invoiceNotification.execute" (
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
        (SELECT is."invoiceStatusId" FROM transfer."invoiceStatus" is WHERE is."name" = 'executed')
    );
END;
$body$
LANGUAGE 'plpgsql';
