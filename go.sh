#!/bin/bash

LIFERAY_PARENT_DIR=/usr/java
LIFERAY_DIR=$LIFERAY_PARENT_DIR/liferay-portal-6.0.6
LIFERAY_ZIP=$LIFERAY_PARENT_DIR/liferay-portal-6.0.6.zip
LIFERAY_TOMCAT=$LIFERAY_DIR/tomcat-6.0.29
WAR_NAME=vivo

# Because I don't have a clean build yet, this actually stops and blows away the whole liferay to get a clean db and uncached app
set -e
DIRECTORY=$(cd `dirname $0` && pwd)
mvn clean install
echo "For the following to work, you must have $LIFERAY_ZIP. If you don't, download, rename it, etc."
if [ -f "$LIFERAY_TOMCAT/bin/shutdown.sh" ]; then
  echo "Shutting down liferay and then will recursively delete Liferay at $LIFERAY_DIR! (stop now if you are scared with ctrl-c)"
  sleep 1
  echo "3"
  sleep 1
  echo "2"
  sleep 1
  echo "1"
  sleep 1
  echo "GO!"
  cd "$LIFERAY_TOMCAT/bin/"
  ./shutdown.sh
  sleep 10
  cd "$LIFERAY_PARENT_DIR"
  rm -rf "$LIFERAY_DIR"
  echo "destruct complete"
fi

if [ -f "$LIFERAY_ZIP" ]; then
  cd "$LIFERAY_PARENT_DIR"
  unzip "$LIFERAY_ZIP"
  cd "$LIFERAY_TOMCAT/bin/"
  ./startup.sh
  cp "$DIRECTORY/target/$WAR_NAME.war" "$LIFERAY_DIR/deploy"
  tail -f "$LIFERAY_TOMCAT/logs/catalina.out"
fi
