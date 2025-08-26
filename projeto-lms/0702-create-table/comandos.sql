CREATE TABLE "users" (
  "id" INTEGER PRIMARY KEY,
  "name" TEXT NOT NULL,
  "password_hash" TEXT NOT NULL,
  "email" TEXT NOT NULL COLLATE NOCASE UNIQUE,
  "username" TEXT NOT NULL COLLATE NOCASE UNIQUE,
  "created" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
) STRICT;

CREATE TABLE "resets" (
  "token" TEXT PRIMARY KEY,
  "user_id" INTEGER NOT NULL,
  "ip" TEXT NOT NULL,
  "created" INTEGER NOT NULL DEFAULT (STRFTIME('%s', 'NOW')),
  "expires" INTEGER NOT NULL,
  FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE
) WITHOUT ROWID, STRICT;

CREATE INDEX "idx_resets_user_id" ON "resets" ("user_id");

CREATE TABLE "sessions" (
  "token" TEXT PRIMARY KEY,
  "user_id" INTEGER NOT NULL,
  "ip" TEXT NOT NULL,
  "created" INTEGER NOT NULL DEFAULT (STRFTIME('%s', 'NOW')),
  "expires" INTEGER NOT NULL,
  FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE
) WITHOUT ROWID, STRICT;

CREATE INDEX "idx_sessions_user_id" ON "sessions" ("user_id");

CREATE TABLE "courses" (
  "id" INTEGER PRIMARY KEY,
  "slug" TEXT NOT NULL COLLATE NOCASE UNIQUE,
  "title" TEXT NOT NULL,
  "description" TEXT NOT NULL,
  "lessons" INTEGER NOT NULL,
  "hours" INTEGER NOT NULL,
  "created" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
) STRICT;

CREATE TABLE "lessons" (
  "id" INTEGER PRIMARY KEY,
  "course_id" INTEGER NOT NULL,
  "slug" TEXT NOT NULL COLLATE NOCASE,
  "title" TEXT NOT NULL,
  "materia" TEXT NOT NULL,
  "materia_slug" TEXT NOT NULL,
  "seconds" INTEGER NOT NULL,
  "video" TEXT NOT NULL,
  "description" TEXT NOT NULL,
  "order" INTEGER NOT NULL,
  "free" INTEGER NOT NULL DEFAULT 0 CHECK ("free" IN (0,1)),
  "created" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY ("course_id") REFERENCES "courses" ("id"),
  UNIQUE("course_id", "slug")
) STRICT;

SELECT * FROM "lessons" WHERE "course_id" = 1 ORDER BY "order";
EXPLAIN QUERY PLAN SELECT * FROM "lessons" WHERE "course_id" = 1 ORDER BY "order";
CREATE INDEX "idx_lessons_order" ON "lessons" ("course_id", "order");

CREATE TABLE "lessons_completed" (
  "user_id" INTEGER NOT NULL,
  "course_id" INTEGER NOT NULL,
  "lesson_id" INTEGER NOT NULL,
  "completed" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("user_id", "course_id", "lesson_id"),
  FOREIGN KEY ("lesson_id") REFERENCES "lessons" ("id"),
  FOREIGN KEY ("course_id") REFERENCES "courses" ("id"),
  FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE
) WITHOUT ROWID, STRICT;

CREATE TABLE "certificates" (
  "id" TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(8)))),
  "user_id" INTEGER NOT NULL,
  "course_id" INTEGER NOT NULL,
  "completed" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE ("user_id", "course_id"),
  FOREIGN KEY ("course_id") REFERENCES "courses" ("id"),
  FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE
) WITHOUT ROWID, STRICT;
