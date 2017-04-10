CREATE OR REPLACE FUNCTION transfer."invoiceNotification.edit" (
    "@invoiceNotificationId" INTEGER,
    "@status" VARCHAR
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
    UPDATE
        transfer."invoiceNotification" AS t
    SET
        "invoiceNotificationStatusId" = (SELECT s."invoiceStatusId" FROM transfer."invoiceStatus" s WHERE s."name" = "@status")
    WHERE
        t."invoiceNotificationId" = "@invoiceNotificationId";

    RETURN QUERY
    SELECT * FROM transfer."invoiceNotification.get"("@invoiceNotificationId");
END;
$body$
LANGUAGE 'plpgsql';
