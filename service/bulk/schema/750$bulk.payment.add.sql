CREATE OR REPLACE FUNCTION bulk."payment.add" (
    "@actorId" varchar,
    "@payments" json
)
RETURNS TABLE (
    "insertedRows" INTEGER,
    "isSingleResult" boolean
) AS
$BODY$
DECLARE
    "@paymentStatusId" SMALLINT:= (SELECT ps."paymentStatusId" FROM bulk."paymentStatus" ps WHERE ps."name" = 'new');
    "@count" INT;
    "@paymentsCount" INT:= json_array_length("@payments"); 
BEGIN
    IF "@actorId" IS NULL THEN
        RAISE EXCEPTION 'bulk.actorIdMissing';
    END IF;
    IF "@payments" IS NULL THEN
        RAISE EXCEPTION 'bulk.paymentsMissing';
    END IF;
    IF "@paymentsCount" = 0 THEN
        RAISE EXCEPTION 'bulk.emptyPayments';
    END IF;

    WITH 
    p AS (
        INSERT INTO bulk."payment" (
            "batchId",
            "sequenceNumber",
            "userNumber",
            "firstName",
            "lastName",
            "dob",
            "nationalId",
            "amount",
            "paymentStatusId",
            "createdAt",
            "updatedAt"
        )
        SELECT 
            *,
            "@paymentStatusId" as "paymentStatusId",
            NOW() as "createdAt",
            NOW() as "updatedAt"
        FROM
            json_to_recordset("@payments") AS x(
                "batchId" INTEGER,
                "sequenceNumber" INTEGER,
                "userNumber" VARCHAR(25),
                "firstName" VARCHAR(255),
                "lastName" VARCHAR(255),
                "dob" TIMESTAMP,
                "nationalId" VARCHAR(255),
                "amount" numeric(19,2)
            )
        RETURNING *
    ), ph as (
        INSERT INTO bulk."paymentHistory" (
            "actorId",
            "paymentId",
            "batchId",
            "sequenceNumber" ,
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
            "@actorId" as "actorId",
            "paymentId",
            "batchId",
            "sequenceNumber" ,
            "userNumber",
            "firstName",
            "lastName",
            "dob",
            "nationalId",
            "amount",
            "paymentStatusId",
            "createdAt"
        FROM
            p
        RETURNING *
    )
    
    SELECT count(p.*) FROM p INTO "@count";

    RETURN QUERY
    SELECT
        "@count" as "insertedRows",
        true AS "isSingleResult";
END;
$BODY$ 
LANGUAGE plpgsql