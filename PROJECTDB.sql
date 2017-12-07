


CREATE TABLE cant_orden_producto (
    id_cant_prod     INTEGER NOT NULL,
    valor_cantp      FLOAT(2) NOT NULL,
    orden_id_orden   INTEGER NOT NULL
);

ALTER TABLE cant_orden_producto ADD CONSTRAINT cant_orden_producto_pk PRIMARY KEY ( id_cant_prod );

commit;