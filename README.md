# To Do

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

**Hints**

Delete untagged images:

```
docker rmi $(docker images -f "dangling=true" -q)
```

Delete unused volumes

```
docker volume prune
```
