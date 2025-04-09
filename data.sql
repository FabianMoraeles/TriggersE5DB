-- Inserción de Usuarios o clientes.
INSERT INTO usuario (nombre, correo, telefono) VALUES
('Carlos López', 'carlos.lopez@example.com', 501234567),
('María González', 'maria.gonzalez@example.com', 501234568),
('Juan Pérez', 'juan.perez@example.com', 501234569),
('Laura Martínez', 'laura.martinez@example.com', 501234570),
('Pedro Sánchez', 'pedro.sanchez@example.com', 501234571),
('Ana Castillo', 'ana.castillo@example.com', 501234572),
('Roberto Díaz', 'roberto.diaz@example.com', 501234573),
('Paula Herrera', 'paula.herrera@example.com', 501234574),
('Luis Ramírez', 'luis.ramirez@example.com', 501234575),
('Gabriela Torres', 'gabriela.torres@example.com', 501234576);

-- Inserción de datos productos.
INSERT INTO producto (nombre, precio_unitario, cantidad, descripcion) VALUES
('Carpa familiar para 6 personas', 150.00, 10, 'Carpa espaciosa para familias, resistente al clima.'),
('Saco de dormir térmico', 60.00, 30, 'Saco de dormir aislante para temperaturas bajas.'),
('Mochila de senderismo 60L', 95.00, 20, 'Mochila amplia para excursiones largas.'),
('Colchoneta inflable para camping', 45.00, 25, 'Colchoneta de fácil inflado, compacta para transporte.'),
('Estufa portátil a gas', 80.00, 15, 'Estufa para cocinar en exteriores.'),
('Mesa plegable para campamento', 55.00, 8, 'Mesa resistente para comidas al aire libre.'),
('Nevera portátil 25L', 70.00, 12, 'Nevera de gran capacidad para mantener alimentos frescos.'),
('Kit de cocina para camping', 65.00, 18, 'Incluye olla, sartén y utensilios básicos.'),
('Linterna LED recargable', 25.00, 50, 'Linterna portátil con recarga USB.'),
('Botiquín de primeros auxilios', 35.00, 20, 'Kit de emergencias para campamento.'),
('Hamaca de viaje ultraligera', 40.00, 30, 'Hamaca compacta para excursiones.'),
('Filtro de agua portátil', 50.00, 15, 'Purificador de agua para camping.'),
('Chaqueta impermeable para lluvia', 85.00, 25, 'Protección contra lluvia y viento.'),
('Cuerda multiusos 20m', 15.00, 100, 'Cuerda resistente para uso general.'),
('Sombrero de ala ancha UV', 18.00, 60, 'Protección solar para exteriores.');


-- Inserción de datos para alquileres.
INSERT INTO alquiler (cliente_id) VALUES
(1), (2), (3), (4), (5),
(6), (7), (8), (9), (10),
(1), (2), (3), (4), (5),
(6), (7), (8), (9), (10),
(1), (2), (3), (4), (5),
(6), (7), (8), (9), (10);


-- Inserción de datos asociados con su alquiler y productos. El detalle de cada alquiler.
INSERT INTO detalle_alquiler (alquiler_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(1, 1, 2, 150.00, 300.00),
(2, 2, 1, 60.00, 60.00),
(3, 3, 1, 95.00, 95.00),
(4, 4, 2, 45.00, 90.00),
(5, 5, 1, 80.00, 80.00),
(6, 6, 1, 55.00, 55.00),
(7, 7, 1, 70.00, 70.00),
(8, 8, 2, 65.00, 130.00),
(9, 9, 1, 25.00, 25.00),
(10, 10, 2, 35.00, 70.00),
(11, 11, 1, 40.00, 40.00),
(12, 12, 1, 50.00, 50.00),
(13, 13, 2, 85.00, 170.00),
(14, 14, 3, 15.00, 45.00),
(15, 15, 2, 18.00, 36.00),
(16, 1, 1, 150.00, 150.00),
(17, 2, 2, 60.00, 120.00),
(18, 3, 1, 95.00, 95.00),
(19, 4, 3, 45.00, 135.00),
(20, 5, 2, 80.00, 160.00),
(21, 6, 1, 55.00, 55.00),
(22, 7, 2, 70.00, 140.00),
(23, 8, 1, 65.00, 65.00),
(24, 9, 3, 25.00, 75.00),
(25, 10, 2, 35.00, 70.00),
(26, 11, 1, 40.00, 40.00),
(27, 12, 2, 50.00, 100.00),
(28, 13, 1, 85.00, 85.00),
(29, 14, 2, 15.00, 30.00),
(30, 15, 3, 18.00, 54.00);