CREATE TABLE consulta (
    id_consulta         INTEGER PRIMARY KEY AUTOINCREMENT,
    id_paciente         INTEGER NOT NULL,
    motivo_consulta     TEXT    NOT NULL,
    fecha_consulta      TEXT    NOT NULL,
    peso                REAL,-- Peso en kg (ej. 70.5)
    altura              REAL,-- Altura en metros (ej. 1.75)
    frecuencia_cardiaca INTEGER,-- Latidos por minuto (ej. 72)
    presion_arterial    TEXT,-- Formato "sistólica/diastólica" (ej. "120/80")
    id_antecedente      INTEGER,
    id_episodio         INTEGER,
    id_laboratorio      INTEGER,
    id_examen_fisico    INTEGER,
    id_diagnostico      INTEGER,
    proxima_cita        TEXT    NOT NULL,
    id_plan_terapeutico INTEGER,
    FOREIGN KEY (id_paciente) REFERENCES paciente (id_paciente),
    FOREIGN KEY (id_antecedente)REFERENCES antecedentes_patologicos (id_antecedente),
    FOREIGN KEY (id_episodio)REFERENCES historial_enfermedades (id_episodio),
    FOREIGN KEY ( id_laboratorio)  REFERENCES laboratorios (id_laboratorio),
    FOREIGN KEY (id_examen_fisico) REFERENCES examen_fisico (id_examen_fisico),
    FOREIGN KEY (id_diagnostico)REFERENCES diagnostico (id_diagnostico),
    FOREIGN KEY (id_plan_terapeutico) REFERENCES plan_terapeuticoo (id_plan_terapeutico) 
);