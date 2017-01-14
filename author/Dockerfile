# DOCKER-VERSION 1.7.0 AUTHOR
FROM aem_6-2_base
LABEL version="1.0"
LABEL description="AEM author docker image"
MAINTAINER smurfsky101

# In case windows line endings exist, yuck
RUN apt-get -y install dos2unix

#Copies required build media
ADD resources/*.jar /aem/cq-author-4502.jar
ADD resources/license.properties /aem/license.properties
ADD resources/postInstallHook.py /aem/postInstallHook.py
ADD resources/packagelist.txt /aem/packagelist.txt
#ADD resources/packages/*.zip /aem/packages/

# Cleanup windows line just in case
RUN dos2unix /aem/*

# Extracts AEM
WORKDIR /aem
RUN java -Djava.awt.headless=true -XX:MaxPermSize=256m -Xmx1280m -jar cq-author-4502.jar -unpack -r nosamplecontent


# Add customised log file, to print the logging to standard out.
ADD resources/org.apache.sling.commons.log.LogManager.config /aem/crx-quickstart/install/org.apache.sling.commons.log.LogManager.config
ADD resources/org.apache.jackrabbit.oak.plugins.segment.SegmentNodeStoreService.cfg /aem/crx-quickstart/install/org.apache.jackrabbit.oak.plugins.segment.SegmentNodeStoreService.cfg

# Cleanup windows line just in case
RUN dos2unix /aem/crx-quickstart/install/org.apache.sling.commons.log.LogManager.config
RUN dos2unix /aem/crx-quickstart/install/org.apache.jackrabbit.oak.plugins.segment.SegmentNodeStoreService.cfg

# Installs AEM
WORKDIR /aem
RUN ["python","aemInstaller.py","-i","cq-author-4502.jar","-r","author","-p","4502"]

WORKDIR /aem/crx-quickstart/bin
RUN mv quickstart quickstart.original
ADD resources/quickstart /aem/crx-quickstart/bin/quickstart

# Convert from windows line endings, just in case
RUN dos2unix /aem/crx-quickstart/bin/*

# Make AEM executable
RUN chmod +x /aem/crx-quickstart/bin/quickstart
RUN chmod +x /aem/compaction.sh

EXPOSE 4502
ENTRYPOINT ["/aem/crx-quickstart/bin/quickstart"]
#ENTRYPOINT ["/aem/compaction.sh"]
