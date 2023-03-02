# Postgresql Partial Logical Replication Scenario In Minikube 

```
minikube start --cpus=6 --memory=8192m

kubectl apply -f ./secret-string.yaml -f ./shard01-configmap.yaml -f ./postgres-shard01.yaml -f ./postgres-shard02.yaml
kubectl get all
kubectl exec -it <podname> bash
psql -U shard -d shard

1,2> create table t1 (id int primary key);
1,2> create table t2 (id int primary key);
1> insert into t1(id) select id from generate_series(1,10) as id;
1> insert into t2(id) select id from generate_series(1,20) as id;
1> create publication tpub for table t1 where (id > 4),t2 where (id > 10);
2> create subscription tsub connection 'host=shard01-db-service.default.svc.cluster.local port=5432 user=shard password=shard dbname=shard' publication tpub;

kubectl delete -f ./secret-string.yaml -f ./shard01-configmap.yaml -f ./postgres-shard01.yaml -f ./postgres-shard02.yaml

minikube delete
```