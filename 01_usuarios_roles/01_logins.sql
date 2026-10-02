USE master;
GO

-- Creamos login para el Administrador
CREATE LOGIN turismo_admin WITH PASSWORD = 'PasswordSeguro123!';
GO

-- Creamos login para el Vendedor
CREATE LOGIN turismo_vendedor WITH PASSWORD = 'PasswordVendedor123!';
GO

-- Creamos login para el Analista
CREATE LOGIN turismo_analista WITH PASSWORD = 'PasswordAnalista123!';
GO