CREATE TABLE paciente (
    Id_paciente      INTEGER PRIMARY KEY AUTOINCREMENT,-- ¡Usa INTEGER, no INT!
    Nombre_1         TEXT    NOT NULL,
    Nombre_2         TEXT    NOT NULL,
    Nombre_3         TEXT,
    Apellido_1       TEXT    NOT NULL,
    Apellido_2       TEXT,
    Apellido_casado  TEXT,
    Fecha_Nacimiento TEXT    NOT NULL,-- SQLite no tiene tipo 'date', usa TEXT
    Direccion        TEXT    NOT NULL,
    Telefono         TEXT    NOT NULL
                             CHECK (LENGTH(Telefono) >= 8 AND Telefono GLOB '[0-9]*'),
    Genero           TEXT    CHECK (Genero IN ('Masculino', 'Femenino', 'Otro') ),
    fecha_registro   TEXT    DEFAULT CURRENT_TIMESTAMP
);