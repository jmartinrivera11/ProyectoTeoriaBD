CREATE TABLE Usuario (
    Id_usuario VARCHAR(36) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    salario_mensual_base DECIMAL(10,2) NOT NULL,
    estado VARCHAR(20),
    creado_por VARCHAR(50) NOT NULL,
    modificado_por VARCHAR(50),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modificado_en TIMESTAMP
);

CREATE TABLE Presupuesto (
    Id_presupuesto VARCHAR(36) PRIMARY KEY,
    Id_usuario VARCHAR(36),
    nombre VARCHAR(100) NOT NULL,
    anio_inicio INT NOT NULL,
    mes_inicio INT,
    anio_fin INT NOT NULL,
    mes_fin INT,
    total_ingresos DECIMAL(10,2) DEFAULT 0,
    total_gastos DECIMAL(10,2) DEFAULT 0,
    total_ahorro DECIMAL(10,2) DEFAULT 0,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20),
    creado_por VARCHAR(50) NOT NULL,
    modificado_por VARCHAR(50),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modificado_en TIMESTAMP,
    CONSTRAINT fk_presupuesto_usuario FOREIGN KEY (Id_usuario)
        REFERENCES Usuario (Id_usuario)
);

CREATE TABLE Categoria (
    Id_categoria VARCHAR(36) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    tipo VARCHAR(20),
    icono VARCHAR(100),
    color_hex VARCHAR(10),
    orden INT,
    creado_por VARCHAR(50) NOT NULL,
    modificado_por VARCHAR(50),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modificado_en TIMESTAMP
);

CREATE TABLE Subcategoria (
    Id_subcategoria VARCHAR(36) PRIMARY KEY,
    Id_categoria VARCHAR(36),
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    activa BOOLEAN DEFAULT TRUE,
    es_defecto BOOLEAN DEFAULT FALSE,
    creado_por VARCHAR(50) NOT NULL,
    modificado_por VARCHAR(50),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modificado_en TIMESTAMP,
    CONSTRAINT fk_subcategoria_categoria FOREIGN KEY (Id_categoria)
        REFERENCES Categoria (Id_categoria)
);

CREATE TABLE Presupuesto_detalle (
    Id_presupuesto_detalle VARCHAR(36) PRIMARY KEY,
    Id_presupuesto VARCHAR(36),
    Id_subcategoria VARCHAR(36),
    monto_mensual DECIMAL(10,2) NOT NULL,
    observacion VARCHAR(255),
    creado_por VARCHAR(50) NOT NULL,
    modificado_por VARCHAR(50),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modificado_en TIMESTAMP,
    CONSTRAINT fk_detalle_presupuesto FOREIGN KEY (Id_presupuesto)
        REFERENCES Presupuesto (Id_presupuesto),
    CONSTRAINT fk_detalle_subcategoria FOREIGN KEY (Id_subcategoria)
        REFERENCES Subcategoria (Id_subcategoria)
);

CREATE TABLE Obligacion_fija (
    Id_obligacion_fija VARCHAR(36) PRIMARY KEY,
    Id_subcategoria VARCHAR(36),
    Id_usuario VARCHAR(36),
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    monto_mensual DECIMAL(10,2) NOT NULL,
    dia_mes INT,
    vigente BOOLEAN DEFAULT TRUE,
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_fin TIMESTAMP,
    creado_por VARCHAR(50) NOT NULL,
    modificado_por VARCHAR(50),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modificado_en TIMESTAMP,
    CONSTRAINT fk_obligacion_subcategoria FOREIGN KEY (Id_subcategoria)
        REFERENCES Subcategoria (Id_subcategoria),
    CONSTRAINT fk_obligacion_usuario FOREIGN KEY (Id_usuario)
        REFERENCES Usuario (Id_usuario)
);

CREATE TABLE Transaccion (
    Id_transaccion VARCHAR(36) PRIMARY KEY,
    Id_usuario VARCHAR(36),
    Id_presupuesto VARCHAR(36),
    Id_subcategoria VARCHAR(36),
    Id_obligacion_fija VARCHAR(36),
    anio INT NOT NULL,
    mes INT,
    tipo VARCHAR(20),
    descripcion VARCHAR(255),
    monto DECIMAL(10,2) NOT NULL,
    fecha TIMESTAMP NOT NULL,
    metodo_pago VARCHAR(50),
    numero_factura VARCHAR(50),
    observaciones VARCHAR(255),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    creado_por VARCHAR(50) NOT NULL,
    modificado_por VARCHAR(50),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modificado_en TIMESTAMP,
    CONSTRAINT fk_trans_usuario FOREIGN KEY (Id_usuario)
        REFERENCES Usuario (Id_usuario),
    CONSTRAINT fk_trans_presupuesto FOREIGN KEY (Id_presupuesto)
        REFERENCES Presupuesto (Id_presupuesto),
    CONSTRAINT fk_trans_subcategoria FOREIGN KEY (Id_subcategoria)
        REFERENCES Subcategoria (Id_subcategoria),
    CONSTRAINT fk_trans_obligacion FOREIGN KEY (Id_obligacion_fija)
        REFERENCES Obligacion_fija (Id_obligacion_fija)
);

CREATE TABLE Meta_ahorro (
    Id_meta_ahorro VARCHAR(36) PRIMARY KEY,
    Id_usuario VARCHAR(36),
    Id_subcategoria VARCHAR(36),
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    monto_total DECIMAL(10,2) NOT NULL,
    monto_ahorrado DECIMAL(10,2) DEFAULT 0,
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_objetivo TIMESTAMP NOT NULL,
    prioridad VARCHAR(20),
    estado VARCHAR(20),
    creado_por VARCHAR(50) NOT NULL,
    modificado_por VARCHAR(50),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modificado_en TIMESTAMP,
    CONSTRAINT fk_meta_usuario FOREIGN KEY (Id_usuario)
        REFERENCES Usuario (Id_usuario),
    CONSTRAINT fk_meta_subcategoria FOREIGN KEY (Id_subcategoria)
        REFERENCES Subcategoria (Id_subcategoria)
);