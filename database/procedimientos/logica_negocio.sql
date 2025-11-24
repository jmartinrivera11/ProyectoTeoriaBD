SET TERM ^ ;

-- 1) Registrar transaccion
CREATE OR ALTER PROCEDURE sp_registrar_transaccion_negocio (
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
DECLARE VARIABLE v_estado_presupuesto VARCHAR(20);
DECLARE VARIABLE v_total_ingresos DECIMAL(12,2);
DECLARE VARIABLE v_total_gastos   DECIMAL(12,2);
DECLARE VARIABLE v_total_ahorro   DECIMAL(12,2);
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


-- 2) Recalcular totales de un presupuesto desde cero
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


-- 3) Cerrar presupuesto
CREATE OR ALTER PROCEDURE sp_cerrar_presupuesto (
    p_id_presupuesto VARCHAR(36),
    p_modificado_por VARCHAR(50)
)
AS
BEGIN
  EXECUTE PROCEDURE sp_recalcular_totales_presupuesto(:p_id_presupuesto);

  UPDATE Presupuesto
     SET estado        = 'cerrado',
         modificado_por = :p_modificado_por,
         modificado_en  = CURRENT_TIMESTAMP
   WHERE Id_presupuesto = :p_id_presupuesto;
END^


-- 4) Reabrir presupuesto
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


-- 5) Crear un nuevo presupuesto copiando otro
CREATE OR ALTER PROCEDURE sp_crear_presupuesto_desde_anterior (
    p_id_presupuesto_origen  VARCHAR(36),
    p_id_presupuesto_nuevo   VARCHAR(36),
    p_anio_inicio_nuevo      INT,
    p_mes_inicio_nuevo       INT,
    p_anio_fin_nuevo         INT,
    p_mes_fin_nuevo          INT,
    p_creado_por             VARCHAR(50)
)
AS
DECLARE VARIABLE v_id_usuario     VARCHAR(36);
DECLARE VARIABLE v_nombre         VARCHAR(100);
DECLARE VARIABLE v_estado         VARCHAR(20);
DECLARE VARIABLE v_id_detalle     VARCHAR(36);
DECLARE VARIABLE v_id_subcategoria VARCHAR(36);
DECLARE VARIABLE v_monto_mensual  DECIMAL(12,2);
DECLARE VARIABLE v_observacion    VARCHAR(255);
BEGIN
  SELECT Id_usuario,
         nombre,
         estado
    FROM Presupuesto
   WHERE Id_presupuesto = :p_id_presupuesto_origen
    INTO :v_id_usuario,
         :v_nombre,
         :v_estado;

  IF (v_id_usuario IS NULL) THEN
    EXIT;

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
      :p_id_presupuesto_nuevo,
      :v_id_usuario,
      :v_nombre,
      :p_anio_inicio_nuevo,
      :p_mes_inicio_nuevo,
      :p_anio_fin_nuevo,
      :p_mes_fin_nuevo,
      0, 0, 0,
      'borrador',
      :p_creado_por
  );

  FOR
    SELECT Id_subcategoria,
           monto_mensual,
           observacion
      FROM Presupuesto_detalle
     WHERE Id_presupuesto = :p_id_presupuesto_origen
    INTO :v_id_subcategoria,
         :v_monto_mensual,
         :v_observacion
  DO
  BEGIN
    v_id_detalle = UUID_TO_CHAR(GEN_UUID());

    INSERT INTO Presupuesto_detalle (
        Id_presupuesto_detalle,
        Id_presupuesto,
        Id_subcategoria,
        monto_mensual,
        observacion,
        creado_por
    )
    VALUES (
        :v_id_detalle,
        :p_id_presupuesto_nuevo,
        :v_id_subcategoria,
        :v_monto_mensual,
        :v_observacion,
        :p_creado_por
    );
  END
END^


-- 6) Aplicar aporte a una meta de ahorro
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
         monto_ahorrado
    FROM Meta_ahorro
   WHERE Id_meta_ahorro = :p_id_meta_ahorro
    INTO :v_monto_total,
         :v_monto_ahorrado;

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


-- 7) Generar resumen mensual por usuario
CREATE OR ALTER PROCEDURE sp_generar_resumen_mensual_usuario (
    p_id_usuario VARCHAR(36)
)
RETURNS (
    r_anio            INT,
    r_mes             INT,
    r_total_ingresos  DECIMAL(12,2),
    r_total_gastos    DECIMAL(12,2),
    r_total_ahorro    DECIMAL(12,2),
    r_saldo_neto      DECIMAL(12,2)
)
AS
BEGIN
  FOR
    SELECT
        t.anio,
        t.mes,
        COALESCE(SUM(CASE WHEN t.tipo = 'ingreso' THEN t.monto ELSE 0 END), 0) AS total_ingresos,
        COALESCE(SUM(CASE WHEN t.tipo = 'gasto'   THEN t.monto ELSE 0 END), 0) AS total_gastos,
        COALESCE(SUM(CASE WHEN t.tipo = 'ahorro'  THEN t.monto ELSE 0 END), 0) AS total_ahorro
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


-- 8) Actualizar vigencia de obligaciones fijas
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
