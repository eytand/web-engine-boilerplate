## Repository: @NAME@

Description: @DESC@

## Requirements
* Node 8+
* esm - The framework is coded ES6 module style, be sure to use `node -r esm <your-service>` when running. esm can be installed globally

```bash
npm i esm -g
```

* pm2-runtime

```bash
npm i pm2 -g
```

## Installation

the installation script will initiate and push a new repository to github

- run the `repo-ini.sh` and follow the instructions 

   -comments: 


    * the script will find and replace all occurrences  of @NAME@ and @DESC@
    
    `@NAME` - repositoy name

    `@DESC` - repository description 
   
when the script is done a new folder based on the repository name will be created with an initiated git repo

***if there are erros during instllation please do the following steps manually:***

1 rm -rvf .git

2 git init

3 sed -i --backup 's/test-service/repo_name/g' package.json README.md build-docker.sh run-docker.sh

4 sed -i --backup 's/desc/repo_description/g' package.json README.md build-docker.sh run-docker.sh

5 git add .

6 git commit -m "initiate repo_name repo"

7 git remote add origin $GITHUB_ACCOUNT/repo_name.git

8 git push -u origin master



## Dependencies
- The microservice is based on web-engine https://github.com/eytand/web-engine 
- Microservice has to implement "HealthcheckService" 


## Healthcheck

For debugging health checks, the Docker inspect command lets you view the output of commands that succeed or fail (here in JSON format):

```docker inspect e61 | jq ".[].State.Health" ```
* please install jq on your machine

Or run :
```docker inspect --format='{{json .State.Health}}' your-container-name```

You can find instructions here :
https://blog.newrelic.com/2016/08/24/docker-health-check-instruction/


## pm2-runtime

a pm2 wrapper for docker integration

read more about here:
http://pm2.keymetrics.io/docs/usage/docker-pm2-nodejs/ 

start the app from a configuration file:
```CMD pm2-runtime process.yml```

##### Configuration file

process.yml - a configuration file for pm2 

```npm_package_name:  ${name} ```  - will be replaced by project( key = name) name from package.json

``` npm_package_version: ${version} ``` - will be replaced by version number ( key = version)  from package.json


### watch and autorestart
PM2 can automatically restart your application when a file is modified in the current directory or its subdirectories

set ```watch:true``` in process.yml to enable the feature 




### ESlint
ESLint provide a pluggable linting utility for JavaScript. 
https://eslint.org/ 

configuration location:
``` .eslintrc.js ```
