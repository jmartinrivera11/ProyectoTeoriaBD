SET TERM ^ ;

CREATE OR ALTER PROCEDURE sp_recalcular_totales_presupuesto (
    p_id_presupuesto VARCHAR(36)
)
AS
DECLARE VARIABLE v_total_ingresos DECIMAL(12,2);
DECLARE VARIABLE v_total_gastos   DECIMAL(12,2);
DECLARE VARIABLE v_total_ahorro   DECIMAL(12,2);
BEGIN
  v_total_ingresos = 0;
  v_total_gastos   = 0;
  v_total_ahorro   = 0;

  SELECT
      COALESCE(SUM(CASE WHEN t.tipo = 'ingreso' THEN t.monto ELSE 0 END), 0),
      COALESCE(SUM(CASE WHEN t.tipo = 'gasto'   THEN t.monto ELSE 0 END), 0),
      COALESCE(SUM(CASE WHEN t.tipo = 'ahorro'  THEN t.monto ELSE 0 END), 0)
    FROM Transaccion t
   WHERE t.Id_presupuesto = :p_id_presupuesto
    INTO :v_total_ingresos,
         :v_total_gastos,
         :v_total_ahorro;

  UPDATE Presupuesto
     SET total_ingresos = :v_total_ingresos,
         total_gastos   = :v_total_gastos,
         total_ahorro   = :v_total_ahorro
   WHERE Id_presupuesto = :p_id_presupuesto;
END^

CREATE OR ALTER PROCEDURE sp_registrar_transaccion_negocio (
    p_id_transaccion     VARCHAR(36),
    p_id_usuario         VARCHAR(36),
    p_id_presupuesto     VARCHAR(36),
    p_id_subcategoria    VARCHAR(36),
    p_id_obligacion_fija VARCHAR(36),
    p_anio               INTEGER,
    p_mes                INTEGER,
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
DECLARE VARIABLE v_estado_presupuesto VARCHAR(20);
BEGIN
  SELECT estado
    FROM Presupuesto
   WHERE Id_presupuesto = :p_id_presupuesto
    INTO :v_estado_presupuesto;

  IF (v_estado_presupuesto IS NULL) THEN
    EXIT;

  IF (v_estado_presupuesto <> 'activo') THEN
    EXIT;

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

  EXECUTE PROCEDURE sp_recalcular_totales_presupuesto(:p_id_presupuesto);
END^

CREATE OR ALTER PROCEDURE sp_cerrar_presupuesto (
    p_id_presupuesto VARCHAR(36),
    p_modificado_por VARCHAR(50)
)
AS
BEGIN
  EXECUTE PROCEDURE sp_recalcular_totales_presupuesto(:p_id_presupuesto);

  UPDATE Presupuesto
     SET estado         = 'cerrado',
         modificado_por = :p_modificado_por,
         modificado_en  = CURRENT_TIMESTAMP
   WHERE Id_presupuesto = :p_id_presupuesto;
END^

CREATE OR ALTER PROCEDURE sp_reabrir_presupuesto (
    p_id_presupuesto VARCHAR(36),
    p_modificado_por VARCHAR(50)
)
AS
DECLARE VARIABLE v_estado VARCHAR(20);
BEGIN
  SELECT estado
    FROM Presupuesto
   WHERE Id_presupuesto = :p_id_presupuesto
    INTO :v_estado;

  IF (v_estado = 'cerrado') THEN
  BEGIN
    UPDATE Presupuesto
       SET estado         = 'activo',
           modificado_por = :p_modificado_por,
           modificado_en  = CURRENT_TIMESTAMP
     WHERE Id_presupuesto = :p_id_presupuesto;
  END
END^

CREATE OR ALTER PROCEDURE sp_aplicar_aporte_meta (
    p_id_meta_ahorro VARCHAR(36),
    p_monto_aporte   DECIMAL(12,2),
    p_modificado_por VARCHAR(50)
)
AS
DECLARE VARIABLE v_monto_total    DECIMAL(12,2);
DECLARE VARIABLE v_monto_ahorrado DECIMAL(12,2);
DECLARE VARIABLE v_nuevo_ahorro   DECIMAL(12,2);
DECLARE VARIABLE v_nuevo_estado   VARCHAR(20);
BEGIN
  SELECT monto_total,
         monto_ahorrado,
         estado
    FROM Meta_ahorro
   WHERE Id_meta_ahorro = :p_id_meta_ahorro
    INTO :v_monto_total,
         :v_monto_ahorrado,
         :v_nuevo_estado;

  IF (v_monto_total IS NULL) THEN
    EXIT;

  v_nuevo_ahorro = COALESCE(v_monto_ahorrado, 0) + COALESCE(p_monto_aporte, 0);
  v_nuevo_estado = 'en_progreso';

  IF (v_nuevo_ahorro >= v_monto_total) THEN
    v_nuevo_estado = 'completada';

  UPDATE Meta_ahorro
     SET monto_ahorrado = :v_nuevo_ahorro,
         estado         = :v_nuevo_estado,
         modificado_por = :p_modificado_por,
         modificado_en  = CURRENT_TIMESTAMP
   WHERE Id_meta_ahorro = :p_id_meta_ahorro;
END^

CREATE OR ALTER PROCEDURE sp_recalcular_estado_meta (
    p_id_meta_ahorro VARCHAR(36),
    p_modificado_por VARCHAR(50)
)
AS
DECLARE VARIABLE v_monto_total    DECIMAL(12,2);
DECLARE VARIABLE v_monto_ahorrado DECIMAL(12,2);
DECLARE VARIABLE v_nuevo_estado   VARCHAR(20);
BEGIN
  SELECT monto_total,
         monto_ahorrado,
         estado
    FROM Meta_ahorro
   WHERE Id_meta_ahorro = :p_id_meta_ahorro
    INTO :v_monto_total,
         :v_monto_ahorrado,
         :v_nuevo_estado;

  IF (v_monto_total IS NULL) THEN
    EXIT;

  v_nuevo_estado = 'en_progreso';

  IF (v_monto_ahorrado >= v_monto_total) THEN
    v_nuevo_estado = 'completada';

  UPDATE Meta_ahorro
     SET estado         = :v_nuevo_estado,
         modificado_por = :p_modificado_por,
         modificado_en  = CURRENT_TIMESTAMP
   WHERE Id_meta_ahorro = :p_id_meta_ahorro;
END^

CREATE OR ALTER PROCEDURE sp_generar_resumen_mensual_usuario (
    p_id_usuario VARCHAR(36)
)
RETURNS (
    r_anio           INTEGER,
    r_mes            INTEGER,
    r_total_ingresos DECIMAL(12,2),
    r_total_gastos   DECIMAL(12,2),
    r_total_ahorro   DECIMAL(12,2),
    r_saldo_neto     DECIMAL(12,2)
)
AS
BEGIN
  FOR
    SELECT
        t.anio,
        t.mes,
        COALESCE(SUM(CASE WHEN t.tipo = 'ingreso' THEN t.monto ELSE 0 END), 0),
        COALESCE(SUM(CASE WHEN t.tipo = 'gasto'   THEN t.monto ELSE 0 END), 0),
        COALESCE(SUM(CASE WHEN t.tipo = 'ahorro'  THEN t.monto ELSE 0 END), 0)
      FROM Transaccion t
     WHERE t.Id_usuario = :p_id_usuario
     GROUP BY t.anio, t.mes
     ORDER BY t.anio, t.mes
    INTO :r_anio,
         :r_mes,
         :r_total_ingresos,
         :r_total_gastos,
         :r_total_ahorro
  DO
  BEGIN
    r_saldo_neto = r_total_ingresos - r_total_gastos - r_total_ahorro;
    SUSPEND;
  END
END^

CREATE OR ALTER PROCEDURE sp_generar_resumen_presupuesto (
    p_id_presupuesto VARCHAR(36)
)
RETURNS (
    r_id_categoria      VARCHAR(36),
    r_nombre_categoria  VARCHAR(100),
    r_tipo_categoria    VARCHAR(20),
    r_total_monto       DECIMAL(12,2)
)
AS
BEGIN
  FOR
    SELECT
        c.Id_categoria,
        c.nombre,
        c.tipo,
        COALESCE(SUM(t.monto), 0)
      FROM Transaccion t
      JOIN Subcategoria s ON s.Id_subcategoria = t.Id_subcategoria
      JOIN Categoria    c ON c.Id_categoria    = s.Id_categoria
     WHERE t.Id_presupuesto = :p_id_presupuesto
     GROUP BY c.Id_categoria, c.nombre, c.tipo
    INTO :r_id_categoria,
         :r_nombre_categoria,
         :r_tipo_categoria,
         :r_total_monto
  DO
    SUSPEND;
END^

CREATE OR ALTER PROCEDURE sp_actualizar_vigencia_obligaciones
AS
BEGIN
  UPDATE Obligacion_fija
     SET vigente       = FALSE,
         modificado_en = CURRENT_TIMESTAMP
   WHERE fecha_fin IS NOT NULL
     AND fecha_fin < CURRENT_TIMESTAMP
     AND vigente = TRUE;
END^

SET TERM ; ^
