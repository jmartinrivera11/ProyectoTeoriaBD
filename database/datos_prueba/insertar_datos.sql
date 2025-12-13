INSERT INTO Usuario (
    Id_usuario,
    nombre,
    apellido,
    correo,
    salario_mensual_base,
    estado,
    creado_por
) VALUES (
    'USR-0001',
    'Pedro',
    'Gonzalez',
    'pedro.gonzalez@example.com',
    35000.00,
    'activo',
    'seed'
);


INSERT INTO Categoria (Id_categoria, nombre, descripcion, tipo, icono, color_hex, orden, creado_por) VALUES
('CAT-ING-01', 'Salario',           'Ingresos por salario mensual',           'ingreso', 'mdi-cash',      '#4CAF50', 1, 'seed');
INSERT INTO Categoria (Id_categoria, nombre, descripcion, tipo, icono, color_hex, orden, creado_por) VALUES
('CAT-ING-02', 'Freelance',         'Ingresos por trabajos adicionales',      'ingreso', 'mdi-briefcase', '#8BC34A', 2, 'seed');
INSERT INTO Categoria (Id_categoria, nombre, descripcion, tipo, icono, color_hex, orden, creado_por) VALUES
('CAT-ING-03', 'Regalos',           'Dinero recibido como regalo',            'ingreso', 'mdi-gift',      '#CDDC39', 3, 'seed');
INSERT INTO Categoria (Id_categoria, nombre, descripcion, tipo, icono, color_hex, orden, creado_por) VALUES
('CAT-ING-04', 'Reembolsos',        'Reembolsos de gastos',                   'ingreso', 'mdi-cash-refund','#9CCC65', 4, 'seed');



INSERT INTO Categoria (Id_categoria, nombre, descripcion, tipo, icono, color_hex, orden, creado_por) VALUES
('CAT-GAS-01', 'Alquiler',          'Pago de vivienda',                        'gasto',   'mdi-home',      '#F44336', 10, 'seed');
INSERT INTO Categoria (Id_categoria, nombre, descripcion, tipo, icono, color_hex, orden, creado_por) VALUES
('CAT-GAS-02', 'Servicios publicos','Luz, agua, internet, telefono',          'gasto',   'mdi-flash',     '#FF9800', 11, 'seed');
INSERT INTO Categoria (Id_categoria, nombre, descripcion, tipo, icono, color_hex, orden, creado_por) VALUES
('CAT-GAS-03', 'Supermercado',      'Compra de comida y despensa',            'gasto',   'mdi-cart',      '#FFB300', 12, 'seed');
INSERT INTO Categoria (Id_categoria, nombre, descripcion, tipo, icono, color_hex, orden, creado_por) VALUES
('CAT-GAS-04', 'Transporte',        'Gasolina, buses, taxis',                 'gasto',   'mdi-car',       '#FF7043', 13, 'seed');
INSERT INTO Categoria (Id_categoria, nombre, descripcion, tipo, icono, color_hex, orden, creado_por) VALUES
('CAT-GAS-05', 'Comida fuera',      'Restaurantes, cafes, snacks',            'gasto',   'mdi-food',      '#E64A19', 14, 'seed');
INSERT INTO Categoria (Id_categoria, nombre, descripcion, tipo, icono, color_hex, orden, creado_por) VALUES
('CAT-GAS-06', 'Salud',             'Medicinas, consultas, seguros medicos',  'gasto',   'mdi-hospital',  '#E91E63', 15, 'seed');
INSERT INTO Categoria (Id_categoria, nombre, descripcion, tipo, icono, color_hex, orden, creado_por) VALUES
('CAT-GAS-07', 'Educacion',         'Cursos, libros, colegiaturas',           'gasto',   'mdi-school',    '#9C27B0', 16, 'seed');
INSERT INTO Categoria (Id_categoria, nombre, descripcion, tipo, icono, color_hex, orden, creado_por) VALUES
('CAT-GAS-08', 'Entretenimiento',   'Cine, streaming, ocio',                  'gasto',   'mdi-movie',     '#3F51B5', 17, 'seed');
INSERT INTO Categoria (Id_categoria, nombre, descripcion, tipo, icono, color_hex, orden, creado_por) VALUES
('CAT-GAS-09', 'Suscripciones',     'Servicios mensuales (apps, musica, etc)','gasto',   'mdi-repeat',    '#2196F3', 18, 'seed');



INSERT INTO Categoria (Id_categoria, nombre, descripcion, tipo, icono, color_hex, orden, creado_por) VALUES
('CAT-AHO-01', 'Fondo de emergencia', 'Ahorro para imprevistos',              'ahorro',  'mdi-shield',    '#009688', 30, 'seed');
INSERT INTO Categoria (Id_categoria, nombre, descripcion, tipo, icono, color_hex, orden, creado_por) VALUES
('CAT-AHO-02', 'Ahorro a largo plazo','Metas grandes (auto, casa, etc.)',     'ahorro',  'mdi-bank',      '#00796B', 31, 'seed');
INSERT INTO Categoria (Id_categoria, nombre, descripcion, tipo, icono, color_hex, orden, creado_por) VALUES
('CAT-AHO-03', 'Inversiones',         'Aportes a inversiones',                'ahorro',  'mdi-chart-line','#00695C', 32, 'seed');



INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-ALQ-01', 'CAT-GAS-01', 'Alquiler apartamento', 'Renta mensual del apartamento', TRUE, TRUE, 'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-SER-01', 'CAT-GAS-02', 'Electricidad',         'Pago mensual de energia',      TRUE, TRUE, 'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-SER-02', 'CAT-GAS-02', 'Agua',                 'Servicio de agua potable',     TRUE, FALSE,'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-SER-03', 'CAT-GAS-02', 'Internet',             'Servicio de internet hogar',   TRUE, TRUE, 'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-SER-04', 'CAT-GAS-02', 'Telefono',             'Plan de telefono movil',       TRUE, FALSE,'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-SUP-01', 'CAT-GAS-03', 'Supermercado grande',  'Compra grande de despensa',    TRUE, TRUE, 'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-SUP-02', 'CAT-GAS-03', 'Compras rapidas',      'Compras pequenas de comida',   TRUE, FALSE,'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-TRA-01', 'CAT-GAS-04', 'Gasolina',             'Combustible para auto',        TRUE, TRUE, 'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-TRA-02', 'CAT-GAS-04', 'Transporte publico',   'Bus, taxi, etc.',              TRUE, FALSE,'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-COM-01', 'CAT-GAS-05', 'Restaurante',          'Comidas en restaurante',       TRUE, TRUE, 'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-COM-02', 'CAT-GAS-05', 'Cafe/snacks',          'Cafes y snacks',               TRUE, FALSE,'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-SAL-01', 'CAT-GAS-06', 'Medicinas',            'Compra de medicinas',          TRUE, TRUE, 'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-SAL-02', 'CAT-GAS-06', 'Consultas',            'Consultas medicas',            TRUE, FALSE,'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-EDU-01', 'CAT-GAS-07', 'Cursos online',        'Cursos en linea',              TRUE, TRUE, 'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-EDU-02', 'CAT-GAS-07', 'Libros',               'Compra de libros',             TRUE, FALSE,'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-ENT-01', 'CAT-GAS-08', 'Cine',                 'Entradas de cine',             TRUE, FALSE,'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-ENT-02', 'CAT-GAS-08', 'Streaming',            'Plataformas de video',         TRUE, TRUE, 'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-SUS-01', 'CAT-GAS-09', 'Musica',               'Servicios de musica',          TRUE, FALSE,'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-SUS-02', 'CAT-GAS-09', 'Software',             'Apps y herramientas',          TRUE, TRUE, 'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-ING-01', 'CAT-ING-01', 'Salario base',         'Salario mensual fijo',         TRUE, TRUE, 'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-ING-02', 'CAT-ING-02', 'Proyecto freelance',   'Trabajos adicionales',         TRUE, TRUE, 'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-ING-03', 'CAT-ING-03', 'Regalo familiar',      'Regalos de familia',           TRUE, FALSE,'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-ING-04', 'CAT-ING-04', 'Reembolso empresa',    'Reembolso de gastos',          TRUE, FALSE,'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-AHO-01', 'CAT-AHO-01', 'Fondo emergencia',     'Ahorro para emergencias',      TRUE, TRUE, 'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-AHO-02', 'CAT-AHO-02', 'Ahorro auto',          'Meta para auto',               TRUE, FALSE,'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-AHO-03', 'CAT-AHO-02', 'Ahorro estudios',      'Meta para estudios',           TRUE, FALSE,'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-AHO-04', 'CAT-AHO-03', 'Inversion indexada',   'Fondos indexados',             TRUE, TRUE, 'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-AHO-05', 'CAT-AHO-03', 'Inversion local',      'Inversiones locales',          TRUE, FALSE,'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-OTR-01', 'CAT-GAS-08', 'Juegos',               'Videojuegos u otros',          TRUE, FALSE,'seed');
INSERT INTO Subcategoria (Id_subcategoria, Id_categoria, nombre, descripcion, activa, es_defecto, creado_por) VALUES
('SUB-OTR-02', 'CAT-GAS-03', 'Snacks hogar',         'Snacks para casa',             TRUE, FALSE,'seed');



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
    fecha_creacion,
    estado,
    creado_por
) VALUES
('PRE-2025-03', 'USR-0001', 'Presupuesto marzo 2025', 2025, 3, 2025, 3, 0, 0, 0, '2025-02-25', 'activo', 'seed');
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
    fecha_creacion,
    estado,
    creado_por
) VALUES
('PRE-2025-04', 'USR-0001', 'Presupuesto abril 2025', 2025, 4, 2025, 4, 0, 0, 0, '2025-03-25', 'activo', 'seed');



INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-MAR-01', 'PRE-2025-03', 'SUB-ALQ-01',  9000.00, 'Renta mensual',       'seed');
INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-MAR-02', 'PRE-2025-03', 'SUB-SER-01',  1200.00, 'Electricidad',        'seed');
INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-MAR-03', 'PRE-2025-03', 'SUB-SER-02',   600.00, 'Agua',                'seed');
INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-MAR-04', 'PRE-2025-03', 'SUB-SER-03',  1000.00, 'Internet hogar',      'seed');
INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-MAR-05', 'PRE-2025-03', 'SUB-TRA-01',  2500.00, 'Gasolina',            'seed');
INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-MAR-06', 'PRE-2025-03', 'SUB-SUP-01',  5000.00, 'Supermercado grande', 'seed');
INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-MAR-07', 'PRE-2025-03', 'SUB-SUP-02',  1500.00, 'Compras extra',       'seed');
INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-MAR-08', 'PRE-2025-03', 'SUB-COM-01',  2000.00, 'Comidas fuera',       'seed');
INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-MAR-09', 'PRE-2025-03', 'SUB-ENT-02',   500.00, 'Streaming',           'seed');
INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-MAR-10', 'PRE-2025-03', 'SUB-AHO-01',  3000.00, 'Fondo emergencia',    'seed');
INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-MAR-11', 'PRE-2025-03', 'SUB-AHO-02',  1500.00, 'Ahorro auto',         'seed');
INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-MAR-12', 'PRE-2025-03', 'SUB-AHO-04',  1000.00, 'Inversion indexada',  'seed');



INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-ABR-01', 'PRE-2025-04', 'SUB-ALQ-01',  9000.00, 'Renta mensual',       'seed');
INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-ABR-02', 'PRE-2025-04', 'SUB-SER-01',  1300.00, 'Electricidad',        'seed');
INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-ABR-03', 'PRE-2025-04', 'SUB-SER-02',   650.00, 'Agua',                'seed');
INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-ABR-04', 'PRE-2025-04', 'SUB-SER-03',  1000.00, 'Internet hogar',      'seed');
INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-ABR-05', 'PRE-2025-04', 'SUB-TRA-01',  2600.00, 'Gasolina',            'seed');
INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-ABR-06', 'PRE-2025-04', 'SUB-SUP-01',  5200.00, 'Supermercado grande', 'seed');
INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-ABR-07', 'PRE-2025-04', 'SUB-SUP-02',  1600.00, 'Compras extra',       'seed');
INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-ABR-08', 'PRE-2025-04', 'SUB-COM-01',  2100.00, 'Comidas fuera',       'seed');
INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-ABR-09', 'PRE-2025-04', 'SUB-ENT-02',   500.00, 'Streaming',           'seed');
INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-ABR-10', 'PRE-2025-04', 'SUB-AHO-01',  3200.00, 'Fondo emergencia',    'seed');
INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-ABR-11', 'PRE-2025-04', 'SUB-AHO-02',  1500.00, 'Ahorro auto',         'seed');
INSERT INTO Presupuesto_detalle (
    Id_presupuesto_detalle,
    Id_presupuesto,
    Id_subcategoria,
    monto_mensual,
    observacion,
    creado_por
) VALUES
('PDET-ABR-12', 'PRE-2025-04', 'SUB-AHO-04',  1200.00, 'Inversion indexada',  'seed');



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
) VALUES
('OBL-0001', 'SUB-ALQ-01', 'USR-0001', 'Renta apartamento',    'Pago de alquiler mensual',          9000.00, 1,  TRUE, '2024-01-01', NULL, 'seed');
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
) VALUES
('OBL-0002', 'SUB-SER-01', 'USR-0001', 'Electricidad hogar',   'Factura de energia electrica',      1200.00, 5,  TRUE, '2024-01-01', NULL, 'seed');
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
) VALUES
('OBL-0003', 'SUB-SER-03', 'USR-0001', 'Internet hogar',       'Servicio de internet',              1000.00, 10, TRUE, '2024-01-01', NULL, 'seed');
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
) VALUES
('OBL-0004', 'SUB-SUS-02', 'USR-0001', 'Suscripcion software', 'Herramientas de productividad',      400.00, 15, TRUE, '2024-01-01', NULL, 'seed');
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
) VALUES
('OBL-0005', 'SUB-ENT-02', 'USR-0001', 'Streaming video',      'Plataforma de series y peliculas',   300.00, 20, TRUE, '2024-01-01', NULL, 'seed');
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
) VALUES
('OBL-0006', 'SUB-SAL-01', 'USR-0001', 'Seguro medico',        'Pago mensual de seguro medico',     1500.00, 25, TRUE, '2024-01-01', NULL, 'seed');



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
) VALUES
('META-0001', 'USR-0001', 'SUB-AHO-01', 'Fondo de emergencia 3 meses', 'Ahorro para cubrir 3 meses de gastos basicos', 30000.00, 5000.00, '2025-01-01', '2025-12-31', 'alta',   'en_progreso', 'seed');
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
) VALUES
('META-0002', 'USR-0001', 'SUB-AHO-02', 'Ahorro para auto',            'Ahorro para enganche de auto',                80000.00, 10000.00,'2025-01-01', '2026-06-30', 'media',  'en_progreso', 'seed');
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
) VALUES
('META-0003', 'USR-0001', 'SUB-AHO-04', 'Inversion inicial',           'Aporte inicial a fondo indexado',             20000.00, 20000.00,'2024-09-01', '2025-03-31', 'alta',   'completada',  'seed');



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
) VALUES
('TRA-ING-001', 'USR-0001', 'PRE-2025-03', 'SUB-ING-01', NULL, 2025, 3, 'ingreso', 'Salario marzo 2025', 35000.00, '2025-03-01', 'transferencia', NULL, 'Pago de salario', 'seed');
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
) VALUES
('TRA-ING-002', 'USR-0001', 'PRE-2025-03', 'SUB-ING-02', NULL, 2025, 3, 'ingreso', 'Proyecto freelance marzo', 3500.00, '2025-03-15', 'transferencia', NULL, 'Trabajo adicional', 'seed');
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
) VALUES
('TRA-ING-003', 'USR-0001', 'PRE-2025-03', 'SUB-ING-03', NULL, 2025, 3, 'ingreso', 'Regalo cumpleanos', 1500.00, '2025-03-20', 'efectivo', NULL, 'Regalo de familiar', 'seed');
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
) VALUES
('TRA-ING-004', 'USR-0001', 'PRE-2025-04', 'SUB-ING-01', NULL, 2025, 4, 'ingreso', 'Salario abril 2025', 35000.00, '2025-04-01', 'transferencia', NULL, 'Pago de salario', 'seed');
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
) VALUES
('TRA-ING-005', 'USR-0001', 'PRE-2025-04', 'SUB-ING-02', NULL, 2025, 4, 'ingreso', 'Proyecto freelance abril', 2500.00, '2025-04-18', 'transferencia', NULL, 'Trabajo adicional', 'seed');



INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-OBL-001', 'USR-0001', 'PRE-2025-03', 'SUB-ALQ-01', 'OBL-0001', 2025, 3, 'gasto', 'Renta marzo',        9000.00, '2025-03-01', 'transferencia', 'FAC-ALQ-202503', 'Pago renta marzo', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-OBL-002', 'USR-0001', 'PRE-2025-03', 'SUB-SER-01', 'OBL-0002', 2025, 3, 'gasto', 'Electricidad marzo', 1200.00, '2025-03-05', 'tarjeta',      'FAC-EL-202503',  'Pago luz marzo',   'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-OBL-003', 'USR-0001', 'PRE-2025-03', 'SUB-SER-03', 'OBL-0003', 2025, 3, 'gasto', 'Internet marzo',     1000.00, '2025-03-10', 'tarjeta',      'FAC-INT-202503', 'Pago internet',   'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-OBL-004', 'USR-0001', 'PRE-2025-03', 'SUB-SUS-02', 'OBL-0004', 2025, 3, 'gasto', 'Software marzo',      400.00, '2025-03-15', 'tarjeta',      'FAC-SW-202503',  'Suscripcion',     'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-OBL-005', 'USR-0001', 'PRE-2025-03', 'SUB-ENT-02', 'OBL-0005', 2025, 3, 'gasto', 'Streaming marzo',     300.00, '2025-03-20', 'tarjeta',      'FAC-STR-202503', 'Streaming video', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-OBL-006', 'USR-0001', 'PRE-2025-03', 'SUB-SAL-01', 'OBL-0006', 2025, 3, 'gasto', 'Seguro medico marzo',1500.00, '2025-03-25', 'transferencia','FAC-SAL-202503', 'Seguro medico',   'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-OBL-007', 'USR-0001', 'PRE-2025-04', 'SUB-ALQ-01', 'OBL-0001', 2025, 4, 'gasto', 'Renta abril',        9000.00, '2025-04-01', 'transferencia', 'FAC-ALQ-202504', 'Pago renta abril','seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-OBL-008', 'USR-0001', 'PRE-2025-04', 'SUB-SER-01', 'OBL-0002', 2025, 4, 'gasto', 'Electricidad abril', 1300.00, '2025-04-05', 'tarjeta',      'FAC-EL-202504',  'Pago luz abril',  'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-OBL-009', 'USR-0001', 'PRE-2025-04', 'SUB-SER-03', 'OBL-0003', 2025, 4, 'gasto', 'Internet abril',     1000.00, '2025-04-10', 'tarjeta',      'FAC-INT-202504', 'Pago internet',   'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-OBL-010', 'USR-0001', 'PRE-2025-04', 'SUB-SUS-02', 'OBL-0004', 2025, 4, 'gasto', 'Software abril',      400.00, '2025-04-15', 'tarjeta',      'FAC-SW-202504',  'Suscripcion',     'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-OBL-011', 'USR-0001', 'PRE-2025-04', 'SUB-ENT-02', 'OBL-0005', 2025, 4, 'gasto', 'Streaming abril',     300.00, '2025-04-20', 'tarjeta',      'FAC-STR-202504', 'Streaming video', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-OBL-012', 'USR-0001', 'PRE-2025-04', 'SUB-SAL-01', 'OBL-0006', 2025, 4, 'gasto', 'Seguro medico abril',1500.00, '2025-04-25', 'transferencia','FAC-SAL-202504', 'Seguro medico',   'seed');



INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-001', 'USR-0001', 'PRE-2025-03', 'SUB-SUP-01', NULL, 2025, 3, 'gasto', 'Supermercado quincena', 2500.00, '2025-03-08', 'tarjeta', 'SUP-20250308', 'Compra grande', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-002', 'USR-0001', 'PRE-2025-03', 'SUB-SUP-02', NULL, 2025, 3, 'gasto', 'Compras rapidas',        600.00, '2025-03-12', 'efectivo', NULL,          'Snacks y extras', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-003', 'USR-0001', 'PRE-2025-03', 'SUB-TRA-01', NULL, 2025, 3, 'gasto', 'Gasolina',              1200.00, '2025-03-09', 'tarjeta', 'GAS-20250309', 'Llenado tanque', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-004', 'USR-0001', 'PRE-2025-03', 'SUB-TRA-02', NULL, 2025, 3, 'gasto', 'Taxi',                   250.00, '2025-03-18', 'efectivo', NULL,          'Viaje a cita',    'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-005', 'USR-0001', 'PRE-2025-03', 'SUB-COM-01', NULL, 2025, 3, 'gasto', 'Cena con amigos',       800.00, '2025-03-22', 'tarjeta', 'COM-20250322', 'Restaurante',     'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-006', 'USR-0001', 'PRE-2025-03', 'SUB-ENT-01', NULL, 2025, 3, 'gasto', 'Cine',                   300.00, '2025-03-23', 'efectivo', NULL,          'Entradas cine',   'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-007', 'USR-0001', 'PRE-2025-04', 'SUB-SUP-01', NULL, 2025, 4, 'gasto', 'Supermercado quincena', 2600.00, '2025-04-07', 'tarjeta', 'SUP-20250407', 'Compra grande',   'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-008', 'USR-0001', 'PRE-2025-04', 'SUB-SUP-02', NULL, 2025, 4, 'gasto', 'Compras rapidas',        700.00, '2025-04-16', 'efectivo', NULL,          'Snacks y extras', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-009', 'USR-0001', 'PRE-2025-04', 'SUB-TRA-01', NULL, 2025, 4, 'gasto', 'Gasolina',              1300.00, '2025-04-10', 'tarjeta', 'GAS-20250410', 'Llenado tanque', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-010', 'USR-0001', 'PRE-2025-04', 'SUB-COM-01', NULL, 2025, 4, 'gasto', 'Almuerzo trabajo',      450.00, '2025-04-11', 'tarjeta', 'COM-20250411', 'Restaurante',     'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-011', 'USR-0001', 'PRE-2025-04', 'SUB-ENT-01', NULL, 2025, 4, 'gasto', 'Cine',                   320.00, '2025-04-19', 'efectivo', NULL,          'Entradas cine',   'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-012', 'USR-0001', 'PRE-2025-04', 'SUB-ENT-01', NULL, 2025, 4, 'gasto', 'Juegos',                 500.00, '2025-04-21', 'tarjeta', 'ENT-20250421', 'Videojuegos',     'seed');



INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-AHO-001', 'USR-0001', 'PRE-2025-03', 'SUB-AHO-01', NULL, 2025, 3, 'ahorro', 'Aporte fondo emergencia', 1500.00, '2025-03-05', 'transferencia', NULL, 'Aporte a META-0001', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-AHO-002', 'USR-0001', 'PRE-2025-03', 'SUB-AHO-02', NULL, 2025, 3, 'ahorro', 'Aporte ahorro auto',     1000.00, '2025-03-15', 'transferencia', NULL, 'Aporte a META-0002', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-AHO-003', 'USR-0001', 'PRE-2025-03', 'SUB-AHO-04', NULL, 2025, 3, 'ahorro', 'Aporte inversion',       800.00,  '2025-03-25', 'transferencia', NULL, 'Aporte a META-0003', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-AHO-004', 'USR-0001', 'PRE-2025-04', 'SUB-AHO-01', NULL, 2025, 4, 'ahorro', 'Aporte fondo emergencia', 1600.00,'2025-04-05', 'transferencia', NULL, 'Aporte a META-0001', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-AHO-005', 'USR-0001', 'PRE-2025-04', 'SUB-AHO-02', NULL, 2025, 4, 'ahorro', 'Aporte ahorro auto',     1000.00,'2025-04-15', 'transferencia', NULL, 'Aporte a META-0002', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-AHO-006', 'USR-0001', 'PRE-2025-04', 'SUB-AHO-04', NULL, 2025, 4, 'ahorro', 'Aporte inversion',       900.00, '2025-04-25', 'transferencia', NULL, 'Aporte a META-0003', 'seed');



INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-101', 'USR-0001', 'PRE-2025-03', 'SUB-SUP-01', NULL, 2025, 3, 'gasto', 'Supermercado fin de mes', 1800.00, '2025-03-28', 'tarjeta', 'SUP-20250328', 'Compra de despensa adicional', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-102', 'USR-0001', 'PRE-2025-03', 'SUB-SUP-02', NULL, 2025, 3, 'gasto', 'Compras pequenas',         350.00,  '2025-03-06', 'efectivo', NULL,           'Snacks y bebidas',          'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-103', 'USR-0001', 'PRE-2025-03', 'SUB-TRA-01', NULL, 2025, 3, 'gasto', 'Gasolina adicional',       700.00,  '2025-03-19', 'tarjeta', 'GAS-20250319',  'Viajes extras',             'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-104', 'USR-0001', 'PRE-2025-03', 'SUB-TRA-02', NULL, 2025, 3, 'gasto', 'Bus urbano',               120.00,  '2025-03-04', 'efectivo', NULL,           'Traslado dentro de la ciudad', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-105', 'USR-0001', 'PRE-2025-03', 'SUB-COM-02', NULL, 2025, 3, 'gasto', 'Cafe con amigos',          220.00,  '2025-03-03', 'tarjeta', 'CAF-20250303',  'Cafe y pastel',             'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-106', 'USR-0001', 'PRE-2025-03', 'SUB-SAL-02', NULL, 2025, 3, 'gasto', 'Consulta medica general',  900.00,  '2025-03-14', 'tarjeta', 'MED-20250314',  'Chequeo general',           'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-107', 'USR-0001', 'PRE-2025-03', 'SUB-EDU-01', NULL, 2025, 3, 'gasto', 'Curso online corto',       600.00,  '2025-03-16', 'tarjeta', 'EDU-20250316',  'Curso de actualizacion',    'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-108', 'USR-0001', 'PRE-2025-03', 'SUB-EDU-02', NULL, 2025, 3, 'gasto', 'Compra de libro',          450.00,  '2025-03-11', 'tarjeta', 'LIB-20250311',  'Libro de estudio',          'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-109', 'USR-0001', 'PRE-2025-03', 'SUB-ENT-01', NULL, 2025, 3, 'gasto', 'Noche de juegos',          280.00,  '2025-03-29', 'efectivo', NULL,           'Juegos de mesa',            'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-110', 'USR-0001', 'PRE-2025-03', 'SUB-OTR-01', NULL, 2025, 3, 'gasto', 'Compra videojuego',        900.00,  '2025-03-13', 'tarjeta', 'JUE-20250313',  'Videojuego digital',        'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-111', 'USR-0001', 'PRE-2025-03', 'SUB-OTR-02', NULL, 2025, 3, 'gasto', 'Snacks para casa',         260.00,  '2025-03-20', 'efectivo', NULL,           'Snacks varios',             'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-112', 'USR-0001', 'PRE-2025-03', 'SUB-COM-01', NULL, 2025, 3, 'gasto', 'Almuerzo rapido',          320.00,  '2025-03-26', 'tarjeta', 'COM-20250326',  'Menu ejecutivo',            'seed');



INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-113', 'USR-0001', 'PRE-2025-04', 'SUB-SUP-01', NULL, 2025, 4, 'gasto', 'Supermercado fin de mes', 1900.00, '2025-04-27', 'tarjeta', 'SUP-20250427', 'Compra de despensa adicional', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-114', 'USR-0001', 'PRE-2025-04', 'SUB-SUP-02', NULL, 2025, 4, 'gasto', 'Compras pequenas',         380.00,  '2025-04-06', 'efectivo', NULL,           'Snacks y bebidas',          'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-115', 'USR-0001', 'PRE-2025-04', 'SUB-TRA-01', NULL, 2025, 4, 'gasto', 'Gasolina adicional',       750.00,  '2025-04-18', 'tarjeta', 'GAS-20250418',  'Viajes extras',             'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-116', 'USR-0001', 'PRE-2025-04', 'SUB-TRA-02', NULL, 2025, 4, 'gasto', 'Taxi noche',               300.00,  '2025-04-09', 'efectivo', NULL,           'Salida nocturna',           'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-117', 'USR-0001', 'PRE-2025-04', 'SUB-COM-02', NULL, 2025, 4, 'gasto', 'Cafe para estudiar',       210.00,  '2025-04-03', 'tarjeta', 'CAF-20250403',  'Cafe y snack',              'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-118', 'USR-0001', 'PRE-2025-04', 'SUB-SAL-02', NULL, 2025, 4, 'gasto', 'Consulta dental',          950.00,  '2025-04-14', 'tarjeta', 'MED-20250414',  'Revision dental',           'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-119', 'USR-0001', 'PRE-2025-04', 'SUB-EDU-01', NULL, 2025, 4, 'gasto', 'Curso de finanzas',        700.00,  '2025-04-20', 'tarjeta', 'EDU-20250420',  'Curso corto de finanzas',   'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-120', 'USR-0001', 'PRE-2025-04', 'SUB-EDU-02', NULL, 2025, 4, 'gasto', 'Compra de libro',          420.00,  '2025-04-10', 'tarjeta', 'LIB-20250410',  'Libro de productividad',    'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-121', 'USR-0001', 'PRE-2025-04', 'SUB-ENT-01', NULL, 2025, 4, 'gasto', 'Noche de juegos',          300.00,  '2025-04-24', 'efectivo', NULL,           'Juegos con amigos',         'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-122', 'USR-0001', 'PRE-2025-04', 'SUB-OTR-01', NULL, 2025, 4, 'gasto', 'Compra videojuego',        850.00,  '2025-04-12', 'tarjeta', 'JUE-20250412',  'Videojuego digital',        'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-123', 'USR-0001', 'PRE-2025-04', 'SUB-OTR-02', NULL, 2025, 4, 'gasto', 'Snacks para casa',         280.00,  '2025-04-16', 'efectivo', NULL,           'Snacks varios',             'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-124', 'USR-0001', 'PRE-2025-04', 'SUB-COM-01', NULL, 2025, 4, 'gasto', 'Cena informal',            450.00,  '2025-04-22', 'tarjeta', 'COM-20250422',  'Cena rapida',               'seed');



INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-ING-101', 'USR-0001', 'PRE-2025-03', 'SUB-ING-02', NULL, 2025, 3, 'ingreso', 'Freelance diseno logo',  1800.00, '2025-03-07', 'transferencia', NULL, 'Trabajo freelance pequeno', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-ING-102', 'USR-0001', 'PRE-2025-03', 'SUB-ING-04', NULL, 2025, 3, 'ingreso', 'Reembolso empresa',      600.00,  '2025-03-17', 'transferencia', NULL, 'Reembolso de gastos',       'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-ING-103', 'USR-0001', 'PRE-2025-03', 'SUB-ING-02', NULL, 2025, 3, 'ingreso', 'Job puntual fin de mes', 900.00,  '2025-03-27', 'transferencia', NULL, 'Trabajo extra',             'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-ING-104', 'USR-0001', 'PRE-2025-04', 'SUB-ING-02', NULL, 2025, 4, 'ingreso', 'Freelance pagina web',  2200.00, '2025-04-08', 'transferencia', NULL, 'Proyecto web',              'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-ING-105', 'USR-0001', 'PRE-2025-04', 'SUB-ING-04', NULL, 2025, 4, 'ingreso', 'Reembolso viaticos',     700.00,  '2025-04-18', 'transferencia', NULL, 'Reembolso viaje',           'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-ING-106', 'USR-0001', 'PRE-2025-04', 'SUB-ING-03', NULL, 2025, 4, 'ingreso', 'Regalo familiar',        800.00,  '2025-04-27', 'efectivo',      NULL, 'Regalo de familia',        'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-ING-107', 'USR-0001', 'PRE-2025-04', 'SUB-ING-02', NULL, 2025, 4, 'ingreso', 'Trabajo freelance corto', 950.00, '2025-04-20', 'transferencia', NULL, 'Trabajo ocasional',         'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-ING-108', 'USR-0001', 'PRE-2025-03', 'SUB-ING-02', NULL, 2025, 3, 'ingreso', 'Freelance correccion texto', 500.00, '2025-03-10', 'transferencia', NULL, 'Correccion de documento', 'seed');



INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-AHO-101', 'USR-0001', 'PRE-2025-03', 'SUB-AHO-01', NULL, 2025, 3, 'ahorro', 'Aporte extra emergencia', 700.00,  '2025-03-09',  'transferencia', NULL, 'Extra a META-0001', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-AHO-102', 'USR-0001', 'PRE-2025-03', 'SUB-AHO-02', NULL, 2025, 3, 'ahorro', 'Aporte extra auto',      500.00,  '2025-03-19',  'transferencia', NULL, 'Extra a META-0002', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-AHO-103', 'USR-0001', 'PRE-2025-03', 'SUB-AHO-04', NULL, 2025, 3, 'ahorro', 'Aporte extra inversion', 600.00,  '2025-03-21',  'transferencia', NULL, 'Extra a META-0003', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-AHO-104', 'USR-0001', 'PRE-2025-04', 'SUB-AHO-01', NULL, 2025, 4, 'ahorro', 'Aporte extra emergencia', 800.00, '2025-04-07',  'transferencia', NULL, 'Extra a META-0001', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-AHO-105', 'USR-0001', 'PRE-2025-04', 'SUB-AHO-02', NULL, 2025, 4, 'ahorro', 'Aporte extra auto',      600.00,  '2025-04-17',  'transferencia', NULL, 'Extra a META-0002', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-AHO-106', 'USR-0001', 'PRE-2025-04', 'SUB-AHO-04', NULL, 2025, 4, 'ahorro', 'Aporte extra inversion', 650.00,  '2025-04-23',  'transferencia', NULL, 'Extra a META-0003', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-AHO-107', 'USR-0001', 'PRE-2025-03', 'SUB-AHO-03', NULL, 2025, 3, 'ahorro', 'Ahorro estudios',        400.00,  '2025-03-18',  'transferencia', NULL, 'Aporte a estudios', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-AHO-108', 'USR-0001', 'PRE-2025-04', 'SUB-AHO-03', NULL, 2025, 4, 'ahorro', 'Ahorro estudios',        450.00,  '2025-04-18',  'transferencia', NULL, 'Aporte a estudios', 'seed');



INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-201', 'USR-0001', 'PRE-2025-03', 'SUB-SUP-02', NULL, 2025, 3, 'gasto', 'Compras rapidas noche',   300.00, '2025-03-02',  'efectivo', NULL, 'Snacks noche',        'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-202', 'USR-0001', 'PRE-2025-03', 'SUB-COM-02', NULL, 2025, 3, 'gasto', 'Cafe estudio',           180.00, '2025-03-05',  'tarjeta', 'CAF-20250305', 'Cafe para estudiar', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-203', 'USR-0001', 'PRE-2025-03', 'SUB-ENT-01', NULL, 2025, 3, 'gasto', 'Renta pelicula',         120.00, '2025-03-15',  'tarjeta', NULL, 'Renta en linea',       'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-204', 'USR-0001', 'PRE-2025-03', 'SUB-OTR-01', NULL, 2025, 3, 'gasto', 'Accesorios juego',       350.00, '2025-03-21',  'tarjeta', NULL, 'Accesorios gaming',   'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-205', 'USR-0001', 'PRE-2025-03', 'SUB-SAL-01', NULL, 2025, 3, 'gasto', 'Medicinas resfriado',    280.00, '2025-03-24',  'tarjeta', NULL, 'Medicamentos varios', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-206', 'USR-0001', 'PRE-2025-03', 'SUB-EDU-02', NULL, 2025, 3, 'gasto', 'Libro motivacion',       320.00, '2025-03-30',  'tarjeta', NULL, 'Libro motivacional',   'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-207', 'USR-0001', 'PRE-2025-04', 'SUB-SUP-02', NULL, 2025, 4, 'gasto', 'Compras rapidas noche',  320.00, '2025-04-02',  'efectivo', NULL, 'Snacks noche',        'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-208', 'USR-0001', 'PRE-2025-04', 'SUB-COM-02', NULL, 2025, 4, 'gasto', 'Cafe estudio',           190.00, '2025-04-05',  'tarjeta', 'CAF-20250405', 'Cafe para estudiar', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-209', 'USR-0001', 'PRE-2025-04', 'SUB-ENT-01', NULL, 2025, 4, 'gasto', 'Renta pelicula',         130.00, '2025-04-15',  'tarjeta', NULL, 'Renta en linea',       'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-210', 'USR-0001', 'PRE-2025-04', 'SUB-OTR-01', NULL, 2025, 4, 'gasto', 'Accesorios juego',       360.00, '2025-04-21',  'tarjeta', NULL, 'Accesorios gaming',   'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-211', 'USR-0001', 'PRE-2025-04', 'SUB-SAL-01', NULL, 2025, 4, 'gasto', 'Medicinas alergia',      300.00, '2025-04-24',  'tarjeta', NULL, 'Medicamentos varios', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-212', 'USR-0001', 'PRE-2025-04', 'SUB-EDU-02', NULL, 2025, 4, 'gasto', 'Libro tecnico',          380.00, '2025-04-29',  'tarjeta', NULL, 'Libro tecnico',       'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-213', 'USR-0001', 'PRE-2025-03', 'SUB-ENT-02', 'OBL-0005', 2025, 3, 'gasto', 'Streaming adicional', 50.00, '2025-03-25', 'tarjeta', NULL, 'Consumo extra streaming', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-214', 'USR-0001', 'PRE-2025-04', 'SUB-ENT-02', 'OBL-0005', 2025, 4, 'gasto', 'Streaming adicional', 60.00, '2025-04-25', 'tarjeta', NULL, 'Consumo extra streaming', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-215', 'USR-0001', 'PRE-2025-03', 'SUB-SUS-01', NULL, 2025, 3, 'gasto', 'Musica en linea',        200.00, '2025-03-09',  'tarjeta', NULL, 'Pago plataforma musica', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-216', 'USR-0001', 'PRE-2025-04', 'SUB-SUS-01', NULL, 2025, 4, 'gasto', 'Musica en linea',        200.00, '2025-04-09',  'tarjeta', NULL, 'Pago plataforma musica', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-217', 'USR-0001', 'PRE-2025-03', 'SUB-SUP-01', NULL, 2025, 3, 'gasto', 'Compra frutas',          420.00, '2025-03-18',  'efectivo', NULL, 'Frutas y verduras', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-218', 'USR-0001', 'PRE-2025-04', 'SUB-SUP-01', NULL, 2025, 4, 'gasto', 'Compra frutas',          430.00, '2025-04-18',  'efectivo', NULL, 'Frutas y verduras', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-219', 'USR-0001', 'PRE-2025-03', 'SUB-COM-01', NULL, 2025, 3, 'gasto', 'Cena rapida',            280.00, '2025-03-07',  'tarjeta', NULL, 'Comida rapida', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-220', 'USR-0001', 'PRE-2025-04', 'SUB-COM-01', NULL, 2025, 4, 'gasto', 'Cena rapida',            290.00, '2025-04-07',  'tarjeta', NULL, 'Comida rapida', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-221', 'USR-0001', 'PRE-2025-03', 'SUB-TRA-02', NULL, 2025, 3, 'gasto', 'Bus al trabajo',         100.00, '2025-03-01',  'efectivo', NULL, 'Transporte diario', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-222', 'USR-0001', 'PRE-2025-04', 'SUB-TRA-02', NULL, 2025, 4, 'gasto', 'Bus al trabajo',         100.00, '2025-04-01',  'efectivo', NULL, 'Transporte diario', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-223', 'USR-0001', 'PRE-2025-03', 'SUB-SAL-02', NULL, 2025, 3, 'gasto', 'Consulta rapida',        500.00, '2025-03-05',  'tarjeta', NULL, 'Consulta menor', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-224', 'USR-0001', 'PRE-2025-04', 'SUB-SAL-02', NULL, 2025, 4, 'gasto', 'Consulta rapida',        520.00, '2025-04-05',  'tarjeta', NULL, 'Consulta menor', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-225', 'USR-0001', 'PRE-2025-03', 'SUB-ENT-01', NULL, 2025, 3, 'gasto', 'Salida al parque',       100.00, '2025-03-16',  'efectivo', NULL, 'Snacks en parque', 'seed');
INSERT INTO Transaccion (
    Id_transaccion, Id_usuario, Id_presupuesto, Id_subcategoria, Id_obligacion_fija,
    anio, mes, tipo, descripcion, monto, fecha, metodo_pago, numero_factura, observaciones, creado_por
) VALUES
('TRA-GAS-226', 'USR-0001', 'PRE-2025-04', 'SUB-ENT-01', NULL, 2025, 4, 'gasto', 'Salida al parque',       110.00, '2025-04-16',  'efectivo', NULL, 'Snacks en parque', 'seed');
