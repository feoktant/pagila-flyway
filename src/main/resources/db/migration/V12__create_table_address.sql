CREATE TABLE address
(
    address_id  SERIAL PRIMARY KEY,
    address     TEXT                                                         NOT NULL,
    address2    TEXT,
    district    TEXT                                                         NOT NULL,
    city_id     INTEGER REFERENCES city ON UPDATE CASCADE ON DELETE RESTRICT NOT NULL,
    postal_code TEXT,
    phone       TEXT                                                         NOT NULL,
    last_update TIMESTAMPTZ DEFAULT now()                                    NOT NULL
);

CREATE INDEX idx_fk_city_id
    ON address (city_id);

CREATE TRIGGER last_updated
    BEFORE UPDATE
    ON address
    FOR EACH ROW
EXECUTE PROCEDURE last_updated();
