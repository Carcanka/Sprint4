CREATE TABLE if NOT EXISTS Usuario (id serial, email varchar unique, activo boolean);
CREATE TABLE if NOT EXISTS Prioridad (id serial, nombre varchar, descripcion varchar);
CREATE TABLE if NOT EXISTS Tarea (id serial, titulo varchar, prioridad_id int, usuario_id int, completado boolean);
--@block
INSERT INTO prioridad (nombre, descripcion) VALUES ('ALTA','ASAP'), ('MEDIA','AEOD'), ('BAJA','AEOW');
--@block
INSERT INTO usuario (email, activo) VALUES ('gonza@senpaimail.com', true), ('pela@senpai.com', false), ('martin@senpai.com', true);
--@block
INSERT INTO tarea (titulo, prioridad_id, usuario_id, completado) VALUES ('leer emails', 1, 4, true), ('tomar agua', 2, 5, false), ('aprender SQL', 3, 6, true);  
--@block
SELECT * FROM tarea;
--@block
SELECT titulo, usuario_id FROM tarea;
--@block
SELECT titulo, usuario_id FROM tarea WHERE completado = FALSE;
--@block
DELETE FROM tarea WHERE titulo = 'leer emails';
--email es unique y al repetirlo no da resultados y nos da error, pero genera rows de ID que se ven de manera permanente
--@block
SELECT nombre, titulo FROM prioridad, tarea WHERE
-- 1) Sí, es posible eliminar una prioridad que está siendo referenciada en una tarea en SQL. 
-- 2)La posibilidad de eliminar una prioridad en uso está determinada por las restricciones de integridad referencial aplicadas en la base de datos. Estas restricciones son reglas que garantizan que las relaciones entre las tablas sean coherentes y consistentes. Si se ha configurado una restricción de clave foránea con una acción de eliminación específica, entonces la eliminación de una prioridad podría tener efectos distintos en las tareas que la referencian. 
--3) Si se ha configurado una acción de eliminación en cascada, la eliminación de la prioridad también eliminará todas las tareas asociadas a esa prioridad.
--@block
UPDATE tarea SET completado = CASE WHEN completado = true THEN false ELSE true END WHERE id = (SELECT max (id) FROM tarea);