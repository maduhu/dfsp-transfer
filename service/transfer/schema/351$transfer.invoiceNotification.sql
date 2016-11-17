CREATE TABLE transfer."invoiceNotification" (
    "invoiceNotificationId" SERIAL,
    "invoiceUrl" VARCHAR(100),
    "userNumber" VARCHAR(50),
    "status" VARCHAR(5),
    "memo" VARCHAR(200),
    CONSTRAINT "pkTransferInvoiceNotification" PRIMARY KEY ("invoiceNotificationId"),
    CONSTRAINT "fkTransferInvoiceNotification_TransferInvoiceStatus" FOREIGN KEY ("status")
        REFERENCES transfer."invoiceStatus"("code")
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
        NOT DEFERRABLE
)
