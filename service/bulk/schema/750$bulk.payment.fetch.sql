CREATE OR REPLACE FUNCTION bulk."payment.fetch" (
    "@paymentId" BIGINT[],
    "@batchId" INTEGER,
    "@nationalId" VARCHAR(255),
    "@paymentStatusId" INTEGER[],
    "@fromDate" TIMESTAMP,
    "@toDate" TIMESTAMP,
    "@sequenceNumber" INTEGER,
    "@name" VARCHAR(100),
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
    "@payments" JSON;
    "@pagination" JSON;
BEGIN
WITH a as (
    SELECT
        p."paymentId",
        p."batchId",
        p."sequenceNumber",
        p."identifier",
        p."firstName",
        p."lastName",
        p."dob",
        p."nationalId",
        p."amount",
        p."paymentStatusId",
        (SELECT ps."name" FROM bulk."paymentStatus" ps WHERE ps."paymentStatusId" = p."paymentStatusId") AS "status",
        p."info",
        b."name",
        p."createdAt",
        p."updatedAt"
    FROM
        bulk."payment" AS p
    JOIN
        bulk."batch" b ON b."batchId" = p."batchId"
    WHERE
    	(CASE
         	WHEN "@paymentId" IS NOT NULL THEN
         		p."paymentId" IN (SELECT UNNEST("@paymentId"))
         	ELSE
                ("@batchId" IS NULL OR p."batchId" = "@batchId")
                AND ("@nationalId" IS NULL OR p."nationalId" = "@nationalId")
                AND ("@paymentStatusId" IS NULL OR p."paymentStatusId" = ANY("@paymentStatusId"))
                AND ("@fromDate" IS NULL OR p."createdAt" >= "@fromDate")
                AND ("@toDate" IS NULL OR p."createdAt" <= "@toDate")
                AND ("@sequenceNumber" IS NULL OR p."sequenceNumber" = "@sequenceNumber")
                AND ("@name" IS NULL OR p."firstName" ~* "@name" OR p."lastName" ~* "@name")
        END)
    ORDER BY p."paymentId"
)

    SELECT
        json_agg(row_to_json(aa)) as "payments",
        json_build_object(
            'pageNumber', "@pageNumber",
            'pageSize', (SELECT COUNT(aa.*)),
            'pagesTotal', (SELECT CEIL(COUNT(a)::numeric / "@pageSize") FROM a),
            'recordsTotal', (SELECT COUNT(a) FROM a)
        ) AS "pagination"
    FROM
    (
        SELECT a.*
        FROM a
        LIMIT "@pageSize" OFFSET ("@pageNumber" - 1) * "@pageSize"
    ) aa
    INTO "@payments", "@pagination";

RETURN QUERY
SELECT
    "@payments" AS "data",
    "@pagination" AS "pagination",
    true AS "isSingleResult";

END;
$body$
LANGUAGE 'plpgsql';
