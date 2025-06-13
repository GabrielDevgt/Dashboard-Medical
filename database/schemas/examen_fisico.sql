CREATE TABLE examen_fisico (
    id_examen_fisico    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_paciente         INTEGER NOT NULL,-- Campos con opciones predefinidas (simulando ENUM)
    estado_general      TEXT    CHECK (estado_general IN ('Consciente orientado', 'Consciente desorientado', 'Decaído', 'Inconsciente') ),
    piel_mucosas        TEXT    CHECK (piel_mucosas IN ('Normal', 'Pálido', 'Cianótico', 'Ictérico', 'Eritematoso', 'Lesiones presentes') ),
    cardiopulmonar      TEXT    CHECK (cardiopulmonar IN ('Normal', 'Taquicardia', 'Bradicardia', 'Soplo', 'Sibilancias', 'Crepitantes') ),
    abdomen             TEXT    CHECK (abdomen IN ('Blando depresible', 'Dolor a la palpación', 'Rigidez', 'Distendido', 'Masas palpables') ),
    extremidades        TEXT    CHECK (extremidades IN ('Normal', 'Edema', 'Pulsos disminuidos', 'Pulsos ausentes', 'Deformidad') ),
    neurologico         TEXT    CHECK (neurologico IN ('Normal', 'Reflejos disminuidos', 'Reflejos aumentados', 'Déficit motor', 'Parestesias') ),-- Campo libre para detalles no cubiertos
    extra_examen_fisico TEXT,
    FOREIGN KEY (id_paciente)REFERENCES paciente (id_paciente) 
);