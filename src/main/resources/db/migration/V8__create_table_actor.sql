CREATE TABLE actor
(
    actor_id    SERIAL PRIMARY KEY,
    first_name  TEXT                      NOT NULL,
    last_name   TEXT                      NOT NULL,
    last_update TIMESTAMPTZ DEFAULT now() NOT NULL
);

CREATE INDEX idx_actor_last_name
    ON actor (last_name);

CREATE TRIGGER last_updated
    BEFORE UPDATE
    ON actor
    FOR EACH ROW
EXECUTE PROCEDURE last_updated();
