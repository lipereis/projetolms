DELETE FROM "sessions" WHERE "token" = 'DBBE430A92F4CCAD';
DELETE FROM "users" WHERE "id" = 10;

DELETE FROM "sessions" WHERE "expires" < STRFTIME('%s','now');