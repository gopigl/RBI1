FROM tomcat:9
COPY target/*.war /usr/local/tomcat/webapps/myweb.war
RUN mv /usr/local/tomcat/webapps.dist /usr/local/tomcat/webapps 
# Added to test webhook
