CREATE TABLE plan_terapeutico (
    id_plan_terapeutico INTEGER PRIMARY KEY AUTOINCREMENT,
    id_diagnostico      INTEGER NOT NULL,
    Objetivo            TEXT    NOT NULL,
    Recomendaciones     TEXT    NOT NULL,
    id_paciente         INTEGER NOT NULL,
    FOREIGN KEY (id_paciente)REFERENCES paciente (id_paciente),
    FOREIGN KEY (id_diagnostico) REFERENCES diagnostico (id_diagnostico) 
);