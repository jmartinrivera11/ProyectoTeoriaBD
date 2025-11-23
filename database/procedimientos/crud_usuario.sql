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

CREATE OR ALTER PROCEDURE sp_get_usuarios_all
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
     ORDER BY apellido, nombre
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

SET TERM ; ^
