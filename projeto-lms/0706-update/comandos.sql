UPDATE "users" SET "email" = 'renata@email.com', "updated" = CURRENT_TIMESTAMP WHERE "id" = 9;

UPDATE "users" SET "password_hash" = '123456' WHERE "id" = 9;

UPDATE "sessions" SET "expires" = STRFTIME('%s','now','+15 days') WHERE "token" = '308DFB6F3E163514';