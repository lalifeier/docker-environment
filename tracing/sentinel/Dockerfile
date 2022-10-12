FROM openjdk:8-jdk-alpine

ENV SENTINEL_HOME /opt/sentinel-dashboard

RUN mkdir -p ${SENTINEL_HOME}

ADD https://github.com/alibaba/Sentinel/releases/download/1.8.5/sentinel-dashboard-1.8.5.jar ${SENTINEL_HOME}/sentinel-dashboard.jar

WORKDIR ${SENTINEL_HOME}

EXPOSE 8858
EXPOSE 8719

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-Dserver.port=8858", "-Dcsp.sentinel.api.port=8719", "-Dcsp.sentinel.dashboard.server=localhost:8858", "-Dproject.name=sentinel-dashboard", "-jar", "sentinel-dashboard.jar"]
