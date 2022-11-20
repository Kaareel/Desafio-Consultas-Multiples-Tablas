CREATE DATABASE desafio_carlos_venegas_997;

CREATE TABLE usuarios (
    id SERIAL,
    email VARCHAR,
    nombre VARCHAR,
    apellido VARCHAR,
    rol VARCHAR);


INSERT INTO usuarios(id, email, nombre, apellido, rol) 
VALUES (DEFAULT, 'juan@mail.com', 'juan', 'perez', 'administrador'),
(DEFAULT,' diego@mail.com', 'diego', 'munoz', 'usuario'),
(DEFAULT,'maria@mail.com', 'maria', 'meza', 'usuario'),
(DEFAULT,'roxana@mail.com','roxana', 'diaz', 'usuario'),
(DEFAULT,'pedro@mail.com', 'pedro', 'diaz', 'usuario');

CREATE TABLE posts (
    id SERIAL,
    titulo VARCHAR,
    contenido TEXT,
    fecha_creacion DATE,
    fecha_actualizacion DATE,
    destacado BOOLEAN,
    usuario_id BIGINT);

INSERT INTO posts (id, titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id)
VALUES(DEFAULT,'prueba', 'contenido prueba','01/01/2021','01/02/2021',true,1);
(DEFAULT,'prueba2', 'contenido prueba2','01/03/2021','01/03/2021',true,1); 
(DEFAULT, 'ejercicios','contenido ejercicios','02/05/2021','03/04/2021',true, 2);
(DEFAULT, 'ejercicios2','contenido ejercicios2','03/05/2021','04/04/2021', false,2);
(DEFAULT,'random', 'contenido random','03/06/2021','04/05/2021',false,null);

CREATE TABLE comentarios (id SERIAL, contenido VARCHAR, fecha_creacion DATE, usuario_id BIGINT, post_id BIGINT);

INSERT INTO comentarios (id, contenido, fecha_creacion, usuario_id, post_id)
VALUES (DEFAULT, 'comentario 1', '03/06/2021', 1, 1),
(DEFAULT, 'comentario 2', '03/06/2021', 2, 1),
(DEFAULT, 'comentario 3', '04/06/2021', 3, 1),
(DEFAULT, 'comentario 4', '04/06/2021', 1, 2),
(DEFAULT, 'comentario 5', '04/06/2021', 2, 2);

--Pregunta 2
SELECT u.nombre ,u.email, p.titulo, p.contenido 
FROM usuarios AS u JOIN post p ON u.id = p.usuario_id;

--Pregunta 3
SELECT u.nombre, u.id, p.titulo, p.contenido FROM post p 
JOIN usuarios u ON p.usuario_id = u.id WHERE u.rol = 'administrador';

--Pregunta 4
SELECT u.id, u.email, COUNT(p.id) FROM usuarios u  LEFT JOIN posts p  ON u.id = p.usuario_id GROUP BY u.id, u.email;

--Pregunta 5
SELECT u.email, count(p.id) FROM posts p  JOIN usuarios u  ON p.usuario_id = u.id GROUP BY u.email;

--Pregunta 6
SELECT nombre, MAX(fecha_creacion) FROM (SELECT p.contenido,p.fecha_creacion, u.nombre FROM usuarios u JOIN posts p ON u.id = p.usuario_id) AS po GROUP BY po.nombre;

--pregunta 7
SELECT titulo, contenido FROM posts p JOIN (SELECT post_id, COUNT(post_id) FROM comentarios GROUP BY post_id ORDER BY count DESC LIMIT 1) AS c ON p.id = c.post_id;


--pregunta 8
SELECT p.titulo as titulo_post, p.contenido as contenido_post, c.contenido as contenido_comentario, u.email FROM posts p JOIN comentarios c ON p.id = c.post_id JOIN usuarios u ON c.usuario_id = u.id;

--pregunta 9
SELECT fecha_creacion, contenido, usuario_id, u.nombre FROM comentarios c JOIN usuarios u ON c.usuario_id = u.id WHERE c.fecha_creacion = (SELECT MAX(fecha_creacion) FROM comentarios WHERE usuario_id = u.id);

--pregunta 10
SELECT u.email FROM usuarios u LEFT JOIN comentarios c ON u.id = c.usuario_id GROUP BY u.email HAVING COUNT(c.id) = 0;