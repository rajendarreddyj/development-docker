FROM tomcat:8.5.70-jdk8-openjdk-buster

# Update repos and install required dependencies for build
RUN apt-get update \
 && apt-get upgrade -y 

#########
# Maven #
#########

# Preparation
ENV MAVEN_HOME /etc/maven-${MAVEN_VERSION}
# Get Updated Maven Version && SHA512 checksum from https://maven.apache.org/download.cgi
ENV MAVEN_VERSION 3.6.3
ENV MAVEN_DOWNLOAD_SHA512 c35a1803a6e70a126e80b2b3ae33eed961f83ed74d18fcd16909b2d44d7dada3203f1ffe726c17ef8dcca2dcaa9fca676987befeadc9b9f759967a8cb77181c0

# Installation
RUN cd /tmp
# Download Binary and verify the integrity of the downloaded files using SHA512 checksums.
RUN wget -q "http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" \
    && echo "$MAVEN_DOWNLOAD_SHA512  apache-maven-${MAVEN_VERSION}-bin.tar.gz" \ 
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
RUN unset MAVEN_DOWNLOAD_SHA512

#######
# Ant #
#######

# Preparation
ENV ANT_HOME /etc/ant-${ANT_VERSION}
# Get Updated Ant Version && SHA512 checksum from https://ant.apache.org/bindownload.cgi
ENV ANT_VERSION 1.10.9
ENV ANT_DOWNLOAD_SHA512 ed73febff2803079d13117e18a22697eecdac64c9c52fc5259ac880d7b07f527d8ce3779851af0cda5798a368ebc979d43dd7085a0a62af57df23ff3d105dd6f

# Installation
RUN cd /tmp
# Download Binary and verify the integrity of the downloaded files using SHA512 checksums.
RUN wget -q "http://www.us.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz" \
    && echo "$ANT_DOWNLOAD_SHA512  apache-ant-${ANT_VERSION}-bin.tar.gz" \
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
RUN unset ANT_DOWNLOAD_SHA512

######################################
# Check Java/Javac/Maven/Ant Version #
######################################

RUN env
RUN java -version
RUN javac -version
RUN mvn -version
RUN ant -version
 
# Expose any necessary ports for the application
EXPOSE 8080
CMD [ "bin/catalina.sh", "run" ]
