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
  <!--replaceme1-->

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

    // The following two variable are automatically replaced as part of Maven war packaging via the next replacement.
    var vivoGetUrl = 'overridden-during-packaging';
    var vivoUpdateUrl = 'overridden-during-packaging';

    //replaceme2

    function initialize() {
        alert('initialize() called');

        $.getJSON(
              "<%=renderResponse.encodeURL(vivoUpdateUrl.toString())%>",
              {key: 'successfully read portlet persisted value. now move to next step.'},
              function(json) {
                  alert('setting key');
                  $("#pid_query").val();
              }
        );

        $.getJSON(
              "<%=renderResponse.encodeURL(vivoGetUrl.toString())%>",
              function(json) {
                  alert('getting key');
                  $("#pid_query").val(json);
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

