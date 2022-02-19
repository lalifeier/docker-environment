FROM maven:3.8.4-openjdk-8-slim AS build

WORKDIR /app

COPY src ./src
COPY pom.xml ./
RUN mvn clean install -Dmaven.test.skip=true

FROM openjdk:8-jdk-alpine

WORKDIR /usr/src/

COPY --from=build /app/target/spring-boot-0.0.1-SNAPSHOT.jar /usr/src/app.jar

ENTRYPOINT ["java","-jar","app.jar"]
