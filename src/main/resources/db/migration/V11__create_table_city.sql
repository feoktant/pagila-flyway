CREATE TABLE city
(
    city_id     SERIAL PRIMARY KEY,
    city        TEXT                                                            NOT NULL,
    country_id  INTEGER REFERENCES country ON UPDATE CASCADE ON DELETE RESTRICT NOT NULL,
    last_update TIMESTAMPTZ DEFAULT now()                                       NOT NULL
);

CREATE INDEX idx_fk_country_id
    ON city (country_id);

CREATE TRIGGER last_updated
    BEFORE UPDATE
    ON city
    FOR EACH ROW
EXECUTE PROCEDURE last_updated();


