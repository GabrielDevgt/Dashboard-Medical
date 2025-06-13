CREATE TRIGGER valida_antecedente_cronico
        BEFORE INSERT
            ON antecedentes_patologicos
      FOR EACH ROW
BEGIN
    SELECT CASE WHEN (SELECT es_cronica FROM enfermedades WHERE id_enfermedad = NEW.id_enfermedad
                     )!=  1 THEN RAISE(ABORT, "Error: Esta enfermedad no es crónica. Usa historial_enfermedades.") END;
END;-- Trigger para historial_enfermedades (solo enfermedades agudas)