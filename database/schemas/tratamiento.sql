CREATE TABLE tratamiento (
    id_tratamiento       INTEGER PRIMARY KEY AUTOINCREMENT,
    via                  TEXT    CHECK (via IN ('Oral', 'IV', 'IM', 'Topica', 'Otro') ) 
                                 NOT NULL,
    duracion_tratamiento TEXT,
    frecuencia           TEXT    NOT NULL,
    dosis                TEXT    NOT NULL,
    medicamento          TEXT    NOT NULL,
    id_paciente          INTEGER NOT NULL,
    id_plan_terapeutico  INTEGER,
    FOREIGN KEY (id_plan_terapeutico) REFERENCES plan_terapeutico(id_plan_terapeutico),
    FOREIGN KEY (  id_paciente) REFERENCES paciente (id_paciente));