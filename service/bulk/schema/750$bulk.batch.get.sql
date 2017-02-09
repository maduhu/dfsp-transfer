CREATE OR REPLACE FUNCTION bulk."batch.get" (
    "@batchId" integer
)
RETURNS TABLE (
    "batchId" INTEGER,
    "name" VARCHAR(100),
    "accountNumber" VARCHAR(25),
    "expirationDate" TIMESTAMP,
    "statusId" SMALLINT,
    "actorId" VARCHAR(25),
    "info" TEXT,
    "createdAt" TIMESTAMP,
    "isSingleResult" boolean
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
        b."statusId",
        b."actorId",
        b."info",
        b."createdAt",
        true as "isSingleResult"
    FROM 
        bulk."batch" AS b
    WHERE
        b."batchId" = "@batchId";
END;
$body$
LANGUAGE 'plpgsql';
