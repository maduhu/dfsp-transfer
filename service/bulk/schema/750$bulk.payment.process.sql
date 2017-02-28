CREATE OR REPLACE FUNCTION bulk."payment.process" (
    "@paymentId" BIGINT,
    "@actorId" VARCHAR,
    "@info" VARCHAR
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
    "status" VARCHAR(100),
    "info" TEXT,
    "name" VARCHAR(100),
    "createdAt" timestamp,
    "updatedAt" timestamp,
    "isSingleResult" BOOLEAN
) AS
$body$
BEGIN
    PERFORM bulk."payment.edit"(
        "@actorId",
        (
            '[{
                "paymentId" : ' || "@paymentId" ||
                ', "paymentStatusId": ' ||
                    CASE
                    WHEN("@info" IS NULL)
                    THEN (SELECT ps."paymentStatusId" FROM bulk."paymentStatus" ps WHERE ps."name" = 'paid')
                    ELSE (SELECT ps."paymentStatusId" FROM bulk."paymentStatus" ps WHERE ps."name" = 'failed') END ||
                ', "info": "' || "@info" || 
            '"}]'
        )::json
    );

    IF ("@info" IS NULL) THEN
        UPDATE
            bulk."queue" q
        SET
            q."retryId" = NULL
        WHERE
            q."paymentId" = "@paymentId";
    END IF;

    RETURN QUERY
    SELECT *, true FROM bulk."payment.get"("@paymentId");
END;
$body$
LANGUAGE 'plpgsql';
