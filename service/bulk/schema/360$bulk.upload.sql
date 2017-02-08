CREATE TABLE bulk."upload"  (
    "uploadId" SERIAL,
    "batchId" INTEGER,
    "fileName" VARCHAR(256),
    "info" TEXT,
    "createdAt" timestamp without time zone NOT NULL,
    CONSTRAINT "pkBulkUpload" PRIMARY KEY ("uploadId"),
    CONSTRAINT "fkBulkUpload_bulkBatch" FOREIGN KEY ("batchId") REFERENCES bulk."batch"("batchId")
)
