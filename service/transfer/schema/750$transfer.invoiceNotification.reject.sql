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
        (SELECT tis."invoiceStatusId" FROM transfer."invoiceStatus" tis WHERE tis."name" = 'rejected')
    );
END;
$body$
LANGUAGE 'plpgsql';
