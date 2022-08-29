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

change master to master_host='db01', master_user='slave', master_password='mypass', master_port=3306, master_auto_position=1;

start slave;
show slave status \G

stop slave;
reset slave all;

curl -i -X POST http://localhost:8080/payment -H "Content-Type:application/json" -H "clientid:0-1" -d '{"clientId": "0-1", "amount": "3500", "timestamp": "2022-07-02T11:41:46", "status": "PS"}'
curl -i -X POST http://localhost:8080/payment -H "Content-Type:application/json" -H "clientid:0-2" -d '{"clientId": "0-2", "amount": "3500", "timestamp": "2022-07-02T11:41:46", "status": "PS"}'
curl -i -X POST http://localhost:8080/payment -H "Content-Type:application/json" -H "clientid:0-3" -d '{"clientId": "0-3", "amount": "3500", "timestamp": "2022-07-02T11:41:46", "status": "PS"}'
curl -i -X POST http://localhost:8080/payment -H "Content-Type:application/json" -H "clientid:0-4" -d '{"clientId": "0-4", "amount": "3500", "timestamp": "2022-07-02T11:41:46", "status": "PS"}'

curl -i -X POST http://localhost:8080/payment -H "Content-Type:application/json" -H "clientid:0-5" -d '{"clientId": "0-5", "amount": "3500", "timestamp": "2022-07-02T11:41:46", "status": "PS"}'
curl -i -X POST http://localhost:8080/payment -H "Content-Type:application/json" -H "clientid:0-6" -d '{"clientId": "0-6", "amount": "3500", "timestamp": "2022-07-02T11:41:46", "status": "PS"}'
curl -i -X POST http://localhost:8080/payment -H "Content-Type:application/json" -H "clientid:0-7" -d '{"clientId": "0-7", "amount": "3500", "timestamp": "2022-07-02T11:41:46", "status": "PS"}'
curl -i -X POST http://localhost:8080/payment -H "Content-Type:application/json" -H "clientid:0-8" -d '{"clientId": "0-8", "amount": "3500", "timestamp": "2022-07-02T11:41:46", "status": "PS"}'

curl -i -X POST http://localhost:8080/payment -H "Content-Type:application/json" -H "clientid:0-9" -d '{"clientId": "0-9", "amount": "3500", "timestamp": "2022-07-02T11:41:46", "status": "PS"}'
curl -i -X POST http://localhost:8080/payment -H "Content-Type:application/json" -H "clientid:0-A" -d '{"clientId": "0-A", "amount": "3500", "timestamp": "2022-07-02T11:41:46", "status": "PS"}'
curl -i -X POST http://localhost:8080/payment -H "Content-Type:application/json" -H "clientid:0-B" -d '{"clientId": "0-B", "amount": "3500", "timestamp": "2022-07-02T11:41:46", "status": "PS"}'
curl -i -X POST http://localhost:8080/payment -H "Content-Type:application/json" -H "clientid:0-C" -d '{"clientId": "0-C", "amount": "3500", "timestamp": "2022-07-02T11:41:46", "status": "PS"}'

docker-compose up -d --build --scale app05=0 --scale app06=0 --scale app07=0 --scale app08=0
docker-compose up -d app05 app06
docker-compose restart balancer
