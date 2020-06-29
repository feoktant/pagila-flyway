CREATE OR REPLACE FUNCTION last_updated() RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$$
BEGIN
    NEW.last_update = CURRENT_TIMESTAMP;
    RETURN NEW;
END
$$;

DO
$$
    DECLARE
        t record;
    BEGIN
        FOR t IN
            SELECT table_name
            FROM information_schema.columns
            WHERE column_name = 'last_update'
            LOOP
                EXECUTE format(
                        'CREATE TRIGGER last_updated
                         BEFORE UPDATE
                         ON %I
                         FOR EACH ROW EXECUTE PROCEDURE last_updated();',
                        t.table_name);
            END LOOP;
    END;
$$ LANGUAGE plpgsql;
