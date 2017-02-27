CREATE OR REPLACE FUNCTION bulk."batch.pay" (
    "@batchId" integer,
    "@actorId" varchar(25),
    "@expirationDate" timestamp,
    "@account" varchar(100)
)
RETURNS TABLE (
    "batchId" integer,
    "account" varchar(100),
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
    SELECT *
    FROM
       bulk."batch.edit"("@batchId", "@account", "@expirationDate", NULL, (SELECT bs."batchStatusId" FROM bulk."batchStatus" bs WHERE bs."name" = 'processing'), NULL, NULL, "@actorId", NULL, NULL, NULL);
END;
$body$
LANGUAGE 'plpgsql';
