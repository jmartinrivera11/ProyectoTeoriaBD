CREATE TABLE Usuario (
    Id_usuario VARCHAR(36) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    salario_mensual_base DECIMAL(12,2) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    creado_por VARCHAR(50) NOT NULL,
    modificado_por VARCHAR(50),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modificado_en TIMESTAMP,
    CONSTRAINT pk_usuario PRIMARY KEY (Id_usuario),
    CONSTRAINT uq_usuario_correo UNIQUE (correo),
    CONSTRAINT ck_usuario_estado CHECK (estado IN ('activo', 'inactivo'))
);

CREATE TABLE Presupuesto (
    Id_presupuesto VARCHAR(36) NOT NULL,
    Id_usuario VARCHAR(36) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    anio_inicio INT NOT NULL,
    mes_inicio INT NOT NULL,
    anio_fin INT NOT NULL,
    mes_fin INT NOT NULL,
    total_ingresos DECIMAL(12,2) DEFAULT 0 NOT NULL,
    total_gastos DECIMAL(12,2) DEFAULT 0 NOT NULL,
    total_ahorro DECIMAL(12,2) DEFAULT 0 NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    estado VARCHAR(20) NOT NULL,
    creado_por VARCHAR(50) NOT NULL,
    modificado_por VARCHAR(50),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modificado_en TIMESTAMP,
    CONSTRAINT pk_presupuesto PRIMARY KEY (Id_presupuesto),
    CONSTRAINT fk_presupuesto_usuario FOREIGN KEY (Id_usuario)
        REFERENCES Usuario (Id_usuario),
    CONSTRAINT ck_presupuesto_mes_inicio CHECK (mes_inicio BETWEEN 1 AND 12),
    CONSTRAINT ck_presupuesto_mes_fin CHECK (mes_fin BETWEEN 1 AND 12),
    CONSTRAINT ck_presupuesto_estado CHECK (estado IN ('activo', 'cerrado', 'borrador')),
    CONSTRAINT ck_presupuesto_anios CHECK (anio_fin >= anio_inicio)
);

CREATE TABLE Categoria (
    Id_categoria VARCHAR(36) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    tipo VARCHAR(20) NOT NULL,
    icono VARCHAR(100),
    color_hex VARCHAR(10),
    orden INT,
    creado_por VARCHAR(50) NOT NULL,
    modificado_por VARCHAR(50),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modificado_en TIMESTAMP,
    CONSTRAINT pk_categoria PRIMARY KEY (Id_categoria),
    CONSTRAINT ck_categoria_tipo CHECK (tipo IN ('ingreso', 'gasto', 'ahorro'))
);

CREATE TABLE Subcategoria (
    Id_subcategoria VARCHAR(36) NOT NULL,
    Id_categoria VARCHAR(36) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    activa BOOLEAN DEFAULT TRUE NOT NULL,
    es_defecto BOOLEAN DEFAULT FALSE NOT NULL,
    creado_por VARCHAR(50) NOT NULL,
    modificado_por VARCHAR(50),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modificado_en TIMESTAMP,
    CONSTRAINT pk_subcategoria PRIMARY KEY (Id_subcategoria),
    CONSTRAINT fk_subcategoria_categoria FOREIGN KEY (Id_categoria)
        REFERENCES Categoria (Id_categoria)
);

CREATE TABLE Presupuesto_detalle (
    Id_presupuesto_detalle VARCHAR(36) NOT NULL,
    Id_presupuesto VARCHAR(36) NOT NULL,
    Id_subcategoria VARCHAR(36) NOT NULL,
    monto_mensual DECIMAL(12,2) NOT NULL,
    observacion VARCHAR(255),
    creado_por VARCHAR(50) NOT NULL,
    modificado_por VARCHAR(50),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modificado_en TIMESTAMP,
    CONSTRAINT pk_presupuesto_detalle PRIMARY KEY (Id_presupuesto_detalle),
    CONSTRAINT fk_detalle_presupuesto FOREIGN KEY (Id_presupuesto)
        REFERENCES Presupuesto (Id_presupuesto),
    CONSTRAINT fk_detalle_subcategoria FOREIGN KEY (Id_subcategoria)
        REFERENCES Subcategoria (Id_subcategoria),
    CONSTRAINT ck_detalle_monto CHECK (monto_mensual >= 0)
);

CREATE TABLE Obligacion_fija (
    Id_obligacion_fija VARCHAR(36) NOT NULL,
    Id_subcategoria VARCHAR(36) NOT NULL,
    Id_usuario VARCHAR(36) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    monto_mensual DECIMAL(12,2) NOT NULL,
    dia_mes INT NOT NULL,
    vigente BOOLEAN DEFAULT TRUE NOT NULL,
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_fin TIMESTAMP,
    creado_por VARCHAR(50) NOT NULL,
    modificado_por VARCHAR(50),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modificado_en TIMESTAMP,
    CONSTRAINT pk_obligacion_fija PRIMARY KEY (Id_obligacion_fija),
    CONSTRAINT fk_obligacion_subcategoria FOREIGN KEY (Id_subcategoria)
        REFERENCES Subcategoria (Id_subcategoria),
    CONSTRAINT fk_obligacion_usuario FOREIGN KEY (Id_usuario)
        REFERENCES Usuario (Id_usuario),
    CONSTRAINT ck_obligacion_dia CHECK (dia_mes BETWEEN 1 AND 31),
    CONSTRAINT ck_obligacion_monto CHECK (monto_mensual >= 0)
);

CREATE TABLE Transaccion (
    Id_transaccion VARCHAR(36) NOT NULL,
    Id_usuario VARCHAR(36) NOT NULL,
    Id_presupuesto VARCHAR(36) NOT NULL,
    Id_subcategoria VARCHAR(36) NOT NULL,
    Id_obligacion_fija VARCHAR(36),
    anio INT NOT NULL,
    mes INT NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    descripcion VARCHAR(255),
    monto DECIMAL(12,2) NOT NULL,
    fecha TIMESTAMP NOT NULL,
    metodo_pago VARCHAR(50),
    numero_factura VARCHAR(50),
    observaciones VARCHAR(255),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creado_por VARCHAR(50) NOT NULL,
    modificado_por VARCHAR(50),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modificado_en TIMESTAMP,
    CONSTRAINT pk_transaccion PRIMARY KEY (Id_transaccion),
    CONSTRAINT fk_trans_usuario FOREIGN KEY (Id_usuario)
        REFERENCES Usuario (Id_usuario),
    CONSTRAINT fk_trans_presupuesto FOREIGN KEY (Id_presupuesto)
        REFERENCES Presupuesto (Id_presupuesto),
    CONSTRAINT fk_trans_subcategoria FOREIGN KEY (Id_subcategoria)
        REFERENCES Subcategoria (Id_subcategoria),
    CONSTRAINT fk_trans_obligacion FOREIGN KEY (Id_obligacion_fija)
        REFERENCES Obligacion_fija (Id_obligacion_fija)
        ON DELETE SET NULL,
    CONSTRAINT ck_trans_mes CHECK (mes BETWEEN 1 AND 12),
    CONSTRAINT ck_trans_monto CHECK (monto >= 0),
    CONSTRAINT ck_trans_tipo CHECK (tipo IN ('ingreso', 'gasto', 'ahorro'))
);

CREATE TABLE Meta_ahorro (
    Id_meta_ahorro VARCHAR(36) NOT NULL,
    Id_usuario VARCHAR(36) NOT NULL,
    Id_subcategoria VARCHAR(36) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    monto_total DECIMAL(12,2) NOT NULL,
    monto_ahorrado DECIMAL(12,2) DEFAULT 0 NOT NULL,
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_objetivo TIMESTAMP NOT NULL,
    prioridad VARCHAR(20) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    creado_por VARCHAR(50) NOT NULL,
    modificado_por VARCHAR(50),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modificado_en TIMESTAMP,
    CONSTRAINT pk_meta_ahorro PRIMARY KEY (Id_meta_ahorro),
    CONSTRAINT fk_meta_usuario FOREIGN KEY (Id_usuario)
        REFERENCES Usuario (Id_usuario),
    CONSTRAINT fk_meta_subcategoria FOREIGN KEY (Id_subcategoria)
        REFERENCES Subcategoria (Id_subcategoria),
    CONSTRAINT ck_meta_monto_total CHECK (monto_total > 0),
    CONSTRAINT ck_meta_monto_ahorrado CHECK (monto_ahorrado >= 0),
    CONSTRAINT ck_meta_prioridad CHECK (prioridad IN ('alta','media','baja')),
    CONSTRAINT ck_meta_estado CHECK (estado IN ('en_progreso','completada','cancelada','pausada'))
);

CREATE INDEX idx_presupuesto_id_usuario ON Presupuesto (Id_usuario);
CREATE INDEX idx_subcategoria_id_categoria ON Subcategoria (Id_categoria);
CREATE INDEX idx_detalle_id_presupuesto ON Presupuesto_detalle (Id_presupuesto);
CREATE INDEX idx_detalle_id_subcategoria ON Presupuesto_detalle (Id_subcategoria);
CREATE INDEX idx_obligacion_id_subcategoria ON Obligacion_fija (Id_subcategoria);
CREATE INDEX idx_obligacion_id_usuario ON Obligacion_fija (Id_usuario);
CREATE INDEX idx_trans_id_usuario ON Transaccion (Id_usuario);
CREATE INDEX idx_trans_id_presupuesto ON Transaccion (Id_presupuesto);
CREATE INDEX idx_trans_id_subcategoria ON Transaccion (Id_subcategoria);
CREATE INDEX idx_trans_id_obligacion ON Transaccion (Id_obligacion_fija);
CREATE INDEX idx_meta_id_usuario ON Meta_ahorro (Id_usuario);
CREATE INDEX idx_meta_id_subcategoria ON Meta_ahorro (Id_subcategoria);
