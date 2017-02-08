CREATE TABLE bulk."batchHistory"  (
    "batchHistoryId" SERIAL,
    "batchId" INTEGER,
    "statusId" SMALLINT,
    "actorId" character varying(25) NOT NULL,
    "info" TEXT,
    "createdAt" timestamp without time zone NOT NULL,
    CONSTRAINT "pkBulkBatchHistory" PRIMARY KEY ("batchHistoryId"),
    CONSTRAINT "fkBulkBatchHistory_bulkBatch" FOREIGN KEY ("batchId") REFERENCES bulk."batch"("batchId"),
    CONSTRAINT "fkBulkBatchHistory_bulkStatus" FOREIGN KEY ("statusId") REFERENCES bulk."status"("statusId")
)
