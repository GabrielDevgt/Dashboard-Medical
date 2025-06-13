CREATE TABLE antecedentes_patologicos (
    id_antecedente    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_paciente       INTEGER NOT NULL,
    id_enfermedad     INTEGER NOT NULL,
    fecha_diagnostico TEXT    NOT NULL,
    tratamiento       TEXT,
    FOREIGN KEY (id_paciente)REFERENCES paciente (Id_paciente),
    FOREIGN KEY (id_enfermedad)REFERENCES enfermedades (id_enfermedad) 
);
