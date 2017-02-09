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

    DECLARE "@batchId" INTEGER;
    DECLARE "@batchStatusId" SMALLINT:= (SELECT "batchStatusId" FROM bulk."paymentStatus" WHERE "name" = 'uploading');

    BEGIN
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