CREATE OR REPLACE FUNCTION bulk."batch.add" (
    "@name" varchar,
    "@actorId" varchar,
    "@fileName" varchar,
    "@originalFileName" varchar
)
RETURNS TABLE (
    "batchId" INTEGER,
    "name" VARCHAR(100),
    "batchStatusId" SMALLINT,
    "actorId" VARCHAR(25),
    "isSingleResult" boolean
) AS
$BODY$

DECLARE
    "@batchId" INTEGER;
    "@batchStatusId" SMALLINT:= (SELECT "batchStatusId" FROM bulk."batchStatus" ps WHERE ps."name" = 'uploading');
BEGIN
    IF "@name" IS NULL THEN
        RAISE EXCEPTION 'bulk.nameIsMissing';
    END IF;
    IF "@actorId" IS NULL THEN
        RAISE EXCEPTION 'bulk.actorIdMissing';
    END IF;
    IF "@fileName" IS NULL THEN
        RAISE EXCEPTION 'bulk.missingFileName';
    END IF;
    IF "@originalFileName" IS NULL THEN
        RAISE EXCEPTION 'bulk.missingOriginalFileName';
    END IF;

    INSERT INTO bulk."batch" (
        "name",
        "batchStatusId",
        "actorId",
        "info",
        "createdAt"
    )
    VALUES (
        "@name",
        "@batchStatusId",
        "@actorId",
        '',
        NOW()
    )
    RETURNING bulk."batch"."batchId" INTO "@batchId";

    INSERT INTO bulk."upload" (
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
        NOW()
    );

    RETURN QUERY
    SELECT
        b."batchId",
        b."name",
        b."batchStatusId",
        b."actorId",
        true as "isSingleResult"
    FROM 
        bulk."batch" AS b
    WHERE
        b."batchId" = "@batchId";
END;
$BODY$ 
LANGUAGE plpgsql