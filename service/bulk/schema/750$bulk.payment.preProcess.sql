CREATE OR REPLACE FUNCTION bulk."payment.preProcess" (
    "@paymentId" BIGINT
)
RETURNS TABLE (
    "paymentId" BIGINT,
    "batchId" INTEGER,
    "sequenceNumber" INTEGER,
    "userNumber" VARCHAR(25),
    "firstName" VARCHAR(255),
    "lastName" VARCHAR(255),
    "dob" TIMESTAMP,
    "nationalId" VARCHAR(255),
    "amount" numeric(19,2),
    "paymentStatusId" SMALLINT,
    "info" TEXT,
    "name" VARCHAR(100),
    "createdAt" TIMESTAMP,
    "updatedAt" TIMESTAMP,
    "account" VARCHAR(100),
    "expirationDate" TIMESTAMP WITHOUT TIME ZONE,
    "actorId" VARCHAR(25),
    "isSingleResult" boolean
) AS
$body$
DECLARE
    "@payment" bulk."payment";
BEGIN
	SELECT bulk."payment.get"("@paymentId") INTO "@payment";
    UPDATE bulk."queue" q SET
        q."retryId" = (
            CASE
            WHEN("retryId" + 1 > (SELECT MAX(r."retryId") FROM bulk."retry" r) OR "@payment"."expirationDate" < NOW())
            THEN NULL
            ELSE "retryId" + 1 END
        ),
        q."updatedAt" = NOW()
    WHERE
        q."paymentId" = "@paymentId";

    RETURN QUERY
    SELECT "@payment";
END;
$body$
LANGUAGE 'plpgsql';
