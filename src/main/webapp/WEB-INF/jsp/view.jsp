<!--
<%--
* @author Jeremy Bandini
* @author Gary S. Weaver
* Maven-replacer in pom.xml is used to replace some text in this JSP as part of build. This along with html.sh allows
* light testing of the Javascript and HTML outside of the portlet environment.
--%>

<%@ page contentType="text/html" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="portlet" uri="http://java.sun.com/portlet" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
-->
  <!--<%--Do not alter the following line!!!--%>-->
  <!--replaceme1-->

  <!--<%--
  URLs that can be hardcoded for development are:
  getHistoryUrl =
  http://localhost:8080/web/guest/home?p_p_id=1_WAR_vivo&p_p_lifecycle=2&p_p_state=normal&p_p_mode=view&p_p_resource_id=getHistory&p_p_cacheability=cacheLevelPage&p_p_col_id=column-1&p_p_col_count=2

  updateHistoryUrl (add history param to this)=
  http://localhost:8080/web/guest/home?p_p_id=1_WAR_vivo&p_p_lifecycle=2&p_p_state=normal&p_p_mode=view&p_p_resource_id=updateHistory&p_p_cacheability=cacheLevelPage&p_p_col_id=column-1&p_p_col_count=2

  Example specifying history
  http://localhost:8080/web/guest/home?p_p_id=1_WAR_vivo&p_p_lifecycle=2&p_p_state=normal&p_p_mode=view&p_p_resource_id=updateHistory&p_p_cacheability=cacheLevelPage&p_p_col_id=column-1&p_p_col_count=2&history=music|video|games
  --%>-->

  <style type="text/css">
/*<![CDATA[*/

  /*]]>*/
  </style>

  <div class="portlet-container" id="pid_main">
    <script src="rcp_/js/jquery-1.5.1.js" type="text/javascript"> </script>
    <script src="rcp_/js/jquery.ui.core.js" type="text/javascript"> </script>
    <script src="rcp_/js/jquery.ui.widget.js" type="text/javascript"> </script>
    <script src="rcp_/js/jquery.ui.button.js" type="text/javascript"> </script>
    <script src="rcp_/js/jquery.ui.position.js" type="text/javascript"> </script>
    <script src="rcp_/js/jquery.ui.autocomplete.js" type="text/javascript"> </script>
    <script type="text/javascript">

    // TODO: need to prefix functions, etc. with portlet namespace or is not jsr286 compliant

    //<%--Do not alter the following line!!!--%>
    //replaceme2

    //<%--portlet resource can only set as JSP variable--%>
    //var getHistoryUrl = '<%=getHistoryUrl%>';
    //var updateHistoryUrl = '<%=updateHistoryUrl%>';

    var getHistoryUrl = 'http://localhost:8080/web/guest/home?p_p_id=1_WAR_vivo&p_p_lifecycle=2&p_p_state=normal&p_p_mode=view&p_p_resource_id=getHistory&p_p_cacheability=cacheLevelPage&p_p_col_id=column-1&p_p_col_count=2';
    var updateHistoryUrl = 'http://localhost:8080/web/guest/home?p_p_id=1_WAR_vivo&p_p_lifecycle=2&p_p_state=normal&p_p_mode=view&p_p_resource_id=updateHistory&p_p_cacheability=cacheLevelPage&p_p_col_id=column-1&p_p_col_count=2';

    function initialize() {
        //alert('initialize() called');

        $.getJSON(
              updateHistoryUrl + '&history=success',
              function(json) {
                  //alert('called ' + updateHistoryUrl.toString() + ' with history "success" and got ' + json);
                  console.log(json);

                  $("#pid_query").val(json.history);
              }
        );

        $.getJSON(
              getHistoryUrl,
              function(json) {
                  //alert('called ' + getHistoryUrl.toString() + ' and got ' + json);
                  console.log(json);

                  $("#pid_query").val(json.history);
              }
        );

        return false;
    }

    $(initialize());

    </script>

    <input type="text" id="pid_query"/>
    <select id="pid_history">
    <option value="">Loading . . .</option>
    </select>

    <p>
    Test URLs that are generated if running as a portlet:<br/>
    <a href="<portlet:resourceURL escapeXml='false' id='info'/>">Test info</a><br/>
    <a href="<portlet:resourceURL escapeXml='false' id='getHistory'/>">Test getHistory</a><br/>
    <a href="<portlet:resourceURL escapeXml='false' id='updateHistory'/>&history=success">Test updateHistory</a><br/>

    Test URLs that are hardcoded and work if portal and portlet is up on localhost:<br/>
    <a href="http://localhost:8080/web/guest/home?p_p_id=1_WAR_vivo&p_p_lifecycle=2&p_p_state=normal&p_p_mode=view&p_p_resource_id=info&p_p_cacheability=cacheLevelPage&p_p_col_id=column-1&p_p_col_count=2">Test info</a><br/>
    <a href="http://localhost:8080/web/guest/home?p_p_id=1_WAR_vivo&p_p_lifecycle=2&p_p_state=normal&p_p_mode=view&p_p_resource_id=getHistory&p_p_cacheability=cacheLevelPage&p_p_col_id=column-1&p_p_col_count=2">Test getHistory</a><br/>
    <a href="http://localhost:8080/web/guest/home?p_p_id=1_WAR_vivo&p_p_lifecycle=2&p_p_state=normal&p_p_mode=view&p_p_resource_id=updateHistory&p_p_cacheability=cacheLevelPage&p_p_col_id=column-1&p_p_col_count=2&history=success">Test updateHistory</a><br/>
