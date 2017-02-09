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
        b."statusId",
        b."actorId",
        b."info",
        b."createdAt"
    FROM 
        bulk."batch" AS b
    WHERE
        ("@name" IS NULL OR b."name" = "@name")
        AND ("@statusId" IS NULL OR b."statusId" = "@statusId")
        AND ("@fromDate" IS NULL OR b."createdAt" >= "@fromDate")
        AND ("@toDate" IS NULL OR b."createdAt" <= "@toDate");
END;
$body$
LANGUAGE 'plpgsql';
