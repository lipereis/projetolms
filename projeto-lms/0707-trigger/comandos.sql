CREATE TRIGGER "set_users_updated"
AFTER UPDATE ON "users"
BEGIN
  UPDATE "users" SET "updated" = CURRENT_TIMESTAMP WHERE "id" = NEW."id";
END;

UPDATE "users" SET "email" = 'renata5@email.com' WHERE "id" = 9;