CREATE OR REPLACE FUNCTION bulk."payment.add" (
    "@actorId" varchar,
    "@payments" json
)
RETURNS TABLE (
    "insertedRows" INTEGER,
    "isSingleResult" boolean
) AS
$BODY$

    DECLARE "@statusId" SMALLINT:= (SELECT bulk."status"."statusId" FROM bulk."status" WHERE bulk."status"."name" = 'pending');
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
                "statusId",
                "createdAt",
                "updatedAt"
            )
            SELECT 
                *,
                "@statusId" as statusId,
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
                "statusId",
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
                "statusId",
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