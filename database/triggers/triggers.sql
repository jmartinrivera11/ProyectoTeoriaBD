SET TERM ^ ;

CREATE OR ALTER TRIGGER bi_usuario_auditoria
FOR Usuario
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.creado_en IS NULL) THEN
    NEW.creado_en = CURRENT_TIMESTAMP;

  IF (NEW.modificado_en IS NULL) THEN
    NEW.modificado_en = NEW.creado_en;

  IF (NEW.creado_por IS NULL) THEN
    NEW.creado_por = CURRENT_USER;

  IF (NEW.modificado_por IS NULL) THEN
    NEW.modificado_por = NEW.creado_por;
END^

CREATE OR ALTER TRIGGER bu_usuario_auditoria
FOR Usuario
ACTIVE BEFORE UPDATE POSITION 0
AS
BEGIN
  NEW.creado_en  = OLD.creado_en;
  NEW.creado_por = OLD.creado_por;

  NEW.modificado_en = CURRENT_TIMESTAMP;

  IF (NEW.modificado_por IS NULL) THEN
    NEW.modificado_por = CURRENT_USER;
END^


CREATE OR ALTER TRIGGER bi_categoria_auditoria
FOR Categoria
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.creado_en IS NULL) THEN
    NEW.creado_en = CURRENT_TIMESTAMP;

  IF (NEW.modificado_en IS NULL) THEN
    NEW.modificado_en = NEW.creado_en;

  IF (NEW.creado_por IS NULL) THEN
    NEW.creado_por = CURRENT_USER;

  IF (NEW.modificado_por IS NULL) THEN
    NEW.modificado_por = NEW.creado_por;
END^

CREATE OR ALTER TRIGGER bu_categoria_auditoria
FOR Categoria
ACTIVE BEFORE UPDATE POSITION 0
AS
BEGIN
  NEW.creado_en  = OLD.creado_en;
  NEW.creado_por = OLD.creado_por;

  NEW.modificado_en = CURRENT_TIMESTAMP;

  IF (NEW.modificado_por IS NULL) THEN
    NEW.modificado_por = CURRENT_USER;
END^


CREATE OR ALTER TRIGGER bi_presupuesto_auditoria
FOR Presupuesto
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.creado_en IS NULL) THEN
    NEW.creado_en = CURRENT_TIMESTAMP;

  IF (NEW.modificado_en IS NULL) THEN
    NEW.modificado_en = NEW.creado_en;

  IF (NEW.creado_por IS NULL) THEN
    NEW.creado_por = CURRENT_USER;

  IF (NEW.modificado_por IS NULL) THEN
    NEW.modificado_por = NEW.creado_por;
END^

CREATE OR ALTER TRIGGER bu_presupuesto_auditoria
FOR Presupuesto
ACTIVE BEFORE UPDATE POSITION 0
AS
BEGIN
  NEW.creado_en  = OLD.creado_en;
  NEW.creado_por = OLD.creado_por;

  NEW.modificado_en = CURRENT_TIMESTAMP;

  IF (NEW.modificado_por IS NULL) THEN
    NEW.modificado_por = CURRENT_USER;
END^


CREATE OR ALTER TRIGGER bi_subcategoria_auditoria
FOR Subcategoria
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.creado_en IS NULL) THEN
    NEW.creado_en = CURRENT_TIMESTAMP;

  IF (NEW.modificado_en IS NULL) THEN
    NEW.modificado_en = NEW.creado_en;

  IF (NEW.creado_por IS NULL) THEN
    NEW.creado_por = CURRENT_USER;

  IF (NEW.modificado_por IS NULL) THEN
    NEW.modificado_por = NEW.creado_por;
END^

CREATE OR ALTER TRIGGER bu_subcategoria_auditoria
FOR Subcategoria
ACTIVE BEFORE UPDATE POSITION 0
AS
BEGIN
  NEW.creado_en  = OLD.creado_en;
  NEW.creado_por = OLD.creado_por;

  NEW.modificado_en = CURRENT_TIMESTAMP;

  IF (NEW.modificado_por IS NULL) THEN
    NEW.modificado_por = CURRENT_USER;
END^


CREATE OR ALTER TRIGGER bi_presupuesto_detalle_auditoria
FOR Presupuesto_detalle
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.creado_en IS NULL) THEN
    NEW.creado_en = CURRENT_TIMESTAMP;

  IF (NEW.modificado_en IS NULL) THEN
    NEW.modificado_en = NEW.creado_en;

  IF (NEW.creado_por IS NULL) THEN
    NEW.creado_por = CURRENT_USER;

  IF (NEW.modificado_por IS NULL) THEN
    NEW.modificado_por = NEW.creado_por;
END^

CREATE OR ALTER TRIGGER bu_presupuesto_detalle_auditoria
FOR Presupuesto_detalle
ACTIVE BEFORE UPDATE POSITION 0
AS
BEGIN
  NEW.creado_en  = OLD.creado_en;
  NEW.creado_por = OLD.creado_por;

  NEW.modificado_en = CURRENT_TIMESTAMP;

  IF (NEW.modificado_por IS NULL) THEN
    NEW.modificado_por = CURRENT_USER;
END^


CREATE OR ALTER TRIGGER bi_obligacion_fija_auditoria
FOR Obligacion_fija
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.creado_en IS NULL) THEN
    NEW.creado_en = CURRENT_TIMESTAMP;

  IF (NEW.modificado_en IS NULL) THEN
    NEW.modificado_en = NEW.creado_en;

  IF (NEW.creado_por IS NULL) THEN
    NEW.creado_por = CURRENT_USER;

  IF (NEW.modificado_por IS NULL) THEN
    NEW.modificado_por = NEW.creado_por;
END^

CREATE OR ALTER TRIGGER bu_obligacion_fija_auditoria
FOR Obligacion_fija
ACTIVE BEFORE UPDATE POSITION 0
AS
BEGIN
  NEW.creado_en  = OLD.creado_en;
  NEW.creado_por = OLD.creado_por;

  NEW.modificado_en = CURRENT_TIMESTAMP;

  IF (NEW.modificado_por IS NULL) THEN
    NEW.modificado_por = CURRENT_USER;
END^


CREATE OR ALTER TRIGGER bi_transaccion_auditoria
FOR Transaccion
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.creado_en IS NULL) THEN
    NEW.creado_en = CURRENT_TIMESTAMP;

  IF (NEW.modificado_en IS NULL) THEN
    NEW.modificado_en = NEW.creado_en;

  IF (NEW.creado_por IS NULL) THEN
    NEW.creado_por = CURRENT_USER;

  IF (NEW.modificado_por IS NULL) THEN
    NEW.modificado_por = NEW.creado_por;
END^

CREATE OR ALTER TRIGGER bu_transaccion_auditoria
FOR Transaccion
ACTIVE BEFORE UPDATE POSITION 0
AS
BEGIN
  NEW.creado_en  = OLD.creado_en;
  NEW.creado_por = OLD.creado_por;

  NEW.modificado_en = CURRENT_TIMESTAMP;

  IF (NEW.modificado_por IS NULL) THEN
    NEW.modificado_por = CURRENT_USER;
END^


CREATE OR ALTER TRIGGER bi_meta_ahorro_auditoria
FOR Meta_ahorro
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.creado_en IS NULL) THEN
    NEW.creado_en = CURRENT_TIMESTAMP;

  IF (NEW.modificado_en IS NULL) THEN
    NEW.modificado_en = NEW.creado_en;

  IF (NEW.creado_por IS NULL) THEN
    NEW.creado_por = CURRENT_USER;

  IF (NEW.modificado_por IS NULL) THEN
    NEW.modificado_por = NEW.creado_por;
END^

CREATE OR ALTER TRIGGER bu_meta_ahorro_auditoria
FOR Meta_ahorro
ACTIVE BEFORE UPDATE POSITION 0
AS
BEGIN
  NEW.creado_en  = OLD.creado_en;
  NEW.creado_por = OLD.creado_por;

  NEW.modificado_en = CURRENT_TIMESTAMP;

  IF (NEW.modificado_por IS NULL) THEN
    NEW.modificado_por = CURRENT_USER;
END^

SET TERM ; ^
