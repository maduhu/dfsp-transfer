CREATE OR REPLACE FUNCTION queue."queue.add" (
    "@recordId" BIGINT[],
    "@expirationDate" TIMESTAMP WITHOUT TIME ZONE
)
RETURNS TABLE (
    "inserted" INTEGER,
    "isSingleResult" BOOLEAN
) AS
$BODY$

DECLARE
    "@inserted" INTEGER;
BEGIN
    IF "@recordId" IS NULL THEN
        RAISE EXCEPTION 'queue.recordsMissing';
    END IF;
    IF "@expirationDate" IS NULL THEN
        RAISE EXCEPTION 'queue.expirationDateMissing';
    END IF;

    WITH rows AS (
        INSERT INTO queue."queue" (
            "recordId",
            "retryId",
            "expirationDate",
            "updatedAt"
        )
        SELECT
            "recordId",
            1,
            "@expirationDate",
            NOW()
        FROM
            UNNEST("@recordId") AS "recordId"
        RETURNING 1
    )

    SELECT COUNT(*) FROM rows INTO "@inserted";

    RETURN QUERY
    SELECT
        "@inserted",
        true AS "isSingleResult";
END;
$BODY$ 
LANGUAGE plpgsql