alter role postgres password 'postgres';
create role test login password 'test';
create role odyssey login superuser password 'odyssey';
create role pgbouncer login password 'pgbouncer';
grant select on pg_shadow to pgbouncer;