FROM maven:3.5.2-jdk-8-alpine AS maven_build
COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
RUN mvn package

FROM openjdk:8-jdk-alpine
RUN apk add bash git curl gcc g++ make cmake python maven openjdk8
RUN git clone https://github.com/GoogleCloudPlatform/cloud-debug-java
WORKDIR cloud-debug-java
RUN bash build.sh
RUN mkdir -p /opt/cdbg
RUN tar -xvf cdbg_java_agent_service_account.tar.gz -C /opt/cdbg
COPY --from=maven_build /tmp/target/hello-world-0.1.0.jar /data/hello-world-0.1.0.jar

EXPOSE 8080

CMD java -agentpath:/opt/cdbg/cdbg_java_agent.so \
    -Dcom.google.cdbg.module=myapp3 \
    -Dcom.google.cdbg.version=1 \
    -Dcom.google.cdbg.breakpoints.enable_canary=true \
    -jar /data/hello-world-0.1.0.jar
