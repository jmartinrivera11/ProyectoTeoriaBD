SET TERM ^ ;

-- 1. fn_calcular_monto_ejecutado
CREATE OR ALTER FUNCTION fn_calcular_monto_ejecutado(
    p_id_subcategoria VARCHAR(36),
    p_anio INTEGER,
    p_mes INTEGER
)
RETURNS DECIMAL(10,2)
AS
DECLARE VARIABLE v_total DECIMAL(10,2);
BEGIN
    SELECT COALESCE(SUM(monto), 0)
    FROM Transaccion
    WHERE Id_subcategoria = :p_id_subcategoria
      AND anio = :p_anio
      AND mes = :p_mes
      AND tipo = 'gasto'
    INTO :v_total;

    RETURN v_total;
END^

-- 2.  fn_calcular_porcentaje_ejecutado
CREATE OR ALTER FUNCTION fn_calcular_porcentaje_ejecutado(
    p_id_subcategoria VARCHAR(36),
    p_id_presupuesto VARCHAR(36),
    p_anio INTEGER,
    p_mes INTEGER
)
RETURNS DECIMAL(10,2)
AS
DECLARE VARIABLE v_ejecutado DECIMAL(10,2);
DECLARE VARIABLE v_presupuestado DECIMAL(10,2);
BEGIN
    -- Obtener ejecutado
    v_ejecutado = fn_calcular_monto_ejecutado(:p_id_subcategoria, :p_anio, :p_mes);

    -- Obtener presupuestado
    SELECT monto_mensual
    FROM Presupuesto_detalle
    WHERE Id_presupuesto = :p_id_presupuesto
      AND Id_subcategoria = :p_id_subcategoria
    INTO :v_presupuestado;

    IF (v_presupuestado IS NULL OR v_presupuestado = 0) THEN
        RETURN 0;
    
    RETURN (v_ejecutado / v_presupuestado) * 100;
END^

-- 3.  fn_obtener_balance_subcategoria
CREATE OR ALTER FUNCTION fn_obtener_balance_subcategoria(
    p_id_presupuesto VARCHAR(36),
    p_id_subcategoria VARCHAR(36),
    p_anio INTEGER,
    p_mes INTEGER
)
RETURNS DECIMAL(10,2)
AS
DECLARE VARIABLE v_ejecutado DECIMAL(10,2);
DECLARE VARIABLE v_presupuestado DECIMAL(10,2);
BEGIN
    v_ejecutado = fn_calcular_monto_ejecutado(:p_id_subcategoria, :p_anio, :p_mes);

    SELECT monto_mensual
    FROM Presupuesto_detalle
    WHERE Id_presupuesto = :p_id_presupuesto
      AND Id_subcategoria = :p_id_subcategoria
    INTO :v_presupuestado;

    RETURN COALESCE(v_presupuestado, 0) - v_ejecutado;
END^

-- 4. fn_obtener_total_categoria_mes
CREATE OR ALTER FUNCTION fn_obtener_total_categoria_mes(
    p_id_categoria VARCHAR(36),
    p_id_presupuesto VARCHAR(36),
    p_anio INTEGER,
    p_mes INTEGER
)
RETURNS DECIMAL(10,2)
AS
DECLARE VARIABLE v_total DECIMAL(10,2);
BEGIN
    SELECT COALESCE(SUM(pd.monto_mensual), 0)
    FROM Presupuesto_detalle pd
    JOIN Subcategoria s ON pd.Id_subcategoria = s.Id_subcategoria
    WHERE s.Id_categoria = :p_id_categoria
      AND pd. Id_presupuesto = :p_id_presupuesto
    INTO :v_total;

    RETURN v_total;
END^

-- 5. fn_obtener_total_ejecutado_categoria_mes
CREATE OR ALTER FUNCTION fn_obtener_total_ejecutado_categoria_mes(
    p_id_categoria VARCHAR(36),
    p_anio INTEGER,
    p_mes INTEGER
)
RETURNS DECIMAL(10,2)
AS
DECLARE VARIABLE v_total DECIMAL(10,2);
BEGIN
    SELECT COALESCE(SUM(t.monto), 0)
    FROM Transaccion t
    JOIN Subcategoria s ON t.Id_subcategoria = s.Id_subcategoria
    WHERE s.Id_categoria = :p_id_categoria
      AND t.anio = :p_anio
      AND t.mes = :p_mes
      AND t.tipo = 'gasto'
    INTO :v_total;

    RETURN v_total;
END^

-- 6. fn_dias_hasta_vencimiento
CREATE OR ALTER FUNCTION fn_dias_hasta_vencimiento(
    p_id_obligacion VARCHAR(36)
)
RETURNS INTEGER
AS
DECLARE VARIABLE v_dia_mes INTEGER;
DECLARE VARIABLE v_fecha_vencimiento DATE;
DECLARE VARIABLE v_hoy DATE;
DECLARE VARIABLE v_anio INTEGER;
DECLARE VARIABLE v_mes INTEGER;
BEGIN
    SELECT dia_mes FROM Obligacion_fija WHERE Id_obligacion_fija = :p_id_obligacion INTO :v_dia_mes;
    
    IF (v_dia_mes IS NULL) THEN RETURN NULL;

    v_hoy = CURRENT_DATE;
    v_anio = EXTRACT(YEAR FROM v_hoy);
    v_mes = EXTRACT(MONTH FROM v_hoy);
    BEGIN
        v_fecha_vencimiento = CAST(:v_anio || '-' || :v_mes || '-' || :v_dia_mes AS DATE);
    WHEN ANY DO
        -- Al fallar, asumimos que vence el 1 del otro mes
        v_fecha_vencimiento = CAST(:v_anio || '-' || :v_mes || '-01' AS DATE);
    END

    IF (v_fecha_vencimiento < v_hoy) THEN
    BEGIN
        -- Si ya paso este mes, calcular para el proximo
        v_fecha_vencimiento = DATEADD(1 MONTH TO v_fecha_vencimiento);
    END

    RETURN v_fecha_vencimiento - v_hoy;
END^

-- 7.  fn_validar_vigencia_presupuesto
CREATE OR ALTER FUNCTION fn_validar_vigencia_presupuesto(
    p_fecha TIMESTAMP,
    p_id_presupuesto VARCHAR(36)
)
RETURNS SMALLINT
AS
DECLARE VARIABLE v_anio_inicio INTEGER;
DECLARE VARIABLE v_mes_inicio INTEGER;
DECLARE VARIABLE v_anio_fin INTEGER;
DECLARE VARIABLE v_mes_fin INTEGER;
DECLARE VARIABLE v_fecha_inicio DATE;
DECLARE VARIABLE v_fecha_fin DATE;
DECLARE VARIABLE v_fecha_check DATE;
BEGIN
    SELECT anio_inicio, mes_inicio, anio_fin, mes_fin
    FROM Presupuesto
    WHERE Id_presupuesto = :p_id_presupuesto
    INTO :v_anio_inicio, :v_mes_inicio, :v_anio_fin, :v_mes_fin;

    v_fecha_inicio = CAST(:v_anio_inicio || '-' || COALESCE(:v_mes_inicio, 1) || '-01' AS DATE);
    
    v_fecha_fin = CAST(:v_anio_fin || '-' || COALESCE(:v_mes_fin, 12) || '-01' AS DATE);
    v_fecha_fin = DATEADD(1 MONTH TO v_fecha_fin);
    v_fecha_fin = DATEADD(-1 DAY TO v_fecha_fin);

    v_fecha_check = CAST(:p_fecha AS DATE);

    IF (v_fecha_check >= v_fecha_inicio AND v_fecha_check <= v_fecha_fin) THEN
        RETURN 1;
    
    RETURN 0;
END^

-- 8. fn_obtener_categoria_por_subcategoria
CREATE OR ALTER FUNCTION fn_obtener_categoria_por_subcategoria(
    p_id_subcategoria VARCHAR(36)
)
RETURNS VARCHAR(36)
AS
DECLARE VARIABLE v_id_categoria VARCHAR(36);
BEGIN
    SELECT Id_categoria
    FROM Subcategoria
    WHERE Id_subcategoria = :p_id_subcategoria
    INTO :v_id_categoria;

    RETURN v_id_categoria;
END^

-- 9. fn_calcular_proyeccion_gasto_mensual
CREATE OR ALTER FUNCTION fn_calcular_proyeccion_gasto_mensual(
    p_id_subcategoria VARCHAR(36),
    p_anio INTEGER,
    p_mes INTEGER
)
RETURNS DECIMAL(10,2)
AS
DECLARE VARIABLE v_ejecutado DECIMAL(10,2);
DECLARE VARIABLE v_hoy DATE;
DECLARE VARIABLE v_dias_transcurridos INTEGER;
DECLARE VARIABLE v_dias_totales_mes INTEGER;
DECLARE VARIABLE v_fecha_inicio_mes DATE;
DECLARE VARIABLE v_fecha_fin_mes DATE;
BEGIN
    v_ejecutado = fn_calcular_monto_ejecutado(:p_id_subcategoria, :p_anio, :p_mes);
    v_hoy = CURRENT_DATE;

    -- Si es mes pasado, la proyeccion es el ejecutado real
    IF (:p_anio < EXTRACT(YEAR FROM v_hoy) OR (:p_anio = EXTRACT(YEAR FROM v_hoy) AND :p_mes < EXTRACT(MONTH FROM v_hoy))) THEN
        RETURN v_ejecutado;

    -- Si es mes futuro, 0
    IF (:p_anio > EXTRACT(YEAR FROM v_hoy) OR (:p_anio = EXTRACT(YEAR FROM v_hoy) AND :p_mes > EXTRACT(MONTH FROM v_hoy))) THEN
        RETURN 0;

    -- Mes actual
    v_fecha_inicio_mes = CAST(:p_anio || '-' || :p_mes || '-01' AS DATE);
    v_fecha_fin_mes = DATEADD(1 MONTH TO v_fecha_inicio_mes);
    v_fecha_fin_mes = DATEADD(-1 DAY TO v_fecha_fin_mes);
    
    v_dias_totales_mes = EXTRACT(DAY FROM v_fecha_fin_mes);
    v_dias_transcurridos = EXTRACT(DAY FROM v_hoy);

    IF (v_dias_transcurridos = 0) THEN RETURN 0;

    RETURN (v_ejecutado / v_dias_transcurridos) * v_dias_totales_mes;
END^

-- 10. fn_obtener_promedio_gasto_subcategoria
CREATE OR ALTER FUNCTION fn_obtener_promedio_gasto_subcategoria(
    p_id_usuario VARCHAR(36),
    p_id_subcategoria VARCHAR(36),
    p_cantidad_meses INTEGER
)
RETURNS DECIMAL(10,2)
AS
DECLARE VARIABLE v_total DECIMAL(10,2);
DECLARE VARIABLE v_fecha_limite DATE;
BEGIN
    v_fecha_limite = DATEADD(-:p_cantidad_meses MONTH TO CURRENT_DATE);

    -- Calcular suma total y dividir por N
    SELECT COALESCE(SUM(monto), 0)
    FROM Transaccion
    WHERE Id_usuario = :p_id_usuario
      AND Id_subcategoria = :p_id_subcategoria
      AND fecha >= :v_fecha_limite
      AND tipo = 'gasto'
    INTO :v_total;

    IF (:p_cantidad_meses > 0) THEN
        RETURN v_total / :p_cantidad_meses;
    
    RETURN 0;
END^

SET TERM ; ^