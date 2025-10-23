# FROM openjdk:8-jdk-alpine
# WORKDIR /app
# COPY ./target/*.jar ./app.jar
# CMD ["java", "-jar", "app.jar"]

# Use JDK 17 to build
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app

# Copy Maven files and source code
COPY pom.xml .
COPY src ./src

# Build the jar
RUN mvn clean package -DskipTests

# Use JRE 17 for runtime
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy jar from build stage
COPY --from=build /app/target/*.jar ./app.jar

# Run the app
CMD ["java", "-jar", "app.jar"]
