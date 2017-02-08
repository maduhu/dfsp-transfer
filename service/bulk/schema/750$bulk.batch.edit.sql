CREATE OR REPLACE FUNCTION bulk."batch.edit" (
    "@batchId" integer,
    "@accountNumber" varchar(25),
    "@expirationDate" timestamp,
    "@name" varchar(100),
    "@statusId" smallint,
    "@historyInfo" text,
    "@uploadInfo" text,
    "@actorId" varchar(25),
    "@fileName" varchar(256),
    "@originalFileName" varchar(256)
)
RETURNS TABLE (
    "batchId" integer,
    "accountNumber" varchar(25),
    "expirationDate" timestamp,
    "name" varchar(100),
    "statusId" smallint,
    "historyInfo" text,
    "uploadInfo" text,
    "actorId" varchar(25),
    "fileName" varchar(256),
    "originalFileName" varchar(256)
) AS
$body$
DECLARE 
    "@lastStatusId" smallint:=(SELECT bh."statusId" FROM bulk."batchHistory" bh WHERE bh."batchId" = "@batchId" ORDER BY bh."createdAt" DESC LIMIT 1);
    "@lastHistoryInfo" text:=(SELECT bh."info" FROM bulk."batchHistory" bh WHERE bh."batchId" = "@batchId" ORDER BY bh."createdAt" DESC LIMIT 1);
BEGIN
    IF "@actorId" IS NULL THEN
        RAISE EXCEPTION 'bulk.actorIdMissing';
     END IF;
    IF "@batchId" IS NULL THEN
        RAISE EXCEPTION 'bulk.batchIdMissing';
     END IF;
    IF NOT EXISTS (SELECT 1 FROM bulk."batch" AS b WHERE b."batchId" = "@batchId") THEN
        RAISE EXCEPTION 'bulk.batchNotFound';
     END IF;
    IF "@statusId" IS NOT NULL THEN
        IF NOT EXISTS (SELECT 1 FROM bulk."status" AS s WHERE s."statusId" = "@statusId") THEN
            RAISE EXCEPTION 'bulk.statusIdNotFound';
         END IF;
     END IF;

    UPDATE
        bulk."batch" AS b
    SET
        "accountNumber" = COALESCE("@accountNumber", "accountNumber"),
        "expirationDate" = COALESCE("@expirationDate", "expirationDate"),
        "name" = COALESCE("@name", "name")
    WHERE
        b."batchId" = "@batchId";

    IF "@fileName" IS NOT NULL THEN 
        IF "@originalFileName" IS NULL THEN
            RAISE EXCEPTION 'bulk.statusIdNotFound';
         END IF;
        INSERT INTO
            bulk."upload"
            (
                "batchId",
                "fileName",
                "originalFileName",
                "createdAt"
            )
        VALUES (
                "@batchId",
                "@fileName",
                "@originalFileName",
                now()
        );
    ELSE
        IF "@uploadInfo" IS NOT NULL THEN
            UPDATE
                bulk."upload" AS u
            SET
                "info" = "@uploadInfo"
            WHERE
                u."batchId" = "@batchId";
         END IF;
    END IF;

    INSERT INTO
        bulk."batchHistory"
    (
        "batchId",
        "statusId",
        "actorId",
        "info",
        "createdAt"
    )
    VALUES (
        "@batchId",
        COALESCE("@statusId", "@lastStatusId"),
        "@actorId",
        COALESCE("@historyInfo", "@lastHistoryInfo"),
        now()
    );
    
    RETURN QUERY
    SELECT 
        bh."batchId" as "batchId",
        b."accountNumber" as "accountNumber",
        b."expirationDate" as "expirationDate",
        b."name" as "name",
        bh."statusId" as "statusId", 
        bh."info" as "historyInfo",
        bh."actorId" as "actorId", 
        u."fileName" as "fileName",
        u."info" as "uploadInfo"
    FROM 
        bulk."batchHistory" bh
    JOIN 
        bulk."batch" as b ON b."batchId" = bh."batchId"
        AND bh."batchHistoryId" = (
            SELECT MAX("batchHistoryId")
	        FROM bulk."batchHistory" h
	        WHERE h."batchId" = b."batchId"
        )
    JOIN 
        bulk."upload" as u ON u."batchId" = bh."batchId"
        AND u."uploadId" = (
            SELECT MAX("uploadId")
            FROM bulk."upload" up
            WHERE up."batchId" = u."batchId"
    );
END;
$body$
LANGUAGE 'plpgsql';
