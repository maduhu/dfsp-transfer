CREATE OR REPLACE FUNCTION bulk."batch.fetch" (
    "@name" VARCHAR,
    "@batchStatusId" INTEGER,
    "@fromDate" TIMESTAMP,
    "@toDate" TIMESTAMP
)
RETURNS TABLE (
    "batchId" INTEGER,
    "name" VARCHAR(100),
    -- "accountNumber" VARCHAR(25),
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
        -- b."accountNumber",
        -- b."expirationDate",
        b."batchStatusId",
        bs."name" AS "status",
        -- b."actorId",
        -- b."info",
        -- u."fileName",
        -- u."originalFileName",
        b."createdAt",
        (
            SELECT MAX(x."createdAt")
            FROM (
                WITH orderedhistory AS
                (
                    SELECT
                        row_number() over(ORDER BY bulk."batchHistory"."createdAt") AS "RowNum",
                        bulk."batchHistory".*
                    FROM bulk."batchHistory"
                    WHERE bulk."batchHistory"."batchId" = b."batchId"
                )
                (
                    SELECT
                        orderedhistory1."batchStatusId",
                        orderedhistory2."createdAt"
                    FROM orderedhistory orderedhistory1
                    JOIN orderedhistory orderedhistory2
                        ON orderedhistory1."RowNum" = orderedhistory2."RowNum" + 1
                )
                UNION
                (
                    SELECT
                        bb."batchStatusId",
                        (
                            SELECT max(bh."createdAt")
                            FROM bulk."batchHistory" bh
                            WHERE bh."batchId" = bb."batchId" AND bb."batchStatusId" <> bh."batchStatusId"
                        ) AS "createdAt"
                    FROM bulk."batch" bb
                    WHERE bb."batchId" = b."batchId"
                )
                ORDER BY "createdAt"
            ) AS x
            WHERE x."batchStatusId" = ANY("@validationStatuses")
        ) AS "lastValidation",
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
        ("@name" IS NULL OR b."name" = "@name")
        AND ("@batchStatusId" IS NULL OR b."batchStatusId" = "@batchStatusId")
        AND ("@fromDate" IS NULL OR b."createdAt" >= "@fromDate")
        AND ("@toDate" IS NULL OR b."createdAt" <= "@toDate");
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
END;
$body$
LANGUAGE 'plpgsql';
