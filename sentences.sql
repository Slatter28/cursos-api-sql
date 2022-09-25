
-- Creacion de las tablas con sus restricciones y normalizacion

CREATE TABLE "users" (
  "id" uuid PRIMARY KEY,
  "name" varchar NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "password" varchar NOT NULL,
  "age" int NOT NULL,
  "id_roles" int NOT NULL
);

CREATE TABLE "courses" (
  "id" uuid PRIMARY KEY,
  "title" varchar NOT NULL,
  "description" varchar NOT NULL,
  "level" varchar NOT NULL,
  "id_teacher" uuid NOT NULL,
  "id_categories" int NOT NULL
);

CREATE TABLE "course_videos" (
  "id" uuid PRIMARY KEY,
  "title" varchar NOT NULL,
  "url" varchar NOT NULL,
  "id_course" uuid NOT NULL
);

CREATE TABLE "categories" (
  "id" int PRIMARY KEY,
  "name" varchar NOT NULL
);

CREATE TABLE "roles" (
  "id" int PRIMARY KEY,
  "name" varchar NOT NULL
);

CREATE TABLE "users_courses" (
  "id" uuid PRIMARY KEY,
  "id_course" uuid NOT NULL,
  "id_user" uuid NOT NULL,
  "review" varchar NOT NULL,
  "percentage" float NOT NULL
);

-- Agregar relaciones de las tablas

ALTER TABLE "users" ADD FOREIGN KEY ("id_roles") REFERENCES "roles" ("id");

ALTER TABLE "course_videos" ADD FOREIGN KEY ("id_course") REFERENCES "courses" ("id");

ALTER TABLE "users_courses" ADD FOREIGN KEY ("id_user") REFERENCES "users" ("id");

ALTER TABLE "users_courses" ADD FOREIGN KEY ("id_course") REFERENCES "courses" ("id");

ALTER TABLE "courses" ADD FOREIGN KEY ("id_categories") REFERENCES "categories" ("id");

ALTER TABLE "courses" ADD FOREIGN KEY ("id_teacher") REFERENCES "users" ("id");

-- Creando dos o mas entidades para cada tabla

INSERT INTO public.categories
(id, "name")
VALUES(1, 'Desarrollo Backend'),
(2, 'Desarrollo Fronted');


INSERT INTO public.roles
(id, "name")
VALUES(1, 'student'),
(2, 'teacher'),
(3, 'admin');

INSERT INTO public.users
(id, "name", email, "password", age, id_roles)
VALUES('acf2d1d9-fe61-4fbc-9cb9-93d9ac35d6bb', 'Roger Matamoros', 'rmatamoros@gmail.com', 'asdas2131', 25, 1),
('dc1d33e7-811f-448d-9c6a-190210f6a7bb', 'Raul Ruilova', 'rruilovas@gmail.com', 'guatita28', 30, 2),
('f522cb46-f6c0-4721-82ed-135bb46d2d08', 'admin','admin@admin.com', 'admin2938328', 23,3);


INSERT INTO public.courses
(id, title, description, "level", id_teacher, id_categories)
VALUES('941537f3-c345-4f43-ba26-084d87cb88f2', 'Aprende Node js', ' Aprenderas a construir una Api Rest', 'medios', 'dc1d33e7-811f-448d-9c6a-190210f6a7bb', 1),
('24d510ee-ac4c-44bf-b151-a16e8d8b2f9a', 'Aprende Angular', ' Aprenderas a desarrollar aplicaciones web con Angular', 'medios', 'dc1d33e7-811f-448d-9c6a-190210f6a7bb', 2);


INSERT INTO public.course_videos
(id, title, url, id_course)
VALUES('05073191-c5a9-4ce9-9223-c05a6c1cd191', 'Introduccion', 'https://www.youtube.com/watch?v=BhvLIzVL8_o','941537f3-c345-4f43-ba26-084d87cb88f2'),
('c5ab1dfe-e76c-4427-b41a-91fbae905d48', 'web sockets con node', 'https://www.youtube.com/watch?v=0wqteZNqruc', '941537f3-c345-4f43-ba26-084d87cb88f2'),
('9153b835-7058-45b3-9b4b-c33c2b2de8d0', 'Introduccion', 'https://www.youtube.com/watch?v=fXpMiweCC_o&t=18s', '24d510ee-ac4c-44bf-b151-a16e8d8b2f9a');

-- RETOS OPCIONALES

-- Se creo la tabla pibote para usuarios y cursos, insertamos dos entidades


INSERT INTO public.users_courses
(id, id_course, id_user, review, percentage)
VALUES('ddeccd5b-7409-4ffb-bc63-3f4edd6ac814','941537f3-c345-4f43-ba26-084d87cb88f2', 'acf2d1d9-fe61-4fbc-9cb9-93d9ac35d6bb', 'Muy buen curso', 80),
('8b3e6b4e-5b18-4cbc-b847-f986da8d74c3', '24d510ee-ac4c-44bf-b151-a16e8d8b2f9a','acf2d1d9-fe61-4fbc-9cb9-93d9ac35d6bb', 'Aprendi mucho', 100);

-- Se hizo que se visualice la tabla cursos con su respectiva relacion de categoria y  nombre del profesor utilizando left join

select c.id , c.title , c.description , c."level" , c2."name" , u."name" , u.email  from courses c left join categories c2 on c.id_categories  = c2.id left join users u ON c.id_teacher = u.id ;