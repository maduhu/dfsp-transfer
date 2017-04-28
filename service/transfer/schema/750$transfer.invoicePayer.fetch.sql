CREATE OR REPLACE FUNCTION transfer."invoicePayer.fetch" (
    "@invoiceId" BIGINT,
    "@paid" boolean
)
RETURNS TABLE (
    "invoicePayerId" BIGINT,
    "invoiceId" INTEGER,
    "identifier" VARCHAR(25),
    "createdAt" TIMESTAMP,
    "paidAt" TIMESTAMP
) AS
$body$
BEGIN
  RETURN QUERY
    SELECT
        payer."invoicePayerId" AS "invoicePayerId",
        payer."invoiceId" AS "invoiceId",
        payer."identifier" AS "identifier",
        payer."createdAt" AS "createdAt",
        payment."createdAt" AS "paidAt"
    FROM
        transfer."invoicePayer" payer
    JOIN
        transfer."invoice" invoice ON invoice."invoiceId" = payer."invoiceId"
    LEFT JOIN
        transfer."invoicePayment" payment ON payment."invoicePayerId" = payer."invoicePayerId"
    WHERE
        invoice."invoiceId" = "@invoiceId"
        AND ("@paid" IS NULL OR (
            CASE WHEN
                payment."invoicePaymentId" IS NULL
            THEN
                "@paid" = FALSE
            ELSE
                "@paid" = TRUE
            END
        ));
END;
$body$
LANGUAGE 'plpgsql';
