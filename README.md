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
