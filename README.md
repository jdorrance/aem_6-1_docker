
# Docker AEM
This project holds all our 6.1 AEM docker images we have built so far.  They are standard (TAR MK images)

The easiest way to get start would be to clone this repo then from the cloned root directory run the following command
```
docker-compose build
docker-compose up
```

The build may take up to 5-10 minutes the first time. Afterwards -->
```

docker-compose up
```

Afterwards, visit [http://localhost:4502](http://localhost:4502) - to confirm successful installation.
## Configuration

Configuration is driven through environment variables.  
A comprehensive list of the environment variables used can be found in each `Dockerfile`

* `CQ_RUNMODE` - If custom runmodes are required
* `CQ_JAAS_CONFIG` - Path within the VM to the jaas auth config file
* `CQ_JVM_OPTS` - `-XX:MaxPermSize=512M -Xmx2G -XX:+UseParallelGC -XX:+UseParallelOldGC`


## System Requirements

* AEM Author -> 2GB RAM
* AEM Publish -> 2GB RAM
* Dispatcher -> 1GB RAM

An SSD is advised.