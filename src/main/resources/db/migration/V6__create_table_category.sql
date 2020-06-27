CREATE TABLE category
(
    category_id SMALLSERIAL PRIMARY KEY,
    name        TEXT                      NOT NULL,
    last_update TIMESTAMPTZ DEFAULT now() NOT NULL
);

CREATE TRIGGER last_updated
    BEFORE UPDATE
    ON category
    FOR EACH ROW
EXECUTE PROCEDURE last_updated();