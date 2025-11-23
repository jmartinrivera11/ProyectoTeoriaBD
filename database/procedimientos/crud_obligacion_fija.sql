SET TERM ^ ;

CREATE OR ALTER PROCEDURE sp_insert_obligacion_fija (
    p_id_obligacion_fija VARCHAR(36),
    p_id_subcategoria    VARCHAR(36),
    p_id_usuario         VARCHAR(36),
    p_nombre             VARCHAR(100),
    p_descripcion        VARCHAR(255),
    p_monto_mensual      DECIMAL(12,2),
    p_dia_mes            INT,
    p_vigente            BOOLEAN,
    p_fecha_inicio       TIMESTAMP,
    p_fecha_fin          TIMESTAMP,
    p_creado_por         VARCHAR(50)
)
AS
BEGIN
  INSERT INTO Obligacion_fija (
      Id_obligacion_fija,
      Id_subcategoria,
      Id_usuario,
      nombre,
      descripcion,
      monto_mensual,
      dia_mes,
      vigente,
      fecha_inicio,
      fecha_fin,
      creado_por
  )
  VALUES (
      :p_id_obligacion_fija,
      :p_id_subcategoria,
      :p_id_usuario,
      :p_nombre,
      :p_descripcion,
      :p_monto_mensual,
      :p_dia_mes,
      :p_vigente,
      :p_fecha_inicio,
      :p_fecha_fin,
      :p_creado_por
  );
END^

CREATE OR ALTER PROCEDURE sp_update_obligacion_fija (
    p_id_obligacion_fija VARCHAR(36),
    p_nombre             VARCHAR(100),
    p_descripcion        VARCHAR(255),
    p_monto_mensual      DECIMAL(12,2),
    p_dia_mes            INT,
    p_vigente            BOOLEAN,
    p_fecha_fin          TIMESTAMP,
    p_modificado_por     VARCHAR(50)
)
AS
BEGIN
  UPDATE Obligacion_fija
     SET nombre         = :p_nombre,
         descripcion    = :p_descripcion,
         monto_mensual  = :p_monto_mensual,
         dia_mes        = :p_dia_mes,
         vigente        = :p_vigente,
         fecha_fin      = :p_fecha_fin,
         modificado_por = :p_modificado_por,
         modificado_en  = CURRENT_TIMESTAMP
   WHERE Id_obligacion_fija = :p_id_obligacion_fija;
END^

CREATE OR ALTER PROCEDURE sp_delete_obligacion_fija (
    p_id_obligacion_fija VARCHAR(36)
)
AS
BEGIN
  DELETE FROM Obligacion_fija
   WHERE Id_obligacion_fija = :p_id_obligacion_fija;
END^

CREATE OR ALTER PROCEDURE sp_get_obligacion_fija_by_id (
    p_id_obligacion_fija VARCHAR(36)
)
RETURNS (
    r_id_obligacion_fija VARCHAR(36),
    r_id_subcategoria    VARCHAR(36),
    r_id_usuario         VARCHAR(36),
    r_nombre             VARCHAR(100),
    r_descripcion        VARCHAR(255),
    r_monto_mensual      DECIMAL(12,2),
    r_dia_mes            INT,
    r_vigente            BOOLEAN,
    r_fecha_inicio       TIMESTAMP,
    r_fecha_fin          TIMESTAMP
)
AS
BEGIN
  FOR
    SELECT Id_obligacion_fija,
           Id_subcategoria,
           Id_usuario,
           nombre,
           descripcion,
           monto_mensual,
           dia_mes,
           vigente,
           fecha_inicio,
           fecha_fin
      FROM Obligacion_fija
     WHERE Id_obligacion_fija = :p_id_obligacion_fija
    INTO :r_id_obligacion_fija,
         :r_id_subcategoria,
         :r_id_usuario,
         :r_nombre,
         :r_descripcion,
         :r_monto_mensual,
         :r_dia_mes,
         :r_vigente,
         :r_fecha_inicio,
         :r_fecha_fin
  DO
    SUSPEND;
END^

CREATE OR ALTER PROCEDURE sp_get_obligaciones_by_usuario (
    p_id_usuario VARCHAR(36)
)
RETURNS (
    r_id_obligacion_fija VARCHAR(36),
    r_id_subcategoria    VARCHAR(36),
    r_nombre             VARCHAR(100),
    r_monto_mensual      DECIMAL(12,2),
    r_dia_mes            INT,
    r_vigente            BOOLEAN
)
AS
BEGIN
  FOR
    SELECT Id_obligacion_fija,
           Id_subcategoria,
           nombre,
           monto_mensual,
           dia_mes,
           vigente
      FROM Obligacion_fija
     WHERE Id_usuario = :p_id_usuario
     ORDER BY vigente DESC, dia_mes
    INTO :r_id_obligacion_fija,
         :r_id_subcategoria,
         :r_nombre,
         :r_monto_mensual,
         :r_dia_mes,
         :r_vigente
  DO
    SUSPEND;
END^

SET TERM ; ^
