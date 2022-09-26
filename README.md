# To Do

**Image**

1. Build project:

```
mvn package -DskipTests
```

2. Create image:

```
docker build . -t dimarudik/shard:latest
```

3. Login with your Docker ID to push images:

```
docker login
```

4. Upload image to Docker Hub:

```
docker push dimarudik/shard:latest
```

---

**Minikube**

1. Start minikube:

```
minikube start --cpus=6 --memory=8192m
```

2. Create dashboard:

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.6.1/aio/deploy/recommended.yaml
```

3. Create user:

```
kubectl apply -f dashboard-adminuser.yaml
```

4. Create token:

```
kubectl -n kubernetes-dashboard create token admin-user
```

5. Start proxy:

```
kubectl proxy
```

6. [K8s Dashboard](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/)

---

**Hints**

Delete untagged images:

```
docker rmi $(docker images -f "dangling=true" -q)
```

Delete unused volumes

```
docker volume prune
```

Start postgres in docker

```
docker run --name my-postgres -e POSTGRES_USER=shard -e POSTGRES_PASSWORD=shard -e POSTGRES_DB=shard -p 5432:5432 -d postgres
```

Connect to postgres remotely

```
psql -h localhost -p 5432 -U shard -W
```

Start mysql in docker

```
docker run --name my-mysql -e MYSQL_ROOT_PASSWORD=shard -e MYSQL_DATABASE=shard -e MYSQL_USER=shard -e MYSQL_PASSWORD=shard -p 3306:3306 -d mysql
```

Connect to mysql remotely

```
mysql -uroot -p -h 127.0.0.1 --port 3306
```

PSQL Commands

```
\l+   # show databases
\dt+  # show tables
```