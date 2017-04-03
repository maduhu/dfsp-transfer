CREATE OR REPLACE FUNCTION bulk."batch.edit" (
    "@batchId" integer,
    "@account" varchar(100),
    "@expirationDate" timestamp,
    "@name" varchar(100),
    "@batchStatusId" integer,
    "@batchInfo" text,
    "@uploadInfo" text,
    "@actorId" varchar(25),
    "@fileName" varchar(256),
    "@originalFileName" varchar(256),
    "@validatedAt" timestamp with time zone
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
    IF "@actorId" IS NULL THEN
        RAISE EXCEPTION 'bulk.actorIdMissing';
    END IF;
    IF "@batchId" IS NULL THEN
        RAISE EXCEPTION 'bulk.batchIdMissing';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM bulk."batch" AS b WHERE b."batchId" = "@batchId") THEN
        RAISE EXCEPTION 'bulk.batchNotFound';
    END IF;
    IF "@batchStatusId" IS NOT NULL THEN
        IF NOT EXISTS (SELECT 1 FROM bulk."batchStatus" AS bs WHERE bs."batchStatusId" = "@batchStatusId") THEN
            RAISE EXCEPTION 'bulk.batchStatusIdNotFound';
        END IF;
     END IF;

    INSERT INTO bulk."batchHistory" (
        "name",
        "account",
        "expirationDate",
        "batchId",
        "batchStatusId",
        "actorId",
        "info",
        "validatedAt",
        "createdAt"
    )
    SELECT
        b."name",
        b."account",
        b."expirationDate",
        b."batchId",
        b."batchStatusId",
        b."actorId",
        b."info",
        b."validatedAt",
        NOW()
    FROM
        bulk."batch" AS b
    WHERE
        b."batchId" = "@batchId";

    UPDATE
        bulk."batch" AS b
    SET
        "account" = COALESCE("@account", b."account"),
        "expirationDate" = COALESCE("@expirationDate", b."expirationDate"),
        "name" = COALESCE("@name", b."name"),
        "batchStatusId" = COALESCE("@batchStatusId", b."batchStatusId"),
        "info" = COALESCE("@batchInfo", b."info"),
        "actorId" = "@actorId",
        "validatedAt" = COALESCE("@validatedAt", b."validatedAt")
    WHERE
        b."batchId" = "@batchId";

    IF "@fileName" IS NOT NULL THEN
        IF "@originalFileName" IS NULL THEN
            RAISE EXCEPTION 'bulk.missingOriginalFileName';
        END IF;
        INSERT INTO
            bulk."upload" (
                "batchId",
                "fileName",
                "originalFileName",
                "info",
                "createdAt"
            )
        VALUES (
                "@batchId",
                "@fileName",
                "@originalFileName",
                '',
                now()
        );
    ELSE
        IF "@uploadInfo" IS NOT NULL THEN
            UPDATE
                bulk."upload" AS u
            SET
                "info" = "@uploadInfo"
            WHERE
                u."uploadId" = (
                    SELECT
                        MAX(up."uploadId")
                    FROM
                        bulk."upload" up
                    WHERE
                        up."batchId" = "@batchId"
                );
         END IF;
    END IF;

    RETURN QUERY
    SELECT
        b."batchId" as "batchId",
        b."account" as "account",
        b."expirationDate" as "expirationDate",
        b."name" as "name",
        b."batchStatusId" as "batchStatusId",
        b."info" as "batchInfo",
        u."info" as "uploadInfo",
        "@actorId" as "actorId",
        u."fileName" as "fileName",
        u."originalFileName" as "originalFileName",
        b."validatedAt",
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
