CREATE OR REPLACE FUNCTION transfer."invoicePayment.add" (
    "@invoicePayerId" BIGINT
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
        RAISE EXCEPTION 'transfer.invoicePayerIdMissing';
    END IF;

    WITH
    ip AS (
        INSERT INTO transfer."invoicePayment" (
            "invoicePayerId",
            "createdAt"
        )
        VALUES (
            "@invoicePayerId",
            NOW()
        )
        RETURNING *
    )
    SELECT
        ip."invoicePaymentId"
    INTO
        "@invoicePaymentId"
    FROM
        ip;

    RETURN QUERY
        SELECT
            *
        FROM
            transfer."invoicePayment.get" ("@invoicePayerId");
    END
$BODY$ LANGUAGE plpgsql
