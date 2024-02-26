alter role postgres password 'postgres';
create role test login password 'test';
create role odyssey login superuser password 'odyssey';
create role pgbouncer login password 'pgbouncer';
grant select on pg_shadow to pgbouncer;
create table test (id int primary key, name text);
insert into test values (0, 'a');
insert into test values (1, 'b');
create table parted (id int, ltime timestamp not null, name text, amount bigint) partition by range (ltime);
alter table parted add primary key (id, ltime);
create table parted_def partition of parted default;
create table parted_202301 partition of parted for values from ('2023-01-01') to ('2023-01-31');
create table parted_202302 partition of parted for values from ('2023-02-01') to ('2023-02-28');
create table parted_202303 partition of parted for values from ('2023-03-01') to ('2023-03-31');
insert into parted values (0, '2022-01-10', 'a', 0), (1, '2023-01-10', 'b', 10), (2, '2023-02-10', 'c', 20), (3, '2023-03-10', 'd', 30);
create index on parted (ltime);
-- как добавить индекс на большую партиционированную табличку под нагрузкой
create index on only parted (amount);
create index concurrently on parted_def (amount);
create index concurrently on parted_202301 (amount);
create index concurrently on parted_202302 (amount);
create index concurrently on parted_202303  (amount);
alter index parted_amount_idx attach partition parted_def_amount_idx;
alter index parted_amount_idx attach partition parted_202301_amount_idx;
alter index parted_amount_idx attach partition parted_202302_amount_idx;
alter index parted_amount_idx attach partition parted_202303_amount_idx;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO test;
create extension pageinspect;
create extension pg_visibility;
create extension pg_buffercache;
create type pagerecord as (ctid text, state text, xmin text, xmax text, hhu text, hot text, t_ctid tid, xmin_age int);
create or replace function pageoftable(
        IN tablename text,
        IN pagenumber integer)
RETURNS SETOF pagerecord AS $$
SELECT '('||pagenumber||','||lp||')' AS ctid,
       CASE lp_flags
         WHEN 0 THEN 'unused'
         WHEN 1 THEN 'normal'
         WHEN 2 THEN 'redirect to '||lp_off
         WHEN 3 THEN 'dead'
       END AS state,
       t_xmin || CASE
         WHEN (t_infomask & 256) > 0 THEN ' (c)'
         WHEN (t_infomask & 512) > 0 THEN ' (a)'
         ELSE '' END
         || CASE
             WHEN (t_infomask & 256) > 0 AND (t_infomask & 512) > 0 THEN '(f)'
            ELSE '' END
       AS xmin,
       t_xmax || CASE
         WHEN (t_infomask & 1024) > 0 THEN ' (c)'
         WHEN (t_infomask & 2048) > 0 THEN ' (a)'
         ELSE ''
       END AS xmax,
       CASE WHEN (t_infomask2 & 16384) > 0 THEN 't' END AS hhu,
       CASE WHEN (t_infomask2 & 32768) > 0 THEN 't' END AS hot,
       t_ctid,
       age(t_xmin) AS xmin_age
FROM heap_page_items(get_raw_page(tablename,pagenumber))
ORDER BY lp;
$$ LANGUAGE sql;
CREATE VIEW pg_buffercache_v AS
SELECT bufferid,
       (SELECT c.relname
        FROM   pg_class c
        WHERE  pg_relation_filenode(c.oid) = b.relfilenode
       ) relname,
       CASE relforknumber
         WHEN 0 THEN 'main'
         WHEN 1 THEN 'fsm'
         WHEN 2 THEN 'vm'
       END relfork,
       relblocknumber,
       isdirty,
       usagecount
FROM   pg_buffercache b
WHERE  b.reldatabase IN (
         0, (SELECT oid FROM pg_database WHERE datname = current_database())
       )
AND    b.usagecount IS NOT NULL;
