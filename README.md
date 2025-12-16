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
![WhatsApp Image 2025-12-15 at 22 18 46_d17791d3](https://github.com/user-attachments/assets/6215057f-1c19-41a8-a079-17d0f141d101)
En el siguiente orden:
- database\DDL\01_crear_tablas.sql
- database\procedimientos\crud.sql
- database\funciones\funciones.sql
- database\triggers\triggers.sql
- database\datos_prueba\insertar_datos.sql

### Paso 3. Compilar y correr desde Qt
  

