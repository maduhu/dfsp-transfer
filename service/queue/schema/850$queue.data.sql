-- Insert queue retry
INSERT INTO
   queue."retry" ("retryId", "period")
VALUES
  (1, 0),
  (2, 20),
  (3, 60),
  (4, 120),
  (5, 240),
  (6, 480)
ON CONFLICT ("retryId") DO UPDATE SET "period" = EXCLUDED.period;
