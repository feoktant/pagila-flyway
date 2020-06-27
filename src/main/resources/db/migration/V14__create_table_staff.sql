CREATE TABLE staff
(
    staff_id    SMALLSERIAL PRIMARY KEY,
    first_name  TEXT                                                            NOT NULL,
    last_name   TEXT                                                            NOT NULL,
    address_id  INTEGER REFERENCES address ON UPDATE CASCADE ON DELETE RESTRICT NOT NULL,
    email       TEXT,
    store_id    SMALLINT REFERENCES store                                       NOT NULL,
    active      BOOLEAN     DEFAULT true                                        NOT NULL,
    username    TEXT                                                            NOT NULL,
    password    TEXT,
    last_update TIMESTAMPTZ DEFAULT now()                                       NOT NULL,
    picture     BYTEA
);

CREATE TRIGGER last_updated
    BEFORE UPDATE
    ON staff
    FOR EACH ROW
EXECUTE PROCEDURE last_updated();
