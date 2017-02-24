CREATE OR REPLACE FUNCTION queue."queue.remove" (
    "@recordId" BIGINT
)
RETURNS TABLE (
    "deleted" INTEGER,
    "isSingleResult" BOOLEAN
) AS
$body$
DECLARE
    "@deleted" INTEGER;
BEGIN
    WITH rows AS (
        DELETE FROM  queue."queue"
        WHERE "recordId" = "@recordId"
        RETURNING 1
    )
    SELECT COUNT(*) FROM rows INTO "@deleted";

    RETURN QUERY
    SELECT
        "@deleted",
        true AS "isSingleResult";
END;
$body$
LANGUAGE 'plpgsql';
