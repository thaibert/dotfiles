#!/usr/bin/env bash

#  
# Force-stop all running containers
#

if [[ -n "$(docker ps -q)" ]]; then
  docker stop $(docker ps -q)
fi

if [[ "$?" -eq 0 ]]; then
  docker container prune --force
fi

