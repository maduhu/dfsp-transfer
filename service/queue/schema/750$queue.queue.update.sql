CREATE OR REPLACE FUNCTION queue."queue.update" (
    "@recordId" BIGINT
)
RETURNS TABLE (
    "updated" INTEGER,
    "isSingleResult" BOOLEAN
) AS
$body$
DECLARE
    "@updated" INTEGER;
BEGIN
    WITH rows AS (
        UPDATE queue."queue" SET
            "retryId" = (CASE WHEN("retryId" + 1 > (SELECT MAX(qr."retryId") FROM queue."retry" qr)) THEN NULL ELSE "retryId" + 1 END),
            "updatedAt" = NOW()
        WHERE "recordId" = "@recordId"
        RETURNING 1
    )
    SELECT COUNT(*) FROM rows INTO "@updated";

    RETURN QUERY
    SELECT
        "@updated",
        true AS "isSingleResult";
END;
$body$
LANGUAGE 'plpgsql';
