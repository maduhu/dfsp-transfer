CREATE TABLE queue."retry"  (
    "retryId" SERIAL,
    "period" INTEGER,
    CONSTRAINT "pkQueueRetry" PRIMARY KEY ("retryId")
)
