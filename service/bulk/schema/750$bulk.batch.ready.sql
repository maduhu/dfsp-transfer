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
    "isSingleResult" boolean
) AS
$body$
BEGIN
    PERFORM bulk."batch.edit"("@batchId", NULL, NULL, NULL, (SELECT bs."batchStatusId" FROM bulk."batchStatus" bs WHERE bs."name" = 'ready'), NULL, NULL, "@actorId", NULL, NULL);
    
    RETURN QUERY
    SELECT 
        b."batchId" as "batchId",
        b."accountNumber" as "accountNumber",
        b."expirationDate" as "expirationDate",
        b."name" as "name",
        b."batchStatusId" as "batchStatusId", 
        b."info" as "batchInfo",
        u."info" as "uploadInfo",
        "@actorId" as "actorId", 
        u."fileName" as "fileName",
        u."originalFileName" as "originalFileName",
        true as "isSingleResult"
    FROM 
        bulk."batch" b
    JOIN 
        bulk."upload" as u ON u."batchId" = b."batchId"
        AND u."uploadId" = (
            SELECT MAX("uploadId")
            FROM bulk."upload" up
            WHERE up."batchId" = u."batchId"
    )
    WHERE b."batchId" = "@batchId";
END;
$body$
LANGUAGE 'plpgsql';
