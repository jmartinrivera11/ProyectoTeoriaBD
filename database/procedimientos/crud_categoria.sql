SET TERM ^ ;

CREATE OR ALTER PROCEDURE sp_insert_categoria (
    p_id_categoria VARCHAR(36),
    p_nombre       VARCHAR(100),
    p_descripcion  VARCHAR(255),
    p_tipo         VARCHAR(20),
    p_icono        VARCHAR(100),
    p_color_hex    VARCHAR(10),
    p_orden        INT,
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
    p_orden          INT,
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
    r_id_categoria VARCHAR(36),
    r_nombre       VARCHAR(100),
    r_descripcion  VARCHAR(255),
    r_tipo         VARCHAR(20),
    r_icono        VARCHAR(100),
    r_color_hex    VARCHAR(10),
    r_orden        INT
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
           orden
      FROM Categoria
     WHERE Id_categoria = :p_id_categoria
    INTO :r_id_categoria,
         :r_nombre,
         :r_descripcion,
         :r_tipo,
         :r_icono,
         :r_color_hex,
         :r_orden
  DO
    SUSPEND;
END^

CREATE OR ALTER PROCEDURE sp_get_categorias_all
RETURNS (
    r_id_categoria VARCHAR(36),
    r_nombre       VARCHAR(100),
    r_tipo         VARCHAR(20),
    r_orden        INT
)
AS
BEGIN
  FOR
    SELECT Id_categoria,
           nombre,
           tipo,
           orden
      FROM Categoria
     ORDER BY tipo, orden, nombre
    INTO :r_id_categoria,
         :r_nombre,
         :r_tipo,
         :r_orden
  DO
    SUSPEND;
END^

SET TERM ; ^
