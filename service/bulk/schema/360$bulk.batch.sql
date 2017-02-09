CREATE TABLE bulk."batch"  (
    "batchId" SERIAL,
    "name" VARCHAR(100) NOT NULL,
    "accountNumber" VARCHAR(25),
    "expirationDate" timestamp without time zone,
    "statusId" SMALLINT,
    "actorId" VARCHAR(25) NOT NULL,
    "info" TEXT,
    "createdAt" timestamp without time zone NOT NULL,
    CONSTRAINT "pkBulkBatch" PRIMARY KEY ("batchId"),
    CONSTRAINT "fkBulkBatchHistory_bulkStatus" FOREIGN KEY ("statusId") REFERENCES bulk."status"("statusId")
)
