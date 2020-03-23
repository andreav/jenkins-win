## Base jenkins image:
- ref - https://github.com/slide/docker.git
- ref - https://github.com/jenkinsci/docker/pull/924

## JCasC cfg & project layout:
- ref - https://github.com/Praqma/praqma-jenkins-casc

## Useful commands:

```
docker build -t andreav/jenkins-win ./jenkins-image
docker run  -it \
            -v jenkins_home:C:\\ProgramData\\Jenkins\\JenkinsHome \
            -v '\\.\pipe\docker_engine':'\\.\pipe\docker_engine' \
            -v $(cygpath.exe -w ${PWD})'\jcasc_configs':'C:\ProgramData\Jenkins\jcasc_configs' \
            -p 8888:8080 \
            -p 55555:50000 \
            andreav/jenkins-win
```
