CREATE TABLE historial_enfermedades (
    id_episodio   INTEGER PRIMARY KEY AUTOINCREMENT,
    id_paciente   INTEGER NOT NULL,
    id_enfermedad INTEGER NOT NULL,
    fecha_inicio  TEXT    NOT NULL,
    fecha_fin     TEXT,
    sintomas      TEXT,
    FOREIGN KEY (id_paciente) REFERENCES paciente (Id_paciente),
    FOREIGN KEY (id_enfermedad) REFERENCES enfermedades (id_enfermedad) 
);-- Trigger para antecedentes_patologicos (solo enfermedades crónicas)
