CREATE OR REPLACE FUNCTION bulk."payment.process" (
    "@paymentId" BIGINT,
    "@actorId" VARCHAR,
    "@error" VARCHAR
)
RETURNS TABLE (
    "paymentId" BIGINT,
    "batchId" INTEGER,
    "sequenceNumber" INTEGER,
    "identifier" VARCHAR(25),
    "firstName" VARCHAR(255),
    "lastName" VARCHAR(255),
    "dob" timestamp,
    "nationalId" VARCHAR(255),
    "amount" numeric(19,2),
    "paymentStatusId" SMALLINT,
    "info" TEXT,
    "name" VARCHAR(100),
    "createdAt" timestamp,
    "updatedAt" timestamp,
    "account" VARCHAR(100),
    "expirationDate" timestamp without time zone,
    "actorId" VARCHAR(25),
    "isSingleResult" boolean
) AS
$body$
DECLARE
    "@batchId" INTEGER := (SELECT p."batchId" FROM bulk."payment" p WHERE p."paymentId" = "@paymentId");
BEGIN
    PERFORM bulk."payment.edit"(
        "@actorId",
        json_agg((SELECT x FROM (SELECT
            "@paymentId" as "paymentId",
            CASE
            WHEN(COALESCE("@error", '') = '')
            THEN (SELECT ps."paymentStatusId" FROM bulk."paymentStatus" ps WHERE ps."name" = 'paid')
            ELSE (SELECT ps."paymentStatusId" FROM bulk."paymentStatus" ps WHERE ps."name" = 'failed') END as "paymentStatusId",
            "@error" as "info") x
            ))
    );

    IF (COALESCE("@error", '') = '') THEN
        UPDATE
            bulk."queue"
        SET
            "retryId" = NULL
        WHERE
            bulk."queue"."paymentId" = "@paymentId";
    END IF;

    IF NOT EXISTS (
        SELECT
            1
        FROM
            bulk."payment" p
        JOIN
            bulk."queue" q ON p."paymentId" = q."paymentId"
        WHERE
            p."batchId" = "@batchId" AND
            q."retryId" IS NOT NULL
    ) THEN
        UPDATE
            bulk."batch"
        SET
            "batchStatusId" = (SELECT bs."batchStatusId" FROM bulk."batchStatus" bs WHERE bs."name" = 'done')
        WHERE
            bulk."batch"."batchId" = "@batchId";
    END IF;

    RETURN QUERY
    SELECT * FROM bulk."payment.get"("@paymentId");
END;
$body$
LANGUAGE 'plpgsql';
