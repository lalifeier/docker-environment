ARG APP_PATH=/app

FROM maven:3.8.4-openjdk-8-slim AS build

ARG APP_PATH
WORKDIR $APP_PATH

COPY pom.xml ./
COPY src ./src

RUN mvn clean install -Dmaven.test.skip=true

FROM openjdk:8-jdk-alpine

ARG APP_PATH
WORKDIR $APP_PATH

COPY --from=build $APP_PATH/target/*.jar $APP_PATH/app.jar

ENTRYPOINT ["java","-jar","app.jar"]
