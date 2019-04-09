#! /bin/bash
source .env

docker build --tag ${image} .
docker tag ${image} $HOST:$PORT/${image}:${tag}
docker push $HOST:$PORT/${image}:${tag}
