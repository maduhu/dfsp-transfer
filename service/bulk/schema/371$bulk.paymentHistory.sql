CREATE TABLE bulk."paymentHistory"  (
    "paymentHistoryId" BIGSERIAL,
    "actorId" VARCHAR(25) NOT NULL,
    "paymentId" BIGINT,
    "batchId" INTEGER,
    "sequenceNumber" INTEGER,
    "userNumber" VARCHAR(25),
    "firstName" VARCHAR(255),
    "lastName" VARCHAR(255),
    "dob" timestamp without time zone,
    "nationalId" VARCHAR(255),
    "amount" numeric(19,2),
    "statusId" SMALLINT,
    "createdAt" timestamp without time zone NOT NULL,
    CONSTRAINT "pkBulkPaymentHistory" PRIMARY KEY ("paymentHistoryId"),
    CONSTRAINT "fkBulkPaymentHistory_bulkPayment" FOREIGN KEY ("paymentId") REFERENCES bulk."payment"("paymentId"),
    CONSTRAINT "fkBulkPaymentHistory_bulkBatch" FOREIGN KEY ("batchId") REFERENCES bulk."batch"("batchId"),
    CONSTRAINT "fkBulkPayment_bulkStatus" FOREIGN KEY ("statusId") REFERENCES bulk."status"("statusId")
)
