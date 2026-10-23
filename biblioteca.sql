
USE master;
GO

IF DB_ID('Biblioteca') IS NOT NULL
BEGIN
    ALTER DATABASE Biblioteca
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    DROP DATABASE Biblioteca;
END
GO

-- ============================================
-- 2. CREAR LA BASE DE DATOS
-- ============================================

CREATE DATABASE Biblioteca;
GO

USE Biblioteca;
GO

-- ============================================
-- 3. TABLA ALUMNO
-- ============================================

CREATE TABLE dbo.Alumno (
    matricula VARCHAR(20) PRIMARY KEY,
    nombre_completo VARCHAR(150) NOT NULL,
    carrera VARCHAR(100),
    estatus_escolar VARCHAR(50),
    libros_en_poder INT DEFAULT 0,
    saldo_deudor DECIMAL(10,2) DEFAULT 0.00
);
GO

-- ============================================
-- 4. TABLA LIBRO
-- ============================================

CREATE TABLE dbo.Libro (
    id_libro INT IDENTITY(1,1) PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    autor VARCHAR(150),
    editorial VARCHAR(100),
    edicion VARCHAR(50),
    anio_publicacion INT,
    categoria VARCHAR(100)
);
GO

-- ============================================
-- 5. TABLA EJEMPLAR
-- ============================================

CREATE TABLE dbo.Ejemplar (
    codigo_barras VARCHAR(50) PRIMARY KEY,
    id_libro INT NOT NULL,
    ubicacion_pasillo VARCHAR(50),
    condicion_estante VARCHAR(100),
    estado_operativo VARCHAR(50),
    condicion_fisica VARCHAR(100),

    CONSTRAINT FK_Ejemplar_Libro
        FOREIGN KEY (id_libro)
        REFERENCES dbo.Libro(id_libro)
);
GO

-- ============================================
-- 6. TABLA PRESTAMO
-- ============================================

CREATE TABLE dbo.Prestamo (
    id_prestamo INT IDENTITY(1,1) PRIMARY KEY,
    codigo_barras VARCHAR(50) NOT NULL,
    matricula VARCHAR(20) NOT NULL,
    fecha_salida DATE NOT NULL,
    fecha_limite DATE NOT NULL,
    fecha_devolucion DATE,
    estado_prestamo VARCHAR(50),
    multa_generada DECIMAL(10,2) DEFAULT 0.00,
    condicion_salida VARCHAR(100),
    condicion_retorno VARCHAR(100),

    CONSTRAINT FK_Prestamo_Ejemplar
        FOREIGN KEY (codigo_barras)
        REFERENCES dbo.Ejemplar(codigo_barras),

    CONSTRAINT FK_Prestamo_Alumno
        FOREIGN KEY (matricula)
        REFERENCES dbo.Alumno(matricula)
);
GO

-- ============================================
-- 7. VERIFICAR LAS TABLAS
-- ============================================

SELECT TABLE_NAME AS Tabla
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;
GO


USE Biblioteca;
GO

SELECT * FROM Alumno;
SELECT * FROM Libro;
SELECT * FROM Ejemplar;
SELECT * FROM Prestamo;
GO


USE Biblioteca;
GO

INSERT INTO Alumno (
    matricula,
    nombre_completo,
    carrera,
    estatus_escolar,
    libros_en_poder,
    saldo_deudor
)
VALUES
('20260001', 'Celeste espinoza hernandez', 'Ingenieria en TI', 'Activo', 1, 0.00),
('20260002', 'simon enrrique barrera silva', 'Ingenieria Industrial', 'Activo', 0, 0.00),
('20260003', 'Dassia samanta miranda gonzales', 'Ingenieria en TI', 'Activo', 1, 25.00),
('20260004', 'esahu trejo mendoza', 'Ingenieria en TI', 'Activo', 0, 0.00),
('20260005', 'angel emmanuel terrazas martinez', 'Ingenieria en Sistemas', 'Activo', 1, 50.00);
GO

-- Mostrar los alumnos registrados
SELECT * FROM Alumno;
GO


USE Biblioteca;
GO

INSERT INTO Libro (
    titulo,
    autor,
    editorial,
    edicion,
    anio_publicacion,
    categoria
)
VALUES
('El principito', 'Antoine de Saint-Exupéry', 'Porrúa', NULL, 1975, 'Literatura infantil'),
('El principito', 'Antoine de Saint-Exupéry', 'El Arca', NULL, 2007, 'Literatura infantil'),
('El principito', 'Antoine de Saint-Exupéry', 'Colofón', NULL, 2008, 'Literatura infantil'),
('El principito', 'Antoine de Saint-Exupéry', 'Alfaguara', NULL, 2015, 'Literatura juvenil'),
('Cien años de soledad', 'Gabriel García Márquez', 'Sudamericana', NULL, 1967, 'Novela latinoamericana'),
('Cien años de soledad', 'Gabriel García Márquez', 'Alfaguara', NULL, 2007, 'Realismo mágico'),
('Cien años de soledad', 'Gabriel García Márquez', 'Literatura Random House', NULL, 2014, 'Novela latinoamericana'),
('Don Quijote de la Mancha', 'Miguel de Cervantes', 'Francisco de Robles', NULL, 1605, 'Novela clásica'),
('Don Quijote de la Mancha', 'Miguel de Cervantes', 'RAE y ASALE', NULL, 2004, 'Literatura clásica'),
('Harry Potter y el misterio del príncipe', 'J. K. Rowling', 'Salamandra', NULL, 2006, 'Fantasía juvenil'),
('1984', 'George Orwell', 'Secker & Warburg', NULL, 1949, 'Ciencia ficción distópica'),
('El Hobbit', 'J. R. R. Tolkien', 'Minotauro', NULL, 1982, 'Fantasía'),
('Orgullo y prejuicio', 'Jane Austen', 'Penguin Clásicos', NULL, 2015, 'Novela romántica'),
('Frankenstein', 'Mary Shelley', 'Editorial Planeta', NULL, 2017, 'Terror gótico'),
('Drácula', 'Bram Stoker', 'Penguin Clásicos', NULL, 2015, 'Terror gótico');
GO

USE Biblioteca;
GO

UPDATE Libro
SET edicion = CASE
    WHEN id_libro = 1 THEN 'Primera edicion'
    WHEN id_libro = 2 THEN 'Segunda edicion'
    WHEN id_libro = 3 THEN 'Tercera edicion'
    WHEN id_libro = 4 THEN 'Cuarta edicion'
    WHEN id_libro = 5 THEN 'Primera edicion'
    WHEN id_libro = 6 THEN 'Segunda edicion'
    WHEN id_libro = 7 THEN 'Tercera edicion'
    WHEN id_libro = 8 THEN 'Primera edicion'
    WHEN id_libro = 9 THEN 'Segunda edicion'
    WHEN id_libro = 10 THEN 'Primera edicion'
    WHEN id_libro = 11 THEN 'Primera edicion'
    WHEN id_libro = 12 THEN 'Primera edicion'
    WHEN id_libro = 13 THEN 'Primera edicion'
    WHEN id_libro = 14 THEN 'Primera edicion'
    WHEN id_libro = 15 THEN 'Primera edicion'
END
WHERE id_libro BETWEEN 1 AND 15
  AND edicion IS NULL;
GO

SELECT * FROM Libro;
GO


USE Biblioteca;
GO

INSERT INTO Ejemplar (
    codigo_barras,
    id_libro,
    ubicacion_pasillo,
    condicion_estante,
    estado_operativo,
    condicion_fisica
)
VALUES
('LIB000001', 1, 'Pasillo A1', 'Estante 1', 'Disponible', 'Excelente'),
('LIB000002', 2, 'Pasillo A1', 'Estante 1', 'Disponible', 'Bueno'),
('LIB000003', 3, 'Pasillo A1', 'Estante 2', 'Prestado', 'Bueno'),
('LIB000004', 4, 'Pasillo A1', 'Estante 2', 'Disponible', 'Excelente'),
('LIB000005', 5, 'Pasillo A2', 'Estante 1', 'Disponible', 'Bueno'),
('LIB000006', 6, 'Pasillo A2', 'Estante 1', 'Prestado', 'Regular'),
('LIB000007', 7, 'Pasillo A2', 'Estante 2', 'Disponible', 'Excelente'),
('LIB000008', 8, 'Pasillo B1', 'Estante 1', 'Disponible', 'Bueno'),
('LIB000009', 9, 'Pasillo B1', 'Estante 1', 'Disponible', 'Regular'),
('LIB000010', 10, 'Pasillo B1', 'Estante 2', 'Prestado', 'Bueno'),
('LIB000011', 11, 'Pasillo B2', 'Estante 1', 'Disponible', 'Excelente'),
('LIB000012', 12, 'Pasillo B2', 'Estante 1', 'Disponible', 'Bueno'),
('LIB000013', 13, 'Pasillo C1', 'Estante 1', 'Disponible', 'Bueno'),
('LIB000014', 14, 'Pasillo C1', 'Estante 2', 'En revision', 'Regular'),
('LIB000015', 15, 'Pasillo C2', 'Estante 1', 'Disponible', 'Excelente');
GO

-- Consultar los ejemplares registrados
SELECT * FROM Ejemplar;
GO


USE Biblioteca;
GO

SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Prestamo'
ORDER BY ORDINAL_POSITION;
GO

USE Biblioteca;
GO

SELECT codigo_barras, id_libro, estado_operativo
FROM Ejemplar;
GO


USE Biblioteca;
GO

-- Registrar cuatro préstamos para el mismo alumno
IF EXISTS (
    SELECT 1
    FROM Alumno
    WHERE matricula = '20260001'
)
AND (
    SELECT COUNT(*)
    FROM Ejemplar
    WHERE codigo_barras IN (
        'LIB000001',
        'LIB000005',
        'LIB000008',
        'LIB000012'
    )
) = 4
AND NOT EXISTS (
    SELECT 1
    FROM Prestamo
    WHERE codigo_barras IN (
        'LIB000001',
        'LIB000005',
        'LIB000008',
        'LIB000012'
    )
    AND fecha_devolucion IS NULL
)
BEGIN
    INSERT INTO Prestamo (
        codigo_barras,
        matricula,
        fecha_salida,
        fecha_limite,
        fecha_devolucion,
        estado_prestamo,
        multa_generada,
        condicion_salida,
        condicion_retorno
    )
    VALUES
    ('LIB000001', '20260001', CAST(GETDATE() AS DATE),
     DATEADD(DAY, 7, CAST(GETDATE() AS DATE)), NULL,
     'Activo', 0.00, 'Bueno', NULL),

    ('LIB000005', '20260001', CAST(GETDATE() AS DATE),
     DATEADD(DAY, 7, CAST(GETDATE() AS DATE)), NULL,
     'Activo', 0.00, 'Bueno', NULL),

    ('LIB000008', '20260001', CAST(GETDATE() AS DATE),
     DATEADD(DAY, 7, CAST(GETDATE() AS DATE)), NULL,
     'Activo', 0.00, 'Bueno', NULL),

    ('LIB000012', '20260001', CAST(GETDATE() AS DATE),
     DATEADD(DAY, 7, CAST(GETDATE() AS DATE)), NULL,
     'Activo', 0.00, 'Bueno', NULL);

    PRINT 'Se registraron los cuatro préstamos.';
END
ELSE
BEGIN
    PRINT 'No se insertaron los préstamos. Verifica la matrícula, los ejemplares y sus préstamos activos.';
END;
GO

-- Consultar los préstamos del alumno
SELECT *
FROM Prestamo
WHERE matricula = '20260001';
GO
