SET TERM ^ ;

CREATE OR ALTER PROCEDURE sp_insert_usuario (
    p_id_usuario           VARCHAR(36),
    p_nombre               VARCHAR(100),
    p_apellido             VARCHAR(100),
    p_correo               VARCHAR(150),
    p_salario_mensual_base DECIMAL(12,2),
    p_estado               VARCHAR(20),
    p_creado_por           VARCHAR(50)
)
AS
BEGIN
  INSERT INTO Usuario (
      Id_usuario,
      nombre,
      apellido,
      correo,
      salario_mensual_base,
      estado,
      creado_por
  )
  VALUES (
      :p_id_usuario,
      :p_nombre,
      :p_apellido,
      :p_correo,
      :p_salario_mensual_base,
      :p_estado,
      :p_creado_por
  );
END^

CREATE OR ALTER PROCEDURE sp_update_usuario (
    p_id_usuario           VARCHAR(36),
    p_nombre               VARCHAR(100),
    p_apellido             VARCHAR(100),
    p_correo               VARCHAR(150),
    p_salario_mensual_base DECIMAL(12,2),
    p_estado               VARCHAR(20),
    p_modificado_por       VARCHAR(50)
)
AS
BEGIN
  UPDATE Usuario
     SET nombre               = :p_nombre,
         apellido             = :p_apellido,
         correo               = :p_correo,
         salario_mensual_base = :p_salario_mensual_base,
         estado               = :p_estado,
         modificado_por       = :p_modificado_por,
         modificado_en        = CURRENT_TIMESTAMP
   WHERE Id_usuario           = :p_id_usuario;
END^

CREATE OR ALTER PROCEDURE sp_delete_usuario (
    p_id_usuario VARCHAR(36)
)
AS
BEGIN
  DELETE FROM Usuario
   WHERE Id_usuario = :p_id_usuario;
END^

CREATE OR ALTER PROCEDURE sp_get_usuario_by_id (
    p_id_usuario VARCHAR(36)
)
RETURNS (
    r_id_usuario           VARCHAR(36),
    r_nombre               VARCHAR(100),
    r_apellido             VARCHAR(100),
    r_correo               VARCHAR(150),
    r_fecha_registro       TIMESTAMP,
    r_salario_mensual_base DECIMAL(12,2),
    r_estado               VARCHAR(20),
    r_creado_por           VARCHAR(50),
    r_modificado_por       VARCHAR(50),
    r_creado_en            TIMESTAMP,
    r_modificado_en        TIMESTAMP
)
AS
BEGIN
  FOR
    SELECT Id_usuario,
           nombre,
           apellido,
           correo,
           fecha_registro,
           salario_mensual_base,
           estado,
           creado_por,
           modificado_por,
           creado_en,
           modificado_en
      FROM Usuario
     WHERE Id_usuario = :p_id_usuario
    INTO :r_id_usuario,
         :r_nombre,
         :r_apellido,
         :r_correo,
         :r_fecha_registro,
         :r_salario_mensual_base,
         :r_estado,
         :r_creado_por,
         :r_modificado_por,
         :r_creado_en,
         :r_modificado_en
  DO
    SUSPEND;
END^

CREATE OR ALTER PROCEDURE sp_get_usuario_por_correo (
    p_correo VARCHAR(150)
)
RETURNS (
    r_id_usuario           VARCHAR(36),
    r_nombre               VARCHAR(100),
    r_apellido             VARCHAR(100),
    r_correo               VARCHAR(150),
    r_fecha_registro       TIMESTAMP,
    r_salario_mensual_base DECIMAL(12,2),
    r_estado               VARCHAR(20)
)
AS
BEGIN
  FOR
    SELECT Id_usuario,
           nombre,
           apellido,
           correo,
           fecha_registro,
           salario_mensual_base,
           estado
      FROM Usuario
     WHERE correo = :p_correo
    INTO :r_id_usuario,
         :r_nombre,
         :r_apellido,
         :r_correo,
         :r_fecha_registro,
         :r_salario_mensual_base,
         :r_estado
  DO
    SUSPEND;
END^

CREATE OR ALTER PROCEDURE sp_insert_categoria (
    p_id_categoria VARCHAR(36),
    p_nombre       VARCHAR(100),
    p_descripcion  VARCHAR(255),
    p_tipo         VARCHAR(20),
    p_icono        VARCHAR(100),
    p_color_hex    VARCHAR(10),
    p_orden        INTEGER,
    p_creado_por   VARCHAR(50)
)
AS
BEGIN
  INSERT INTO Categoria (
      Id_categoria,
      nombre,
      descripcion,
      tipo,
      icono,
      color_hex,
      orden,
      creado_por
  )
  VALUES (
      :p_id_categoria,
      :p_nombre,
      :p_descripcion,
      :p_tipo,
      :p_icono,
      :p_color_hex,
      :p_orden,
      :p_creado_por
  );
END^

CREATE OR ALTER PROCEDURE sp_update_categoria (
    p_id_categoria   VARCHAR(36),
    p_nombre         VARCHAR(100),
    p_descripcion    VARCHAR(255),
    p_tipo           VARCHAR(20),
    p_icono          VARCHAR(100),
    p_color_hex      VARCHAR(10),
    p_orden          INTEGER,
    p_modificado_por VARCHAR(50)
)
AS
BEGIN
  UPDATE Categoria
     SET nombre         = :p_nombre,
         descripcion    = :p_descripcion,
         tipo           = :p_tipo,
         icono          = :p_icono,
         color_hex      = :p_color_hex,
         orden          = :p_orden,
         modificado_por = :p_modificado_por,
         modificado_en  = CURRENT_TIMESTAMP
   WHERE Id_categoria   = :p_id_categoria;
END^

CREATE OR ALTER PROCEDURE sp_delete_categoria (
    p_id_categoria VARCHAR(36)
)
AS
BEGIN
  DELETE FROM Categoria
   WHERE Id_categoria = :p_id_categoria;
END^

CREATE OR ALTER PROCEDURE sp_get_categoria_by_id (
    p_id_categoria VARCHAR(36)
)
RETURNS (
    r_id_categoria   VARCHAR(36),
    r_nombre         VARCHAR(100),
    r_descripcion    VARCHAR(255),
    r_tipo           VARCHAR(20),
    r_icono          VARCHAR(100),
    r_color_hex      VARCHAR(10),
    r_orden          INTEGER,
    r_creado_por     VARCHAR(50),
    r_modificado_por VARCHAR(50),
    r_creado_en      TIMESTAMP,
    r_modificado_en  TIMESTAMP
)
AS
BEGIN
  FOR
    SELECT Id_categoria,
           nombre,
           descripcion,
           tipo,
           icono,
           color_hex,
           orden,
           creado_por,
           modificado_por,
           creado_en,
           modificado_en
      FROM Categoria
     WHERE Id_categoria = :p_id_categoria
    INTO :r_id_categoria,
         :r_nombre,
         :r_descripcion,
         :r_tipo,
         :r_icono,
         :r_color_hex,
         :r_orden,
         :r_creado_por,
         :r_modificado_por,
         :r_creado_en,
         :r_modificado_en
  DO
    SUSPEND;
END^

CREATE OR ALTER PROCEDURE sp_get_categoria_por_nombre (
    p_nombre VARCHAR(100)
)
RETURNS (
    r_id_categoria VARCHAR(36),
    r_nombre       VARCHAR(100),
    r_descripcion  VARCHAR(255),
    r_tipo         VARCHAR(20)
)
AS
BEGIN
  FOR
    SELECT Id_categoria,
           nombre,
           descripcion,
           tipo
      FROM Categoria
     WHERE nombre = :p_nombre
    INTO :r_id_categoria,
         :r_nombre,
         :r_descripcion,
         :r_tipo
  DO
    SUSPEND;
END^

CREATE OR ALTER PROCEDURE sp_insert_subcategoria (
    p_id_subcategoria VARCHAR(36),
    p_id_categoria    VARCHAR(36),
    p_nombre          VARCHAR(100),
    p_descripcion     VARCHAR(255),
    p_activa          BOOLEAN,
    p_es_defecto      BOOLEAN,
    p_creado_por      VARCHAR(50)
)
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
  )
  VALUES (
      :p_id_subcategoria,
      :p_id_categoria,
      :p_nombre,
      :p_descripcion,
      :p_activa,
      :p_es_defecto,
      :p_creado_por
  );
END^

CREATE OR ALTER PROCEDURE sp_update_subcategoria (
    p_id_subcategoria VARCHAR(36),
    p_id_categoria    VARCHAR(36),
    p_nombre          VARCHAR(100),
    p_descripcion     VARCHAR(255),
    p_activa          BOOLEAN,
    p_es_defecto      BOOLEAN,
    p_modificado_por  VARCHAR(50)
)
AS
BEGIN
  UPDATE Subcategoria
     SET Id_categoria   = :p_id_categoria,
         nombre         = :p_nombre,
         descripcion    = :p_descripcion,
         activa         = :p_activa,
         es_defecto     = :p_es_defecto,
         modificado_por = :p_modificado_por,
         modificado_en  = CURRENT_TIMESTAMP
   WHERE Id_subcategoria = :p_id_subcategoria;
END^

CREATE OR ALTER PROCEDURE sp_delete_subcategoria (
    p_id_subcategoria VARCHAR(36)
)
AS
BEGIN
  DELETE FROM Subcategoria
   WHERE Id_subcategoria = :p_id_subcategoria;
END^

CREATE OR ALTER PROCEDURE sp_get_subcategoria_by_id (
    p_id_subcategoria VARCHAR(36)
)
RETURNS (
    r_id_subcategoria VARCHAR(36),
    r_id_categoria    VARCHAR(36),
    r_nombre          VARCHAR(100),
    r_descripcion     VARCHAR(255),
    r_activa          BOOLEAN,
    r_es_defecto      BOOLEAN,
    r_creado_por      VARCHAR(50),
    r_modificado_por  VARCHAR(50),
    r_creado_en       TIMESTAMP,
    r_modificado_en   TIMESTAMP
)
AS
BEGIN
  FOR
    SELECT Id_subcategoria,
           Id_categoria,
           nombre,
           descripcion,
           activa,
           es_defecto,
           creado_por,
           modificado_por,
           creado_en,
           modificado_en
      FROM Subcategoria
     WHERE Id_subcategoria = :p_id_subcategoria
    INTO :r_id_subcategoria,
         :r_id_categoria,
         :r_nombre,
         :r_descripcion,
         :r_activa,
         :r_es_defecto,
         :r_creado_por,
         :r_modificado_por,
         :r_creado_en,
         :r_modificado_en
  DO
    SUSPEND;
END^

CREATE OR ALTER PROCEDURE sp_insert_presupuesto (
    p_id_presupuesto VARCHAR(36),
    p_id_usuario     VARCHAR(36),
    p_nombre         VARCHAR(100),
    p_anio_inicio    INTEGER,
    p_mes_inicio     INTEGER,
    p_anio_fin       INTEGER,
    p_mes_fin        INTEGER,
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
    p_anio_inicio    INTEGER,
    p_mes_inicio     INTEGER,
    p_anio_fin       INTEGER,
    p_mes_fin        INTEGER,
    p_estado         VARCHAR(20),
    p_modificado_por VARCHAR(50)
)
AS
BEGIN
  UPDATE Presupuesto
     SET nombre         = :p_nombre,
         anio_inicio    = :p_anio_inicio,
         mes_inicio     = :p_mes_inicio,
         anio_fin       = :p_anio_fin,
         mes_fin        = :p_mes_fin,
         estado         = :p_estado,
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
    r_anio_inicio    INTEGER,
    r_mes_inicio     INTEGER,
    r_anio_fin       INTEGER,
    r_mes_fin        INTEGER,
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
    r_observacion            VARCHAR(255),
    r_creado_por             VARCHAR(50),
    r_modificado_por         VARCHAR(50),
    r_creado_en              TIMESTAMP,
    r_modificado_en          TIMESTAMP
)
AS
BEGIN
  FOR
    SELECT Id_presupuesto_detalle,
           Id_presupuesto,
           Id_subcategoria,
           monto_mensual,
           observacion,
           creado_por,
           modificado_por,
           creado_en,
           modificado_en
      FROM Presupuesto_detalle
     WHERE Id_presupuesto_detalle = :p_id_presupuesto_detalle
    INTO :r_id_presupuesto_detalle,
         :r_id_presupuesto,
         :r_id_subcategoria,
         :r_monto_mensual,
         :r_observacion,
         :r_creado_por,
         :r_modificado_por,
         :r_creado_en,
         :r_modificado_en
  DO
    SUSPEND;
END^

CREATE OR ALTER PROCEDURE sp_insert_obligacion_fija (
    p_id_obligacion_fija VARCHAR(36),
    p_id_subcategoria    VARCHAR(36),
    p_id_usuario         VARCHAR(36),
    p_nombre             VARCHAR(100),
    p_descripcion        VARCHAR(255),
    p_monto_mensual      DECIMAL(12,2),
    p_dia_mes            INTEGER,
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
    p_dia_mes            INTEGER,
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
    r_dia_mes            INTEGER,
    r_vigente            BOOLEAN,
    r_fecha_inicio       TIMESTAMP,
    r_fecha_fin          TIMESTAMP,
    r_creado_por         VARCHAR(50),
    r_modificado_por     VARCHAR(50),
    r_creado_en          TIMESTAMP,
    r_modificado_en      TIMESTAMP
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
           fecha_fin,
           creado_por,
           modificado_por,
           creado_en,
           modificado_en
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
         :r_fecha_fin,
         :r_creado_por,
         :r_modificado_por,
         :r_creado_en,
         :r_modificado_en
  DO
    SUSPEND;
END^

CREATE OR ALTER PROCEDURE sp_insert_transaccion (
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
    p_anio               INTEGER,
    p_mes                INTEGER,
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
    r_anio               INTEGER,
    r_mes                INTEGER,
    r_tipo               VARCHAR(20),
    r_descripcion        VARCHAR(255),
    r_monto              DECIMAL(12,2),
    r_fecha              TIMESTAMP,
    r_metodo_pago        VARCHAR(50),
    r_numero_factura     VARCHAR(50),
    r_observaciones      VARCHAR(255),
    r_fecha_registro     TIMESTAMP,
    r_creado_por         VARCHAR(50),
    r_modificado_por     VARCHAR(50),
    r_creado_en          TIMESTAMP,
    r_modificado_en      TIMESTAMP
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
           fecha_registro,
           creado_por,
           modificado_por,
           creado_en,
           modificado_en
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
         :r_fecha_registro,
         :r_creado_por,
         :r_modificado_por,
         :r_creado_en,
         :r_modificado_en
  DO
    SUSPEND;
END^

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
    r_estado          VARCHAR(20),
    r_creado_por      VARCHAR(50),
    r_modificado_por  VARCHAR(50),
    r_creado_en       TIMESTAMP,
    r_modificado_en   TIMESTAMP
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
           estado,
           creado_por,
           modificado_por,
           creado_en,
           modificado_en
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
         :r_estado,
         :r_creado_por,
         :r_modificado_por,
         :r_creado_en,
         :r_modificado_en
  DO
    SUSPEND;
END^

CREATE OR ALTER PROCEDURE sp_get_meta_ahorro_por_nombre_usuario (
    p_id_usuario VARCHAR(36),
    p_nombre     VARCHAR(100)
)
RETURNS (
    r_id_meta_ahorro  VARCHAR(36),
    r_id_subcategoria VARCHAR(36),
    r_nombre          VARCHAR(100),
    r_monto_total     DECIMAL(12,2),
    r_monto_ahorrado  DECIMAL(12,2),
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
           estado
      FROM Meta_ahorro
     WHERE Id_usuario = :p_id_usuario
       AND nombre     = :p_nombre
    INTO :r_id_meta_ahorro,
         :r_id_subcategoria,
         :r_nombre,
         :r_monto_total,
         :r_monto_ahorrado,
         :r_estado
  DO
    SUSPEND;
END^

SET TERM ; ^
