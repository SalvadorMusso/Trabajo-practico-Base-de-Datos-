-- Se crea la base de datos
CREATE DATABASE calzados_sa; 

-- Tabulacion de entidades maestras 
CREATE TABLE Talle(
	Num DECIMAL(4, 1) PRIMARY KEY -- Permite talles como 37,5
);

CREATE TABLE Zapato(
	IdZapato SERIAL PRIMARY KEY,
	Modelo VARCHAR(100) NOT NULL,
	Color VARCHAR(50) NOT NULL, 
	PrecioZap DECIMAL(12, 2) NOT NULL,
	CONSTRAINT chk_precio_limite CHECK (PrecioZap > 0 AND PrecioZap < 200000),
	CONSTRAINT uq_modelo_color UNIQUE (Modelo, Color)
);

CREATE TABLE Proveedor (
    IdProveedor SERIAL PRIMARY KEY, 
    Cuit VARCHAR(15) UNIQUE NOT NULL, 
    RazSoci VARCHAR(150) NOT NULL,
    Direccion VARCHAR(200) NOT NULL,
    TelefonoFijo VARCHAR(20) NOT NULL
);

CREATE TABLE Cliente (
    DniCliente VARCHAR(15) PRIMARY KEY, 
    Direccion VARCHAR(200) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL
);

CREATE TABLE Vendedor (
    NumVend SERIAL PRIMARY KEY, 
    Dni VARCHAR(15) UNIQUE NOT NULL,
    Direccion VARCHAR(200) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL
);

CREATE TABLE DiaSemana (
    Dia VARCHAR(9) PRIMARY KEY 
);

-- Relación N:M entre Zapato y Talle
CREATE TABLE DisponibleEn (
    IdZapato INT NOT NULL,
    Num DECIMAL(4, 1) NOT NULL,
    Cant INT NOT NULL DEFAULT 0,
    CONSTRAINT chk_cant_positiva CHECK (Cant >= 0),
    PRIMARY KEY (IdZapato, Num),
    FOREIGN KEY (IdZapato) REFERENCES Zapato(IdZapato) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Num) REFERENCES Talle(Num) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Atributo multivaluado de Proveedor
CREATE TABLE MultEvCelus (
    IdProveedor INT NOT NULL,
    Celus VARCHAR(20) NOT NULL,
    PRIMARY KEY (IdProveedor, Celus),
    FOREIGN KEY (IdProveedor) REFERENCES Proveedor(IdProveedor) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Relación N:M entre Proveedor y Zapato
CREATE TABLE Provee (
    IdProveedor INT NOT NULL,
    IdZapato INT NOT NULL,
    PRIMARY KEY (IdProveedor, IdZapato),
    FOREIGN KEY (IdProveedor) REFERENCES Proveedor(IdProveedor) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (IdZapato) REFERENCES Zapato(IdZapato) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Subclase Minorista
CREATE TABLE CliMinorista (
    DniCliente VARCHAR(15) PRIMARY KEY,
    FechaNacim DATE NOT NULL,
    FOREIGN KEY (DniCliente) REFERENCES Cliente(DniCliente) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Subclase Mayorista
CREATE TABLE CliMayorista (
    DniCliente VARCHAR(15) PRIMARY KEY,
    DescGen DECIMAL(5, 2) NOT NULL,
    CONSTRAINT chk_desc_mayorista CHECK (DescGen >= 0 AND DescGen <= 100),
    FOREIGN KEY (DniCliente) REFERENCES Cliente(DniCliente) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Relación N:M entre Vendedor y DiaSemana
CREATE TABLE CumpleHorar (
    Dia VARCHAR(9) NOT NULL,
    NumVend INT NOT NULL,
    HoraIngreso TIME NOT NULL,
    HoraSalida TIME NOT NULL,
    PRIMARY KEY (Dia, NumVend),
    FOREIGN KEY (Dia) REFERENCES DiaSemana(Dia) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (NumVend) REFERENCES Vendedor(NumVend) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Entidad dependiente de Vendedor
CREATE TABLE Franco (
    NumFranco SERIAL PRIMARY KEY, 
    Observaciones TEXT,
    Fecha DATE NOT NULL,
    NumVend INT NOT NULL,
    FOREIGN KEY (NumVend) REFERENCES Vendedor(NumVend) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Factura (
    IdFactura SERIAL PRIMARY KEY,
    Fecha DATE NOT NULL,
    Monto DECIMAL(12, 2) NOT NULL CHECK (Monto >= 0),
    DescuentoAplicado DECIMAL(5, 2) NOT NULL,
    DniCliente VARCHAR(15) NOT NULL,
    NumVend INT NOT NULL,
    CONSTRAINT chk_desc_factura CHECK (DescuentoAplicado >= 0 AND DescuentoAplicado <= 100), -- Límite de descuento[cite: 1]
    -- Se usa RESTRICT para evitar que se borre un cliente o vendedor si ya tiene facturas emitidas
    FOREIGN KEY (DniCliente) REFERENCES Cliente(DniCliente) ON DELETE RESTRICT ON UPDATE CASCADE, 
    FOREIGN KEY (NumVend) REFERENCES Vendedor(NumVend) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Facturado (
    IdFactura INT NOT NULL,
    IdZapato INT NOT NULL,
    Num DECIMAL(4, 1) NOT NULL, 
    Precio DECIMAL(12, 2) NOT NULL CHECK (Precio > 0),
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    PRIMARY KEY (IdFactura, IdZapato, Num),
    FOREIGN KEY (IdFactura) REFERENCES Factura(IdFactura) ON DELETE CASCADE ON UPDATE CASCADE,
    -- Referencia a DisponibleEn asegura que se venda un modelo y talle que exista en el catálogo
    FOREIGN KEY (IdZapato, Num) REFERENCES DisponibleEn(IdZapato, Num) ON DELETE RESTRICT ON UPDATE CASCADE
);