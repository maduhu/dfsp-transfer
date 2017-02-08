CREATE TABLE bulk."batch"  (
    "batchId" SERIAL,
    "name" VARCHAR(100),
    "accountNumber" VARCHAR(25),
    "expirationDate" timestamp without time zone,
    CONSTRAINT "pkBulkBatch" PRIMARY KEY ("batchId")
)
