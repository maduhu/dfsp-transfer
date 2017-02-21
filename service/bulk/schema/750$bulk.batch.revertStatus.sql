CREATE OR REPLACE FUNCTION bulk."batch.revertStatus" (
    "@batchId" INTEGER,
    "@actorId" VARCHAR(25)
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
    SELECT * 
    FROM 
        bulk."batch.edit"(
            "@batchId",
            NULL,
            NULL,
            NULL,
            (
                SELECT 
                    bh."batchStatusId"
                FROM
                    bulk."batchHistory" bh 
                WHERE 
                    bh."batchId" = "@batchId" 
                ORDER BY 
                    bh."batchHistoryId" DESC
                LIMIT 
                    1
            ),
            NULL,
            NULL,
            "@actorId",
            NULL,
            NULL,
            NOW()
        );
END;
$body$
LANGUAGE 'plpgsql';
