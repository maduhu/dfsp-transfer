CREATE TABLE transfer."invoiceType" (
    "invoiceTypeId" SERIAL,
    "name" VARCHAR(50),
    "description" VARCHAR(100),
    CONSTRAINT "pkTransferInvoiceType" PRIMARY KEY ("invoiceTypeId")
)
