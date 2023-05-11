alter role postgres password 'postgres';
create role test login password 'test';
create role odyssey login superuser password 'odyssey';
create role pgbouncer login password 'pgbouncer';
grant select on pg_shadow to pgbouncer;
create table test (id int primary key, name text);
insert into test values (0, 'a');
insert into test values (1, 'b');
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO test;
