CREATE OR REPLACE FUNCTION bulk."batch.add" (
    "@name" varchar,
    "@actorId" varchar,
    "@fileName" varchar
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
            "name"
        )
        VALUES (
            "@name"
        )
        RETURNING bulk."batch"."batchId" INTO "@batchId";

        INSERT INTO bulk."batchHistory" (
            "batchId",
            "statusId",
            "actorId",
            "info",
            "createdAt"
        )
        VALUES (
            "@batchId",
            "@statusId",
            "@actorId",
            '',
            NOW()
        );

        INSERT INTO bulk."upload" (
            "batchId",
            "fileName",
            "info",
            "createdAt"
        )
        VALUES (
            "@batchId",
            "@fileName",
            '',
            NOW()
        );

        RETURN QUERY
        SELECT
            b."batchId",
            b."name",
            bh."statusId",
            bh."actorId",
            true as "isSingleResult"
        FROM 
            bulk."batch" AS b
        JOIN
            bulk."batchHistory" bh ON b."batchId" = bh."batchId"
        WHERE
            b."batchId" = "@batchId";
END;
$BODY$ 
LANGUAGE plpgsql