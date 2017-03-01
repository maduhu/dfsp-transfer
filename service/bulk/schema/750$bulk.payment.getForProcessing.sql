CREATE OR REPLACE FUNCTION bulk."payment.getForProcessing" (
    "@count" INTEGER DEFAULT 100
)
RETURNS TABLE (
    "paymentId" BIGINT,
    "batchId" INTEGER,
    "sequenceNumber" INTEGER,
    "userNumber" VARCHAR(25),
    "firstName" VARCHAR(255),
    "lastName" VARCHAR(255),
    "dob" TIMESTAMP,
    "nationalId" VARCHAR(255),
    "amount" NUMERIC(19,2),
    "paymentStatusId" SMALLINT,
    "info" TEXT,
    "createdAt" TIMESTAMP,
    "updatedAt" TIMESTAMP
) AS
$body$
DECLARE
    "@maxRetry" INTEGER := (SELECT MAX(queue."retry"."retryId") FROM queue."retry");
BEGIN
    RETURN QUERY
    SELECT DISTINCT ON (p."paymentId")
        p."paymentId",
        p."batchId",
        p."sequenceNumber",
        p."userNumber",
        p."firstName",
        p."lastName",
        p."dob",
        p."nationalId",
        p."amount",
        p."paymentStatusId",
        p."info",
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
    	LEAST(b."expirationDate", q."updatedAt" + (r.interval * interval '1 minute')) < NOW()
        OR (r."retryId" < "@maxRetry" AND b."expirationDate" < NOW())
        OR (r."retryId" = "@maxRetry" AND b."expirationDate" > NOW())
    ORDER BY
        p."paymentId", q."queueId"
    LIMIT "@count";
END;
$body$
LANGUAGE 'plpgsql';
