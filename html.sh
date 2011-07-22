#!/bin/bash
LIFERAY_PARENT_DIR=/usr/java
LIFERAY_DIR=$LIFERAY_PARENT_DIR/liferay-portal-6.0.6

mkdir html
mkdir html/rcp_
cp -r src/main/webapp/* html/rcp_/
cp src/main/webapp/WEB-INF/jsp/view.jsp html/view.html
rm html.war
zip -r html.war html/

set -e
cp html.war "$LIFERAY_DIR/deploy"
sleep 10
open http://localhost:8080/html/view.html
