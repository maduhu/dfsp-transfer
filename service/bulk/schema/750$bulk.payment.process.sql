CREATE OR REPLACE FUNCTION bulk."payment.process" (
    "@paymentId" BIGINT,
    "@actorId" VARCHAR,
    "@error" VARCHAR
)
RETURNS TABLE (
    "paymentId" BIGINT,
    "batchId" INTEGER,
    "sequenceNumber" INTEGER,
    "userNumber" VARCHAR(25),
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
BEGIN
    PERFORM bulk."payment.edit"(
        "@actorId",
        json_agg((SELECT x FROM (SELECT
            "@paymentId" as "paymentId",
            CASE
            WHEN("@error" IS NULL)
            THEN (SELECT ps."paymentStatusId" FROM bulk."paymentStatus" ps WHERE ps."name" = 'paid')
            ELSE (SELECT ps."paymentStatusId" FROM bulk."paymentStatus" ps WHERE ps."name" = 'failed') END as "paymentStatusId",
            "@error" as "info") x
            ))
    );

    IF ("@error" IS NULL) THEN
        UPDATE
            bulk."queue"
        SET
            "retryId" = NULL
        WHERE
            bulk."queue"."paymentId" = "@paymentId";
    END IF;

    RETURN QUERY
    SELECT * FROM bulk."payment.get"("@paymentId");
END;
$body$
LANGUAGE 'plpgsql';
