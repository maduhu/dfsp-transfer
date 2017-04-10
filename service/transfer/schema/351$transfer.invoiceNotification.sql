CREATE TABLE transfer."invoiceNotification" (
    "invoiceNotificationId" SERIAL,
    "invoiceUrl" VARCHAR(100),
    "identifier" VARCHAR(50),
    "invoiceNotificationStatusId" INTEGER,
    "memo" VARCHAR(200),
    CONSTRAINT "pkTransferInvoiceNotification" PRIMARY KEY ("invoiceNotificationId"),
    CONSTRAINT "fkTransferInvoiceNotification_TransferInvoiceStatus" FOREIGN KEY ("invoiceNotificationStatusId")
        REFERENCES transfer."invoiceStatus"("invoiceStatusId")
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
        NOT DEFERRABLE
)
