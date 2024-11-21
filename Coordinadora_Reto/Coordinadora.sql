-- Creación de la base de datos
CREATE DATABASE EmpresaDB;

-- Seleccionar la base de datos
USE EmpresaDB;

-- Tabla Departamento
CREATE TABLE Departamento (
    codDepto INT PRIMARY KEY,
    nombreDpto VARCHAR(50) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    director VARCHAR(15) NOT NULL
);

-- Tabla Empleado
CREATE TABLE Empleado (
    nDIEmp VARCHAR(15) PRIMARY KEY,
    nomEmp VARCHAR(100) NOT NULL,
    sexEmp CHAR(1) NOT NULL,
    fecNac DATE NOT NULL,
    fecIncorporacion DATE NOT NULL,
    salEmp DECIMAL(10, 2) NOT NULL,
    comisionE DECIMAL(10, 2) DEFAULT 0,
    CargoE VARCHAR(50),
    jefeID VARCHAR(15),
    CodDepto INT,
    FOREIGN KEY (CodDepto) REFERENCES Departamento(codDepto),
    FOREIGN KEY (jefeID) REFERENCES Empleado(nDIEmp)
);

INSERT INTO Departamento (codDepto, nombreDpto, ciudad, director)
VALUES
    (1000, 'GERENCIA', 'CALI', '31.840.269'),
    (1500, 'PRODUCCIÓN', 'CALI', '16.211.383'),
    (2000, 'VENTAS', 'CALI', '31.178.144'),
    (3000, 'INVESTIGACIÓN', 'CALI', '16.759.060'),
    (3500, 'MERCADEO', 'CALI', '22.222.222');


-- Insertar datos en la tabla Departamento
INSERT INTO Departamento (codDepto, nombreDpto, ciudad, director)
VALUES
    (1000, 'GERENCIA', 'CALI', '31.840.269'),
    (1500, 'PRODUCCIÓN', 'CALI', '16.211.383'),
    (2000, 'VENTAS', 'CALI', '31.178.144'),
    (3000, 'INVESTIGACIÓN', 'CALI', '16.759.060'),
    (3500, 'MERCADEO', 'CALI', '22.222.222'),
    (2100, 'VENTAS', 'POPAYAN', '31.751.219'),
    (2200, 'VENTAS', 'BUGA', '768.782'),
    (2300, 'VENTAS', 'CARTAGO', '737.689'),
    (4000, 'MANTENIMIENTO', 'CALI', '333.333.333'),
    (4100, 'MANTENIMIENTO', 'POPAYAN', '888.888'),
    (4200, 'MANTENIMIENTO', 'BUGA', '11.111.111'),
    (4300, 'MANTENIMIENTO', 'CARTAGO', '444.444');

-- Insertar datos en la tabla Empleado
INSERT INTO Empleado (nDIEmp, nomEmp, sexEmp, fecNac, fecIncorporacion, salEmp, comisionE, cargoE, jefeID, codDepto)
VALUES
('31.840.269', 'María Rojas', 'F', '1959-01-15', '1990-05-16', 6250000, 1500000, 'Gerente', NULL, '1000'),
('16.211.383', 'Luis Pérez', 'M', '1980-12-12', '1990-05-16', 3500000, 500000, 'Director', '31.840.269', '1500'),
('31.178.144', 'Rosa Angulo', 'F', '1975-05-22', '1990-05-16', 3000000, 500000, 'Investigador', '31.840.269', '2000'),
('16.759.060', 'Darío Casas', 'M', '1956-02-25', '1998-08-16', 3500000, 500000, 'Jefe Ventas', '31.840.269', '3000'),
('31.840.269', 'Elisa Rojas', 'F', '1979-09-28', '2004-06-01', 3000000, 200000, 'Mecánico', '31.840.269', '3500'),
('1.751.219', 'Melissa Roa', 'F', '1987-05-14', '2005-07-16', 4500000, 300000, 'Mercadeo', '31.840.269', '3500'),
('31.178.145', 'Carla López', 'F', '1975-05-11', '2005-07-16', 4500000, 300000, 'Vendedor', '31.840.269', '2000'),
('737.689', 'Mario Llano', 'M', '1945-08-30', '1990-05-16', 2250000, 2250000, 'Vendedor', '31.178.144', '2000'),
('333.333.333', 'Joaquín Rosas', 'M', '1960-06-19', '1990-05-16', 2500000, 2500000, 'Vendedor', '31.178.144', '2100'),
('333.333.334', 'Marisol Pulido', 'F', '1979-10-01', '1990-05-16', 3250000, 1000000, 'Investigador', '31.178.144', '2200'),
('333.333.335', 'Ana Moreno', 'F', '1992-01-05', '2004-06-01', 1200000, 400000, 'Secretaria', '31.178.144', '2300'),
('333.333.336', 'Carolina Ríos', 'F', '1992-02-15', '2000-10-01', 1250000, 500000, 'Secretaria', '31.178.144', '3000'),
('333.333.337', 'Edith Muñoz', 'F', '1992-03-31', '2000-10-01', 800000, 3600000, 'Vendedor', '31.178.144', '2100'),
('333.333.338', 'Pedro Blanco', 'M', '1987-10-28', '2000-10-01', 800000, 3000000, 'Vendedor', '31.178.144', '2000'),
('333.333.339', 'José Giraldo', 'M', '1985-01-20', '2000-11-01', 1200000, 400000, 'Asesor', '31.178.144', '3500');


--1 Valor total que recibirán los empleados del departamento 3000 en su próximo pago, con el reconocimiento adicional único de $500.000:

	SELECT 
    e.nomEmp, 
    e.salEmp + e.comisionE + 500000 AS valorTotalPago
FROM 
    Empleado e
WHERE 
    e.codDepto = '3000'
ORDER BY 
    e.nomEmp;

--2 Departamentos que tienen más de 3 empleados y el número de empleados en cada uno, ordenados de mayor a menor cantidad de empleados:
	SELECT 
    e.codDepto, 
    COUNT(*) AS numeroEmpleados
FROM 
    Empleado e
GROUP BY 
    e.codDepto
HAVING 
    COUNT(*) > 3
ORDER BY 
    numeroEmpleados DESC;

--3 Verificar si existen empleados que no estén asignados a algún departamento existente

	SELECT 
    e.nDIEmp, 
    e.nomEmp
FROM 
    Empleado e
LEFT JOIN 
    Departamento d ON e.codDepto = d.codDepto
WHERE 
    d.codDepto IS NULL;

--4.  Departamento con la nómina total más alta, considerando salario y comisión

	SELECT TOP 1
    e.codDepto, 
    SUM(e.salEmp + e.comisionE) AS totalNomina
FROM 
    Empleado e
GROUP BY 
    e.codDepto
ORDER BY 
    totalNomina DESC;

--5.Tres directores con más personas a cargo

	SELECT TOP 3
    e.nomEmp AS director, 
    COUNT(*) AS cantidadEmpleadosACargo
FROM 
    Empleado e
WHERE 
    e.cargoE = 'Director'
GROUP BY 
    e.nomEmp
ORDER BY 
    cantidadEmpleadosACargo DESC;


--6. Salario promedio general de la empresa y el departamento con el salario promedio más alto

-- Salario promedio general
SELECT 
    AVG(e.salEmp) AS salarioPromedioGeneral
FROM 
    Empleado e;

-- Departamento con el salario promedio más alto
SELECT TOP 1
    e.codDepto, 
    AVG(e.salEmp) AS salarioPromedioDepto
FROM 
    Empleado e
GROUP BY 
    e.codDepto
ORDER BY 
    salarioPromedioDepto DESC;
