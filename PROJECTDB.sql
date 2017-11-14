CREATE TABLE cliente (
    id_cliente         INTEGER NOT NULL,
    codigo_cliente     INTEGER NOT NULL,
    primer_nombre      VARCHAR2(30) NOT NULL,
    segundo_nombre     VARCHAR2(30) NOT NULL,
    primer_apellido    VARCHAR2(30) NOT NULL,
    segundo_apellido   VARCHAR2(30) NOT NULL,
    n_telefono         INTEGER NOT NULL,
    correo             VARCHAR2(30),
    otros_detalles     VARCHAR2(30)
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( id_cliente );

CREATE TABLE direccion (
    id_dirección   INTEGER NOT NULL,
    descripcion    VARCHAR2(30) NOT NULL
);

ALTER TABLE direccion ADD CONSTRAINT direccion_pk PRIMARY KEY ( id_dirección );

CREATE TABLE direccion_cliente (
    registrada_desde   DATE NOT NULL,
    registrada_hasta   DATE,
    id_dirección       INTEGER NOT NULL,
    id_cliente         INTEGER NOT NULL
);

ALTER TABLE direccion_cliente ADD CONSTRAINT direccion_cliente_pk PRIMARY KEY ( id_dirección,id_cliente );

CREATE TABLE envio_articulos (
    id_envio_articulos            INTEGER NOT NULL,
    orden_id_orden                INTEGER NOT NULL,
    id_cliente                    INTEGER NOT NULL,
    "_cod_estado_orden"           INTEGER NOT NULL,
    "_orden_articulo_id"          INTEGER NOT NULL,
    "_Orden_id_orden"             INTEGER NOT NULL,
    "_Orden_Cliente_id_cliente"   INTEGER NOT NULL,
    "_codigo_estado_orden"        INTEGER NOT NULL,
    "_Productos_id_producto"      INTEGER NOT NULL,
    "_Productos_id_tipo"          INTEGER NOT NULL
);

ALTER TABLE envio_articulos
    ADD CONSTRAINT envio_articulos_pk PRIMARY KEY ( id_envio_articulos,orden_id_orden,id_cliente,"_cod_estado_orden","_orden_articulo_id","_Orden_id_orden"
,"_Orden_Cliente_id_cliente","_codigo_estado_orden","_Productos_id_producto","_Productos_id_tipo" );

CREATE TABLE envios (
    id_envio                   INTEGER NOT NULL,
    fecha_solicitud            DATE NOT NULL,
    otros_detalles             VARCHAR2(30),
    id_orden                   INTEGER NOT NULL,
    id_cliente                 INTEGER NOT NULL,
    cod_estado_orden           INTEGER NOT NULL,
    factura_id_factura         INTEGER NOT NULL,
    id_estado_factura          INTEGER NOT NULL,
    factura_orden_id_orden     INTEGER NOT NULL,
    factura_orden_id_cliente   INTEGER NOT NULL,
    codigo_estado_orden        INTEGER NOT NULL
);

ALTER TABLE envios
    ADD CONSTRAINT envios_pk PRIMARY KEY ( id_envio,id_orden,id_cliente,cod_estado_orden,factura_id_factura,id_estado_factura,factura_orden_id_orden
,factura_orden_id_cliente,codigo_estado_orden );

CREATE TABLE estado_factura (
    id_estado_factura    INTEGER NOT NULL,
    descripcion_estado   VARCHAR2(7) NOT NULL
);

ALTER TABLE estado_factura ADD CONSTRAINT estado_factura_pk PRIMARY KEY ( id_estado_factura );

CREATE TABLE estado_orden (
    codigo_estado_orden   INTEGER NOT NULL,
    descripcion           VARCHAR2(30) NOT NULL
);

ALTER TABLE estado_orden ADD CONSTRAINT estado_orden_pk PRIMARY KEY ( codigo_estado_orden );

CREATE TABLE factura (
    id_factura          INTEGER NOT NULL,
    fecha_emision       DATE NOT NULL,
    mas_detalles        VARCHAR2(30),
    id_estado_factura   INTEGER NOT NULL,
    id_orden            INTEGER NOT NULL,
    id_cliente          INTEGER NOT NULL,
    cod_estado_orden    INTEGER NOT NULL
);

ALTER TABLE factura
    ADD CONSTRAINT factura_pk PRIMARY KEY ( id_factura,id_estado_factura,id_orden,id_cliente,cod_estado_orden );

CREATE TABLE metodo_pago_cliente (
    id_mpago_cliente   INTEGER NOT NULL,
    id_tipo_pago       INTEGER NOT NULL,
    id_cliente         INTEGER NOT NULL
);

ALTER TABLE metodo_pago_cliente
    ADD CONSTRAINT metodo_pago_cliente_pk PRIMARY KEY ( id_mpago_cliente,id_tipo_pago,id_cliente );

CREATE TABLE orden (
    id_orden              INTEGER NOT NULL,
    fecha_procesada       DATE NOT NULL,
    otros_detalles        VARCHAR2(30),
    id_cliente            INTEGER NOT NULL,
    codigo_estado_orden   INTEGER NOT NULL
);

ALTER TABLE orden
    ADD CONSTRAINT orden_pk PRIMARY KEY ( id_orden,id_cliente,codigo_estado_orden );

CREATE TABLE orden_articulo (
    orden_articulo_id          INTEGER NOT NULL,
    cantidad                   INTEGER NOT NULL,
    orden_id_orden             INTEGER NOT NULL,
    orden_cliente_id_cliente   INTEGER NOT NULL,
    productos_id_producto      INTEGER NOT NULL,
    "_Producto_id_tipo"        INTEGER NOT NULL,
    "_cod_estado_orden"        INTEGER NOT NULL
);

ALTER TABLE orden_articulo
    ADD CONSTRAINT orden_articulo_pk PRIMARY KEY ( orden_articulo_id,orden_id_orden,orden_cliente_id_cliente,"_cod_estado_orden",productos_id_producto
,"_Producto_id_tipo" );

CREATE TABLE pagos (
    id_pago                    INTEGER NOT NULL,
    fecha_pago                 DATE NOT NULL,
    monto_pago                 FLOAT(2) NOT NULL,
    iid_factura                INTEGER NOT NULL,
    id_estado_factura          INTEGER NOT NULL,
    factura_orden_id_orden     INTEGER NOT NULL,
    factura_orden_id_cliente   INTEGER NOT NULL,
    codigo_estado_orden        INTEGER NOT NULL,
    id_mpago_cliente           INTEGER NOT NULL,
    id_tipo_pago               INTEGER NOT NULL,
    "_id_cliente"              INTEGER NOT NULL
);

ALTER TABLE pagos
    ADD CONSTRAINT pagos_pk PRIMARY KEY ( id_pago,iid_factura,id_estado_factura,factura_orden_id_orden,factura_orden_id_cliente,codigo_estado_orden
,id_mpago_cliente,id_tipo_pago,"_id_cliente" );

CREATE TABLE productos (
    id_producto             INTEGER NOT NULL,
    marca                   VARCHAR2(30) NOT NULL,
    precio                  FLOAT(2) NOT NULL,
    otros_detalles          VARCHAR2(30),
    tipo_producto_id_tipo   INTEGER NOT NULL
);

ALTER TABLE productos ADD CONSTRAINT productos_pk PRIMARY KEY ( id_producto,tipo_producto_id_tipo );

CREATE TABLE registro_seguimiento (
    id_seguimiento             INTEGER NOT NULL,
    estado                     VARCHAR2(7) NOT NULL,
    mensaje                    VARCHAR2(30) NOT NULL,
    fecha_evento               DATE NOT NULL,
    orden_id_orden             INTEGER NOT NULL,
    orden_cliente_id_cliente   INTEGER NOT NULL,
    "_cod_estado_orden"        INTEGER NOT NULL
);

ALTER TABLE registro_seguimiento
    ADD CONSTRAINT registro_seguimiento_pk PRIMARY KEY ( id_seguimiento,orden_id_orden,orden_cliente_id_cliente,"_cod_estado_orden" );

CREATE TABLE tipo_de_pago (
    id_tipo_pago   INTEGER NOT NULL,
    descripcion    VARCHAR2(30) NOT NULL
);

ALTER TABLE tipo_de_pago ADD CONSTRAINT tipo_de_pago_pk PRIMARY KEY ( id_tipo_pago );

CREATE TABLE tipo_producto (
    id_tipo       INTEGER NOT NULL,
    descripcion   VARCHAR2(30)
);

ALTER TABLE tipo_producto ADD CONSTRAINT tipo_producto_pk PRIMARY KEY ( id_tipo );

ALTER TABLE direccion_cliente
    ADD CONSTRAINT direccion_cliente_cliente_fk FOREIGN KEY ( id_cliente )
        REFERENCES cliente ( id_cliente );

ALTER TABLE direccion_cliente
    ADD CONSTRAINT direccion_cliente_direccion_fk FOREIGN KEY ( id_dirección )
        REFERENCES direccion ( id_dirección );

ALTER TABLE envio_articulos
    ADD CONSTRAINT envio_art_orden_art_fk FOREIGN KEY ( "_orden_articulo_id","_Orden_id_orden","_Orden_Cliente_id_cliente","_codigo_estado_orden"
,"_Productos_id_producto","_Productos_id_tipo" )
        REFERENCES orden_articulo ( orden_articulo_id,orden_id_orden,orden_cliente_id_cliente,"_cod_estado_orden",productos_id_producto,"_Producto_id_tipo"
);

ALTER TABLE envio_articulos
    ADD CONSTRAINT envio_articulos_orden_fk FOREIGN KEY ( orden_id_orden,id_cliente,"_cod_estado_orden" )
        REFERENCES orden ( id_orden,id_cliente,codigo_estado_orden );

ALTER TABLE envios
    ADD CONSTRAINT envios_factura_fk FOREIGN KEY ( factura_id_factura,id_estado_factura,factura_orden_id_orden,factura_orden_id_cliente,codigo_estado_orden
)
        REFERENCES factura ( id_factura,id_estado_factura,id_orden,id_cliente,cod_estado_orden );

ALTER TABLE envios
    ADD CONSTRAINT envios_orden_fk FOREIGN KEY ( id_orden,id_cliente,cod_estado_orden )
        REFERENCES orden ( id_orden,id_cliente,codigo_estado_orden );

ALTER TABLE factura
    ADD CONSTRAINT factura_estado_factura_fk FOREIGN KEY ( id_estado_factura )
        REFERENCES estado_factura ( id_estado_factura );

ALTER TABLE factura
    ADD CONSTRAINT factura_orden_fk FOREIGN KEY ( id_orden,id_cliente,cod_estado_orden )
        REFERENCES orden ( id_orden,id_cliente,codigo_estado_orden );

ALTER TABLE metodo_pago_cliente
    ADD CONSTRAINT met_pago_clien_tipo_pago_fk FOREIGN KEY ( id_tipo_pago )
        REFERENCES tipo_de_pago ( id_tipo_pago );

ALTER TABLE metodo_pago_cliente
    ADD CONSTRAINT metodo_pago_cliente_cliente_fk FOREIGN KEY ( id_cliente )
        REFERENCES cliente ( id_cliente );

ALTER TABLE orden_articulo
    ADD CONSTRAINT orden_articulo_orden_fk FOREIGN KEY ( orden_id_orden,orden_cliente_id_cliente,"_cod_estado_orden" )
        REFERENCES orden ( id_orden,id_cliente,codigo_estado_orden );

ALTER TABLE orden_articulo
    ADD CONSTRAINT orden_articulo_productos_fk FOREIGN KEY ( productos_id_producto,"_Producto_id_tipo" )
        REFERENCES productos ( id_producto,tipo_producto_id_tipo );

ALTER TABLE orden
    ADD CONSTRAINT orden_cliente_fk FOREIGN KEY ( id_cliente )
        REFERENCES cliente ( id_cliente );

ALTER TABLE orden
    ADD CONSTRAINT orden_estado_orden_fk FOREIGN KEY ( codigo_estado_orden )
        REFERENCES estado_orden ( codigo_estado_orden );

ALTER TABLE pagos
    ADD CONSTRAINT pagos_factura_fk FOREIGN KEY ( iid_factura,id_estado_factura,factura_orden_id_orden,factura_orden_id_cliente,codigo_estado_orden
)
        REFERENCES factura ( id_factura,id_estado_factura,id_orden,id_cliente,cod_estado_orden );

ALTER TABLE pagos
    ADD CONSTRAINT pagos_metodo_pago_cliente_fk FOREIGN KEY ( id_mpago_cliente,id_tipo_pago,"_id_cliente" )
        REFERENCES metodo_pago_cliente ( id_mpago_cliente,id_tipo_pago,id_cliente );

ALTER TABLE productos
    ADD CONSTRAINT productos_tipo_producto_fk FOREIGN KEY ( tipo_producto_id_tipo )
        REFERENCES tipo_producto ( id_tipo );

ALTER TABLE registro_seguimiento
    ADD CONSTRAINT registro_seguimiento_orden_fk FOREIGN KEY ( orden_id_orden,orden_cliente_id_cliente,"_cod_estado_orden" )
        REFERENCES orden ( id_orden,id_cliente,codigo_estado_orden );
        
                
CREATE SEQUENCE PROJECTDB.SEQ_codcliente
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;

CREATE SEQUENCE PROJECTDB.SEQ_direccion
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;

CREATE SEQUENCE PROJECTDB.SEQ_id_envio_articulos
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;

CREATE SEQUENCE PROJECTDB.SEQ_id_envio
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;

CREATE SEQUENCE PROJECTDB.SEQ_idfactura
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;

CREATE SEQUENCE PROJECTDB.SEQ_id_orden
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;

CREATE SEQUENCE PROJECTDB.SEQ_orden_articulo_id
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;

CREATE SEQUENCE PROJECTDB.SEQ_id_pago
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;

CREATE SEQUENCE PROJECTDB.SEQ_id_productos
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;

CREATE SEQUENCE PROJECTDB.SEQ_id_seguimiento
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;

CREATE SEQUENCE PROJECTDB.SEQ_id_tipo_producto
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;

CREATE SEQUENCE PROJECTDB.SEQ_id_estado_orden
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;

CREATE SEQUENCE PROJECTDB.SEQ_id_tipo_pago
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;

CREATE SEQUENCE PROJECTDB.SEQ_estado_factura
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;


INSERT INTO estado_orden (codigo_estado_orden,descripcion) VALUES (SEQ_id_estado_orden.nextval, 'Completada');
INSERT INTO estado_orden (codigo_estado_orden,descripcion) VALUES (SEQ_id_estado_orden.nextval, 'Cancelada');

INSERT INTO tipo_de_pago (id_tipo_pago,descripcion) VALUES (SEQ_id_tipo_pago.nextval, 'Tarjeta-Credito');
INSERT INTO tipo_de_pago (id_tipo_pago,descripcion) VALUES (SEQ_id_tipo_pago.nextval, 'Tarjeta-Debito');
INSERT INTO tipo_de_pago (id_tipo_pago,descripcion) VALUES (SEQ_id_tipo_pago.nextval, 'Efectivo');

INSERT INTO estado_factura (id_estado_factura ,descripcion_estado) VALUES (SEQ_estado_factura.nextval, 'Emitida');

--Prueba de comentario

--Prueba de comentario2

--Prueba de comentario5

--Prueba de comentario6

COMMIT;
