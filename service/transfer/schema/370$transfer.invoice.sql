CREATE TABLE transfer."invoice" (
    "invoiceId" SERIAL,
    "account" VARCHAR(100),
    "merchantIdentifier" VARCHAR(100),
    "name" VARCHAR(100),
    "currencyCode" VARCHAR(3),
    "currencySymbol" VARCHAR(3),
    "amount" NUMERIC,
    "statusCode" VARCHAR(5),
    "invoiceTypeCode" VARCHAR(5),
    "invoiceInfo" VARCHAR(100),
    "createdAt" timestamp,
    CONSTRAINT "pkTransferInvoice" PRIMARY KEY ("invoiceId"),
    CONSTRAINT "fkTransferInvoice_TransferInvoiceType" FOREIGN KEY ("invoiceTypeCode") REFERENCES transfer."invoiceType"("invoiceTypeCode"),
    CONSTRAINT "fkTransferInvoice_TransferInvoiceStatus" FOREIGN KEY ("statusCode")
        REFERENCES transfer."invoiceStatus"(code)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
        NOT DEFERRABLE
)
