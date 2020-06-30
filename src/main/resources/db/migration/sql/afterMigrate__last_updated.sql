DO
$$
    DECLARE
        t record;
    BEGIN
        FOR t IN
            SELECT *
            FROM information_schema.columns
            WHERE column_name = 'last_update'
              AND table_schema = '${flyway:defaultSchema}'
            LOOP
                EXECUTE format( -- TODO is it possible to select only needed tables?
                        'DROP TRIGGER IF EXISTS last_updated ON %1$s.%2$s;
                         CREATE TRIGGER last_updated
                         BEFORE UPDATE
                         ON %1$s.%2$s
                         FOR EACH ROW EXECUTE PROCEDURE last_updated();',
                        t.table_schema, t.table_name);
            END LOOP;
    END;
$$ LANGUAGE plpgsql;
