DO
$$
    DECLARE
        t record;
    BEGIN
        FOR t IN
            SELECT clm.table_schema, clm.table_name
            FROM information_schema.columns clm
                     LEFT JOIN information_schema.triggers trg
                               ON trg.trigger_catalog = clm.table_catalog
                                   AND trg.trigger_schema = clm.table_schema
                                   AND trg.event_object_table = clm.table_name
            WHERE clm.column_name = 'last_update'
              AND clm.table_schema = '${flyway:defaultSchema}'
              AND trg.trigger_name IS NULL
            LOOP
                RAISE INFO 'Creating trigger for %.%', t.table_schema, t.table_name;
                EXECUTE format(
                        'CREATE TRIGGER last_updated
                         BEFORE UPDATE
                         ON %1$s.%2$s
                         FOR EACH ROW EXECUTE PROCEDURE last_updated();',
                        t.table_schema, t.table_name);
            END LOOP;
    END;
$$ LANGUAGE plpgsql;
