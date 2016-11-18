CREATE TABLE transfer."invoice" (
    "invoiceId" SERIAL,
    "account" VARCHAR(100),
    "name" VARCHAR(100),
    "currencyCode" VARCHAR(3),
    "currencySymbol" VARCHAR(3),
    "amount" NUMERIC,
    "statusCode" VARCHAR(5),
    "userNumber" VARCHAR(100),
    "invoiceInfo" VARCHAR(100),
    CONSTRAINT "pkTransferInvoice" PRIMARY KEY ("invoiceId"),
    CONSTRAINT "fkTransferInvoice_TransferInvoiceStatus" FOREIGN KEY ("statusCode")
        REFERENCES transfer."invoiceStatus"(code)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
        NOT DEFERRABLE
)
