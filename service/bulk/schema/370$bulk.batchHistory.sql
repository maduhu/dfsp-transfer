CREATE TABLE bulk."batchHistory"  (
    "batchHistoryId" SERIAL,
    "name" VARCHAR(100) NOT NULL,
    "accountNumber" VARCHAR(25),
    "expirationDate" timestamp without time zone,
    "batchId" INTEGER,
    "batchStatusId" SMALLINT,
    "actorId" VARCHAR(25) NOT NULL,
    "info" TEXT,
    "createdAt" timestamp without time zone NOT NULL,
    CONSTRAINT "pkBulkBatchHistory" PRIMARY KEY ("batchHistoryId"),
    CONSTRAINT "fkBulkBatchHistory_bulkBatch" FOREIGN KEY ("batchId") REFERENCES bulk."batch"("batchId"),
    CONSTRAINT "fkBulkBatchHistory_bulkBatchStatus" FOREIGN KEY ("batchStatusId") REFERENCES bulk."batchStatus"("batchStatusId")
)
