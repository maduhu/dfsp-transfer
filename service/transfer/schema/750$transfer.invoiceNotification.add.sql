CREATE OR REPLACE FUNCTION transfer."invoiceNotification.add" (
    "@invoiceUrl" VARCHAR,
    "@identifier" VARCHAR,
    "@memo" VARCHAR
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
	DECLARE
      "@invoiceNotificationId" INT;
BEGIN
WITH
inot AS (
    INSERT INTO
    transfer."invoiceNotification" (
        "invoiceUrl",
        "identifier",
        "invoiceNotificationStatusId",
        "memo"
    )
    VALUES (
        "@invoiceUrl",
        "@identifier",
        (SELECT s."invoiceStatusId" FROM transfer."invoiceStatus" s WHERE s."name" = 'pending'),
        "@memo"
    )
     RETURNING *
)

    SELECT inot."invoiceNotificationId" FROM inot INTO "@invoiceNotificationId";

    RETURN QUERY
    SELECT
        *
    FROM
        transfer."invoiceNotification.get"("@invoiceNotificationId") ;
END;
$body$
LANGUAGE 'plpgsql';
