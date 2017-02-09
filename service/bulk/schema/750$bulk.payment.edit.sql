CREATE OR REPLACE FUNCTION bulk."payment.edit" (
    "@actorId" varchar,
    "@payments" json
)
RETURNS TABLE (
    "payments" json
) AS
$body$
DECLARE 
    "@paymentIds" BIGINT[];
BEGIN

    INSERT INTO bulk."paymentHistory" (
        "actorId",
        "paymentId",
        "batchId",
        "sequenceNumber",
        "userNumber",
        "firstName",
        "lastName",
        "dob",
        "nationalId",
        "amount",
        "paymentStatusId",
        "createdAt"
    )
    SELECT
        "@actorId",
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
        NOW()
    FROM bulk."payment" AS p
    WHERE "paymentId" IN (SELECT jp."paymentId" FROM json_to_recordset("@payments") AS jp("paymentId" INTEGER));

WITH 
    np AS (
        UPDATE bulk."payment" AS p SET
            "batchId" = COALESCE(jp."batchId", p."batchId"),
            "sequenceNumber" = COALESCE(jp."sequenceNumber", p."sequenceNumber"),
            "userNumber" = COALESCE(jp."userNumber", p."userNumber"),
            "firstName" = COALESCE(jp."firstName", p."firstName"),
            "lastName" = COALESCE(jp."lastName", p."lastName"),
            "dob" = COALESCE(jp."dob", p."dob"),
            "nationalId" = COALESCE(jp."nationalId", p."nationalId"),
            "amount" = COALESCE(jp."amount", p."amount"),
            "paymentStatusId" = COALESCE(jp."paymentStatusId", p."paymentStatusId"),
            "updatedAt" = NOW()
        FROM
            json_to_recordset("@payments") AS jp(
                "paymentId" INTEGER,
                "batchId" INTEGER,
                "sequenceNumber" INTEGER,
                "userNumber" VARCHAR(25),
                "firstName" VARCHAR(255),
                "lastName" VARCHAR(255),
                "dob" TIMESTAMP,
                "nationalId" VARCHAR(255),
                "amount" NUMERIC(19,2),
                "paymentStatusId" INTEGER
            )
        WHERE jp."paymentId" = p."paymentId"
        RETURNING p.*
    )

    SELECT array(SELECT np."paymentId" FROM np) INTO "@paymentIds";

    RETURN QUERY
    SELECT 
        json_agg(p) as "payments"
    FROM 
        bulk."payment" p
    WHERE
        "paymentId" IN (SELECT(UNNEST("@paymentIds")));
END;
$body$
LANGUAGE 'plpgsql';
