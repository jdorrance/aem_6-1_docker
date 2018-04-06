# DOCKER-VERSION 1.0.1
FROM smurfsky101/docker-ubuntu-14-04-java8:2
LABEL version="1.0"
LABEL description="AEM 6.1 base image"
MAINTAINER smurfsky101

ENV DEBIAN_FRONTEND noninteractive

# Install utility for AEM
ADD aemInstaller.py /aem/aemInstaller.py

# In case windows line endings exist, yuck
RUN apt-get update && apt-get -y install dos2unix software-properties-common ipython ipython3 python-psutil python-pycurl
RUN dos2unix /aem/aemInstaller.py

# Add large binaries and license stuff, unfortunately this isnt cached since its loaded over the wire
ADD https://mavendc-utils.s3.amazonaws.com/internal/cq6/6.1/cq-quickstart-6.1.0.jar /aem/cq-quickstart-6.1.0.jar
ADD https://mavendc-utils.s3.amazonaws.com/internal/cq6/license.properties /aem/license.properties

# Explode the 6.1 jar
WORKDIR /aem
RUN java -Djava.awt.headless=true -XX:MaxPermSize=256m -Xmx1280m -jar cq-quickstart-6.1.0.jar -unpack -r nosamplecontent

