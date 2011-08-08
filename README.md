Vivo Portlet
=====

A Liferay 6.0.x JSR-286 portlet that integrates with a [VIVO][vivo] server for searching of semantic web data.

Note: even though it is a JSR-286 portlet and we've made efforts to help it work in other portals, it has only been tested in Liferay 6.0.6. We do not use a Liferay-specific build (it uses maven without all of the liferay repositories, etc.), but the go.sh script is for Liferay 6.0.6 only. If you are using another portal, just deploy the war.

_UNDER CONSTRUCTION! READ INSTRUCTIONS CAREFULLY. ALL MAY NOT BE FUNCTIONAL YET._

### Build and Deploy

1. Install Liferay 6.0.6 and setup Ant and the Liferay Portlet SDK according to the [instructions][liferayportletdevelopersetup].
2. Put liferay in /usr/java/liferay-portal-6.0.6 and you need to name the liferay distribution zip at /usr/java/liferay-portal-6.0.6.zip.
3. Execute go.sh if you dare. **go.sh will DELETE /usr/java/liferay-portal-6.0.6**, so please understand that before using it. go.sh has the purpose of building the portlet and then setting up a fresh instance of liferay to ensure that nothing interferes with a clean build. This means that it can take minutes to start though, or longer if your computer is slower.

### Download

Releases - **please right-click to download**

* [2011-08-08 - current - working with hardcoded service url. Tested w/Liferay 6.0.6 in Firefox 5.0.1 and Chrome 13.0 in OS X 10.6.][rel2011-08-08]
* [2011-06-03 - search not working][rel2011-06-03]
* [2011-05-26 - working search but no persistence][rel2011-05-26]

### Configuration

Modify WEB-INF/classes/vivo.properties to set the vivoUrl like:

      vivoUrl=http://vivo.example.com/widgets/search.jsonp?query=

Modify META-INF/persistence.xml to change to using your favorite database (it uses H2 in-memory-only DB by default, which means data is not saved on restart of the portal.)

### Adding the Portlet

In Liferay 6.0.6, login and go to Add->More...->Social->Vivo->Add. If you are not logged-in, history is not stored, but search still works.

### License

Copyright (c) 2011 Duke University, released under the [MIT license][lic].

[vivo]: http://vivoweb.org/
[liferayportletdevelopersetup]: http://www.liferay.com/documentation/liferay-portal/6.0/development/-/ai/initial-set-8
[rel2011-05-26]: http://dukepass.oit.duke.edu/vivo_portlet/dist/2011-05-26-working/vivo.war
[rel2011-06-03]: http://dukepass.oit.duke.edu/vivo_portlet/dist/2011-06-03-not-working/vivo.war
[rel2011-08-08]: http://dukepass.oit.duke.edu/vivo_portlet/dist/2011-08-08/vivo.war
[lic]: http://github.com/adsweb/vivo_portlet/blob/master/LICENSE
