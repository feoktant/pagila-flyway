CREATE TABLE category
(
    category_id SMALLSERIAL PRIMARY KEY,
    name        TEXT                      NOT NULL,
    last_update TIMESTAMPTZ DEFAULT now() NOT NULL
);
