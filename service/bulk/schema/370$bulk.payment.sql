CREATE TABLE bulk."payment"  (
    "paymentId" BIGSERIAL,
    "batchId" INTEGER,
    "sequenceNumber" INTEGER,
    "userNumber" VARCHAR(25),
    "firstName" VARCHAR(255),
    "lastName" VARCHAR(255),
    "dob" timestamp without time zone,
    "nationalId" VARCHAR(255),
    "amount" numeric(19,2),
    "paymentStatusId" SMALLINT,
    "info" TEXT,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    CONSTRAINT "pkBulkPayment" PRIMARY KEY ("paymentId"),
    CONSTRAINT "fkBulkPayment_bulkBatch" FOREIGN KEY ("batchId") REFERENCES bulk."batch"("batchId"),
    CONSTRAINT "fkBulkPayment_bulkPaymentStatus" FOREIGN KEY ("paymentStatusId") REFERENCES bulk."paymentStatus"("paymentStatusId")
)
