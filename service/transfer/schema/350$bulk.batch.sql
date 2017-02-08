CREATE TABLE bulk."batch"  (
    "batchId" SERIAL,
    "name" VARCHAR(100),
    "accountNumber" character varying(25) NOT NULL,
    "expirationDate" timestamp without time zone NOT NULL,
    CONSTRAINT "pkBulkBatch" PRIMARY KEY ("batchId")
)
