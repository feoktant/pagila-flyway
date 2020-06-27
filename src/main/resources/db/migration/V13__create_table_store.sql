CREATE TABLE store
(
    store_id         SMALLSERIAL PRIMARY KEY,
    manager_staff_id SMALLINT                                                        NOT NULL,
    address_id       INTEGER REFERENCES address ON UPDATE CASCADE ON DELETE RESTRICT NOT NULL,
    last_update      TIMESTAMPTZ DEFAULT now()                                       NOT NULL
);

CREATE UNIQUE INDEX idx_unq_manager_staff_id
    ON store (manager_staff_id);

CREATE TRIGGER last_updated
    BEFORE UPDATE
    ON store
    FOR EACH ROW
EXECUTE PROCEDURE last_updated();
