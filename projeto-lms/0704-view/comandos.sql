CREATE VIEW "lessons_completed_full" AS
SELECT "u"."id", "u"."email", "c"."title" AS "course",
"l"."title" AS "lessons", "lc"."completed"
FROM "lessons_completed" AS "lc"
JOIN "users" AS "u" ON "u"."id" = "lc"."user_id"
JOIN "lessons" AS "l" ON "l"."id" = "lc"."lesson_id"
JOIN "courses" AS "c" ON "c"."id" = "lc"."course_id";

EXPLAIN QUERY PLAN SELECT * FROM "lessons_completed_full" WHERE "id" = 1;

-- certificates with all information
CREATE VIEW "certificates_full" AS
SELECT "cert"."id", "cert"."user_id", "u"."name",
       "cert"."course_id", "c"."title", "c"."hours",
       "c"."lessons", "cert"."completed"
FROM "certificates" as "cert"
JOIN "users" AS "u" ON "u"."id" = "cert"."user_id"
JOIN "courses" AS "c" on "c"."id" = "cert"."course_id";

SELECT * FROM "certificates_full" WHERE "user_id" = 1;


CREATE VIEW "lesson_nav" AS
SELECT "cl"."slug" AS "current_slug", "l".* FROM "lessons" AS "cl"
JOIN "lessons" AS "l"
ON "l"."course_id" = "cl"."course_id"
AND "l"."order" BETWEEN "cl"."order" - 1 AND "cl"."order" + 1
ORDER BY "l"."order";

SELECT * FROM "lesson_nav" WHERE "course_id" = 1 AND "current_slug" = 'tags-basicas';









