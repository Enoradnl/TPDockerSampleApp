# Utiliser une image de base légère
FROM alpine:3.19.0

# Installations nécéssaires
RUN apk update
RUN apk add openjdk8
RUN apk add maven
RUN apk add libpng-dev
RUN apk add git
RUN apk add libc6-compat

# Téléchargement de l'application
RUN git clone https://github.com/barais/TPDockerSampleApp.git

# Build
WORKDIR TPDockerSampleApp
RUN mvn install:install-file -Dfile=./lib/opencv-3410.jar \
     -DgroupId=org.opencv  -DartifactId=opencv -Dversion=3.4.10 -Dpackaging=jar
RUN mvn package


# Lancement de l'application
RUN ulimit -c unlimited
CMD java -Djava.library.path=lib/ubuntuupperthan18/ -jar target/fatjar-0.0.1-SNAPSHOT.jar
