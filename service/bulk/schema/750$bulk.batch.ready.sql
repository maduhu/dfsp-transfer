CREATE OR REPLACE FUNCTION bulk."batch.ready" (
    "@batchId" integer,
    "@actorId" varchar(25)
)
RETURNS TABLE (
    "batchId" integer,
    "accountNumber" varchar(25),
    "expirationDate" timestamp,
    "name" varchar(100),
    "batchStatusId" smallint,
    "batchInfo" text,
    "uploadInfo" text,
    "actorId" varchar(25),
    "fileName" varchar(256),
    "originalFileName" varchar(256),
    "validatedAt" timestamp,
    "isSingleResult" boolean
) AS
$body$
BEGIN
    RETURN QUERY
    SELECT 
       bulk."batch.edit"("@batchId", NULL, NULL, NULL, (SELECT bs."batchStatusId" FROM bulk."batchStatus" bs WHERE bs."name" = 'ready'), NULL, NULL, "@actorId", NULL, NULL, NULL);
END;
$body$
LANGUAGE 'plpgsql';
