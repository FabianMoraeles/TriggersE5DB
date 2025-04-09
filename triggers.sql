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
AFTER UPDATE ON productos
FOR EACH ROW
WHEN (OLD.cantidad <> NEW.cantidad)
EXECUTE FUNCTION Update_cantidad();


-- ########################### Función para guardar una actualización de productos ####################################
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
AFTER DELETE ON alquileres
FOR EACH ROW
EXECUTE FUNCTION Borrar_detalle_historial();


