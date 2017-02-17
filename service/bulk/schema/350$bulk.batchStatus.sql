CREATE TABLE bulk."batchStatus"  (
    "batchStatusId" SMALLINT,
    "name" VARCHAR(100),
    "description" VARCHAR(256),
    CONSTRAINT "pkBulkBatchStatus" PRIMARY KEY ("batchStatusId")
)
