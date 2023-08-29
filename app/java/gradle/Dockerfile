# FROM eclipse-temurin:17-jdk AS builder
FROM gradle:8.1.1-jdk17-focal AS builder
WORKDIR /workspace/app

# COPY gradle/ ./gradle/
# COPY buildSrc/ ./buildSrc/
# COPY *.gradle.kts gradle.properties gradlew ./

COPY . .

RUN --mount=type=cache,id=gradle-cache,target=~/.gradle gradle clean build -x test --no-daemon --info

FROM eclipse-temurin:17-jre-alpine AS layers-builder
WORKDIR /workspace/app

COPY --from=builder build/libs/*.jar app.jar
RUN java -Djarmode=layertools -jar app.jar extract

FROM eclipse-temurin:17-jre-alpine
WORKDIR /workspace/app

COPY --from=layers-builder /workspace/app/dependencies/ ./
COPY --from=layers-builder /workspace/app/spring-boot-loader/ ./
COPY --from=layers-builder /workspace/app/snapshot-dependencies/ ./
COPY --from=layers-builder /workspace/app/application/ ./

ENTRYPOINT ["java","org.springframework.boot.loader.JarLauncher"]
