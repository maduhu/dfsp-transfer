CREATE OR REPLACE FUNCTION bulk."payment.preProcess" (
    "@paymentId" BIGINT
)
RETURNS TABLE (
    "paymentId" BIGINT,
    "batchId" INTEGER,
    "sequenceNumber" INTEGER,
    "identifier" VARCHAR(25),
    "firstName" VARCHAR(255),
    "lastName" VARCHAR(255),
    "dob" TIMESTAMP,
    "nationalId" VARCHAR(255),
    "amount" numeric(19,2),
    "paymentStatusId" SMALLINT,
    "info" TEXT,
    "payee" JSON,
    "name" VARCHAR(100),
    "createdAt" TIMESTAMP,
    "updatedAt" TIMESTAMP,
    "account" VARCHAR(100),
    "startDate" TIMESTAMP WITHOUT TIME ZONE,
    "expirationDate" TIMESTAMP WITHOUT TIME ZONE,
    "actorId" VARCHAR(25),
    "isSingleResult" boolean
) AS
$body$
DECLARE
    "@payment" record;
BEGIN
    SELECT * INTO "@payment" FROM bulk."payment.get"("@paymentId");
    UPDATE bulk."queue" SET
        "retryId" = (
            CASE
            WHEN("retryId" + 1 > (SELECT MAX(r."retryId") FROM bulk."retry" r) OR "@payment"."expirationDate" < NOW())
            THEN NULL
            ELSE "retryId" + 1 END
        ),
        "updatedAt" = NOW()
    WHERE
        bulk."queue"."paymentId" = "@paymentId";

    RETURN QUERY
    VALUES (
        "@payment"."paymentId",
        "@payment"."batchId",
        "@payment"."sequenceNumber",
        "@payment"."identifier",
        "@payment"."firstName",
        "@payment"."lastName",
        "@payment"."dob" ,
        "@payment"."nationalId",
        "@payment"."amount",
        "@payment"."paymentStatusId",
        "@payment"."info",
        "@payment"."payee",
        "@payment"."name",
        "@payment"."createdAt",
        "@payment"."updatedAt",
        "@payment"."account",
        "@payment"."startDate",
        "@payment"."expirationDate",
        "@payment"."actorId",
        "@payment"."isSingleResult"
    );
END;
$body$
LANGUAGE 'plpgsql';