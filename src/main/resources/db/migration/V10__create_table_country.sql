CREATE TABLE country
(
    country_id  SERIAL PRIMARY KEY,
    country     TEXT                      NOT NULL,
    last_update TIMESTAMPTZ DEFAULT now() NOT NULL
);

CREATE TRIGGER last_updated
    BEFORE UPDATE
    ON country
    FOR EACH ROW
EXECUTE PROCEDURE last_updated();
