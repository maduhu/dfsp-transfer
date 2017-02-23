CREATE OR REPLACE FUNCTION queue."queue.fetch" (
    "@count" INTEGER
)
RETURNS TABLE (
    "queueId" BIGINT,
    "recordId" BIGINT,
    "retryId" SMALLINT,
    "expirationDate" timestamp without time zone,
    "updatedAt" timestamp without time zone
) AS
$body$
BEGIN
    RETURN QUERY
    SELECT
        q."queueId",
        q."recordId",
        q."retryId",
        q."expirationDate",
        q."updatedAt"
    FROM 
        queue."queue" AS q
    JOIN
        queue."retry" AS qr ON qr."retryId" = q."retryId"
    WHERE
        LEAST(q."expirationDate", q."updatedAt" + (qr.period * interval '1 minute')) < NOW()
        OR (qr."retryId" = (SELECT MAX(queue."retry"."retryId") FROM queue."retry") AND q."expirationDate" < NOW())
    ORDER BY q."queueId"
    LIMIT "@count";
END;
$body$
LANGUAGE 'plpgsql';
