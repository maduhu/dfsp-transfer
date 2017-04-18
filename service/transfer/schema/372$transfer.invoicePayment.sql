CREATE TABLE transfer."invoicePayment" (
    "invoicePaymentId" BIGSERIAL,
    "invoicePayerId" BIGINT,
    "createdAt" TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT "pkInvoicePaymentId" PRIMARY KEY ("invoicePaymentId"),
    CONSTRAINT "fkInvoicePayment_InvoicePayer" FOREIGN KEY ("invoicePayerId") REFERENCES transfer."invoicePayer"("invoicePayerId")
)
