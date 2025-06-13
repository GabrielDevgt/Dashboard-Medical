CREATE TABLE enfermedades (
    id_enfermedad INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre        TEXT  NOT NULL UNIQUE,
    id_categoria_enfermedades INTEGER,
    es_cronica    BOOLEAN NOT NULL CHECK (es_cronica IN (0, 1) ),-- 1=crónica, 0=aguda
    FOREIGN KEY (id_categoria_enfermedades)REFERENCES categorias_enfermedades (id_categoria_enfermedades) 
);