CREATE TABLE bulk."batch"  (
    "batchId" SERIAL,
    "name" VARCHAR(100) NOT NULL,
    "account" VARCHAR(100),
    "startDate" timestamp without time zone,
    "expirationDate" timestamp without time zone,
    "batchStatusId" SMALLINT,
    "actorId" VARCHAR(25) NOT NULL,
    "info" TEXT,
    "validatedAt" timestamp,
    "createdAt" timestamp without time zone NOT NULL,
    CONSTRAINT "pkBulkBatch" PRIMARY KEY ("batchId"),
    CONSTRAINT "fkBulkBatchHistory_bulkBatchStatus" FOREIGN KEY ("batchStatusId") REFERENCES bulk."batchStatus"("batchStatusId")
)
