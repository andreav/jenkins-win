FROM andreav/jenkins:windowsservercore

# Installing Docker for DinD
# TODO: use a builder image and extrac only exe
RUN Invoke-WebRequest -UseBasicParsing https://chocolatey.org/install.ps1 | Invoke-Expression 
RUN choco install /y docker-cli

# To obtain plugin list from Jenkins
# 
# JENKINS_HOST=username:password@myhost.com:port
# JENKINS_HOST=admin:admin@localhost:8888
# curl -sSL "http://$JENKINS_HOST/pluginManager/api/xml?depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins" | perl -pe 's/.*?<shortName>([\w-]+).*?<version>([^<]+)()(<\/\w+>)+/\1 \2\n/g'|sed 's/ /:/' > jenkins-image.plugins-online.txt
COPY plugins_extra.txt C:/ProgramData/Jenkins/
RUN & C:/ProgramData/Jenkins/install-plugins.ps1 -PluginFile C:/ProgramData/Jenkins/plugins_extra.txt

# JCasC-plugin: file based Jenkins configuration
ENV CASC_JENKINS_CONFIG C:/ProgramData/Jenkins/jcasc_configs
RUN mkdir C:/ProgramData/Jenkins/jcasc_configs
# Files will be passed at container startup to:
# - avoid rebuilding image any time the config changes
# - let to change the image at runtime:
#   1. change file
#   2. go to JCasC plugin page
#   3. reload config from file 
# COPY jenkins.yaml C:/ProgramData/Jenkins/jcasc_configs

# Skip wizard
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"

