CREATE TABLE bulk."queue"  (
    "queueId" BIGSERIAL,
    "paymentId" BIGINT,
    "retryId" SMALLINT,
    "updatedAt" TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT "pkBulkQueue" PRIMARY KEY ("queueId"),
    CONSTRAINT "fkBulkQueue_queuePayment" FOREIGN KEY ("paymentId") REFERENCES bulk."payment"("paymentId"),
    CONSTRAINT "fkBulkQueue_queueRetry" FOREIGN KEY ("retryId") REFERENCES bulk."retry"("retryId")
)
