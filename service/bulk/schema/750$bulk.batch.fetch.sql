CREATE OR REPLACE FUNCTION bulk."batch.fetch" (
    "@actorId" VARCHAR(25),
    "@name" VARCHAR,
    "@batchStatusId" INTEGER,
    "@fromDate" TIMESTAMP,
    "@toDate" TIMESTAMP,
    "@pageSize" INTEGER,
    "@pageNumber" INTEGER
)
RETURNS TABLE (
    "data" JSON,
    "pagination" JSON,
    "isSingleResult" BOOLEAN
) AS
$body$
DECLARE
    "@pageSize" INTEGER := COALESCE("@pageSize", 25);
    "@pageNumber" INTEGER := COALESCE("@pageNumber", 1);
    "@batches" JSON;
    "@pagination" JSON;
    "@validationStatuses" SMALLINT[]:= ARRAY(
        SELECT bs."batchStatusId"
        FROM bulk."batchStatus" bs
        WHERE bs."name" IN ('rejected', 'returned', 'approved')
    );
BEGIN
WITH a as (
    SELECT
        b."batchId",
        b."name",
        -- b."account",
        b."startDate",
        b."expirationDate",
        b."batchStatusId",
        bs."name" AS "status",
        -- b."actorId",
        -- b."info",
        -- u."fileName",
        -- u."originalFileName",
        b."createdAt",
        b."validatedAt" AS "lastValidation",
        (
            SELECT COUNT(p."paymentId")
            FROM bulk."payment" p
            WHERE p."batchId" = b."batchId"
        ) AS "paymentsCount"
    FROM
        bulk."batch" AS b
    JOIN
        bulk."batchStatus" AS bs ON bs."batchStatusId" = b."batchStatusId"
    -- JOIN
    --     bulk."upload" as u on u."batchId" = b."batchId"
    WHERE
        ("@name" IS NULL OR b."name" ~* "@name")
        AND (
            CASE WHEN "@batchStatusId" IS NOT NULL
            THEN b."batchStatusId" = "@batchStatusId"
            ELSE b."batchStatusId" IN (SELECT bs."batchStatusId" FROM bulk."batchStatus" bs WHERE bs.name <> 'deleted')
            END
            )
        AND ("@fromDate" IS NULL OR b."createdAt" >= "@fromDate")
        AND ("@toDate" IS NULL OR b."createdAt" <= "@toDate")
        AND ("@actorId" IS NULL OR b."actorId" = "@actorId")
        -- AND u."uploadId" = (
        --     SELECT
        --         up."uploadId"
        --     FROM
        --         bulk."upload" up
        --     WHERE
        --         up."batchId" = b."batchId"
        --     ORDER BY
        --         up."uploadId" DESC
        --     LIMIT 1
        -- );
    ORDER BY b."batchId" DESC
)
    SELECT
        json_agg(row_to_json(aa)) as "payments",
        json_build_object(
            'pageNumber', "@pageNumber",
            'pageSize', (SELECT COUNT(aa.*)),
            'pageTotal', (SELECT CEIL(COUNT(a)::numeric / "@pageSize") FROM a),
            'recordsTotal', (SELECT COUNT(a) FROM a)
        ) AS "pagination"
    FROM
    (
        SELECT a.*
        FROM a
        LIMIT "@pageSize" OFFSET ("@pageNumber" - 1) * "@pageSize"
    ) aa
    INTO "@batches", "@pagination";

RETURN QUERY
SELECT
    "@batches" AS "data",
    "@pagination" AS "pagination",
    true AS "isSingleResult";
    
END;
$body$
LANGUAGE 'plpgsql';
