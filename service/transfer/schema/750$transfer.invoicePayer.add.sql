CREATE OR REPLACE FUNCTION transfer."invoicePayer.add" (
    "@invoiceId" INTEGER,
    "@identifier" VARCHAR(25)
)
RETURNS TABLE (
    "invoicePayerId" BIGINT,
    "invoiceId" INTEGER,
    "identifier" VARCHAR(25),
    "createdAt" TIMESTAMP,
    "isSingleResult" boolean
) AS
$BODY$

DECLARE "@invoicePayerId" BIGINT;

BEGIN
    IF "@invoiceId" IS NULL THEN
        RAISE EXCEPTION 'transfer.invoiceIdIsMissing';
    END IF;
    IF "@identifier" IS NULL THEN
        RAISE EXCEPTION 'transfer.identifierIsMissing';
    END IF;

    WITH
    ip AS (
            INSERT INTO transfer.invoicePayer (
                "invoiceId",
                "identifier",
                "createdAt"
        )
            SELECT
                "@invoiceId"
                ,"@identifier"
                ,NOW() as "createdAt"
    )

    SELECT ip."invoicePayerId" FROM ip INTO  "@invoicePayerId";

    RETURN QUERY 
        SELECT 
            *,
            true AS "isSingleResult"
        FROM 
            transfer."invoicePayer.get" ("@invoicePayerId");
    END
$BODY$ LANGUAGE plpgsql
