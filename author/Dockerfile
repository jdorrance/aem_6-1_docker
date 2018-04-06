# DOCKER-VERSION 1.7.0 AUTHOR
FROM smurfsky101/6-1_base:latest as base

#Copies required build media
RUN mv /aem/cq-quickstart-6.1.0.jar /aem/cq-author-4502.jar
#ADD resources/packagelist.txt /aem/packagelist.txt
ADD resources/packages/*.zip /aem/packages/
ADD resources/postInstallHook.py /aem/postInstallHook.py

WORKDIR /aem
# Add customised log file, to print the logging to standard out.
ADD resources/org.apache.sling.commons.log.LogManager.config /aem/crx-quickstart/install/org.apache.sling.commons.log.LogManager.config
ADD resources/org.apache.jackrabbit.oak.plugins.segment.SegmentNodeStoreService.cfg /aem/crx-quickstart/install/org.apache.jackrabbit.oak.plugins.segment.SegmentNodeStoreService.cfg
#RUN mv /aem/packages/replication_agent.zip /aem/crx-quickstart/install/replication_agent.zip

# Cleanup windows line just in case
RUN dos2unix /aem/*
RUN dos2unix /aem/crx-quickstart/install/org.apache.sling.commons.log.LogManager.config
RUN dos2unix /aem/crx-quickstart/install/org.apache.jackrabbit.oak.plugins.segment.SegmentNodeStoreService.cfg

# Set Quickstart Env Variables
ENV CQ_RUNMODE "author,nosamplecontent,docker"
ENV CQ_JAAS_CONFIG "etc/jaas.config"
ENV CQ_JVM_OPTS "-XX:MaxPermSize=512M -Xmx2G -XX:+UseParallelGC -XX:+UseParallelOldGC"

# Installs AEM
WORKDIR /aem
RUN ["python","aemInstaller.py","-i","cq-author-4502.jar","-r","author","-p","4502"]

WORKDIR /aem/crx-quickstart/bin
RUN mv quickstart quickstart.original
ADD resources/quickstart /aem/crx-quickstart/bin/quickstart

# Convert from windows line endings, just in case
RUN dos2unix /aem/crx-quickstart/bin/*

###### STAGE 2
FROM smurfsky101/docker-ubuntu-14-04-java8:2
LABEL version="1.0"
LABEL description="AEM author docker image"
MAINTAINER smurfsky101

# Set Quickstart Env Variables
ENV CQ_RUNMODE "author,nosamplecontent,docker"
ENV CQ_JAAS_CONFIG "etc/jaas.config"
ENV CQ_JVM_OPTS "-XX:MaxPermSize=512M -Xmx2G -XX:+UseParallelGC -XX:+UseParallelOldGC"

COPY --from=base /aem /aem

# Make AEM executable
RUN chmod +x /aem/crx-quickstart/bin/quickstart

EXPOSE 4502
ENTRYPOINT ["/aem/crx-quickstart/bin/quickstart"]
