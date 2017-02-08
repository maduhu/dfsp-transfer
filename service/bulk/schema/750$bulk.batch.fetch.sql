CREATE OR REPLACE FUNCTION bulk."batch.fetch" (
    "@name" VARCHAR,
    "@statusId" SMALLINT,
    "@fromDate" TIMESTAMP,
    "@toDate" TIMESTAMP
)
RETURNS TABLE (
    "batchId" INTEGER,
    "name" VARCHAR(100),
    "accountNumber" VARCHAR(25),
    "expirationDate" TIMESTAMP,
    "statusId" SMALLINT,
    "actorId" VARCHAR(25),
    "info" TEXT,
    "createdAt" TIMESTAMP
) AS
$body$
BEGIN
    RETURN QUERY
    SELECT
        b."batchId",
        b."name",
        b."accountNumber",
        b."expirationDate",
        bh."statusId",
        bh."actorId",
        bh."info",
        bh."createdAt"
    FROM 
        bulk."batch" AS b
    JOIN
        bulk."batchHistory" bh ON b."batchId" = bh."batchId"
    WHERE
        ("@name" IS NULL OR b."name" = "@name")
        AND ("@statusId" IS NULL OR bh."statusId" = "@statusId")
        AND ("@fromDate" IS NULL OR bh."createdAt" >= "@fromDate")
        AND ("@toDate" IS NULL OR bh."createdAt" <= "@toDate");
END;
$body$
LANGUAGE 'plpgsql';
