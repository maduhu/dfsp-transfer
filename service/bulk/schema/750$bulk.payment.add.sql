CREATE OR REPLACE FUNCTION bulk."payment.add" (
    "@actorId" varchar,
    "@payments" json
)
RETURNS TABLE (
    "insertedRows" INTEGER,
    "isSingleResult" boolean
) AS
$BODY$

    DECLARE "@paymentStatusId" SMALLINT:= (SELECT "paymentStatusId" FROM bulk."paymentStatus" WHERE "name" = 'new');
    DECLARE "@count" INT;

    BEGIN
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