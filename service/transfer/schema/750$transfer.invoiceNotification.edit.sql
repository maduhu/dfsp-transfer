CREATE OR REPLACE FUNCTION transfer."invoiceNotification.edit" (
    "@invoiceNotificationId" INTEGER,
    "@invoiceNotificationStatusId" INTEGER
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
    IF "@invoiceNotificationId" IS NULL THEN
        RAISE EXCEPTION 'transfer.invoiceNotificationIdMissing';
    END IF;
    IF "@invoiceNotificationStatusId" IS NULL THEN
        RAISE EXCEPTION 'transfer.invoiceNotificationStatusIdMissing';
    END IF;

    UPDATE
        transfer."invoiceNotification" AS t
    SET
        "invoiceNotificationStatusId" = "@invoiceNotificationStatusId"
    WHERE
        t."invoiceNotificationId" = "@invoiceNotificationId";

    RETURN QUERY
    SELECT * FROM transfer."invoiceNotification.get"("@invoiceNotificationId");
END;
$body$
LANGUAGE 'plpgsql';
