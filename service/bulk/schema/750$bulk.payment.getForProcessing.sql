CREATE OR REPLACE FUNCTION bulk."payment.getForProcessing" (
    "@count" INTEGER DEFAULT 100
)
RETURNS TABLE (
    "paymentId" BIGINT,
    "batchId" INTEGER,
    "sequenceNumber" INTEGER,
    "identifier" VARCHAR(25),
    "firstName" VARCHAR(255),
    "lastName" VARCHAR(255),
    "dob" TIMESTAMP,
    "nationalId" VARCHAR(255),
    "amount" NUMERIC(19,2),
    "paymentStatusId" SMALLINT,
    "info" TEXT,
    "payee" JSON,
    "createdAt" TIMESTAMP,
    "updatedAt" TIMESTAMP
) AS
$body$
DECLARE
    "@maxRetry" INTEGER := (SELECT MAX(bulk."retry"."retryId") FROM bulk."retry");
BEGIN
    RETURN QUERY
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
        p."info",
        p."payee",
        p."createdAt",
        p."updatedAt"
    FROM
        bulk."payment" p
    JOIN
        bulk."queue" q ON q."paymentId" = p."paymentId"
    JOIN
        bulk."retry" r ON r."retryId" = q."retryId"
    JOIN
        bulk."batch" b ON b."batchId" = p."batchId"
    WHERE
        p."paymentStatusId" = ANY(SELECT ps."paymentStatusId" FROM bulk."paymentStatus" ps WHERE ps."name" != 'paid')
        AND LEAST(b."expirationDate", q."updatedAt" + (r.interval * interval '1 minute')) < NOW()
        OR (r."retryId" < "@maxRetry" AND b."expirationDate" < NOW())
        OR (r."retryId" = "@maxRetry" AND b."expirationDate" > NOW())
    GROUP BY p."paymentId"
    ORDER BY
        ROW_NUMBER() OVER (PARTITION BY p."payee"->>'spspServer' ORDER BY p."paymentId"), max(q."queueId")
    LIMIT "@count";
END;
$body$
LANGUAGE 'plpgsql';
