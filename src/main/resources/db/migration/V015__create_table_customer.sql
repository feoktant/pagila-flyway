CREATE TABLE customer
(
    customer_id SERIAL PRIMARY KEY,
    store_id    SMALLINT REFERENCES store ON UPDATE CASCADE ON DELETE RESTRICT  NOT NULL,
    first_name  TEXT                                                            NOT NULL,
    last_name   TEXT                                                            NOT NULL,
    email       TEXT,
    address_id  INTEGER REFERENCES address ON UPDATE CASCADE ON DELETE RESTRICT NOT NULL,
    activebool  BOOLEAN     DEFAULT true                                        NOT NULL,
    create_date DATE        DEFAULT now()                                       NOT NULL,
    last_update TIMESTAMPTZ DEFAULT now(), -- TODO why it is nullable?
    active      INTEGER
);