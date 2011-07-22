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
    /*note: have to do styles inline because of needing to use JSP to insert namespace into CSS element ids*/
    p {
          margin:0;
          padding:2px;
    }

    li {
          border-bottom:solid 1px #CCC;
          list-style-type:none;
          padding:10px;
    }

    ul {
          margin:0;
          padding:0;
    }

    h4 {
          font-size:1.2em;
          margin:0;
          padding:0;
    }

    #pid_searchContainer {
          background-image:url(rcp_/images/headerbg.gif);
          border-bottom:solid 2px #FFF;
          color:#FFF;
          padding:0 0 7px 7px;
    }

    #pid_showSearch,#pid_hideSearch,#pid_refreshHistory,#pid_clearAllHistory {
          -moz-border-radius-bottomleft:9px;
          background-color:#FFF;
          border-bottom:solid 1px #2485AE;
          border-bottom-left-radius:8px;
          border-left:solid 1px #2485AE;
          color:#2485AE;
          cursor:pointer;
          float:right;
          font-weight:700;
          opacity:0.6;
          padding:4px;
    }

    #pid_clearAllHistory {
          -moz-border-radius-bottomright:9px;
          border-bottom-right-radius:8px;
    }

    #pid_search,#pid_history {
          font-size:.8em;
    }

    a {
          color:#2485AE;
          margin-right:20px;
          text-decoration:none;
    }

    a:visited {
          color:#2485AE;
    }

    a:hover {
          text-decoration:underline;
    }

    #pid_main {
          background-color:#F3F3F0;
    }

    .read_list {
          display:block;
          float:right;
          padding:6px;
    }

    .unread {
          font-weight:700;
    }

    #pid_readHistory,#pid_searchHistory {
          font-size:1em;
    }

    #pid_results_header,.header {
          -moz-border-radius-bottomleft:8px;
          -moz-border-radius-bottomright:8px;
          background-image:url(rcp_/images/headerbg.gif);
          border-bottom-left-radius:8px;
          border-bottom-right-radius:8px;
          color:#FFF;
          font-size:1.1em;
    }

    .tablib_unselected {
          background-color:#85C13D;
          background-image:url(rcp_/images/taboff.gif);
          border:none;
          color:#FFF;
          cursor:pointer;
          padding:3px 0;
          width:80px;
    }

    .tablib_selected {
          background-image:url(rcp_/images/tab.gif);
          border:none;
          border-bottom-width:0;
          color:#FFF;
          cursor:default;
          font-weight:700;
          padding:3px 0;
          width:80px;
    }

    .group {
          border-bottom:solid 2px #CCC;
          font-size:1.1em;
          font-weight:700;
    }

    .result_summary {
          font-size:.9em;
          font-weight:400;
    }

    #pid_result_summary_container li {
          border:none;
          display:inline;
    }

    .summary_header {
          display:block;
          font-weight:700;
    }

    .selectBoxArrow{
          margin-top:1px;
          float:left;
          position:absolute;
          right:1px;
    }

    .selectBoxInput{
          border:0px;
          padding-left:1px;
          height:16px;
          position:absolute;
          top:0px;
          left:0px;
    }

    .selectBox{
          border:1px solid #7f9db9;
          height:20px;
    }

    .selectBoxOptionContainer{
          position:absolute;
          border:1px solid #7f9db9;
          height:100px;
          background-color:#FFF;
          left:-1px;
          top:20px;
          visibility:hidden;
          overflow:auto;
    }

    .selectBoxAnOption{
          font-family:arial;
          font-size:12px;
          cursor:default;
          margin:1px;
          overflow:hidden;
          white-space:nowrap;
    }

    .selectBoxIframe{
          position:absolute;
          background-color:#FFF;
          border:0px;
          z-index:999;
    }
    /*]]>*/
  </style>
  
  <link rel="stylesheet" type="text/css" href="rcp_/css/jquery-ui-autocomplete.css" media="all" />

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
    //var addHistoryUrl = '<%=addHistoryUrl%>';
    //var clearHistoryUrl = '<%=addHistoryUrl%>';
    //var getHistoryUrl = '<%=getHistoryUrl%>';
    //var updateHistoryUrl = '<%=updateHistoryUrl%>';

    var addHistoryUrl = 'http://localhost:8080/web/guest/home?p_p_id=1_WAR_vivo&p_p_lifecycle=2&p_p_state=normal&p_p_mode=view&p_p_resource_id=addHistory&p_p_cacheability=cacheLevelPage&p_p_col_id=column-1&p_p_col_count=2';
    var clearHistoryUrl = 'http://localhost:8080/web/guest/home?p_p_id=1_WAR_vivo&p_p_lifecycle=2&p_p_state=normal&p_p_mode=view&p_p_resource_id=clearHistory&p_p_cacheability=cacheLevelPage&p_p_col_id=column-1&p_p_col_count=2';
    var getHistoryUrl = 'http://localhost:8080/web/guest/home?p_p_id=1_WAR_vivo&p_p_lifecycle=2&p_p_state=normal&p_p_mode=view&p_p_resource_id=getHistory&p_p_cacheability=cacheLevelPage&p_p_col_id=column-1&p_p_col_count=2';
    var updateHistoryUrl = 'http://localhost:8080/web/guest/home?p_p_id=1_WAR_vivo&p_p_lifecycle=2&p_p_state=normal&p_p_mode=view&p_p_resource_id=updateHistory&p_p_cacheability=cacheLevelPage&p_p_col_id=column-1&p_p_col_count=2';

    function updateInterface(json) {
        alert('updateInterface() called');
        //console.log(json);
        if (json && json.history) {                      
            // remove old select options
            alert('clearing #pid_history');
            $('#pid_history')
                .find('option')
                .remove()
                .end()
                .val('')
            ;            
            
            // set new data
            var history = json.history;
            alert('setting new history ' + history);
            var historyArray = json.key.split('|');
            if (historyArray.length > 0) {
                $("#pid_query").val(historyArray.pop());
                evenOlderSearch = historyArray.pop();
                while (evenOlderSearch) {
                    // add to options
                    var opt = document.createElement("option");
                    $("#pid_history").options.add(opt);
                    opt.innerText = evenOlderSearch;
                    opt.Value = evenOlderSearch;                              
                    // get next
                    evenOlderSearch = historyArray.pop();
                }
            }
        }
        alert('updateInterface complete');
    }
    
    function search() {
        alert('search() called');
        if ($("#pid_query").val() !== "") {
            $.getJSON(
                  updateHistoryUrl + '&history=' + $("#pid_query").val,
                  function(json) {
                      alert('called ' + updateHistoryUrl.toString() + ' with history ' + $("#pid_query").val + ' and got ' + json);
                      updateInterface(json);
                  }
            );
        }
        alert('search complete');
    }
    
    function initialize() {
        alert('initialize() called. getHistoryUrl=' + getHistoryUrl);
        $.getJSON(
              getHistoryUrl,
              function(json) {
                  alert('called ' + getHistoryUrl.toString() + ' and got ' + json);
                  updateInterface(json);
              }
        );
        
        $('#pid_searchButton').click( function() {
                alert('user clicked search');
                search();
        });
        
        $('#pid_query').bind('keydown', function(e) {
                if((e.keyCode ? e.keyCode : e.which) == 13) { // 13 = user clicked enter/return key in search field
                        alert('user entered query');
                        search();
                }
        });

        alert('initialize complete');
        return false;
    }

    $(initialize());

    </script>

    <input type="text" id="pid_query"/>
    <select id="pid_history">
    <option value="">Loading . . .</option>
    </select>
    
    <input type="button" id="pid_searchButton" value="Search"/>

    <p>
    Test URLs that are generated if running as a portlet:<br/>
    <a href="<portlet:resourceURL escapeXml='false' id='info'/>">Test info</a><br/>
    <a href="<portlet:resourceURL escapeXml='false' id='addHistory'/>&history=success">Test addHistory</a><br/>
    <a href="<portlet:resourceURL escapeXml='false' id='clearHistory'/>">Test clearHistory</a><br/>
    <a href="<portlet:resourceURL escapeXml='false' id='getHistory'/>">Test getHistory</a><br/>
    <a href="<portlet:resourceURL escapeXml='false' id='updateHistory'/>&history=success">Test updateHistory</a><br/>

    Test URLs that are hardcoded and work if portal and portlet is up on localhost:<br/>
    <a href="http://localhost:8080/web/guest/home?p_p_id=1_WAR_vivo&p_p_lifecycle=2&p_p_state=normal&p_p_mode=view&p_p_resource_id=info&p_p_cacheability=cacheLevelPage&p_p_col_id=column-1&p_p_col_count=2">Test info</a><br/>
    <a href="http://localhost:8080/web/guest/home?p_p_id=1_WAR_vivo&p_p_lifecycle=2&p_p_state=normal&p_p_mode=view&p_p_resource_id=addHistory&p_p_cacheability=cacheLevelPage&p_p_col_id=column-1&p_p_col_count=2&history=success">Test addHistory</a><br/>
    <a href="http://localhost:8080/web/guest/home?p_p_id=1_WAR_vivo&p_p_lifecycle=2&p_p_state=normal&p_p_mode=view&p_p_resource_id=clearHistory&p_p_cacheability=cacheLevelPage&p_p_col_id=column-1&p_p_col_count=2">Test clearHistory</a><br/>
    <a href="http://localhost:8080/web/guest/home?p_p_id=1_WAR_vivo&p_p_lifecycle=2&p_p_state=normal&p_p_mode=view&p_p_resource_id=getHistory&p_p_cacheability=cacheLevelPage&p_p_col_id=column-1&p_p_col_count=2">Test getHistory</a><br/>
    <a href="http://localhost:8080/web/guest/home?p_p_id=1_WAR_vivo&p_p_lifecycle=2&p_p_state=normal&p_p_mode=view&p_p_resource_id=updateHistory&p_p_cacheability=cacheLevelPage&p_p_col_id=column-1&p_p_col_count=2&history=success">Test updateHistory</a><br/>
