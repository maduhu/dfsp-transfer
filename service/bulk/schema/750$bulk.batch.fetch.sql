CREATE OR REPLACE FUNCTION bulk."batch.fetch" (
    "@actorId" VARCHAR(25),
    "@name" VARCHAR,
    "@batchStatusId" INTEGER,
    "@fromDate" TIMESTAMP,
    "@toDate" TIMESTAMP
)
RETURNS TABLE (
    "batchId" INTEGER,
    "name" VARCHAR(100),
    -- "account" VARCHAR(25),
    -- "expirationDate" TIMESTAMP,
    "batchStatusId" SMALLINT,
    "status" VARCHAR(100),
    -- "actorId" VARCHAR(25),
    -- "info" TEXT,
    -- "fileName" VARCHAR(256),
    -- "originalFileName" VARCHAR(256),
    "createdAt" TIMESTAMP,
    "lastValidation" TIMESTAMP,
    "paymentsCount" BIGINT
) AS
$body$
DECLARE
    "@validationStatuses" SMALLINT[]:= ARRAY(
        SELECT bs."batchStatusId"
        FROM bulk."batchStatus" bs
        WHERE bs."name" IN ('rejected', 'returned', 'approved')
    );
BEGIN
    RETURN QUERY
    SELECT
        b."batchId",
        b."name",
        -- b."account",
        -- b."expirationDate",
        b."batchStatusId",
        bs."name" AS "status",
        -- b."actorId",
        -- b."info",
        -- u."fileName",
        -- u."originalFileName",    
        b."createdAt",
        b."validatedAt" AS "lastValidation",
        (
            SELECT COUNT(p."paymentId")
            FROM bulk."payment" p
            WHERE p."batchId" = b."batchId"
        ) AS "paymentsCount"
    FROM
        bulk."batch" AS b
    JOIN
        bulk."batchStatus" AS bs ON bs."batchStatusId" = b."batchStatusId"
    -- JOIN
    --     bulk."upload" as u on u."batchId" = b."batchId"
    WHERE
        ("@name" IS NULL OR b."name" ~* "@name")
        AND (
            CASE WHEN "@batchStatusId" IS NOT NULL
            THEN b."batchStatusId" = "@batchStatusId"
            ELSE b."batchStatusId" IN (SELECT bs."batchStatusId" FROM bulk."batchStatus" bs WHERE bs.name <> 'deleted')
            END
            )
        AND ("@fromDate" IS NULL OR b."createdAt" >= "@fromDate")
        AND ("@toDate" IS NULL OR b."createdAt" <= "@toDate")
        AND ("@actorId" IS NULL OR b."actorId" = "@actorId")
        -- AND u."uploadId" = (
        --     SELECT
        --         up."uploadId"
        --     FROM
        --         bulk."upload" up
        --     WHERE
        --         up."batchId" = b."batchId"
        --     ORDER BY
        --         up."uploadId" DESC
        --     LIMIT 1
        -- );
    ORDER BY b."batchId" DESC;
END;
$body$
LANGUAGE 'plpgsql';
