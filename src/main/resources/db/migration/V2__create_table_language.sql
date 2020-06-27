CREATE TABLE language
(
    language_id SMALLSERIAL PRIMARY KEY,
    name        CHAR(20)                  NOT NULL,
    last_update TIMESTAMPTZ DEFAULT now() NOT NULL
);

CREATE TRIGGER last_updated
    BEFORE UPDATE
    ON language
    FOR EACH ROW
EXECUTE PROCEDURE last_updated();
