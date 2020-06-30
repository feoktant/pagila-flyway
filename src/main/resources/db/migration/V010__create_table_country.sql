CREATE TABLE country
(
    country_id  SERIAL PRIMARY KEY,
    country     TEXT                      NOT NULL,
    last_update TIMESTAMPTZ DEFAULT now() NOT NULL
);
