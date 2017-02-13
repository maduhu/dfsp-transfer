CREATE OR REPLACE FUNCTION bulk."batchStatus.fetch" ()
RETURNS TABLE (
    "key" SMALLINT,
    "name" VARCHAR(100),
    "description" VARCHAR(256)
) AS
$body$
BEGIN
    RETURN QUERY
    SELECT 
        bs."batchStatusId" AS "key",
        bs."name" AS "name",
        bs."description" AS "description"
    FROM
        bulk."batchStatus" AS bs;
END;
$body$
LANGUAGE 'plpgsql';
