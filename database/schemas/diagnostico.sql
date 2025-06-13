CREATE TABLE diagnostico (
    id_diagnostico          INTEGER PRIMARY KEY AUTOINCREMENT,
    Tipo_diagnostico        TEXT    CHECK (Tipo_diagnostico IN ('Principal', 'Secundario', 'Presuntivo') ) NOT NULL,
    descripcion_diagnostico TEXT,
    id_paciente             INTEGER NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES paciente (id_paciente) 
);