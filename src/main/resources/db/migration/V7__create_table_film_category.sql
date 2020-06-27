CREATE TABLE film_category
(
    film_id     INTEGER REFERENCES film ON UPDATE CASCADE ON DELETE RESTRICT,
    category_id SMALLINT REFERENCES category ON UPDATE CASCADE ON DELETE RESTRICT,
    last_update TIMESTAMPTZ DEFAULT now() NOT NULL,
    PRIMARY KEY (film_id, category_id)
);

CREATE TRIGGER last_updated
    BEFORE UPDATE
    ON film_category
    FOR EACH ROW
EXECUTE PROCEDURE last_updated();
