CREATE TABLE transfer."invoicePayment" (
    "invoicePayerId" BIGSERIAL,
    "invoiceId" INTEGER,
    "identifier" VARCHAR(25),
    "createdAt" TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT "pkInvoicePayerId" PRIMARY KEY ("invoicePayerId"),
    CONSTRAINT "fkInvoicePayer_invoiceId" FOREIGN KEY ("invoiceId") REFERENCES transfer."invoice"("invoiceId")
)