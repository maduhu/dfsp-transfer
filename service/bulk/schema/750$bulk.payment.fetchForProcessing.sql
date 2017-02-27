CREATE OR REPLACE FUNCTION bulk."payment.fetchForProcessing" (
    "@paymentId" BIGINT[],
    "@batchId" INTEGER,
    "@nationalId" VARCHAR(255),
    "@fromDate" TIMESTAMP,
    "@toDate" TIMESTAMP,
    "@sequenceNumber" INTEGER,
    "@name" VARCHAR(100),
    "@pageSize" INTEGER,
    "@pageNumber" INTEGER
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
    "updatedAt" timestamp
) AS
$body$
BEGIN
    RETURN QUERY
    SELECT * FROM bulk."payment.fetch"(
        "@paymentId",
        "@batchId",
        "@nationalId",
        ARRAY(SELECT ps."paymentStatusId" FROM bulk."paymentStatus" ps WHERE ps."name" = ANY(array['new', 'modified', 'verified'])),
        "@fromDate",
        "@toDate",
        "@sequenceNumber",
        "@name",
        "@pageSize",
        "@pageNumber"
    );
END;
$body$
LANGUAGE 'plpgsql';
