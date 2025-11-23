SET TERM ^ ;

CREATE OR ALTER PROCEDURE sp_insert_presupuesto (
    p_id_presupuesto VARCHAR(36),
    p_id_usuario     VARCHAR(36),
    p_nombre         VARCHAR(100),
    p_anio_inicio    INT,
    p_mes_inicio     INT,
    p_anio_fin       INT,
    p_mes_fin        INT,
    p_estado         VARCHAR(20),
    p_creado_por     VARCHAR(50)
)
AS
BEGIN
  INSERT INTO Presupuesto (
      Id_presupuesto,
      Id_usuario,
      nombre,
      anio_inicio,
      mes_inicio,
      anio_fin,
      mes_fin,
      total_ingresos,
      total_gastos,
      total_ahorro,
      estado,
      creado_por
  )
  VALUES (
      :p_id_presupuesto,
      :p_id_usuario,
      :p_nombre,
      :p_anio_inicio,
      :p_mes_inicio,
      :p_anio_fin,
      :p_mes_fin,
      0, 0, 0,
      :p_estado,
      :p_creado_por
  );
END^

CREATE OR ALTER PROCEDURE sp_update_presupuesto (
    p_id_presupuesto VARCHAR(36),
    p_nombre         VARCHAR(100),
    p_anio_inicio    INT,
    p_mes_inicio     INT,
    p_anio_fin       INT,
    p_mes_fin        INT,
    p_estado         VARCHAR(20),
    p_modificado_por VARCHAR(50)
)
AS
BEGIN
  UPDATE Presupuesto
     SET nombre        = :p_nombre,
         anio_inicio   = :p_anio_inicio,
         mes_inicio    = :p_mes_inicio,
         anio_fin      = :p_anio_fin,
         mes_fin       = :p_mes_fin,
         estado        = :p_estado,
         modificado_por = :p_modificado_por,
         modificado_en  = CURRENT_TIMESTAMP
   WHERE Id_presupuesto = :p_id_presupuesto;
END^

CREATE OR ALTER PROCEDURE sp_delete_presupuesto (
    p_id_presupuesto VARCHAR(36)
)
AS
BEGIN
  DELETE FROM Presupuesto
   WHERE Id_presupuesto = :p_id_presupuesto;
END^

CREATE OR ALTER PROCEDURE sp_get_presupuesto_by_id (
    p_id_presupuesto VARCHAR(36)
)
RETURNS (
    r_id_presupuesto VARCHAR(36),
    r_id_usuario     VARCHAR(36),
    r_nombre         VARCHAR(100),
    r_anio_inicio    INT,
    r_mes_inicio     INT,
    r_anio_fin       INT,
    r_mes_fin        INT,
    r_total_ingresos DECIMAL(12,2),
    r_total_gastos   DECIMAL(12,2),
    r_total_ahorro   DECIMAL(12,2),
    r_fecha_creacion TIMESTAMP,
    r_estado         VARCHAR(20),
    r_creado_por     VARCHAR(50),
    r_modificado_por VARCHAR(50),
    r_creado_en      TIMESTAMP,
    r_modificado_en  TIMESTAMP
)
AS
BEGIN
  FOR
    SELECT Id_presupuesto,
           Id_usuario,
           nombre,
           anio_inicio,
           mes_inicio,
           anio_fin,
           mes_fin,
           total_ingresos,
           total_gastos,
           total_ahorro,
           fecha_creacion,
           estado,
           creado_por,
           modificado_por,
           creado_en,
           modificado_en
      FROM Presupuesto
     WHERE Id_presupuesto = :p_id_presupuesto
    INTO :r_id_presupuesto,
         :r_id_usuario,
         :r_nombre,
         :r_anio_inicio,
         :r_mes_inicio,
         :r_anio_fin,
         :r_mes_fin,
         :r_total_ingresos,
         :r_total_gastos,
         :r_total_ahorro,
         :r_fecha_creacion,
         :r_estado,
         :r_creado_por,
         :r_modificado_por,
         :r_creado_en,
         :r_modificado_en
  DO
    SUSPEND;
END^

CREATE OR ALTER PROCEDURE sp_get_presupuestos_by_usuario (
    p_id_usuario VARCHAR(36)
)
RETURNS (
    r_id_presupuesto VARCHAR(36),
    r_nombre         VARCHAR(100),
    r_anio_inicio    INT,
    r_mes_inicio     INT,
    r_anio_fin       INT,
    r_mes_fin        INT,
    r_estado         VARCHAR(20)
)
AS
BEGIN
  FOR
    SELECT Id_presupuesto,
           nombre,
           anio_inicio,
           mes_inicio,
           anio_fin,
           mes_fin,
           estado
      FROM Presupuesto
     WHERE Id_usuario = :p_id_usuario
     ORDER BY anio_inicio, mes_inicio
    INTO :r_id_presupuesto,
         :r_nombre,
         :r_anio_inicio,
         :r_mes_inicio,
         :r_anio_fin,
         :r_mes_fin,
         :r_estado
  DO
    SUSPEND;
END^

SET TERM ; ^
