CREATE OR REPLACE FUNCTION bulk."batch.add" (
    "@name" varchar,
    "@actorId" varchar,
    "@fileName" varchar,
    "@originalFileName" varchar
)
RETURNS TABLE (
    "batchId" INTEGER,
    "name" VARCHAR(100),
    "statusId" SMALLINT,
    "actorId" VARCHAR(25),
    "isSingleResult" boolean
) AS
$BODY$

    DECLARE "@batchId" INTEGER;
    DECLARE "@statusId" SMALLINT:= (SELECT bulk."status"."statusId" FROM bulk."status" WHERE bulk."status"."name" = 'processing');

    BEGIN
        INSERT INTO bulk."batch" (
            "name",
            "statusId",
            "actorId",
            "info",
            "createdAt"
        )
        VALUES (
            "@name",
            "@statusId",
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
            b."statusId",
            b."actorId",
            true as "isSingleResult"
        FROM 
            bulk."batch" AS b
        WHERE
            b."batchId" = "@batchId";
END;
$BODY$ 
LANGUAGE plpgsql