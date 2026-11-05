# Trabajo Practico Integrador - Bases de Datos 2026
Sistema de Gestion para Zapateria Calzados S.A.

## Descripción
Este proyecto corresponde al Trabajo Practico Integrador de la materia Bases de Datos. Su objetivo es gestionar las ventas, stock, clientes, vendedores y proveedores de la zapateria Calzados S.A. Combina una base de datos relacional en PostgreSQL con un programa de consola en Java para la administracion de proveedores.

## Archivos del Proyecto
- lib/: Carpeta que contiene el driver de PostgreSQL (archivo .jar) necesario para la conexion.
- Proveedor.java: Clase que establece la conexion con PostgreSQL y contiene los metodos para insertar, eliminar y listar proveedores.
- Zapateria.java: Clase principal que contiene el menu de consola para interactuar con el sistema.
- BaseDeDatos.sql: Script SQL para la creacion de las tablas y restricciones en PostgreSQL.
- InformacionCargadaEnLaBD.sql: Script SQL con datos iniciales de prueba.

## Funciones del Programa en Java
El programa cumple con el punto 5 del trabajo practico:
1. Listar proveedores: Muestra todos los proveedores registrados en la base de datos.
2. Insertar proveedor: Permite agregar un nuevo proveedor completando sus datos.
3. Eliminar proveedor: Permite dar de baja un proveedor ingresando su CUIT.

## Pasos para Ejecutar
1. Crear la base de datos en PostgreSQL y ejecutar los scripts .sql (primero BaseDeDatos.sql y luego InformacionCargadaEnLaBD.sql).
2. Asegurarse de que el archivo .jar del driver de Postgres este dentro de la carpeta lib/.
3. Abrir Proveedor.java y colocar la contraseña correspondiente a tu PostgreSQL local en la variable PASSWORD.
4. Abrir Zapateria.java y presionar Run para iniciar el menu en la terminal.