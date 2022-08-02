FROM arm64v8/maven:3.8.6-jdk-11 AS builder
COPY src /usr/app/src
COPY pom.xml /usr/app/pom.xml
WORKDIR /usr/app
RUN mvn clean package

FROM arm64v8/openjdk:11-jdk
COPY --from=builder /usr/app/target/spring-petclinic-2.7.0-SNAPSHOT.jar petclinic.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","petclinic.jar"]