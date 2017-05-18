CREATE OR REPLACE FUNCTION bulk."batch.getTotalAmount" (
    "@batchId" integer
)
RETURNS TABLE (
    "totalAmount" numeric(19,2),
    "isSingleResult" boolean
) AS
$body$
BEGIN
  IF "@batchId" IS NULL THEN
     RAISE EXCEPTION 'bulk.batchIdMissing';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM bulk."batch" AS b WHERE b."batchId" = "@batchId") THEN
    RAISE EXCEPTION 'bulk.batchNotFound';
  END IF;
  RETURN QUERY
    SELECT
        COALESCE(SUM(p."amount"), 0) as "totalAmount",
        true as "isSingleResult"
    FROM
        bulk."payment" AS p
    WHERE
        p."batchId" = "@batchId"
        AND p."paymentStatusId" != (
            SELECT ps."paymentStatusId"
            FROM bulk."paymentStatus" ps
            WHERE ps."name" = 'disabled'
    );
END;
$body$
LANGUAGE 'plpgsql';
