CREATE TABLE store
(
    store_id         SMALLSERIAL PRIMARY KEY,
    manager_staff_id SMALLINT                                                        NOT NULL,
    address_id       INTEGER REFERENCES address ON UPDATE CASCADE ON DELETE RESTRICT NOT NULL,
    last_update      TIMESTAMPTZ DEFAULT now()                                       NOT NULL,
    CONSTRAINT unq_manager_staff_id_idx UNIQUE (manager_staff_id)
);
