FROM oraclelinux:8-slim

LABEL maintainer="rajendarreddyj@gmail.com"


# JDK Required Packages fontconfig : Added to support OpenJDK inside container
RUN microdnf install -y tzdata openssl curl ca-certificates fontconfig gzip tar \
    && microdnf update -y --nodocs \
    && microdnf clean all
    
# fontconfig : Added to support OpenJDK inside container
RUN microdnf install -y \
    freetype  \
    iputils \ 
    bind-utils \
    curl \
    net-tools \
    less \
    wget \
    findutils \
    && rm -Rf /var/cache/yum \
    && rm -Rf /var/cache/dnf 

##########
#  Java  #
##########
# Preparation
ENV JAVA_HOME /usr/local/openjdk-8
# Get Latest adoptopenjdk Version, URL && SHA256 checksum from https://github.com/AdoptOpenJDK/openjdk8-binaries/releases
ENV JAVA_VERSION jdk8u282-b08
ENV JAVA_BINARY_URL https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u282-b08/OpenJDK8U-jdk_x64_linux_hotspot_8u282b08.tar.gz
ENV JAVA_SHA256 e6e6e0356649b9696fa5082cfcb0663d4bef159fc22d406e3a012e71fce83a5c

RUN cd /tmp
# Download Binary and verify the integrity of the downloaded files using SHA512 checksums.
RUN wget -q "$JAVA_BINARY_URL" -O "adoptopenjdk-${JAVA_VERSION}-bin.tar.gz" \
    && echo "$JAVA_SHA256 adoptopenjdk-${JAVA_VERSION}-bin.tar.gz" \ 
    | sha256sum -c
# Create directory to extract tar 
RUN mkdir adoptopenjdk-${JAVA_VERSION}
# Extract tar file to directory
RUN tar -zxf adoptopenjdk-${JAVA_VERSION}-bin.tar.gz --directory adoptopenjdk-${JAVA_VERSION} --strip-components=1
# Move directory to JAVA_HOME
RUN mv adoptopenjdk-${JAVA_VERSION} ${JAVA_HOME}
# Add Java binary to path
ENV PATH ${PATH}:${JAVA_HOME}/bin

# Cleanup Jdk residue
RUN rm adoptopenjdk-${JAVA_VERSION}-bin.tar.gz
RUN unset JAVA_VERSION
RUN unset JAVA_SHA256

#########
# Maven #
#########

# Preparation
ENV MAVEN_HOME /usr/local/maven-${MAVEN_VERSION}
# Get Latest Maven Version && SHA512 checksum from https://maven.apache.org/download.cgi
ENV MAVEN_VERSION 3.6.3
ENV MAVEN_SHA512 c35a1803a6e70a126e80b2b3ae33eed961f83ed74d18fcd16909b2d44d7dada3203f1ffe726c17ef8dcca2dcaa9fca676987befeadc9b9f759967a8cb77181c0

# Installation
RUN cd /tmp
# Download Binary and verify the integrity of the downloaded files using SHA512 checksums.
RUN wget -q "https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" \
    && echo "$MAVEN_SHA512  apache-maven-${MAVEN_VERSION}-bin.tar.gz" \ 
    | sha512sum -c
# Create directory to extract tar 
RUN mkdir maven-${MAVEN_VERSION}
# Extract tar file to directory
RUN tar -zxf apache-maven-${MAVEN_VERSION}-bin.tar.gz --directory maven-${MAVEN_VERSION} --strip-components=1
# Move directory to MAVEN_HOME
RUN mv maven-${MAVEN_VERSION} ${MAVEN_HOME}
# Add Maven binary to path
ENV PATH ${PATH}:${MAVEN_HOME}/bin

# Cleanup Maven residue
RUN rm apache-maven-${MAVEN_VERSION}-bin.tar.gz
RUN unset MAVEN_VERSION
RUN unset MAVEN_SHA512

#######
# Ant #
#######

# Preparation
ENV ANT_HOME /usr/local/ant-${ANT_VERSION}
# Get Latest Ant Version && SHA512 checksum from https://ant.apache.org/bindownload.cgi
ENV ANT_VERSION 1.10.9
ENV ANT_SHA512 ed73febff2803079d13117e18a22697eecdac64c9c52fc5259ac880d7b07f527d8ce3779851af0cda5798a368ebc979d43dd7085a0a62af57df23ff3d105dd6f

# Installation
RUN cd /tmp
# Download Binary and verify the integrity of the downloaded files using SHA512 checksums.
RUN wget -q "https://downloads.apache.org/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz" \
    && echo "$ANT_SHA512  apache-ant-${ANT_VERSION}-bin.tar.gz" \
    | sha512sum -c
# Create directory to extract tar     
RUN mkdir ant-${ANT_VERSION}
# Extract tar file to directory
RUN tar -zxf apache-ant-${ANT_VERSION}-bin.tar.gz --directory ant-${ANT_VERSION} --strip-components=1
# Move directory to ANT_HOME
RUN mv ant-${ANT_VERSION} ${ANT_HOME}
# Add Ant binary to path
ENV PATH ${PATH}:${ANT_HOME}/bin

# Cleanup Ant Residue
RUN rm apache-ant-${ANT_VERSION}-bin.tar.gz
RUN unset ANT_VERSION
RUN unset ANT_SHA512

######################################
# Check Java/Javac/Maven/Ant Version #
######################################

RUN env
RUN java -version
RUN javac -version
RUN mvn -version
RUN ant -version

##########
# Tomcat #
##########
# Preparation
ENV CATALINA_HOME /usr/local/tomcat

# Get Latest Tomcat Version && SHA512 checksum from https://tomcat.apache.org/download-80.cgi
ENV TOMCAT_VERSION 8.5.65
ENV TOMCAT_SHA512 eb5a77d75a46496f7de39c1cba5f4fc4991ec7da7717e7b37ad48b4ca2ea334aeabfd094f64977477b4b2352637b56e30e5d9acfcdf7ccd5f4269a824829dd39

# Installation
RUN cd /tmp
# Download Binary and verify the integrity of the downloaded files using SHA512 checksums.
RUN wget -q "https://downloads.apache.org/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz" \
    && echo "$TOMCAT_SHA512  apache-tomcat-${TOMCAT_VERSION}.tar.gz" \
    | sha512sum -c
# Create directory to extract tar     
RUN mkdir tomcat-${TOMCAT_VERSION}
# Extract tar file to directory
RUN tar -zxf apache-tomcat-${TOMCAT_VERSION}.tar.gz --directory tomcat-${TOMCAT_VERSION} --strip-components=1
# Move directory to ANT_HOME
RUN mv tomcat-${TOMCAT_VERSION} ${CATALINA_HOME}
# Add CATALINA_HOME  to path
ENV PATH $CATALINA_HOME/bin:$PATH

# Cleanup Tomcat Residue
RUN rm apache-tomcat-${TOMCAT_VERSION}.tar.gz
RUN unset TOMCAT_VERSION
RUN unset TOMCAT_SHA512

# Set CATALINA_HOME as WORKDIR 
WORKDIR $CATALINA_HOME

RUN set -eux; \
    # https://tomcat.apache.org/tomcat-9.0-doc/security-howto.html#Default_web_applications
    mv webapps webapps.dist; \
    mkdir webapps; \
    # sh removes env vars it doesn't support (ones with periods)
    # https://github.com/docker-library/tomcat/issues/77
    find ./bin/ -name '*.sh' -exec sed -ri 's|^#!/bin/sh$|#!/usr/bin/env bash|' '{}' +; \
    \
    # fix permissions (especially for running as non-root)
    # https://github.com/docker-library/tomcat/issues/35
    chmod -R +rX .; \
    chmod 777 logs temp work; \
    \
    # smoke test
    catalina.sh version

# Remove unnecessary packages    
RUN microdnf remove findutils wget \ 
    && microdnf clean all
     
# Expose any necessary ports for the application
EXPOSE 8080
CMD [ "bin/catalina.sh", "run" ]
