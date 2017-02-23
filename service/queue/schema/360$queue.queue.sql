CREATE TABLE queue."queue"  (
    "queueId" BIGSERIAL,
    "recordId" BIGINT,
    "retryId" INTEGER,
    "expirationDate" timestamp without time zone,
    "updatedAt" timestamp without time zone NOT NULL,
    CONSTRAINT "pkQueueQueue" PRIMARY KEY ("queueId"),
    CONSTRAINT "fkQueueQeueu_queueRetry" FOREIGN KEY ("retryId") REFERENCES queue."retry"("retryId")
)
