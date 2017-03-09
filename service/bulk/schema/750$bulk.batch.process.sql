CREATE OR REPLACE FUNCTION bulk."batch.process" (
    "@batchId" INTEGER,
    "@actorId" VARCHAR(25),
    "@expirationDate" TIMESTAMP,
    "@account" VARCHAR(100)
)
RETURNS TABLE (
    "queued" INTEGER,
    "isSingleResult" BOOLEAN
) AS
$body$
DECLARE
	"@queued" INTEGER;
BEGIN
    PERFORM bulk."batch.edit"(
        "@batchId",
        "@account",
        "@expirationDate",
        NULL,
        (SELECT bs."batchStatusId" FROM bulk."batchStatus" bs WHERE bs."name" = 'processing'),
        NULL,
        NULL,
        "@actorId",
        NULL,
        NULL,
        NULL
    );

    WITH rows AS (
        INSERT INTO bulk."queue" (
            "paymentId",
            "retryId",
            "updatedAt"
        )
        SELECT
            p."paymentId",
            1,
            NOW()
        FROM bulk."payment" p
        WHERE p."batchId" = "@batchId"
        AND p."paymentStatusId" != (SELECT ps."paymentStatusId" FROM bulk."paymentStatus" ps WHERE ps."name" = 'disabled')
        RETURNING 1
    )
    SELECT COUNT(*) FROM rows INTO "@queued";

    RETURN QUERY
    SELECT
        "@queued" as "queued",
        true AS "isSingleResult";
END;
$body$
LANGUAGE 'plpgsql';
