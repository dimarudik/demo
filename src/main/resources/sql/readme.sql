-- https://highload.today/kak-nastroit-mysql-master-slave-replikatsiyu-3f/
-- FLUSH TABLES WITH READ LOCK;
-- SHOW MASTER STATUS;
-- UNLOCK TABLES;
-- https://minervadb.com/index.php/setup-mysql-slave-replication-with-percona-xtrabackup/
-- https://dev.mysql.com/doc/mysql-replication-excerpt/5.7/en/replication-howto-rawdata.html
-- https://www.netapp.com/pdf.html?item=/media/10510-tr-4605pdf.pdf&v=202093749

-- master
CREATE USER 'slave'@'%' IDENTIFIED BY 'mypass';
GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'slave'@'%';
show master status;
flush logs;

-- slave
--change master to master_host='node1',
--master_user='slave',
--master_password='mypass',
--master_port=3306,
--master_log_file='binlog.000002',
--master_log_pos=682;

change master to master_host='db01',
master_user='slave',
master_password='mypass',
master_port=3306,
master_auto_position=1;

start slave;
show slave status \G

stop slave;
reset slave all;