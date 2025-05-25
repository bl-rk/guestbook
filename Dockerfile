# Required runtine for project
FROM eclipse-temurin:21-jdk

#  working directory
WORKDIR /app

# Copy .jar file (output from Jenkins build stage)
COPY target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
