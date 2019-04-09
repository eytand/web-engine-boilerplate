#! /bin/bash
source .env

echo killing any instance of ${image} ...
docker rm $(docker stop $(docker ps -a -q --filter ancestor=${image} --format="{{.ID}}"))
docker run -p 3000:3000 ${image}