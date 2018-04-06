# aem-6_2-author

# Docker AEM 6.1 Author image
This is based on this repo example https://github.com/sergeimuller/ and also https://hub.docker.com/u/ggotti/

Building image localy from the project directory
run this command to build image
```
docker build -t aem_6-1_author .
```
run the image with this command
```
docker run --name AEM_AUTHOR -p 4502:4502 -d aem_6-1_author
```
