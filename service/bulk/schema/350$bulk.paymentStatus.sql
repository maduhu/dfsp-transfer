CREATE TABLE bulk."paymentStatus"  (
    "paymentStatusId" SMALLINT,
    "name" VARCHAR(100),
    "description" VARCHAR(256),
    CONSTRAINT "pkBulkPaymentStatus" PRIMARY KEY ("paymentStatusId")
)
