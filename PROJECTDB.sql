CREATE OR REPLACE PACKAGE pkg_gestion IS
PROCEDURE agregar_tipopago (d_tpago in varchar2);
procedure cambiar_tipopago (id_tpago in integer,d_tpago in varchar2); 
procedure eliminar_tipopago(id_tpago in integer);
function  obtener_todostpago return sys_refcursor;
END pkg_gestion;

CREATE OR REPLACE PACKAGE BODY pkg_gestion IS

procedure agregar_tipopago (d_tpago in varchar2)is
begin
insert into tipo_pago(id_tipo_pago, d_tipopago)
values (SEQ_idtipopago.nextval,d_tpago);
end;

procedure cambiar_tipopago (id_tpago in integer,d_tpago in varchar2) is
begin
update tipo_pago 
set d_tipopago= d_tpago
where id_tipo_pago=id_tpago;
end;

procedure eliminar_tipopago(id_tpago in integer) is
begin
delete from tipo_pago
where id_tipo_pago= id_tpago;
end;

function obtener_todostpago return sys_refcursor is
v_result sys_refcursor;
begin
open v_result for
select * from tipo_pago;
return (v_result);
end;

END  pkg_gestion;


CREATE TABLE cant_orden_producto (
    id_cant_prod     INTEGER NOT NULL,
    valor_cantp      FLOAT(2) NOT NULL,
    orden_id_orden   INTEGER NOT NULL
);

ALTER TABLE cant_orden_producto ADD CONSTRAINT cant_orden_producto_pk PRIMARY KEY ( id_cant_prod );

CREATE TABLE ciudad (
    id_ciudad          INTEGER NOT NULL,
    n_ciudad           VARCHAR2(30) NOT NULL,
    codigo_postal      INTEGER NOT NULL,
    estado_id_estado   INTEGER NOT NULL
);

ALTER TABLE ciudad ADD CONSTRAINT ciudad_pk PRIMARY KEY ( id_ciudad );

CREATE TABLE cliente (
    id_cliente                  INTEGER NOT NULL,
    codigo_cliente              INTEGER NOT NULL,
    primer_nombre               VARCHAR2(30) NOT NULL,
    segundo_nombre              VARCHAR2(30),
    primer_apellido             VARCHAR2(30) NOT NULL,
    segundo_apellido            VARCHAR2(30),
    n_telefono                  INTEGER NOT NULL,
    correo                      VARCHAR2(30) NOT NULL,
    direccion_cliente_id_dirc   INTEGER NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( id_cliente );

CREATE TABLE direccion (
    id_direccion                INTEGER NOT NULL,
    descripcion                 VARCHAR2(30) NOT NULL,
    pais_id_pais                INTEGER NOT NULL,
    direccion_cliente_id_dirc   INTEGER NOT NULL,
    id_dirc                     INTEGER NOT NULL
);

ALTER TABLE direccion ADD CONSTRAINT direccion_pk PRIMARY KEY ( id_direccion );

CREATE TABLE direccion_cliente (
    id_dirc         INTEGER NOT NULL,
    registrada_en   DATE NOT NULL,
    hasta           DATE,
    id_pais         INTEGER NOT NULL
);

ALTER TABLE direccion_cliente ADD CONSTRAINT direccion_cliente_pk PRIMARY KEY ( id_dirc );

CREATE TABLE estado (
    id_estado          INTEGER NOT NULL,
    n_estado           VARCHAR2(30) NOT NULL,
    ciudad_id_ciudad   INTEGER,
    pais_id_pais       INTEGER NOT NULL
);

ALTER TABLE estado ADD CONSTRAINT estado_pk PRIMARY KEY ( id_estado );

CREATE TABLE estado_factura (
    id_estado   INTEGER NOT NULL,
    d_estado    VARCHAR2(30) NOT NULL
);

ALTER TABLE estado_factura ADD CONSTRAINT estado_factura_pk PRIMARY KEY ( id_estado );

CREATE TABLE estado_orden (
    id_estado   INTEGER NOT NULL,
    d_estado    VARCHAR2(30) NOT NULL
);

ALTER TABLE estado_orden ADD CONSTRAINT estado_orden_pk PRIMARY KEY ( id_estado );

CREATE TABLE estado_seguimiento (
    id_estado   INTEGER NOT NULL,
    d_estado    VARCHAR2(30) NOT NULL
);

ALTER TABLE estado_seguimiento ADD CONSTRAINT estado_seguimiento_pk PRIMARY KEY ( id_estado );

CREATE TABLE factura (
    id_factura                 INTEGER NOT NULL,
    fecha_emision              DATE NOT NULL,
    orden_id_orden             INTEGER NOT NULL,
    estado_factura_id_estado   INTEGER NOT NULL
);

ALTER TABLE factura ADD CONSTRAINT factura_pk PRIMARY KEY ( id_factura );

CREATE TABLE metodo_pago_cliente (
    id_mpago_cliente         INTEGER NOT NULL,
    tipo_pago_id_tipo_pago   INTEGER NOT NULL,
    cliente_id_cliente       INTEGER NOT NULL
);

ALTER TABLE metodo_pago_cliente ADD CONSTRAINT metodo_pago_cliente_pk PRIMARY KEY ( id_mpago_cliente );

CREATE TABLE orden (
    id_orden                 INTEGER NOT NULL,
    creada_en                DATE NOT NULL,
    cliente_id_cliente       INTEGER NOT NULL,
    estado_orden_id_estado   INTEGER NOT NULL
);

ALTER TABLE orden ADD CONSTRAINT orden_pk PRIMARY KEY ( id_orden );

CREATE TABLE pago_factura (
    id_pago                      INTEGER NOT NULL,
    factura_id_factura           INTEGER NOT NULL,
    mpcliente_id_mpago_cliente   INTEGER NOT NULL
);

ALTER TABLE pago_factura ADD CONSTRAINT pago_factura_pk PRIMARY KEY ( id_pago );

CREATE TABLE pais (
    id_pais   INTEGER NOT NULL,
    n_pais    VARCHAR2(30) NOT NULL
);

ALTER TABLE pais ADD CONSTRAINT pais_pk PRIMARY KEY ( id_pais );

CREATE TABLE producto (
    id_producto   INTEGER NOT NULL,
    marca         VARCHAR2(30) NOT NULL,
    precio        INTEGER NOT NULL
);

ALTER TABLE producto ADD CONSTRAINT producto_pk PRIMARY KEY ( id_producto );

CREATE TABLE seguimiento (
    id_seguimiento                 INTEGER NOT NULL,
    fecha_evento                   DATE NOT NULL,
    mensaje                        VARCHAR2(30) NOT NULL,
    orden_id_orden                 INTEGER NOT NULL,
    estado_seguimiento_id_estado   INTEGER NOT NULL
);

ALTER TABLE seguimiento ADD CONSTRAINT seguimiento_pk PRIMARY KEY ( id_seguimiento );

CREATE TABLE tipo_pago (
    id_tipo_pago   INTEGER NOT NULL,
    d_tipopago     VARCHAR2(30) NOT NULL
);

ALTER TABLE tipo_pago ADD CONSTRAINT tipo_pago_pk PRIMARY KEY ( id_tipo_pago );

CREATE TABLE tipo_producto (
    id_tipo                INTEGER NOT NULL,
    n_tipo                 VARCHAR2(30) NOT NULL,
    producto_id_producto   INTEGER NOT NULL,
    cop_id_cant_prod       INTEGER NOT NULL
);

ALTER TABLE tipo_producto ADD CONSTRAINT tipo_producto_pk PRIMARY KEY ( id_tipo );

ALTER TABLE cant_orden_producto
    ADD CONSTRAINT cant_orden_producto_orden_fk FOREIGN KEY ( orden_id_orden )
        REFERENCES orden ( id_orden )
            ON DELETE CASCADE;

ALTER TABLE ciudad
    ADD CONSTRAINT ciudad_estado_fk FOREIGN KEY ( estado_id_estado )
        REFERENCES estado ( id_estado );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_direccion_cliente_fk FOREIGN KEY ( direccion_cliente_id_dirc )
        REFERENCES direccion_cliente ( id_dirc )
            ON DELETE CASCADE;

ALTER TABLE direccion
    ADD CONSTRAINT direccion_direccion_cliente_fk FOREIGN KEY ( direccion_cliente_id_dirc )
        REFERENCES direccion_cliente ( id_dirc )
            ON DELETE CASCADE;

ALTER TABLE direccion
    ADD CONSTRAINT direccion_pais_fk FOREIGN KEY ( pais_id_pais )
        REFERENCES pais ( id_pais )
            ON DELETE CASCADE;

ALTER TABLE estado
    ADD CONSTRAINT estado_ciudad_fk FOREIGN KEY ( ciudad_id_ciudad )
        REFERENCES ciudad ( id_ciudad )
            ON DELETE CASCADE;

ALTER TABLE estado
    ADD CONSTRAINT estado_pais_fk FOREIGN KEY ( pais_id_pais )
        REFERENCES pais ( id_pais )
            ON DELETE CASCADE;

ALTER TABLE factura
    ADD CONSTRAINT factura_estado_factura_fk FOREIGN KEY ( estado_factura_id_estado )
        REFERENCES estado_factura ( id_estado )
            ON DELETE CASCADE;

ALTER TABLE factura
    ADD CONSTRAINT factura_orden_fk FOREIGN KEY ( orden_id_orden )
        REFERENCES orden ( id_orden )
            ON DELETE CASCADE;

ALTER TABLE metodo_pago_cliente
    ADD CONSTRAINT m_p_c_tipo_pago_fk FOREIGN KEY ( tipo_pago_id_tipo_pago )
        REFERENCES tipo_pago ( id_tipo_pago )
            ON DELETE CASCADE;

ALTER TABLE metodo_pago_cliente
    ADD CONSTRAINT metodo_pago_cliente_cliente_fk FOREIGN KEY ( cliente_id_cliente )
        REFERENCES cliente ( id_cliente )
            ON DELETE CASCADE;

ALTER TABLE orden
    ADD CONSTRAINT orden_cliente_fk FOREIGN KEY ( cliente_id_cliente )
        REFERENCES cliente ( id_cliente )
            ON DELETE CASCADE;

ALTER TABLE orden
    ADD CONSTRAINT orden_estado_orden_fk FOREIGN KEY ( estado_orden_id_estado )
        REFERENCES estado_orden ( id_estado )
            ON DELETE CASCADE;

ALTER TABLE pago_factura
    ADD CONSTRAINT p_f_m_pago_cliente_fk FOREIGN KEY ( mpcliente_id_mpago_cliente )
        REFERENCES metodo_pago_cliente ( id_mpago_cliente )
            ON DELETE CASCADE;

ALTER TABLE pago_factura
    ADD CONSTRAINT pago_factura_factura_fk FOREIGN KEY ( factura_id_factura )
        REFERENCES factura ( id_factura )
            ON DELETE CASCADE;

ALTER TABLE seguimiento
    ADD CONSTRAINT s_estado_seguimiento_fk FOREIGN KEY ( estado_seguimiento_id_estado )
        REFERENCES estado_seguimiento ( id_estado )
            ON DELETE CASCADE;

ALTER TABLE seguimiento
    ADD CONSTRAINT seguimiento_orden_fk FOREIGN KEY ( orden_id_orden )
        REFERENCES orden ( id_orden )
            ON DELETE CASCADE;

ALTER TABLE tipo_producto
    ADD CONSTRAINT t_p_cant_orden_producto_fk FOREIGN KEY ( cop_id_cant_prod )
        REFERENCES cant_orden_producto ( id_cant_prod )
            ON DELETE CASCADE;

ALTER TABLE tipo_producto
    ADD CONSTRAINT tipo_producto_producto_fk FOREIGN KEY ( producto_id_producto )
        REFERENCES producto ( id_producto )
            ON DELETE CASCADE;
            
            
CREATE SEQUENCE PROJECTDB.SEQ_iddireccion
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;      

CREATE SEQUENCE PROJECTDB.SEQ_idpais
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;  

CREATE SEQUENCE PROJECTDB.SEQ_idestado
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER; 

CREATE SEQUENCE PROJECTDB.SEQ_idciudad
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER; 

CREATE SEQUENCE PROJECTDB.SEQ_dirc
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER; 

CREATE SEQUENCE PROJECTDB.SEQ_codcliente
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER; 

CREATE SEQUENCE PROJECTDB.SEQ_idmpagocliente
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER; 

CREATE SEQUENCE PROJECTDB.SEQ_idtipopago
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER; 

CREATE SEQUENCE PROJECTDB.SEQ_idorden
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;

CREATE SEQUENCE PROJECTDB.SEQ_idestadoor
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

CREATE SEQUENCE PROJECTDB.SEQ_idefactura
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;

CREATE SEQUENCE PROJECTDB.SEQ_idpfactura
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;

CREATE SEQUENCE PROJECTDB.SEQ_idseguimiento
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;

CREATE SEQUENCE PROJECTDB.SEQ_ideseguimiento
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;

CREATE SEQUENCE PROJECTDB.SEQ_idcantprovalorp
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;

CREATE SEQUENCE PROJECTDB.SEQ_idtipoproducto
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;

CREATE SEQUENCE PROJECTDB.SEQ_idproducto
MINVALUE 1
NOMAXVALUE
START WITH 1
NOCYCLE
CACHE  20
NOORDER;


commit;