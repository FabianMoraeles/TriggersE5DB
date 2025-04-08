DROP Database if EXISTS Camping;
CREATE Database Camping;



-- Tabla usuarios
CREATE TABLE usuarios (
id serial Primary Key,
nombre varchar(255) not null,
correo varchar(255) unique not null,
telefono int
);

-- Tabla productos
CREATE TABLE productos (
id serial Primary Key,
nombre varchar(100) not null,
precio_unitario decimal(10,2) not null,
cantidad int not null,
descripcion text
constraint cantidad_no_negativa CHECK (cantidad >= 0)
);


-- Tabla pedidos
CREATE TABLE pedidos (
id serial Primary Key,
cliente_id int not null,
fecha_pedido timestamp default current_timestamp not null	,
Foreign key (cliente_id) references usuarios(id)
);

-- Tabla detalle_pedido
CREATE TABLE detalle_pedido(
id serial Primary Key,
pedido_id int not null,
producto_id int not null,
cantidad int not null,
precio_unitario decimal(10,2) not null,
subtotal decimal(10,2) not null,
Foreign Key (pedido_id) references pedidos(id),
Foreign Key (producto_id) references productos(id)
);

-- Tabla historial para guardar cada evento de cada trigger.
CREATE TABLE historial (
id serial Primary Key,
entidad varchar(155) not null,
registro_id int not null,
valores_anteriores text,
valores_nuevos text,
evento varchar(50),
fecha timestamp default current_timestamp not null
);