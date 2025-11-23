SET TERM ^ ;

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
    r_es_defecto      BOOLEAN
)
AS
BEGIN
  FOR
    SELECT Id_subcategoria,
           Id_categoria,
           nombre,
           descripcion,
           activa,
           es_defecto
      FROM Subcategoria
     WHERE Id_subcategoria = :p_id_subcategoria
    INTO :r_id_subcategoria,
         :r_id_categoria,
         :r_nombre,
         :r_descripcion,
         :r_activa,
         :r_es_defecto
  DO
    SUSPEND;
END^

CREATE OR ALTER PROCEDURE sp_get_subcategorias_by_categoria (
    p_id_categoria VARCHAR(36)
)
RETURNS (
    r_id_subcategoria VARCHAR(36),
    r_nombre          VARCHAR(100),
    r_activa          BOOLEAN,
    r_es_defecto      BOOLEAN
)
AS
BEGIN
  FOR
    SELECT Id_subcategoria,
           nombre,
           activa,
           es_defecto
      FROM Subcategoria
     WHERE Id_categoria = :p_id_categoria
     ORDER BY nombre
    INTO :r_id_subcategoria,
         :r_nombre,
         :r_activa,
         :r_es_defecto
  DO
    SUSPEND;
END^

SET TERM ; ^
