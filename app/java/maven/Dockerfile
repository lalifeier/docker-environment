
# FROM eclipse-temurin:17-jdk AS builder
FROM maven:3.8.4-openjdk-17-slim AS builder
WORKDIR /workspace/app

# COPY pom.xml mvnw ./
# COPY .mvn .mvn
# COPY src ./src

COPY . .

RUN --mount=type=cache,id=mvn-cache,target=~/.m2 mvn clean install -Dmaven.test.skip=true

FROM eclipse-temurin:17-jre-alpine AS layers-builder
WORKDIR /workspace/app

COPY --from=builder target/*.jar app.jar
RUN java -Djarmode=layertools -jar app.jar extract

FROM eclipse-temurin:17-jre-alpine
WORKDIR /workspace/app

COPY --from=layers-builder /workspace/app/dependencies/ ./
COPY --from=layers-builder /workspace/app/spring-boot-loader/ ./
COPY --from=layers-builder /workspace/app/snapshot-dependencies/ ./
COPY --from=layers-builder /workspace/app/application/ ./

ENTRYPOINT ["java","org.springframework.boot.loader.JarLauncher"]
