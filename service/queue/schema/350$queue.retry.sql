CREATE TABLE queue."retry"  (
    "retryId" SMALLINT,
    "period" INTEGER,
    CONSTRAINT "pkQueueRetry" PRIMARY KEY ("retryId")
)
