Vivo Portlet
=====

A JSR-286 portlet that integrates with a [VIVO][vivo] server for searching of semantic web data.

Note: even though it is a JSR-286 portlet and we've made efforts to help it work in other portals, it has only been tested in Liferay 6.0.6. We do not use a Liferay-specific build (it uses Maven without all of the liferay repositories, etc.), but the go.sh script is for Liferay 6.0.6 only. If you are using another portal, just deploy the war.

### Build

### Download

Releases - **please right-click to download**

* [2011-08-08 - current - working with hardcoded service url. Tested w/Liferay 6.0.6 in Firefox 5.0.1 and Chrome 13.0 in OS X 10.6.][rel2011-08-08]
* [2011-06-03 - search not working][rel2011-06-03]
* [2011-05-26 - working search but no persistence][rel2011-05-26]

### Deploy

Manual Method

1. Download Liferay 6.0.6 and unzip so that it lives in /usr/java/liferay-portal-6.0.6 (for example)
2. Start Liferay according to its instructions
3. Copy vivo.war into /usr/java/liferay-portal-6.0.6/deploy

Automated Method

1. Download Liferay 6.0.6, put into /usr/java/ and rename to /usr/java/liferay-portal-6.0.6.zip
2. Execute go.sh if you dare, and if you are using OS X. **go.sh will DELETE /usr/java/liferay-portal-6.0.6**, so please understand that before using it. go.sh uses Maven to build, stops Liferay, deletes Liferay, unzips Liferay, copies the war so that it will be deployed on start, starts Liferay, and tails the log. go.sh may take a few minutes to complete, or longer if your computer is slower.

### Adding the Portlet

In Liferay 6.0.6, login and go to Add->More...->Social->Vivo->Add. If you are not logged-in, history is not stored, but search still works.

### Configuration

If you have installed VIVO and VIVO Widgets, then you can have the portlet point at your own VIVO instance.

Modify the portlet's WEB-INF/classes/vivo.properties to set the vivoUrl like:

      vivoUrl=http://vivo.example.com/widgets/search.jsonp?query=

Modify the portlet's META-INF/persistence.xml to use your favorite database. It uses H2 as an in-memory-only database by default, so unless you change that, data will not be saved on restart of the portal.

Restart Liferay after making these changes.

### License

Copyright (c) 2011 Duke University, released under the [MIT license][lic].

[vivo]: http://vivoweb.org/
[liferayportletdevelopersetup]: http://www.liferay.com/documentation/liferay-portal/6.0/development/-/ai/initial-set-8
[rel2011-05-26]: http://dukepass.oit.duke.edu/vivo_portlet/dist/2011-05-26-working/vivo.war
[rel2011-06-03]: http://dukepass.oit.duke.edu/vivo_portlet/dist/2011-06-03-not-working/vivo.war
[rel2011-08-08]: http://dukepass.oit.duke.edu/vivo_portlet/dist/2011-08-08/vivo.war
[lic]: http://github.com/adsweb/vivo_portlet/blob/master/LICENSE
