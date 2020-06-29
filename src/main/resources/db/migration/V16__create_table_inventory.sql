CREATE TABLE inventory
(
    inventory_id SERIAL PRIMARY KEY,
    film_id      INTEGER REFERENCES film ON UPDATE CASCADE ON DELETE RESTRICT   NOT NULL,
    store_id     SMALLINT REFERENCES store ON UPDATE CASCADE ON DELETE RESTRICT NOT NULL,
    last_update  TIMESTAMPTZ DEFAULT now()                                      NOT NULL
);

CREATE INDEX idx_store_id_film_id
    ON inventory (store_id, film_id);
