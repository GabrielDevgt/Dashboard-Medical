CREATE TABLE laboratorios (
    id_laboratorio  INTEGER PRIMARY KEY AUTOINCREMENT,
    id_tipo_examen  INTEGER NOT NULL,
    id_paciente     INTEGER NOT NULL,
    Fecha_toma      TEXT,
    Fecha_resultado TEXT,
    Observaciones   TEXT,
    Resultado_valor REAL,
    Resultado_texto TEXT    CHECK (Resultado_texto IN ('Positivo', 'Negativo', 'Pendiente', 'Otro ') ) NOT NULL,
    FOREIGN KEY (id_tipo_examen)REFERENCES tipo_examen (id_tipo_examen),
    FOREIGN KEY ( id_paciente) REFERENCES paciente (id_paciente) 
);