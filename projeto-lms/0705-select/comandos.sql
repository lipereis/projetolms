SELECT "name" FROM "users" WHERE "email" = 'ana@email.com';
SELECT * FROM "lessons" WHERE "course_id" = 1 ORDER BY "order";

SELECT * FROM "lessons" WHERE "course_id" =
(SELECT "id" FROM "courses" WHERE "slug" = 'javascript-completo')
ORDER BY "order";

SELECT * FROM "lessons" WHERE "free" = 1;
SELECT * FROM "certificates_full" WHERE "id" = '0456386e1999fbe4';

SELECT (SUM("seconds") / 60) AS "total_minutos" FROM "lessons" WHERE "course_id" = 1;

SELECT COUNT("l"."title") AS "total", COUNT("lc"."completed") AS "completed" FROM "lessons" AS "l"
LEFT JOIN "lessons_completed" AS "lc" ON "lc"."lesson_id" = "l"."id" AND "lc"."user_id" = 1
WHERE "l"."course_id" = 1;
