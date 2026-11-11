TRUNCATE TABLE Talle, DiaSemana, Zapato, Vendedor, Cliente, Proveedor RESTART IDENTITY CASCADE;

-- Talles disponibles
INSERT INTO Talle (Num) VALUES 
(38.0), (39.0), (40.0), (41.0), (42.0);

-- Días de la semana
INSERT INTO DiaSemana (Dia) VALUES 
('Lunes'), ('Martes'), ('Miércoles'), ('Jueves'), ('Viernes'), ('Sábado');

-- Zapatos (El IdZapato se genera automáticamente como 1, 2, 3...)
INSERT INTO Zapato (Modelo, Color) VALUES 
('Urbano Clasico', 'Negro'),
('Deportivo Running', 'Blanco'),
('Bota Cuero', 'Marrón'),
('Botita Vans', 'Negro');

-- Proveedores (IdProveedor 1, 2...)
INSERT INTO Proveedor (Cuit, RazSoci, Direccion, TelefonoFijo) VALUES 
('30-11111111-9', 'Calzados del Centro SRL', 'San Martin 450', '0358-4620000'),
('30-22222222-1', 'Distribuidora Paso a Paso', 'General Paz 890', '0358-4631111');

-- Clientes (Superclase)
INSERT INTO Cliente (DniCliente, Direccion, Nombre, Apellido) VALUES 
('35111222', 'Alberdi 150', 'Lucas', 'Gomez'),
('28333444', 'Banda Norte 900', 'Maria', 'Perez'),
('20555666', 'Centro 120', 'Comercio Shoes', 'SA');

-- Vendedores (NumVend 1, 2...)
INSERT INTO Vendedor (Dni, Direccion, Nombre, Apellido) VALUES 
('32777666', 'Sobremonte 450', 'Martin', 'Rodriguez'),
('30999888', 'Castelli 300', 'Julieta', 'Fernandez'),
('40111222', 'Ruta 8', 'Salvador', 'Musso'),
('12345678','MENDOZA 385','Bautista','Gonzalez y rojo');
	

-- Stock por número (IdZapato, Num)
INSERT INTO DisponibleEn (IdZapato, Num, Cant, Precio) VALUES 
(1, 39.0, 50, 150000.00),
(1, 40.0, 30, 85500.50),
(2, 41.0, 15, 45000.00),
(2, 39.0, 15, 150000.00),
(3, 42.0, 10, 32000.00),
(3, 38.0, 0 , 31000.00);

-- Celulares de proveedores
INSERT INTO MultEvCelus (IdProveedor, Celus) VALUES 
(1, '3584112233'),
(1, '3584998877'),
(2, '3584556677');

-- Relación Zapatos provistos
INSERT INTO Provee (IdProveedor, IdZapato) VALUES 
(1, 1),
(1, 2),
(2, 3);

-- Clientes Minoristas
INSERT INTO CliMinorista (DniCliente, FechaNacim) VALUES 
('35111222', '1990-05-15'),
('28333444', '1985-10-20');

-- Clientes Mayoristas (Descuento General entre 0 y 100)
INSERT INTO CliMayorista (DniCliente, DescGen) VALUES 
('20555666', 15.00);

-- Horarios de los Vendedores
INSERT INTO CumpleHorar (Dia, NumVend, HoraIngreso, HoraSalida) VALUES 
('Lunes', 1, '08:00:00', '16:00:00'),
('Martes', 1, '08:00:00', '16:00:00'),
('Miércoles', 2, '16:00:00', '20:00:00'),
('Jueves', 2, '16:00:00', '20:00:00');

-- Francos de los vendedores
INSERT INTO Franco (Observaciones, Fecha, NumVend) VALUES 
('Descanso semanal', '2026-01-10', 1),
('Día compensatorio', '2026-01-15', 2),
('VACACIONES','2026-07-01',4);

-- Encabezado de Facturas (IdFactura 1, 2, .. generados automáticamente)
INSERT INTO Factura (Fecha, DescuentoAplicado, DniCliente, NumVend) VALUES 
('2026-10-20', 0.00, '35111222', 1),
('2026-10-21', 15.00, '20555666', 2),
('2025-10-22', 15.00, '28333444', 3),
('2026-10-23', 10.00, '35111222', 1),
('2026-10-24', 10.00, '28333444', 2);

-- Detalle de las facturas (Los zapatos y números deben existir en DisponibleEn)
INSERT INTO Facturado (IdFactura, IdZapato, Num, Precio, Cantidad) VALUES 
(1, 1, 39.0, 150000.00, 5),
(2, 3, 42.0, 170000.00, 1),
(3, 2, 41.0, 45000.00, 3),
(4, 2, 39.0, 150000.00, 2),
(5, 1, 39.0, 85500.50, 2);