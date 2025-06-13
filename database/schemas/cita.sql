CREATE TABLE cita (
    id_cita     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_paciente INTEGER NOT NULL,
    fecha_cita  TEXT    NOT NULL,-- Este valor debe coincidir con 'proxima_cita' de CONSULTA
    estado_cita TEXT    CHECK (estado_cita IN ('Pendiente', 'Atendida', 'Cancelada') ) 
                        NOT NULL,
    FOREIGN KEY ( id_paciente)REFERENCES paciente (id_paciente) 
);
