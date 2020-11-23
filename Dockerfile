FROM maven:3.6.3-jdk-11

# get brouter source
RUN mkdir -p /usr/src/app && git clone https://github.com/abrensch/brouter.git /usr/src/app/brouter

# compile last known working version
WORKDIR /usr/src/app/brouter
RUN mvn clean install -pl '!brouter-routing-app' \
    -Dmaven.javadoc.skip=true \
    -DskipTests

EXPOSE 17777

VOLUME /data/segments
VOLUME /data/profiles
VOLUME /data/customprofiles

# REQUEST_TIMEOUT in seconds, set to 0 to disable it
ENV REQUEST_TIMEOUT 300
ENV JAVA_OPTS '-Xmx512M -Xms512M -Xmn16M -XX:+PrintCommandLineFlags'
ENV MAX_THREADS 4

WORKDIR /data

ENV SEGMENTSPATH /data/segments
ENV PROFILESPATH /data/profiles
ENV CUSTOMPROFILESPATH ../customprofiles

CMD /usr/src/app/brouter/misc/scripts/standalone/server.sh
