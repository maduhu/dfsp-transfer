CREATE OR REPLACE FUNCTION bulk."batch.fetch" (
    "@name" VARCHAR,
    "@batchStatusId" INTEGER,
    "@fromDate" TIMESTAMP,
    "@toDate" TIMESTAMP
)
RETURNS TABLE (
    "batchId" INTEGER,
    "name" VARCHAR(100),
    "accountNumber" VARCHAR(25),
    "expirationDate" TIMESTAMP,
    "batchStatusId" SMALLINT,
    "status" VARCHAR(100),
    "actorId" VARCHAR(25),
    "info" TEXT,
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
        b."accountNumber",
        b."expirationDate",
        b."batchStatusId",
        bs."name" AS "status",
        b."actorId",
        b."info",
        b."createdAt",
        (
            SELECT MAX(x."date")
            FROM (
                (
                    SELECT bh."createdAt" as "date"
                    FROM bulk."batchHistory" bh
                    WHERE bh."batchId" = b."batchId" AND bh."batchStatusId" = ANY("@validationStatuses")
                )
                UNION
                (
                    SELECT bb."createdAt" as "date"
                    FROM bulk."batch" AS bb
                    WHERE bb."batchId" = b."batchId" AND bb."batchStatusId" = ANY("@validationStatuses")
                )
            ) AS x
        ) AS "lastValidation",
        (
            SELECT COUNT(p."paymentId")
            FROM bulk."payment" p
            WHERE p."batchId" = b."batchId"
        ) as "paymentsCount"
    FROM 
        bulk."batch" AS b
    JOIN
        bulk."batchStatus" AS bs ON bs."batchStatusId" = b."batchStatusId"
    WHERE
        ("@name" IS NULL OR b."name" = "@name")
        AND ("@batchStatusId" IS NULL OR b."batchStatusId" = "@batchStatusId")
        AND ("@fromDate" IS NULL OR b."createdAt" >= "@fromDate")
        AND ("@toDate" IS NULL OR b."createdAt" <= "@toDate");
END;
$body$
LANGUAGE 'plpgsql';
