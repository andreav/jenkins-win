FROM andreav/jenkins:windowsservercore

# Installing Docker for DinD
# TODO: use a builder image and extrac only exe
RUN Invoke-WebRequest -UseBasicParsing https://chocolatey.org/install.ps1 | Invoke-Expression 
RUN choco install /y docker-cli

# Per avere la lista dei plugins da Jenkins
# 
# JENKINS_HOST=username:password@myhost.com:port
# JENKINS_HOST=admin:admin@172.31.29.78:8080
# curl -sSL "http://$JENKINS_HOST/pluginManager/api/xml?depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins" | perl -pe 's/.*?<shortName>([\w-]+).*?<version>([^<]+)()(<\/\w+>)+/\1 \2\n/g'|sed 's/ /:/' > plugins.txt
COPY plugins.txt C:/ProgramData/Jenkins/
# RUN & C:/ProgramData/Jenkins/install-plugins.ps1 C:/ProgramData/Jenkins/plugins.txt

# Skip wizard
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"

