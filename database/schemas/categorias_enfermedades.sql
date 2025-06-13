CREATE TABLE categorias_enfermedades (
    id_categoria_enfermedades INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_catenfermedades    TEXT    NOT NULL UNIQUE-- Ej: "Cardiovascular", "Infeccioso"
);