SET TERM ^ ;

CREATE OR ALTER PROCEDURE sp_insert_transaccion (
    p_id_transaccion     VARCHAR(36),
    p_id_usuario         VARCHAR(36),
    p_id_presupuesto     VARCHAR(36),
    p_id_subcategoria    VARCHAR(36),
    p_id_obligacion_fija VARCHAR(36),
    p_anio               INT,
    p_mes                INT,
    p_tipo               VARCHAR(20),
    p_descripcion        VARCHAR(255),
    p_monto              DECIMAL(12,2),
    p_fecha              TIMESTAMP,
    p_metodo_pago        VARCHAR(50),
    p_numero_factura     VARCHAR(50),
    p_observaciones      VARCHAR(255),
    p_creado_por         VARCHAR(50)
)
AS
BEGIN
  INSERT INTO Transaccion (
      Id_transaccion,
      Id_usuario,
      Id_presupuesto,
      Id_subcategoria,
      Id_obligacion_fija,
      anio,
      mes,
      tipo,
      descripcion,
      monto,
      fecha,
      metodo_pago,
      numero_factura,
      observaciones,
      creado_por
  )
  VALUES (
      :p_id_transaccion,
      :p_id_usuario,
      :p_id_presupuesto,
      :p_id_subcategoria,
      :p_id_obligacion_fija,
      :p_anio,
      :p_mes,
      :p_tipo,
      :p_descripcion,
      :p_monto,
      :p_fecha,
      :p_metodo_pago,
      :p_numero_factura,
      :p_observaciones,
      :p_creado_por
  );
END^

CREATE OR ALTER PROCEDURE sp_update_transaccion (
    p_id_transaccion     VARCHAR(36),
    p_anio               INT,
    p_mes                INT,
    p_tipo               VARCHAR(20),
    p_descripcion        VARCHAR(255),
    p_monto              DECIMAL(12,2),
    p_fecha              TIMESTAMP,
    p_metodo_pago        VARCHAR(50),
    p_numero_factura     VARCHAR(50),
    p_observaciones      VARCHAR(255),
    p_modificado_por     VARCHAR(50)
)
AS
BEGIN
  UPDATE Transaccion
     SET anio           = :p_anio,
         mes            = :p_mes,
         tipo           = :p_tipo,
         descripcion    = :p_descripcion,
         monto          = :p_monto,
         fecha          = :p_fecha,
         metodo_pago    = :p_metodo_pago,
         numero_factura = :p_numero_factura,
         observaciones  = :p_observaciones,
         modificado_por = :p_modificado_por,
         modificado_en  = CURRENT_TIMESTAMP
   WHERE Id_transaccion  = :p_id_transaccion;
END^

CREATE OR ALTER PROCEDURE sp_delete_transaccion (
    p_id_transaccion VARCHAR(36)
)
AS
BEGIN
  DELETE FROM Transaccion
   WHERE Id_transaccion = :p_id_transaccion;
END^

CREATE OR ALTER PROCEDURE sp_get_transaccion_by_id (
    p_id_transaccion VARCHAR(36)
)
RETURNS (
    r_id_transaccion     VARCHAR(36),
    r_id_usuario         VARCHAR(36),
    r_id_presupuesto     VARCHAR(36),
    r_id_subcategoria    VARCHAR(36),
    r_id_obligacion_fija VARCHAR(36),
    r_anio               INT,
    r_mes                INT,
    r_tipo               VARCHAR(20),
    r_descripcion        VARCHAR(255),
    r_monto              DECIMAL(12,2),
    r_fecha              TIMESTAMP,
    r_metodo_pago        VARCHAR(50),
    r_numero_factura     VARCHAR(50),
    r_observaciones      VARCHAR(255),
    r_fecha_registro     TIMESTAMP
)
AS
BEGIN
  FOR
    SELECT Id_transaccion,
           Id_usuario,
           Id_presupuesto,
           Id_subcategoria,
           Id_obligacion_fija,
           anio,
           mes,
           tipo,
           descripcion,
           monto,
           fecha,
           metodo_pago,
           numero_factura,
           observaciones,
           fecha_registro
      FROM Transaccion
     WHERE Id_transaccion = :p_id_transaccion
    INTO :r_id_transaccion,
         :r_id_usuario,
         :r_id_presupuesto,
         :r_id_subcategoria,
         :r_id_obligacion_fija,
         :r_anio,
         :r_mes,
         :r_tipo,
         :r_descripcion,
         :r_monto,
         :r_fecha,
         :r_metodo_pago,
         :r_numero_factura,
         :r_observaciones,
         :r_fecha_registro
  DO
    SUSPEND;
END^

CREATE OR ALTER PROCEDURE sp_get_transacciones_by_presupuesto (
    p_id_presupuesto VARCHAR(36)
)
RETURNS (
    r_id_transaccion  VARCHAR(36),
    r_id_usuario      VARCHAR(36),
    r_id_subcategoria VARCHAR(36),
    r_tipo            VARCHAR(20),
    r_monto           DECIMAL(12,2),
    r_fecha           TIMESTAMP
)
AS
BEGIN
  FOR
    SELECT Id_transaccion,
           Id_usuario,
           Id_subcategoria,
           tipo,
           monto,
           fecha
      FROM Transaccion
     WHERE Id_presupuesto = :p_id_presupuesto
     ORDER BY fecha
    INTO :r_id_transaccion,
         :r_id_usuario,
         :r_id_subcategoria,
         :r_tipo,
         :r_monto,
         :r_fecha
  DO
    SUSPEND;
END^

SET TERM ; ^
