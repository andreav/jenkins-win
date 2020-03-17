FROM andreav/jenkins:windowsservercore

# Per avere la lista dei plugins da Jenkins
# 
# JENKINS_HOST=username:password@myhost.com:port
# JENKINS_HOST=admin:admin@172.31.29.78:8080
# curl -sSL "http://$JENKINS_HOST/pluginManager/api/xml?depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins" | perl -pe 's/.*?<shortName>([\w-]+).*?<version>([^<]+)()(<\/\w+>)+/\1 \2\n/g'|sed 's/ /:/' > plugins.txt
COPY plugins.txt C:/ProgramData/Jenkins/
RUN & C:/ProgramData/Jenkins/install-plugins.ps1 C:/ProgramData/Jenkins/plugins.txt
