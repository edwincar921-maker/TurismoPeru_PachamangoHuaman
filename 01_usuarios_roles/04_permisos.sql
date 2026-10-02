USE TURISMOPERU_EJPH;
GO

-- Asignación de los usuarios a sus respectivos roles
ALTER ROLE rol_vendedor ADD MEMBER turismo_vendedor;
ALTER ROLE rol_analista ADD MEMBER turismo_analista;

-- Asignamos al administrador control total sobre la base de datos
ALTER ROLE db_owner ADD MEMBER turismo_admin;
GO


-- PERMISOS PARA EL ROL VENDEDOR
--- Permisos concedidos
GRANT SELECT, INSERT ON dbo.cliente TO rol_vendedor;
GRANT SELECT, INSERT ON dbo.reserva TO rol_vendedor;
GRANT SELECT ON dbo.alojamiento TO rol_vendedor;
GRANT SELECT ON dbo.habitacion TO rol_vendedor;

-- Restricciones explícitas 
DENY DELETE ON dbo.cliente TO rol_vendedor;
DENY DELETE ON dbo.reserva TO rol_vendedor;
GO

-- PERMISOS PARA EL ROL ANALISTA
---Permisos concedidos (Únicamente consulta)
GRANT SELECT ON dbo.cliente TO rol_analista;
GRANT SELECT ON dbo.reserva TO rol_analista;
GRANT SELECT ON dbo.pago TO rol_analista;
GRANT SELECT ON dbo.alojamiento TO rol_analista;
GRANT SELECT ON dbo.habitacion TO rol_analista;
GRANT SELECT ON dbo.paquete TO rol_analista;
GRANT SELECT ON dbo.lugar_turistico TO rol_analista;

-- Restricciones explícitas
DENY INSERT, UPDATE, DELETE TO rol_analista;
GO