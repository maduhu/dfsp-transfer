CREATE TABLE transfer."invoice" (
    "invoiceId" SERIAL,
    "account" VARCHAR(100),
    "merchantIdentifier" VARCHAR(100),
    "name" VARCHAR(100),
    "currencyCode" VARCHAR(3),
    "currencySymbol" VARCHAR(3),
    "amount" NUMERIC,
    "invoiceStatusId" INTEGER,
    "invoiceTypeId" INTEGER,
    "invoiceInfo" VARCHAR(100),
    "createdAt" timestamp,
    CONSTRAINT "pkTransferInvoice" PRIMARY KEY ("invoiceId"),
    CONSTRAINT "fkTransferInvoice_TransferInvoiceType" FOREIGN KEY ("invoiceTypeId") REFERENCES transfer."invoiceType"("invoiceTypeId"),
    CONSTRAINT "fkTransferInvoice_TransferInvoiceStatus" FOREIGN KEY ("invoiceStatusId")
        REFERENCES transfer."invoiceStatus"("invoiceStatusId")
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
        NOT DEFERRABLE
)
