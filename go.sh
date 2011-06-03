#!/bin/bash

# Because I don't have a clean build yet, this actually stops and blows away the whole liferay to get a clean db and uncached app
set -e
mvn clean install
echo "Shutting down liferay and then will recursively delete Liferay! (stop now if you are scared with ctrl-c)"
sleep 1
echo "3"
sleep 1
echo "2"
sleep 1
echo "1"
sleep 1
echo "GO!"
cd /usr/java/liferay-portal-6.0.6/tomcat-6.0.29/bin/
./shutdown.sh
sleep 10
cd /usr/java/
rm -rf /usr/java/liferay-portal-6.0.6/
unzip liferay-portal-6.0.6.zip
cd /usr/java/liferay-portal-6.0.6/tomcat-6.0.29/bin/
./startup.sh
cd ~/dev/git/vivo_portlet
cp target/*.war /usr/java/liferay-portal-6.0.6/deploy
echo "destruct complete"
tail -f /usr/java/liferay-portal-6.0.6/tomcat-6.0.29/logs/catalina.out