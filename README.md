Vivo Portlet
=====

A JSR-286 portlet that integrates with a [VIVO][vivo] server for searching of semantic web data.

Note: even though it is a JSR-286 portlet and we've made efforts to help it work in other portals, it has only been tested in Liferay 6.0.6. We do not use a Liferay-specific build (it uses Maven without all of the liferay repositories, etc.), but the go.sh script is for Liferay 6.0.6 only. If you are using another portal, just deploy the war.

### Demonstration

See the [screenshot][screenshot] or the [video][video].

### Download

Releases - **please right-click to download**

* [2011-08-08 - current - working with hardcoded service url. Tested w/Liferay 6.0.6 in Firefox 5.0.1 and Chrome 13.0 in OS X 10.6.][rel2011-08-08]
* [2011-06-03 - search not working][rel2011-06-03]
* [2011-05-26 - working search but no persistence][rel2011-05-26]

### Setting Up Liferay

You don't have to use Liferay to use the portlet, but the portlet was developed and tested with Liferay.

1. [Download Liferay 6.0.6][liferay].
2. If you want to be consistent with other instructions for building, create the path /usr/java/ and unzip Liferay into that directory, so that Liferay's home directory is /usr/java/liferay-portal-6.0.6.
3. Start Liferay according to its instructions.

e.g. Here are the commands to use in OS X 10.6:

      mkdir -p /usr/java
      cd /usr/java
      wget http://downloads.sourceforge.net/project/lportal/Liferay%20Portal/6.0.6/liferay-portal-tomcat-6.0.6-20110225.zip?r=&ts=1312902524&use_mirror=cdnetworks-us-2
      unzip liferay-portal-tomcat-6.0.6-20110225.zip
      cd liferay-portal-6.0.6/tomcat-6.0.29/bin
      ./startup.sh

### Deploy

Copy the vivo.war you downloaded from the releases section into /usr/java/liferay-portal-6.0.6/deploy.

      cp ~/Downloads/vivo.war /usr/java/liferay-portal-6.0.6/deploy/

### Adding the Portlet

In Liferay 6.0.6, login and go to Add->More...->Social->Vivo->Add. If you are not logged-in, history is not stored, but search still works.

### Configuration

If you have installed [VIVO][vivo] and [VIVO Widgets][widgets], then you can have the portlet point at your own VIVO instance.

Modify the portlet's WEB-INF/classes/vivo.properties to set the vivoUrl like:

      vivoUrl=http://vivo.example.com/widgets/search.jsonp?query=

Modify the portlet's META-INF/persistence.xml to use your favorite database. It uses H2 as an in-memory-only database by default, so unless you change that, data will not be saved on restart of the portal.

Restart Liferay after making these changes.

### Development

Install [Maven][maven] and follow the instructions on the Maven site for setting it up. Java 6 (or possibly higher) is required.

Running the following command should do a clean build of the portlet. The resulting portlet should be in target/vivo.war:

      mvn clean install

If you want to ensure a fresh build and deploy to a completely clean Liferay HSQL database, if you are using OS X 10.6 (or possibly higher) then you can use go.sh if you dare, but please understand that **go.sh will DELETE /usr/java/liferay-portal-6.0.6**. go.sh uses Maven to build, stops Liferay, deletes Liferay, unzips Liferay, copies the war so that it will be deployed on start, starts Liferay, and tails the log. go.sh may take a few minutes to complete, or longer if your computer is slower.

### License

Copyright (c) 2011 Duke University, released under the [MIT license][lic].

[liferay]: http://www.liferay.com/downloads/liferay-portal/available-releases
[maven]: http://maven.apache.org/download.html
[vivo]: http://vivoweb.org/
[widgets]: http://github.com/OIT-ADS-Web/vivo_widgets
[screenshot]: http://github.com/OIT-ADS-Web/vivo_portlet/blob/master/screenshots/2011-08-09.png
[video]: http://dukepass.oit.duke.edu/vivo_portlet/videos/2011-08-09.swf
[rel2011-05-26]: http://dukepass.oit.duke.edu/vivo_portlet/dist/2011-05-26-working/vivo.war
[rel2011-06-03]: http://dukepass.oit.duke.edu/vivo_portlet/dist/2011-06-03-not-working/vivo.war
[rel2011-08-08]: http://dukepass.oit.duke.edu/vivo_portlet/dist/2011-08-08/vivo.war
[lic]: http://github.com/OIT-ADS-Web/vivo_portlet/blob/master/LICENSE
