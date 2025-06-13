CREATE TABLE tipo_examen (
    id_tipo_examen          INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_tipo_examen      TEXT    NOT NULL UNIQUE,-- Ej: 'Hemograma', 'Perfil lipídico'
    descripcion_tipo_examen TEXT-- Opcional: detalles del examen
);