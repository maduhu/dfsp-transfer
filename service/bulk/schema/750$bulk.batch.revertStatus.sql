CREATE OR REPLACE FUNCTION bulk."batch.revertStatus" (
    "@batchId" INTEGER,
    "@actorId" VARCHAR(25),
    "@partial" BOOLEAN
)
RETURNS TABLE (
    "batchId" integer,
    "account" varchar(100),
    "startDate" timestamp,
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
            CASE "@partial" WHEN TRUE THEN NULL ELSE NOW() END
        );
END;
$body$
LANGUAGE 'plpgsql';
