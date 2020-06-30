CREATE TABLE film
(
    film_id              SERIAL PRIMARY KEY,
    title                TEXT                                                              NOT NULL,
    description          TEXT,
    release_year         year,
    language_id          SMALLINT REFERENCES language ON UPDATE CASCADE ON DELETE RESTRICT NOT NULL,
    original_language_id SMALLINT REFERENCES language ON UPDATE CASCADE ON DELETE RESTRICT,
    rental_duration      SMALLINT      DEFAULT 3                                           NOT NULL,
    rental_rate          NUMERIC(4, 2) DEFAULT 4.99                                        NOT NULL,
    length               SMALLINT,
    replacement_cost     NUMERIC(5, 2) DEFAULT 19.99                                       NOT NULL,
    rating               mpaa_rating   DEFAULT 'G',
    special_features     feature[],
    last_update          TIMESTAMPTZ   DEFAULT now()                                       NOT NULL,
    fulltext             TSVECTOR                                                          NOT NULL
);

CREATE TRIGGER film_fulltext_trigger
    BEFORE INSERT OR UPDATE
    ON film
    FOR EACH ROW
EXECUTE PROCEDURE tsvector_update_trigger('fulltext', 'pg_catalog.english', 'title', 'description');

CREATE INDEX film_fulltext_idx
    ON film (fulltext);

CREATE INDEX idx_title
    ON film (title);

CREATE INDEX idx_fk_language_id
    ON film (language_id);

CREATE INDEX idx_fk_original_language_id
    ON film (original_language_id);