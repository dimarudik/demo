# Yugabyte


1. Start minikube:

```
minikube start --cpus=6 --memory=16384m
```

2. Create namespace:

```
kubectl create namespace yb-demo
```

3. Install env:

```
helm install yb-demo yugabyte/ --version 2.17.2 \
--set replicas.master=1,replicas.tserver=1
```
or
```
helm install yb-demo yugabyte/ \
--version 2.17.2 \
--set resource.master.requests.cpu=0.5,resource.master.requests.memory=0.5Gi,\
resource.tserver.requests.cpu=0.5,resource.tserver.requests.memory=0.5Gi,\
replicas.master=1,replicas.tserver=1
```

4. Upgrade

```
helm upgrade yb-demo yugabyte/ --set replicas.tserver=4
```

5. List help deployments:

```
helm list
```

6. Delete

```
helm delete yb-demo
```

7. YSQL

```
kubectl exec -it yb-tserver-0 bash

ysqlsh
```

8. Admin UI

```
kubectl port-forward svc/yb-master-ui 7000:7000

http://localhost:7000/
```