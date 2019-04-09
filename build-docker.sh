#! /bin/bash
source .env

docker build --tag ${image} .
docker tag ${image} devsrv:5000/${image}:${tag}
docker push devsrv:5000/${image}:${tag}