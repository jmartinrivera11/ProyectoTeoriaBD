SET TERM ^ ;

CREATE OR ALTER PROCEDURE sp_insert_meta_ahorro (
    p_id_meta_ahorro  VARCHAR(36),
    p_id_usuario      VARCHAR(36),
    p_id_subcategoria VARCHAR(36),
    p_nombre          VARCHAR(100),
    p_descripcion     VARCHAR(255),
    p_monto_total     DECIMAL(12,2),
    p_monto_ahorrado  DECIMAL(12,2),
    p_fecha_inicio    TIMESTAMP,
    p_fecha_objetivo  TIMESTAMP,
    p_prioridad       VARCHAR(20),
    p_estado          VARCHAR(20),
    p_creado_por      VARCHAR(50)
)
AS
BEGIN
  INSERT INTO Meta_ahorro (
      Id_meta_ahorro,
      Id_usuario,
      Id_subcategoria,
      nombre,
      descripcion,
      monto_total,
      monto_ahorrado,
      fecha_inicio,
      fecha_objetivo,
      prioridad,
      estado,
      creado_por
  )
  VALUES (
      :p_id_meta_ahorro,
      :p_id_usuario,
      :p_id_subcategoria,
      :p_nombre,
      :p_descripcion,
      :p_monto_total,
      :p_monto_ahorrado,
      :p_fecha_inicio,
      :p_fecha_objetivo,
      :p_prioridad,
      :p_estado,
      :p_creado_por
  );
END^

CREATE OR ALTER PROCEDURE sp_update_meta_ahorro (
    p_id_meta_ahorro  VARCHAR(36),
    p_nombre          VARCHAR(100),
    p_descripcion     VARCHAR(255),
    p_monto_total     DECIMAL(12,2),
    p_monto_ahorrado  DECIMAL(12,2),
    p_fecha_objetivo  TIMESTAMP,
    p_prioridad       VARCHAR(20),
    p_estado          VARCHAR(20),
    p_modificado_por  VARCHAR(50)
)
AS
BEGIN
  UPDATE Meta_ahorro
     SET nombre         = :p_nombre,
         descripcion    = :p_descripcion,
         monto_total    = :p_monto_total,
         monto_ahorrado = :p_monto_ahorrado,
         fecha_objetivo = :p_fecha_objetivo,
         prioridad      = :p_prioridad,
         estado         = :p_estado,
         modificado_por = :p_modificado_por,
         modificado_en  = CURRENT_TIMESTAMP
   WHERE Id_meta_ahorro  = :p_id_meta_ahorro;
END^

CREATE OR ALTER PROCEDURE sp_delete_meta_ahorro (
    p_id_meta_ahorro VARCHAR(36)
)
AS
BEGIN
  DELETE FROM Meta_ahorro
   WHERE Id_meta_ahorro = :p_id_meta_ahorro;
END^

CREATE OR ALTER PROCEDURE sp_get_meta_ahorro_by_id (
    p_id_meta_ahorro VARCHAR(36)
)
RETURNS (
    r_id_meta_ahorro  VARCHAR(36),
    r_id_usuario      VARCHAR(36),
    r_id_subcategoria VARCHAR(36),
    r_nombre          VARCHAR(100),
    r_descripcion     VARCHAR(255),
    r_monto_total     DECIMAL(12,2),
    r_monto_ahorrado  DECIMAL(12,2),
    r_fecha_inicio    TIMESTAMP,
    r_fecha_objetivo  TIMESTAMP,
    r_prioridad       VARCHAR(20),
    r_estado          VARCHAR(20)
)
AS
BEGIN
  FOR
    SELECT Id_meta_ahorro,
           Id_usuario,
           Id_subcategoria,
           nombre,
           descripcion,
           monto_total,
           monto_ahorrado,
           fecha_inicio,
           fecha_objetivo,
           prioridad,
           estado
      FROM Meta_ahorro
     WHERE Id_meta_ahorro = :p_id_meta_ahorro
    INTO :r_id_meta_ahorro,
         :r_id_usuario,
         :r_id_subcategoria,
         :r_nombre,
         :r_descripcion,
         :r_monto_total,
         :r_monto_ahorrado,
         :r_fecha_inicio,
         :r_fecha_objetivo,
         :r_prioridad,
         :r_estado
  DO
    SUSPEND;
END^

CREATE OR ALTER PROCEDURE sp_get_metas_by_usuario (
    p_id_usuario VARCHAR(36)
)
RETURNS (
    r_id_meta_ahorro  VARCHAR(36),
    r_id_subcategoria VARCHAR(36),
    r_nombre          VARCHAR(100),
    r_monto_total     DECIMAL(12,2),
    r_monto_ahorrado  DECIMAL(12,2),
    r_fecha_inicio    TIMESTAMP,
    r_fecha_objetivo  TIMESTAMP,
    r_prioridad       VARCHAR(20),
    r_estado          VARCHAR(20)
)
AS
BEGIN
  FOR
    SELECT Id_meta_ahorro,
           Id_subcategoria,
           nombre,
           monto_total,
           monto_ahorrado,
           fecha_inicio,
           fecha_objetivo,
           prioridad,
           estado
      FROM Meta_ahorro
     WHERE Id_usuario = :p_id_usuario
     ORDER BY prioridad, fecha_objetivo
    INTO :r_id_meta_ahorro,
         :r_id_subcategoria,
         :r_nombre,
         :r_monto_total,
         :r_monto_ahorrado,
         :r_fecha_inicio,
         :r_fecha_objetivo,
         :r_prioridad,
         :r_estado
  DO
    SUSPEND;
END^

SET TERM ; ^
