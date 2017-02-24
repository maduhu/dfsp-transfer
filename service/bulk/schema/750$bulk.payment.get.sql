CREATE OR REPLACE FUNCTION bulk."payment.get" (
    "@paymentId" BIGINT
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
    "expirationDate" timestamp without time zone
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
        p."info",
        b."name",
        p."createdAt",
        p."updatedAt",
        b."account",
        b."expirationDate"
    FROM
        bulk."payment" AS p
    JOIN
        bulk."batch" b ON b."batchId" = p."batchId"
    WHERE
        p."paymentId" = "@paymentId";
END;
$body$
LANGUAGE 'plpgsql';