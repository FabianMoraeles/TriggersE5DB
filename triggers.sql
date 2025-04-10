-- ########################### Función para calcular subtotal y registrar en historial antes de insertar #####################################################
CREATE OR REPLACE FUNCTION calcular_subtotal()
RETURNS TRIGGER AS $$
BEGIN 
    NEW.subtotal := NEW.precio_unitario * NEW.cantidad;

    INSERT INTO historial ( 
        entidad,registro_id,valores_anteriores,valores_nuevos,evento
    ) VALUES (
        'detalle_alquiler', 
        NEW.id,              
        NULL,
        CONCAT('alquiler_id=', NEW.alquiler_id, ', producto_id=', NEW.producto_id, ', cantidad=', NEW.cantidad, ', precio=', NEW.precio_unitario, ', subtotal=', NEW.subtotal),
        'INSERT'
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ########################### Trigger BEFORE INSERT #####################################################
CREATE OR REPLACE TRIGGER calcular_subtotal_before_trigger
BEFORE INSERT ON detalle_alquiler
FOR EACH ROW
EXECUTE FUNCTION calcular_subtotal();


-- ########################### Función para guardar una actualización de productos ####################################
CREATE OR REPLACE FUNCTION Update_cantidad()
RETURNS TRIGGER AS $$
BEGIN 

    INSERT INTO historial ( 
        entidad,registro_id,valores_anteriores,valores_nuevos,evento
    ) VALUES (
        'productos', 
        NEW.id,              
        CONCAT('id=', OLD.id, ', nombre=', OLD.nombre,', precio=', OLD.precio_unitario, ', cantidad=', OLD.cantidad),
        CONCAT('id=', NEW.id, ', nombre=', NEW.nombre, ', precio=', NEW.precio_unitario, ', cantidad=', NEW.cantidad),
        'UPDATE'
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ########################### Trigger After Update #####################################################
CREATE TRIGGER Update_cantidad_trigger
AFTER UPDATE ON producto
FOR EACH ROW
WHEN (OLD.cantidad <> NEW.cantidad)
EXECUTE FUNCTION Update_cantidad();


-- ########################### Función para guardar en historial un dato borrado ####################################
CREATE OR REPLACE FUNCTION Borrar_detalle_historial()
RETURNS TRIGGER AS $$
BEGIN 

    DELETE FROM detalle_alquiler
    WHERE  alquiler_id= OLD.id;


    INSERT INTO historial ( 
        entidad,registro_id,valores_anteriores,valores_nuevos,evento
    ) VALUES (
        'Alquiler', 
        OLD.id,              
        CONCAT('id=', OLD.id, ', cliente_id=', OLD.cliente_id, ', fecha_alquiler=', OLD.fecha_alquiler),
        null,
        'DELETE'
    );

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- ########################### Trigger After Delete #####################################################
CREATE TRIGGER borrar_detalles_trigger
AFTER DELETE ON alquiler
FOR EACH ROW
EXECUTE FUNCTION Borrar_detalle_historial();


-- ########################### Función para guardar un truncate en historial ####################################
CREATE OR REPLACE FUNCTION truncate_before_function()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO historial (
        entidad,
        registro_id,
        valores_anteriores,
        valores_nuevos,
        evento
    ) VALUES (
        'productos',
        -1,
        NULL,
        NULL,
        'BEFORE TRUNCATE'
    );

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;



-- ########################### Trigger After Delete #####################################################
CREATE TRIGGER truncate_before_trigger
BEFORE TRUNCATE ON producto
FOR EACH STATEMENT
EXECUTE FUNCTION truncate_before_function();



-- ########## Querys de Prueba para Trigger Before insert, Trigger after update, Trigger After Delete
INSERT INTO detalle_alquiler (alquiler_id, producto_id, cantidad, precio_unitario, subtotal)
VALUES
(1, 1, 2, 300.00, 0);

SELECT * FROM detalle_alquiler;
SELECT * FROM historial;
SELECT * FROM alquiler;

UPDATE producto
SET cantidad = 25
WHERE id = 1;

-- #Probar truncate
TRUNCATE producto CASCADE;

SELECT * FROM historial ORDER BY id DESC LIMIT 1;


-- -- ########################### Función para after insert en historial ####################################

CREATE OR REPLACE FUNCTION producto_after_insert()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO historial (
        entidad,
        registro_id,
        valores_anteriores,
        valores_nuevos,
        evento
    ) VALUES (
        'producto',
        NEW.id,
        NULL,
        CONCAT('id=', NEW.id, ', nombre=', NEW.nombre, ', precio=', NEW.precio_unitario, ', cantidad=', NEW.cantidad),
        'AFTER INSERT'
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ########################### Trigger After insert #####################################################
CREATE TRIGGER producto_after_insert_trigger
AFTER INSERT ON producto
FOR EACH ROW
EXECUTE FUNCTION producto_after_insert();

-- -- ########################### Función para before update en historial ####################################

CREATE OR REPLACE FUNCTION producto_before_update()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO historial (
        entidad,
        registro_id,
        valores_anteriores,
        valores_nuevos,
        evento
    ) VALUES (
        'producto',
        OLD.id,
        CONCAT('id=', OLD.id, ', nombre=', OLD.nombre, ', precio=', OLD.precio_unitario, ', cantidad=', OLD.cantidad),
        CONCAT('id=', NEW.id, ', nombre=', NEW.nombre, ', precio=', NEW.precio_unitario, ', cantidad=', NEW.cantidad),
        'BEFORE UPDATE'
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ########################### Trigger before update #####################################################
CREATE TRIGGER producto_before_update_trigger
BEFORE UPDATE ON producto
FOR EACH ROW
EXECUTE FUNCTION producto_before_update();

-- -- ########################### Función para before delete en historial ####################################
CREATE OR REPLACE FUNCTION producto_before_delete()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO historial (
        entidad,
        registro_id,
        valores_anteriores,
        valores_nuevos,
        evento
    ) VALUES (
        'producto',
        OLD.id,
        CONCAT('id=', OLD.id, ', nombre=', OLD.nombre, ', precio=', OLD.precio_unitario, ', cantidad=', OLD.cantidad),
        NULL,
        'BEFORE DELETE'
    );

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- ########################### Trigger before Delete #####################################################
CREATE TRIGGER producto_before_delete_trigger
BEFORE DELETE ON producto
FOR EACH ROW
EXECUTE FUNCTION producto_before_delete();


-- ########################### Función para guardar un truncate en historial ####################################
CREATE OR REPLACE FUNCTION producto_after_truncate()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO historial (
        entidad,
        registro_id,
        valores_anteriores,
        valores_nuevos,
        evento
    ) VALUES (
        'producto',
        -1,
        NULL,
        NULL,
        'AFTER TRUNCATE'
    );

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- ########################### Trigger After truncate #####################################################
CREATE TRIGGER producto_after_truncate_trigger
AFTER TRUNCATE ON producto
FOR EACH STATEMENT
EXECUTE FUNCTION producto_after_truncate();
