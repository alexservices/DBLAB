/* Paquete*/
create or replace package pkg_gestion is
/*tipo pago */
procedure agregar_tipopago (d_tpago in varchar2);
procedure cambiar_tipopago (id_tpago in integer,d_tpago in varchar2); 
procedure eliminar_tipopago(id_tpago in integer);
function  obtener_todostpago return sys_refcursor;
/* pais */
procedure agregar_pais (nom_pais in varchar2);
procedure cambiar_pais(id_p in integer,nom_pais in varchar2);
procedure eliminar_pais(id_p in integer);
function  obtener_todospais return sys_refcursor;
/* estado */
procedure agregar_estado (nom_estado in varchar2, id_p in integer);
procedure cambiar_estado(id_e in integer,nom_estado in varchar2,id_p in integer);
procedure eliminar_estado(id_e in integer);
function  obtener_estadosbypais return sys_refcursor;
END pkg_gestion;
/* Cuerpo del paquete*/
create or replace package body pkg_gestion is
/*Gestion tipo pago*/
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
/*Gestion pais */
procedure agregar_pais (nom_pais in varchar2)is
begin
insert into pais(id_pais,n_pais) values (seq_idpais.nextval,nom_pais);
end;
procedure cambiar_pais(id_p in integer,nom_pais in varchar2)is
begin
update pais 
set n_pais= nom_pais
where id_pais=id_p;
end;
procedure eliminar_pais(id_p in integer) is
begin
delete from pais
where id_pais= id_p;
end;
function obtener_todospais return sys_refcursor is
v_result sys_refcursor;
begin
open v_result for
select * from pais;
return (v_result);
end;
/*Gestion estado*/
procedure agregar_estado (nom_estado in varchar2, id_p in integer)is
begin
insert into estado(id_estado,n_estado,id_pais) values (seq_idestado.nextval,nom_estado,id_p);
end;
procedure cambiar_estado(id_e in integer,nom_estado in varchar2,id_p in integer) is
begin
update estado 
set n_estado= nom_estado, id_pais = id_p
where id_estado=id_e;
end;
procedure eliminar_estado(id_e in integer) is
begin
delete from estado
where id_estado= id_e;
end;
function obtener_estadosbypais return sys_refcursor is
v_result sys_refcursor;
begin
open v_result for
select * from estado order by id_pais;
return (v_result);
end;
END  pkg_gestion;
/*Tablas y alteraciones */
CREATE TABLE cant_orden_producto (
    id_cant_prod   INTEGER NOT NULL,
    valor_cantp    FLOAT(2) NOT NULL,
    id_orden       INTEGER NOT NULL
);
ALTER TABLE cant_orden_producto ADD CONSTRAINT cant_orden_producto_pk PRIMARY KEY ( id_cant_prod );

CREATE TABLE ciudad (
    codigo_postal   INTEGER NOT NULL,
    n_ciudad        VARCHAR2(30) NOT NULL,
    id_estado       INTEGER NOT NULL
);
ALTER TABLE ciudad ADD CONSTRAINT ciudad_pk PRIMARY KEY ( codigo_postal );

CREATE TABLE cliente (
    id_cliente         INTEGER NOT NULL,
    codigo_cliente     INTEGER NOT NULL,
    primer_nombre      VARCHAR2(30) NOT NULL,
    segundo_nombre     VARCHAR2(30),
    primer_apellido    VARCHAR2(30) NOT NULL,
    segundo_apellido   VARCHAR2(30),
    n_telefono         INTEGER NOT NULL,
    correo             VARCHAR2(30) NOT NULL,
    id_dcliente        INTEGER NOT NULL
);
ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( id_cliente );

CREATE TABLE direccion (
    id_direccion   INTEGER NOT NULL,
    descripcion    VARCHAR2(30) NOT NULL,
    id_pais        INTEGER NOT NULL
);
ALTER TABLE direccion ADD CONSTRAINT direccion_pk PRIMARY KEY ( id_direccion );

CREATE TABLE direccion_cliente (
    id_dcliente     INTEGER NOT NULL,
    registrada_en   DATE NOT NULL,
    hasta           DATE,
    id_direccion    INTEGER NOT NULL
);
ALTER TABLE direccion_cliente ADD CONSTRAINT direccion_cliente_pk PRIMARY KEY ( id_dcliente );

CREATE TABLE estado (
    id_estado   INTEGER NOT NULL,
    n_estado    VARCHAR2(30) NOT NULL,
    id_pais     INTEGER NOT NULL
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
    id_factura      INTEGER NOT NULL,
    fecha_emision   DATE NOT NULL,
    id_orden        INTEGER NOT NULL,
    id_estado       INTEGER NOT NULL
);
ALTER TABLE factura ADD CONSTRAINT factura_pk PRIMARY KEY ( id_factura );

CREATE TABLE metodo_pago_cliente (
    id_mpago_cliente   INTEGER NOT NULL,
    id_tipo_pago       INTEGER NOT NULL,
    id_cliente         INTEGER NOT NULL
);
ALTER TABLE metodo_pago_cliente ADD CONSTRAINT metodo_pago_cliente_pk PRIMARY KEY ( id_mpago_cliente );

CREATE TABLE orden (
    id_orden     INTEGER NOT NULL,
    creada_en    DATE NOT NULL,
    id_cliente   INTEGER NOT NULL,
    id_estado    INTEGER NOT NULL
);
ALTER TABLE orden ADD CONSTRAINT orden_pk PRIMARY KEY ( id_orden );

CREATE TABLE pago_factura (
    id_pago            INTEGER NOT NULL,
    id_factura         INTEGER NOT NULL,
    id_mpago_cliente   INTEGER NOT NULL
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
    id_seguimiento   INTEGER NOT NULL,
    fecha_evento     DATE NOT NULL,
    mensaje          VARCHAR2(30) NOT NULL,
    id_orden         INTEGER NOT NULL,
    id_estado        INTEGER NOT NULL
);
ALTER TABLE seguimiento ADD CONSTRAINT seguimiento_pk PRIMARY KEY ( id_seguimiento );

CREATE TABLE tipo_pago (
    id_tipo_pago   INTEGER NOT NULL,
    d_tipopago     VARCHAR2(30) NOT NULL
);
ALTER TABLE tipo_pago ADD CONSTRAINT tipo_pago_pk PRIMARY KEY ( id_tipo_pago );

CREATE TABLE tipo_producto (
    id_tipo        INTEGER NOT NULL,
    n_tipo         VARCHAR2(30) NOT NULL,
    id_producto    INTEGER NOT NULL,
    id_cant_prod   INTEGER NOT NULL
);
ALTER TABLE tipo_producto ADD CONSTRAINT tipo_producto_pk PRIMARY KEY ( id_tipo );

ALTER TABLE cant_orden_producto
    ADD CONSTRAINT cant_orden_producto_orden_fk FOREIGN KEY ( id_orden )
        REFERENCES orden ( id_orden )
            ON DELETE CASCADE;

ALTER TABLE ciudad
    ADD CONSTRAINT ciudad_estado_fk FOREIGN KEY ( id_estado )
        REFERENCES estado ( id_estado )
            ON DELETE CASCADE;

ALTER TABLE cliente
    ADD CONSTRAINT cliente_direccion_cliente_fk FOREIGN KEY ( id_dcliente )
        REFERENCES direccion_cliente ( id_dcliente )
            ON DELETE CASCADE;
            
ALTER TABLE direccion_cliente
    ADD CONSTRAINT direccion_cliente_direccion_fk FOREIGN KEY ( id_direccion )
        REFERENCES direccion ( id_direccion )
            ON DELETE CASCADE;

ALTER TABLE direccion
    ADD CONSTRAINT direccion_pais_fk FOREIGN KEY ( id_pais )
        REFERENCES pais ( id_pais )
            ON DELETE CASCADE;

ALTER TABLE estado
    ADD CONSTRAINT estado_pais_fk FOREIGN KEY ( id_pais )
        REFERENCES pais ( id_pais )
            ON DELETE CASCADE;

ALTER TABLE factura
    ADD CONSTRAINT factura_estado_factura_fk FOREIGN KEY ( id_estado )
        REFERENCES estado_factura ( id_estado )
            ON DELETE CASCADE;

ALTER TABLE factura
    ADD CONSTRAINT factura_orden_fk FOREIGN KEY ( id_orden )
        REFERENCES orden ( id_orden )
            ON DELETE CASCADE;

ALTER TABLE metodo_pago_cliente
    ADD CONSTRAINT met_pago_cliente_tipo_pago_fk FOREIGN KEY ( id_tipo_pago )
        REFERENCES tipo_pago ( id_tipo_pago )
            ON DELETE CASCADE;

ALTER TABLE metodo_pago_cliente
    ADD CONSTRAINT metodo_pago_cliente_cliente_fk FOREIGN KEY ( id_cliente )
        REFERENCES cliente ( id_cliente )
            ON DELETE CASCADE;

ALTER TABLE orden
    ADD CONSTRAINT orden_cliente_fk FOREIGN KEY ( id_cliente )
        REFERENCES cliente ( id_cliente )
            ON DELETE CASCADE;

ALTER TABLE orden
    ADD CONSTRAINT orden_estado_orden_fk FOREIGN KEY ( id_estado )
        REFERENCES estado_orden ( id_estado )
            ON DELETE CASCADE;

ALTER TABLE pago_factura
    ADD CONSTRAINT pago_fact_met_pago_cliente_fk FOREIGN KEY ( id_mpago_cliente )
        REFERENCES metodo_pago_cliente ( id_mpago_cliente )
            ON DELETE CASCADE;

ALTER TABLE pago_factura
    ADD CONSTRAINT pago_factura_factura_fk FOREIGN KEY ( id_factura )
        REFERENCES factura ( id_factura )
            ON DELETE CASCADE;

ALTER TABLE seguimiento
    ADD CONSTRAINT seguimiento_estado_seg_fk FOREIGN KEY ( id_estado )
        REFERENCES estado_seguimiento ( id_estado )
            ON DELETE CASCADE;

ALTER TABLE seguimiento
    ADD CONSTRAINT seguimiento_orden_fk FOREIGN KEY ( id_orden )
        REFERENCES orden ( id_orden )
            ON DELETE CASCADE;

ALTER TABLE tipo_producto
    ADD CONSTRAINT tipo_prod_cant_orden_prod_fk FOREIGN KEY ( id_cant_prod )
        REFERENCES cant_orden_producto ( id_cant_prod )
            ON DELETE CASCADE;

ALTER TABLE tipo_producto
    ADD CONSTRAINT tipo_producto_producto_fk FOREIGN KEY ( id_producto )
        REFERENCES producto ( id_producto )
            ON DELETE CASCADE;
/* Secuencias*/            
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

procedure agregar_direccion
(dir_descrip in varchar2, 
nom_pais in varchar2,
nom_estado in varchar2, 
cod_postal in integer,
nom_ciudad in varchar2);

/*Pruebas Pais
declare 
nom_pais varchar2(30) := 'Guatemala';
BEGIN
pkg_gestion.agregar_pais(nom_pais);
END;
declare 
nom_pais varchar2(30) := 'Honduras';
BEGIN
pkg_gestion.agregar_pais(nom_pais);
END;
declare 
nom_pais varchar2(30) := 'Nicaragua';
BEGIN
pkg_gestion.agregar_pais(nom_pais);
END;
declare
id_p number:=3;
nom_pais varchar2(30) := 'Costa Rica';
BEGIN
pkg_gestion.cambiar_pais(id_p,nom_pais);
END;
declare
id_p number:=3;
BEGIN
pkg_gestion.eliminar_pais(id_p);
END;
SELECT PKG_GESTION.OBTENER_TODOSPAIS() FROM DUAL;
*/
/*Pruebas estado
declare 
nom_estado varchar2(30) := 'Guatemala';
id_p number:=1;
BEGIN
pkg_gestion.agregar_estado(nom_estado,id_p);
END;
declare 
nom_estado varchar2(30) := 'San Pedro Sula';
id_p number:=2;
BEGIN
pkg_gestion.agregar_estado(nom_estado,id_p);
END;
SELECT PKG_GESTION.obtener_estadosbypais() FROM DUAL;
*/
commit;