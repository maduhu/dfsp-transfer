CREATE OR REPLACE FUNCTION bulk."paymentStatus.fetch" ()
RETURNS TABLE (
    "key" SMALLINT,
    "name" VARCHAR(100),
    "description" VARCHAR(256)
) AS
$body$
BEGIN
    RETURN QUERY
    SELECT 
        bs."paymentStatusId" AS "key",
        bs."name" AS "name",
        bs."description" AS "description"
    FROM
        bulk."paymentStatus" AS bs;
END;
$body$
LANGUAGE 'plpgsql';
