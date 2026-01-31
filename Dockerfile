# syntax=docker/dockerfile:1
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app

# Copy dependencies and source
COPY . .

RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre-jammy
WORKDIR /app


COPY --from=build /app/target/*.war application.war
EXPOSE 8080


# Run the application
ENTRYPOINT ["java", "-jar", "application.war"]
