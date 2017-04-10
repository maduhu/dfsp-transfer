CREATE OR REPLACE FUNCTION transfer."invoicePayment.add" (
    "@invoicePayerId" INTEGER
)
RETURNS TABLE (
    "invoicePaymentId" BIGINT,
    "invoicePayerId" BIGINT,
    "createdAt" TIMESTAMP,
    "isSingleResult" boolean
) AS
$BODY$

DECLARE "@invoicePaymentId" BIGINT;

BEGIN
    IF "@invoicePayerId" IS NULL THEN
        RAISE EXCEPTION 'transfer.invoicePayerIdIsMissing';
    END IF;

    WITH
    ip AS (
            INSERT INTO transfer.invoicePayment (
                "invoicePayerId",
                "createdAt"
        )
            SELECT
                "@invoicePayerId"
                ,NOW() as "createdAt"
    )

    SELECT ip."invoicePaymentId" FROM ip INTO "@invoicePaymentId";

    RETURN QUERY 
        SELECT 
            *
        FROM 
            transfer."invoicePayment.get" ("@invoicePayerId");
    END
$BODY$ LANGUAGE plpgsql
