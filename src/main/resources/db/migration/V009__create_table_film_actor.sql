CREATE TABLE film_actor
(
    actor_id    INTEGER REFERENCES actor ON UPDATE CASCADE ON DELETE RESTRICT,
    film_id     INTEGER REFERENCES film ON UPDATE CASCADE ON DELETE RESTRICT,
    last_update TIMESTAMPTZ DEFAULT now() NOT NULL,
    PRIMARY KEY (actor_id, film_id)
);

CREATE INDEX ON film_actor (film_id);
