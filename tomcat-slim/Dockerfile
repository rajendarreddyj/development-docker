FROM tomcat:8.5.65-jdk8-openjdk-slim-buster
LABEL maintainer="rajendarreddy jagapathi rajendarreddyj@gmail.com"

# added noninteractive DEBIAN_FRONTEND. please refer https://stackoverflow.com/a/56569081/2162534
# update dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get update \ 
    && apt-get upgrade -yq 
# Added missing Java runtime dependencies in the slim version
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq \ 
    fontconfig \ 
    libfreetype6 \
    iputils-ping \
    dnsutils \
    curl \
    vim-tiny \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH=/log4j:$PATH
ENV LOG4J_DIR=/log4j
ENV JAVA_OPTS="-Xmx4096m -Dfile.encoding=UTF-8 -Djava.awt.headless=true -Djava.net.preferIPv4Stack=true -Dcom.sun.management.jmxremote.port=5560 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false "

# Security remove unused default webapps
RUN rm -rf ${CATALINA_HOME}/webapps/docs \
 ${CATALINA_HOME}/webapps/examples \
 ${CATALINA_HOME}/webapps/host-manager \
 ${CATALINA_HOME}/webapps/manager \
 ${CATALINA_HOME}/webapps/ROOT

# Set up the mwtomcat user and group
RUN groupadd -g 502 mwtomcat \
 && useradd -m -s /bin/bash -d /home/mwtomcat -u 502 -g 502 mwtomcat \
 && usermod -a -G mwtomcat mwtomcat \
 && chown -R mwtomcat.mwtomcat ${CATALINA_HOME}
 
# Expose any necessary ports for the application
EXPOSE 5560
EXPOSE 8080
CMD [ "bin/catalina.sh", "run" ] 
