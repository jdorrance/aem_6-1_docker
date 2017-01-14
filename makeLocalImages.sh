#!/bin/bash

function getinput {
  while true; do
	  echo "Put your AEM jar and your license file in ${1}-tar/resources directory."
      read -p "When ready type y and hit enter or q to quit? " y
      case $y in
          [Yy]* ) break;;
          [Qq]* ) exit 0;;
          * ) echo "Please answer y when your ready to move foward.";;
      esac
  done
}

function build {
  sh -c 'cd '${1}'/ && exec docker build -t aem_6-1_'$(echo ${1} | sed 's/-.*//')' .'
  #echo -c 'cd '${1}'/ && exec docker build -t aem_6-2_'$(echo ${1} | sed 's/-.*//')' .'
  echo "done building ${1} container"
}

build "base"

#getinput "publish"
build "publish"

#getinput "author"
build "author"

build "dispatcher"

sh -c 'cd composedev-tar'
echo 'Now go into composedev-tar and run this command:./start-containers.sh'
