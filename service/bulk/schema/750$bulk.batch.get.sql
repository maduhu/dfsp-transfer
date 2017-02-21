CREATE OR REPLACE FUNCTION bulk."batch.get" (
    "@batchId" integer
)
RETURNS TABLE (
    "batchId" INTEGER,
    "name" VARCHAR(100),
    "accountNumber" VARCHAR(25),
    "expirationDate" TIMESTAMP,
    "batchStatusId" SMALLINT,
    "actorId" VARCHAR(25),
    "info" TEXT,
    "fileName" VARCHAR(256),
    "originalFileName" VARCHAR(256),
    "createdAt" TIMESTAMP,
    "status" VARCHAR(100),
    "isSingleResult" boolean,
    "updatedAt" TIMESTAMP,
    "paymentsCount" BIGINT
) AS
$body$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM bulk."batch" AS b WHERE b."batchId" = "@batchId") THEN
    RAISE EXCEPTION 'bulk.batchNotFound';
  END IF;
  RETURN QUERY
    SELECT
        b."batchId",
        b."name",
        b."accountNumber",
        b."expirationDate",
        b."batchStatusId",
        b."actorId",
        b."info",
        u."fileName",
        u."originalFileName",
        b."createdAt",
        bs."name" AS "status",
        true as "isSingleResult",
        (
            SELECT
                bh."createdAt"
            FROM
                bulk."batchHistory" bh
            WHERE
                bh."batchId" = "@batchId"
            ORDER BY 
                bh."batchHistoryId" DESC
            LIMIT 1
        ) AS "updatedAt",
        (
            SELECT COUNT(p."paymentId")
            FROM bulk."payment" p
            WHERE p."batchId" = b."batchId"
        ) as "paymentsCount"
    FROM 
        bulk."batch" AS b
    JOIN
        bulk."batchStatus" AS bs ON bs."batchStatusId" = b."batchStatusId"
    JOIN 
        bulk."upload" as u on u."batchId" = b."batchId"
    WHERE
        b."batchId" = "@batchId"
        AND u."uploadId" = (
            SELECT MAX("uploadId")
            FROM bulk."upload" up
            WHERE up."batchId" = "@batchId"
    );
END;
$body$
LANGUAGE 'plpgsql';
