# Jenkins Windows container image + Configuration as Code

This image provides Jenkins on Windows container + Jenkins Configuration-as-Code plugin to deliver a zero time setup if you need this environment (e.g. for building .NET applciations).

Bonus: it mounts docker engine named pipe to let this Windows container build other containers in the exact same Linux-style experience.

## Docker compose startup

With this interaction, no secret can be passed to container (so for instance admin password cannot be modified) 

Just issue:

`docker-compose up`

And connect to localhost:8888

## Docker swarm startup

For using secrets, we must use docker swarm.
First issue:

`docker swarm init` (optionally add --advertise-addr)

Then issue:

`docker stack deploy -c docker-compose.yaml jenkins`

And connect to localhost:8888

## Docker run:

Here some commands for runnig without docker-compose or docker stack deploy

Building image:

`docker build -t andreav/jenkins-win ./jenkins-image`

And running the conatiner from a bash (mingw)

```
docker run  -it \
            -v jenkins_home:C:\\ProgramData\\Jenkins\\JenkinsHome \
            -v '\\.\pipe\docker_engine':'\\.\pipe\docker_engine' \
            -v $(cygpath.exe -w ${PWD})'\jcasc_configs':'C:\ProgramData\Jenkins\jcasc_configs' \
            -p 8888:8080 \
            -p 55555:50000 \
            andreav/jenkins-win
```

Or running from a DOS shell:

```
docker run  -it \
            -v jenkins_home:C:\\ProgramData\\Jenkins\\JenkinsHome \
            -v '\\.\pipe\docker_engine':'\\.\pipe\docker_engine' \
            -v %cd%'\jcasc_configs':'C:\ProgramData\Jenkins\jcasc_configs' \
            -p 8888:8080 \
            -p 55555:50000 \
            andreav/jenkins-win


```

## Base jenkins image:

The base image is completely based on the wonderful work made by github [slide user](https://github.com/slide). Source code can be found [here on github](https://github.com/slide/docker)

I have published an image ready to use on Docekr Hub [here](https://hub.docker.com/repository/docker/andreav/jenkins)

That base image will be dropped when pull request [#924](https://github.com/jenkinsci/docker/pull/924) will be integarted into jenkinsci official docker images.

## JCasC cfg & project layout:

JCasC documentation: https://jenkins.io/projects/jcasc/

And praqma blog: https://github.com/Praqma/praqma-jenkins-casc
