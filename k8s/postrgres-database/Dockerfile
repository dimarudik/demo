FROM postgres:latest
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV POSTGRES_HOST_AUTH_METHOD=md5
COPY init.sql /docker-entrypoint-initdb.d/
USER postgres:postgres
WORKDIR /var/lib/postgresql/data
CMD ["postgres", "-c", "password_encryption=md5"]
#docker build ./k8s/postrgres-database/ -t dimarudik/postgres
#docker run --name my -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=postgres -d dimarudik/postgres
