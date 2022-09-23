FROM openjdk:17-jdk-alpine
RUN addgroup -S spring && adduser -S spring -G spring
RUN mkdir -p /app
RUN mkdir -p /app/config
RUN chown -R spring: /app
USER spring:spring
WORKDIR /app
COPY ./target/shard-0.0.1-SNAPSHOT.jar /app/shard-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/app/shard-0.0.1-SNAPSHOT.jar"]
