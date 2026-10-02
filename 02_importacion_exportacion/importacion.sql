USE TURISMOPERU_EJPH;
GO

--Tabla temporal o de staging
CREATE TABLE dbo.cliente_importacion (
    Documento VARCHAR(20),
    Nombres VARCHAR(100),
    ApellidoPaterno VARCHAR(100),
    ApellidoMaterno VARCHAR(100)
);
GO

-- 2. IMPORTACIÓN DE DATOS
---El comando BCP se ejecuta desde la terminal de Windows (CMD), no en SQL Server.
--- Comando documentado para importar el CSV:
--- bcp TURISMOPERU_EJPH.dbo.cliente_importacion in "C:\ruta\clientes.csv" -c -t"," -T

-- 3. VALIDACIÓN, IDENTIFICACIÓN DE DUPLICADOS E INSERCIÓN
--- Insertamos solo los registros válidos (sin documento nulo) y que no existan ya en la tabla final 'cliente'
INSERT INTO dbo.cliente (documento, nombres, apellido_paterno, apellido_materno)
SELECT DISTINCT 
    i.Documento, 
    i.Nombres, 
    i.ApellidoPaterno, 
    i.ApellidoMaterno
FROM dbo.cliente_importacion i
WHERE i.Documento IS NOT NULL -- Validar que el documento no esté vacío
  AND NOT EXISTS (
      -- Identificar y descartar duplicados comparando con la tabla principal
      SELECT 1 
      FROM dbo.cliente c 
      WHERE c.documento = i.Documento
  );
GO