CREATE OR REPLACE FUNCTION queue."queue.fetch" (
    "@count" INTEGER
)
RETURNS TABLE (
    "recordId" BIGINT
) AS
$body$
BEGIN
    RETURN QUERY
    SELECT
        DISTINCT q."recordId"
    FROM 
        queue."queue" AS q
    JOIN
        queue."retry" AS qr ON qr."retryId" = q."retryId"
    WHERE
        LEAST(q."expirationDate", q."updatedAt" + (qr.period * interval '1 minute')) < NOW()
        OR (qr."retryId" = (SELECT MAX(queue."retry"."retryId") FROM queue."retry") AND q."expirationDate" < NOW())
    ORDER BY q."recordId"
    LIMIT "@count";
END;
$body$
LANGUAGE 'plpgsql';
