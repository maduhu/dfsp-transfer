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
        INSERT INTO transfer."invoicePayer" (
            "invoiceId",
            "identifier",
            "createdAt"
        )
        VALUES (
            "@invoiceId",
            "@identifier",
            NOW()
        )
        RETURNING *
    )
    SELECT
        ip."invoicePayerId"
    INTO
        "@invoicePayerId"
    FROM ip;

    RETURN QUERY
        SELECT
            *
        FROM
            transfer."invoicePayer.get" ("@invoicePayerId");
    END
$BODY$ LANGUAGE plpgsql
