CREATE OR REPLACE FUNCTION bulk."payment.fetch" (
    "@batchId" INTEGER,
    "@nationalId" VARCHAR(255),
    "@paymentStatusId" INTEGER,
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
    SELECT
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
        (SELECT ps."name" FROM bulk."paymentStatus" ps WHERE ps."paymentStatusId" = p."paymentStatusId") AS "status",
        p."info",
        b."name",
        p."createdAt",
        p."updatedAt"
    FROM 
        bulk."payment" AS p
    JOIN
        bulk."batch" b ON b."batchId" = p."batchId"
    WHERE
        ("@batchId" IS NULL OR p."batchId" = "@batchId")
        AND ("@nationalId" IS NULL OR p."nationalId" = "@nationalId")
        AND ("@paymentStatusId" IS NULL OR p."paymentStatusId" = "@paymentStatusId")
        AND ("@fromDate" IS NULL OR p."createdAt" >= "@fromDate")
        AND ("@toDate" IS NULL OR p."createdAt" <= "@toDate")
        AND ("@sequenceNumber" IS NULL OR p."sequenceNumber" = "@sequenceNumber")
        AND ("@name" IS NULL OR b."name" = "@name")
    ORDER BY p."paymentId"
    LIMIT "@pageSize" OFFSET ("@pageNumber" - 1) * "@pageSize";
END;
$body$
LANGUAGE 'plpgsql';
