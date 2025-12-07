SET TERM ^ ;

-- 1.  Trigger para crear subcategoría por defecto al insertar una categoría
CREATE OR ALTER TRIGGER trg_crear_subcategoria_defecto 
FOR Categoria
ACTIVE AFTER INSERT POSITION 0
AS
BEGIN
    INSERT INTO Subcategoria (
        Id_subcategoria,
        Id_categoria,
        nombre,
        descripcion,
        activa,
        es_defecto,
        creado_por
    ) VALUES (
        UUID_TO_CHAR(GEN_UUID()),
        NEW.Id_categoria,
        'General', 
        'Subcategoría por defecto',
        TRUE,
        TRUE,
        NEW.creado_por
    );
END^

-- 2.  Trigger para actualizar monto acumulado en META_AHORRO
CREATE OR ALTER TRIGGER trg_actualizar_meta_ahorro 
FOR Transaccion
ACTIVE AFTER INSERT POSITION 0
AS
DECLARE VARIABLE v_id_meta_ahorro VARCHAR(36);
DECLARE VARIABLE v_monto_total DECIMAL(12,2);
DECLARE VARIABLE v_nuevo_acumulado DECIMAL(12,2);
BEGIN
    IF (NEW.tipo = 'ahorro') THEN
    BEGIN
        -- Identifica meta asociada a la subcategoria
        FOR SELECT Id_meta_ahorro, monto_total 
            FROM Meta_ahorro 
            WHERE Id_subcategoria = NEW.Id_subcategoria
              AND Id_usuario = NEW.Id_usuario
            INTO :v_id_meta_ahorro, :v_monto_total
        DO
        BEGIN
            -- Actualiza monto acumulado
            UPDATE Meta_ahorro
            SET monto_ahorrado = monto_ahorrado + NEW.monto,
                modificado_en = CURRENT_TIMESTAMP
            WHERE Id_meta_ahorro = :v_id_meta_ahorro;

            -- Verifica si se completo
            SELECT monto_ahorrado 
            FROM Meta_ahorro 
            WHERE Id_meta_ahorro = :v_id_meta_ahorro
            INTO :v_nuevo_acumulado;

            IF (v_nuevo_acumulado >= v_monto_total) THEN
            BEGIN
                UPDATE Meta_ahorro
                SET estado = 'completada'
                WHERE Id_meta_ahorro = :v_id_meta_ahorro;
            END
        END
    END
END^

-- 3. Trigger para generar alertas de presupuesto
CREATE OR ALTER TRIGGER trg_alerta_presupuesto FOR Transaccion
ACTIVE AFTER INSERT OR UPDATE POSITION 10
AS
DECLARE VARIABLE v_monto_presupuestado DECIMAL(12,2);
DECLARE VARIABLE v_monto_ejecutado DECIMAL(12,2);
DECLARE VARIABLE v_porcentaje DECIMAL(10,2);
BEGIN
    IF (NEW.tipo = 'gasto') THEN
    BEGIN
        -- Obtener presupuesto mensual para la subcategoria
        SELECT monto_mensual 
        FROM Presupuesto_detalle
        WHERE Id_presupuesto = NEW.Id_presupuesto 
          AND Id_subcategoria = NEW.Id_subcategoria
        INTO :v_monto_presupuestado;

        IF (v_monto_presupuestado IS NOT NULL AND v_monto_presupuestado > 0) THEN
        BEGIN
            -- Calcula dinámicamente el monto ejecutado de la subcategoria para el mes de la transacción
            SELECT COALESCE(SUM(monto), 0)
            FROM Transaccion
            WHERE Id_presupuesto = NEW.Id_presupuesto
              AND Id_subcategoria = NEW.Id_subcategoria
              AND anio = NEW.anio
              AND mes = NEW. mes
              AND tipo = 'gasto'
            INTO :v_monto_ejecutado;

            v_porcentaje = (v_monto_ejecutado / v_monto_presupuestado) * 100;

            IF (v_porcentaje >= 100) THEN
                RDB$SET_CONTEXT('USER_SESSION', 'ALERTA_PRESUPUESTO', 'Subcategoria ' || NEW.Id_subcategoria || ' excedida (100%)');
            ELSE IF (v_porcentaje >= 80) THEN
                RDB$SET_CONTEXT('USER_SESSION', 'ALERTA_PRESUPUESTO', 'Subcategoria ' || NEW.Id_subcategoria || ' al 80%');
        END
    END
END^

-- 4.  Trigger para generar alertas de metas de ahorro
CREATE OR ALTER TRIGGER trg_alerta_meta_ahorro 
FOR Meta_ahorro
ACTIVE AFTER UPDATE POSITION 0
AS
DECLARE VARIABLE v_porcentaje DECIMAL(10,2);
BEGIN
    IF (NEW.monto_ahorrado <> OLD.monto_ahorrado) THEN
    BEGIN
        IF (NEW.monto_total > 0) THEN
        BEGIN
            v_porcentaje = (NEW.monto_ahorrado / NEW.monto_total) * 100;

            IF (v_porcentaje >= 100) THEN
                RDB$SET_CONTEXT('USER_SESSION', 'ALERTA_META', 'Meta ' || NEW.nombre || ' completada! ');
            ELSE IF (v_porcentaje >= 50 AND (OLD.monto_ahorrado / NEW.monto_total * 100) < 50) THEN
                RDB$SET_CONTEXT('USER_SESSION', 'ALERTA_META', 'Meta ' || NEW.nombre || ' al 50%');
        END
    END
END^

SET TERM ; ^