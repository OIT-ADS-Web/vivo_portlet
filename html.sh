#!/bin/bash
mkdir html
mkdir html/rcp_
cp -r src/main/webapp/* html/rcp_/
cp src/main/webapp/WEB-INF/jsp/view.jsp html/view.html
open html/view.html
