CREATE TABLE transfer."invoiceType" (
    "invoiceTypeCode" CHAR(5),
    "name" VARCHAR(50),
    "description" VARCHAR(100),
    CONSTRAINT "pkTransferInvoiceType" PRIMARY KEY ("invoiceTypeCode")
)