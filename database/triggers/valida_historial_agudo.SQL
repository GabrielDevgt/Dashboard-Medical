CREATE TRIGGER valida_historial_agudo
        BEFORE INSERT
            ON historial_enfermedades
      FOR EACH ROW
BEGIN
    SELECT CASE WHEN ( SELECT es_cronica FROM enfermedades  WHERE id_enfermedad = NEW.id_enfermedad )
!=             0 THEN RAISE(ABORT, "Error: Esta enfermedad es crónica. Usa antecedentes_patologicos.") END;
END;-- -----------------------------------------------------------------------------------------------------------