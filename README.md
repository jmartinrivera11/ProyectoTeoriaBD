# Sistema de Gestion de Presupuesto Personal

Este proyecto es una aplicacion diseñada para ayudar a los usuarios a gestionar su presupuesto mensual de forma clara y organizada. Permite registrar presupuestos, ingresos, gastos, metas de ahorro, obligaciones fijas y transacciones, generando resuenes y estadisticas que facilitan el control financiero.

## Herramientas
<img width="128" height="128" alt="image" src="https://github.com/user-attachments/assets/3a36077c-9a1e-4b1c-871d-e97c121210eb" /> 
<img width="128" height="128" alt="image" src="https://github.com/user-attachments/assets/63f7483f-8d66-413c-a5bd-85802945fd55" />
<img width="200" height="130" alt="image" src="https://github.com/user-attachments/assets/c57b7044-642c-4950-8fa6-089ae8b18d5b" />
<img width="130" height="172" alt="image" src="https://github.com/user-attachments/assets/ae56d6f0-5506-4746-862e-981d76c92395" />

## Instalación
Instalar [Qt Community](https://www.qt.io/development/download-qt-installer-oss)
y clonar repositorio en la terminal
```bash
git clone https://github.com/jmartinrivera11/ProyectoTeoriaBD.git
```

## Conectarse a la base de datos
Instalar [Firebird iSQL Tool](https://www.firebirdsql.org/en/server-packages/) y [FlameRobin](https://github.com/mariuz/flamerobin/releases/tag/0.9.14)
En la terminal de Firebird iSQL Tool ejecutar el siguiente comando:
```bash
CREATE DATABASE 'localhost:C:\..\ProyectoPresupuestoBD\database\PRESUPUESTO.FDB' USER 'sysdba' PASSWORD 'masterkey';
```
<img width="1176" height="233" alt="image" src="https://github.com/user-attachments/assets/96046cef-604e-4f11-b3bb-ab074630d4b1" />

Una vez ejecutado, debería de crearse el siguiente archivo en el folder 'database' de la carpeta donde se clono el repositorio: 
<img width="923" height="426" alt="image" src="https://github.com/user-attachments/assets/042ac7c9-7f74-473b-a85e-34b9f3db42c2" />



### Paso 1. Registrar Base de Datos
Abrir FlameRobin y hacer click derecho en Localhost
Localhost --> Registrar base de datos existente
<img width="487" height="277" alt="image" src="https://github.com/user-attachments/assets/1458ae5c-24eb-4604-a00b-6831c229e8ab" />

### Paso 2. Ejecutar los comandos SQL desde FlameRobin
![WhatsApp Image 2025-12-15 at 22 18 46_d17791d3](https://github.com/user-attachments/assets/6215057f-1c19-41a8-a079-17d0f141d101) <br>
<img width="343" height="497" alt="Screenshot 2025-12-15 224000" src="https://github.com/user-attachments/assets/d1f22c28-d82c-4707-ae61-fb89ebf178c4" />
<img width="345" height="496" alt="Screenshot 2025-12-15 224013" src="https://github.com/user-attachments/assets/e64d96f8-6fd6-4e3b-8aef-30a5f03bf4d4" />


En el siguiente orden:
- database\DDL\01_crear_tablas.sql
- database\procedimientos\crud.sql
- database\funciones\funciones.sql
- database\triggers\triggers.sql
- database\datos_prueba\insertar_datos.sql

### Paso 3. Compilar y correr desde Qt

## Funciones del programa
### Usuario
Deberia de aparecer como pagina principal la lista de los usuarios registrados en la base de datos con 3 funciones: Insertar, editar y eliminar Usuario
<img width="1500" height="847" alt="image" src="https://github.com/user-attachments/assets/abcd30c7-2491-41d9-8599-b33e288741fe" />

### Categoría y Subcategoría
Ambas categoría y subcategoría tienen las mismas funciones para insertar, editar y eliminar. Se imprime en pantalla unicamente las subcategorías de la categoría actualmente seleccionada
<img width="1495" height="850" alt="image" src="https://github.com/user-attachments/assets/293fafb1-4559-403a-888f-58705dcc43c0" />

Insertando nueva categoria:
<img width="743" height="684" alt="image" src="https://github.com/user-attachments/assets/fa250039-87f0-45ec-9d18-a2e367b48317" />

Insertando nueva subcategoría para la categoría seleccionada:
<img width="708" height="410" alt="image" src="https://github.com/user-attachments/assets/6eb502ca-efdc-444a-80b2-8b45e68b56b4" />

### Presupuestos
<img width="1499" height="853" alt="image" src="https://github.com/user-attachments/assets/6d7c3220-d781-47b4-881d-28f933a112b8" />
Insertado un nuevo presupuesto para el usuario Pedro Gonzalez...
<img width="1496" height="843" alt="image" src="https://github.com/user-attachments/assets/44a82a60-ef0f-49a1-a6c7-e319d4133e01" />


### Transacciones
Permite insertar, editar o eliminar toda transaccion hecha por el usuario durante el lapso del periodo de dicho presupuesto
<img width="1494" height="854" alt="image" src="https://github.com/user-attachments/assets/e6983ede-a963-41de-8707-9a63d6c47f8d" />
Insertando nueva transaccion: <br>
<img width="345" height="419" alt="image" src="https://github.com/user-attachments/assets/01c611dc-187f-418d-8b5f-89f227c5d8d6" />


### Metas de Ahorro
<img width="1493" height="852" alt="image" src="https://github.com/user-attachments/assets/1af5f299-7c96-459c-a82e-6f962488f578" />
Creando nueva meta de ahorro para el usuario: <br>
<img width="332" height="383" alt="image" src="https://github.com/user-attachments/assets/9e7ad219-4490-4ab5-8041-801fcba1870d" />


### Obligaciones Fijas
<img width="1499" height="845" alt="image" src="https://github.com/user-attachments/assets/c49d1f88-20bb-4726-9fb8-a49620b0e23c" />

Definiendo obligacion fija para el usuario:<br>
<img width="341" height="396" alt="image" src="https://github.com/user-attachments/assets/fb2a2608-f18c-407f-a3f2-d1249595be41" />
