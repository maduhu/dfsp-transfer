CREATE TABLE transfer."invoiceStatus" (
    "invoiceStatusId" SERIAL,
    "name" VARCHAR(50),
    "description" VARCHAR(100),
    CONSTRAINT "pkTransferInvoiceStatus" PRIMARY KEY ("invoiceStatusId")
)
