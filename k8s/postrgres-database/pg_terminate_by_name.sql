CREATE OR REPLACE FUNCTION pg_terminate_by_name (p_usename varchar(100)) RETURNS VOID AS $$
DECLARE
    v_rec RECORD;
BEGIN
    FOR v_rec IN SELECT pid FROM pg_stat_activity WHERE usename = p_usename LOOP
      PERFORM pg_terminate_backend(v_rec.pid);
    END LOOP;
    RETURN;
END;
$$ LANGUAGE plpgsql;
