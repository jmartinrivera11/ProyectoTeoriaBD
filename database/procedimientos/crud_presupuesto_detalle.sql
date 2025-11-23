SET TERM ^ ;

CREATE OR ALTER PROCEDURE sp_insert_presupuesto_detalle (
    p_id_presupuesto_detalle VARCHAR(36),
    p_id_presupuesto         VARCHAR(36),
    p_id_subcategoria        VARCHAR(36),
    p_monto_mensual          DECIMAL(12,2),
    p_observacion            VARCHAR(255),
    p_creado_por             VARCHAR(50)
)
AS
BEGIN
  INSERT INTO Presupuesto_detalle (
      Id_presupuesto_detalle,
      Id_presupuesto,
      Id_subcategoria,
      monto_mensual,
      observacion,
      creado_por
  )
  VALUES (
      :p_id_presupuesto_detalle,
      :p_id_presupuesto,
      :p_id_subcategoria,
      :p_monto_mensual,
      :p_observacion,
      :p_creado_por
  );
END^

CREATE OR ALTER PROCEDURE sp_update_presupuesto_detalle (
    p_id_presupuesto_detalle VARCHAR(36),
    p_id_subcategoria        VARCHAR(36),
    p_monto_mensual          DECIMAL(12,2),
    p_observacion            VARCHAR(255),
    p_modificado_por         VARCHAR(50)
)
AS
BEGIN
  UPDATE Presupuesto_detalle
     SET Id_subcategoria = :p_id_subcategoria,
         monto_mensual   = :p_monto_mensual,
         observacion     = :p_observacion,
         modificado_por  = :p_modificado_por,
         modificado_en   = CURRENT_TIMESTAMP
   WHERE Id_presupuesto_detalle = :p_id_presupuesto_detalle;
END^

CREATE OR ALTER PROCEDURE sp_delete_presupuesto_detalle (
    p_id_presupuesto_detalle VARCHAR(36)
)
AS
BEGIN
  DELETE FROM Presupuesto_detalle
   WHERE Id_presupuesto_detalle = :p_id_presupuesto_detalle;
END^

CREATE OR ALTER PROCEDURE sp_get_presupuesto_detalle_by_id (
    p_id_presupuesto_detalle VARCHAR(36)
)
RETURNS (
    r_id_presupuesto_detalle VARCHAR(36),
    r_id_presupuesto         VARCHAR(36),
    r_id_subcategoria        VARCHAR(36),
    r_monto_mensual          DECIMAL(12,2),
    r_observacion            VARCHAR(255)
)
AS
BEGIN
  FOR
    SELECT Id_presupuesto_detalle,
           Id_presupuesto,
           Id_subcategoria,
           monto_mensual,
           observacion
      FROM Presupuesto_detalle
     WHERE Id_presupuesto_detalle = :p_id_presupuesto_detalle
    INTO :r_id_presupuesto_detalle,
         :r_id_presupuesto,
         :r_id_subcategoria,
         :r_monto_mensual,
         :r_observacion
  DO
    SUSPEND;
END^

CREATE OR ALTER PROCEDURE sp_get_presupuesto_detalle_by_presupuesto (
    p_id_presupuesto VARCHAR(36)
)
RETURNS (
    r_id_presupuesto_detalle VARCHAR(36),
    r_id_subcategoria        VARCHAR(36),
    r_monto_mensual          DECIMAL(12,2),
    r_observacion            VARCHAR(255)
)
AS
BEGIN
  FOR
    SELECT Id_presupuesto_detalle,
           Id_subcategoria,
           monto_mensual,
           observacion
      FROM Presupuesto_detalle
     WHERE Id_presupuesto = :p_id_presupuesto
     ORDER BY Id_subcategoria
    INTO :r_id_presupuesto_detalle,
         :r_id_subcategoria,
         :r_monto_mensual,
         :r_observacion
  DO
    SUSPEND;
END^

SET TERM ; ^
