# Usar una imagen base de OpenJDK con Java 17
FROM openjdk:17-jdk-slim

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar los archivos del proyecto al contenedor
COPY . .

# Ejecutar Gradle para generar el archivo .jar (bootJar)
RUN ./gradlew clean bootJar --no-daemon

# Copiar el archivo application.properties al contenedor (opcional)
COPY src/main/resources/application.properties /app/config/application.properties

# Configurar la variable de entorno PATH_FILE
# Ajustar el valor según lo indicado en el HELP.md
ENV PATH_FILE=/app/src/main/resources/food.txt


# Exponer el puerto que está configurado en application.properties
EXPOSE 8082

# Ejecutar el archivo .jar generado
CMD ["java", "-jar", "/app/build/libs/cinemafood-0.0.1-SNAPSHOT.jar", "--spring.config.additional-location=/app/config/application.properties"]

