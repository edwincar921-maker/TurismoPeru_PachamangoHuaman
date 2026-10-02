USE TURISMOPERU_EJPH;
GO

-- Cambiamos el contexto de ejecución para simular ser el analista
EXECUTE AS USER = 'turismo_analista';
GO

-- Prueba: Intentar insertar un registro en la tabla pago (DEBE SER RECHAZADA)
--- La operación debe ser rechazada por SQL Server si el analista no tiene el permiso correspondiente.
INSERT INTO dbo.pago (id_reserva, monto, fecha_pago, metodo_pago) 
VALUES (1, 150.00, GETDATE(), 'Tarjeta');
GO

-- Revertimos al usuario original 
REVERT;
GO