CREATE DOMAIN year AS integer
    CONSTRAINT year_check CHECK (VALUE BETWEEN 1901 AND 2155);