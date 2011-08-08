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

        <script src="rcp_/js/jquery-1.4.3.min.js" type="text/javascript"></script>
        <script src="rcp_/js/jquery-ui-1.8.6.min.js" type="text/javascript"></script>
        
        <script type="text/javascript">
        // Do not remove the following line!
        //replaceme2

        // var msg = new gadgets.MiniMessage(__MODULE_ID__);

        //alert("anonymous function called");

        /**
         * @author Jeremy Bandini
         */

        //var prefs = new _IG_Prefs();

        var settings = {
            currentTerm : '',
            endPoint : 'http://scholars-test.oit.duke.edu/widgets/search.jsonp?query='
        };

        function initialize() {
            //alert("initialize() called");
            userHistory.initialize();
            //alert("userHistory.initialize() called");
            Search.execute(settings.currentTerm);
            Behaviors.initialize();
        }

        var Template = {
            results_header : function(term, count) {
                return '<li id="pid_results_header"><strong>' + term + '</strong></li><li>Showing <strong>' + count + '</strong> results</li>';
            },
            results_item : function(uri, name) {
                return '<li><a target="_blank" href="' + uri + '">' + name + '</a></li>';
            },
            results_group_summary : function(name) {
                return '<li class="result_summary">' + name + '</li>';
            },
            results_group_header : function(name) {
                return '<li id="pid_' + name + '" class="group">' + name + '</li>';
            },
            results_submenu : function(name, count) {
                return '<li><a href="#pid_' + name + '">' + name + ': ' + count + '</a></li>';
            },
            history_menu : function(url, term) {
                return '<li><a class="recent_search" href="' + url + term + '*">' + term + '</a></li>'

            }

        }


        // Commands
        var Prefs = {
                history : {
                     searchList: "cat|dog|obesity|food|pharm"
                },
                set : function (pref, new_val) {
                   try {
                       //alert("attempting to set history with <%=renderResponse.encodeURL(updateHistoryUrl.toString())%> with data {'history' = '" + new_val + "'}");
                       // prefs.set(pref, new_val);
                       this.history[pref] = new_val;

                       // like a synchronous $.getJSON call
                       $.ajax({
                           type: 'POST',
                           url: "<%=renderResponse.encodeURL(updateHistoryUrl.toString())%>",
                           dataType: 'json',
                           success: function() {
                               //alert("updateHistory call to portlet did not fail!");
                           },
                           error: function(xhr, ajaxOptions, thrownError) {
                               alert("There was a problem contacting the server. Please wait and try refreshing the page. " + xhr.statusText);
                           },
                           data: {'history': new_val},
                           async: false
                       });
                       //alert("request sent");
                   } catch (err) {
                       alert("Error in Prefs.set: " + err);
                   }
                },
                getString : function(pref) {
                    var historyResult = "";
                    try {
                        //return prefs.getString(pref);
                        //alert("attempting to get history from '<%=renderResponse.encodeURL(getHistoryUrl.toString())%>'");
                        var ajaxResult = $.ajax(
                                {
                                   type: 'GET',
                                   url: "<%=renderResponse.encodeURL(getHistoryUrl.toString())%>",
                                   dataType: 'json',
                                   success: function() {
                                       //alert("getHistory call to portlet did not fail!");
                                       // TODO: right here set the title
                                   },
                                   error: function(xhr, ajaxOptions, thrownError) {
                                       alert("There was a problem contacting the server. Please wait and try refreshing the page. " + xhr.statusText);
                                   },
                                   data: {},
                                   async: false
                                }
                            );
                        //alert("ajaxResult was '" + ajaxResult + "'");
                        //alert("ajaxResult.responseText was '" + ajaxResult.responseText + "'");
                        var historyResultObj = $.parseJSON(ajaxResult.responseText);
                        //alert("$.parseJSON(...) result was '" + historyResultObj + "'");
                        if (historyResultObj !== null) {
                            historyResult = historyResultObj.history;
                            if (historyResult !== null) {
                                //alert("historyResult was '" + historyResult + "'");
                            }
                            else if (historyResultObj.error !== null)
                            {
                                alert("error was '" + historyResultObj.error + "'");
                            }
                            else
                            {
                                alert("bad json returned: " + JSON.stringify(historyResultObj));
                            }
                        }

                        if (historyResult === null) {
                          //alert("using backup method this.history[" + pref + "]");
                          historyResult = this.history[pref];
                          //alert("this.history[" + pref + "] returned '" + historyResult + "'");
                        }
                    } catch (err) {
                       alert("Error in Prefs.getString: " + err);
                    }

                    if (historyResult === null) {
                       //alert("neither <%=renderResponse.encodeURL(getHistoryUrl.toString())%> nor this.history[" + pref + "] returned a result!");
                       historyResult = "";
                    }

                    //alert("Pref.getString(...)=" + historyResult);
                    return historyResult;
                }
        }

        var PrefHandler = {

            to_array : function(pref) {
                var finalArray = [];
                try {
                    var prefArray = pref.split('|');
                    var prefLength = prefArray.length;
                    for(var i = 0; i < prefLength; i++) {
                        if(prefArray[i] !== " ") {
                            finalArray.push(prefArray[i]);
                        }
                    }
                } catch (err) {
                    alert("Error in PrefHandler.to_array: " + err);
                }
                return finalArray;
            },
            scan : function(term, searchArray) {
                var searchArrayLength = searchArray.length;
                for(var i = 0; i < searchArrayLength; i++) {
                    if(searchArray[i] === term) {
                        var caughtSearch = searchArray.splice(i, 1);
                        searchArray.push(caughtSearch);
                        return {
                            result : true,
                            patchedArray : searchArray
                        }
                    }
                }

                return {
                    result : false,
                    patchedArray : undefined
                };

            }
        };
        var Scroll = {
            to : function(elementId, offset) {

                $('html,body').animate({
                    scrollTop: $(elementId).offset().top + offset
                },
                {
                    duration: 'slow',
                    easing: 'swing'
                });
            }
        }

        var Search = {
            execute : function(term) {
                if(term.length > 0) {
                    $('[name=searchTerm]').val(term);
                    Behaviors.history_hide();
                    Behaviors.start_loading();
                    this.vivo(term);
                }
            },
            vivo : function(search) {
                 this.load(settings.endPoint + search + '*');
            },
            load : function(url) {
                var surl = url + '&callback=?';
                $.getJSON(surl);
            }
        }


        // Objects
        function Results() {
            this.groups = {};
        }
        Results.prototype.sort = function(searchArray) {
            var resultsString = ['<ul id="pid_result_summary_container">'];
            var searchArrayLength = searchArray.length;
            var filteredResults = {};
            if($.isEmptyObject(this.groups)) {

                return searchArray;
            }
            for(var key in this.groups) {
                filteredResults[key] = [{
                    uri : '#',
                    name : key
                }];
                resultsString.push(Template.results_submenu(key, this.groups[key]));

            }
            resultsString.push("</ul>");
            for(var i = 0; i < searchArrayLength; i++) {

                if(filteredResults[searchArray[i].group]) {
                    filteredResults[searchArray[i].group].push(searchArray[i]);
                }

            }
            var sortedResults = [{
                uri : '#result',
                name : resultsString.join(" ")
            }];

            for(var key in this.groups) {
                sortedResults = sortedResults.concat(filteredResults[key]);

            }

            return sortedResults;
        }
        Results.prototype.render = function(data) {
            Behaviors.stop_loading();

            results.groups = data.groups;

            $('#pid_results').html(this.renderHtml(results.sort(data.items)).join(" "));
        }
        Results.prototype.renderHtml = function(sorted_data) {
            var html = [];
            var count = sorted_data.length;

            html.push(Template.results_header($("#pid_searchTerm").val(), count));

            for(var i = 0; i < count; i++) {
                var sorted_data_uri = sorted_data[i].uri;
                var sorted_data_name = sorted_data[i].name;
                if(sorted_data_uri !== '#' && sorted_data_uri !== '#result') {
                    html.push(Template.results_item(sorted_data_uri, sorted_data_name));
                } else {
                    if(sorted_data_uri === '#result') {
                        html.push(Template.results_group_summary(sorted_data_name));

                    } else {
                        html.push(Template.results_group_header(sorted_data_name));
                    }

                }

            };
            return html;
        }

        function SearchHistory(dom_id) {
            this.dom_id = dom_id;

        }

        SearchHistory.prototype.initialize = function() {
            var searchList = Prefs.getString("searchList");
            //alert("in SearchHistory.prototype.initialize. searchList=" + searchList);
            var searchTermsArray = PrefHandler.to_array(searchList);
               if(searchTermsArray.length > 0) {
                //alert("have search terms!");
                var lastSearch = searchTermsArray.pop();
                if(lastSearch === null) {
                    lastSearch = "";
                }
                settings.currentTerm = lastSearch;

            } else {
                 //alert("NO search terms!");
                 Behaviors.history_button_hide();
            }

           this.updateHistory();
        }
        SearchHistory.prototype.saveSearch = function(search) {

            var search_terms = PrefHandler.to_array(Prefs.getString("searchList"));

            var testResult = PrefHandler.scan(search, search_terms);

            if(!testResult.result) {
                search_terms.push(search);
                // 1994 character max!

                Prefs.set("searchList", search_terms.join('|'));
            } else {
                Prefs.set("searchList", testResult.patchedArray.join('|'));
            }
            //alert("SHOWING history button");
            Behaviors.history_button_show();
            settings.currentTerm = search;

        }

        SearchHistory.prototype.updateHistory = function() {
            $(this.dom_id).html(this.renderSearchList(PrefHandler.to_array(Prefs.getString("searchList"))).join(" "));

            return false;
        }
        SearchHistory.prototype.renderSearchList = function(listArray) {
            finalHtml = [];
            var listArrayLength = listArray.length;
            for(var i = listArrayLength; i >= 0; i--) {
                if(listArray[i]) {
                    finalHtml.push(Template.history_menu(settings.endPoint, listArray[i]));
                }
            }

            return finalHtml;
        }
        SearchHistory.prototype.clearAllHistory = function() {
            Prefs.set("searchList", ' ');

            Behaviors.history_button_hide();
                Behaviors.history_hide();
            this.updateHistory();
            return false;
        }

        // Behaviors

        var Behaviors = {
            initialize : function() {
                that = this;
                $('#pid_searchButton').click(function() {
                    that.search();

                });
                $('#pid_refreshHistory').click(function() {
                   that.history();

                });
                $('#pid_clearAllHistory').click(function() {
                   that.clear_history();
                });

                $('#pid_results').delegate("#pid_result_summary_container li a", "click", function() {

                    Scroll.to($(this).attr("href"), 0);
                    return false;
                });
                $('#pid_searchHistory').delegate("li a", "click", function() {
                    return that.select_history_item(this);
                });

                $('#pid_search input').bind({
                    'keydown' : function(e) {
                        that.keyboard(e);
                    },
                    focus : function() {
                        Behaviors.history_hide();
                    }
                });

            },
            search : function() {
                term = $('[name=searchTerm]').val();
                if(term !== "") {
                    Search.execute(term);
                    userHistory.saveSearch(term);
                }
            },
            history_hide : function() {
                  if($('#pid_history').is(":visible")) {
                      $('#pid_recent_img').attr("src","rcp_/images/recent.gif");
                     $('#pid_history').hide("slide", {
                            direction : "up"
                     }, 90);
                    }
            },
            history_button_hide : function() {

                if($("#pid_refreshHistory").is(':visible')) {
                    $("#pid_refreshHistory").css('display', 'none');
                }
            },
            history_button_show : function() {
                if(!$("#pid_refreshHistory").is(':visible')) {
                    $("#pid_refreshHistory").css('display', 'block');
                }
            },
            history : function() {
                 userHistory.updateHistory();

                if($('#pid_history').is(":visible")) {
                   this.history_hide();
                } else {
                    $('#pid_recent_img').attr("src","rcp_/images/recent-on.gif");
                    $('#pid_history').show("slide", {
                        direction : "up"
                    }, 90);
                }
            },
            clear_history : function() {
                userHistory.clearAllHistory();
            },
            select_history_item : function(caller) {

                Search.execute($(caller).html());
                userHistory.saveSearch($(caller).html());
                return false;
            },
            keyboard : function(e) {
                var code = (e.keyCode ? e.keyCode : e.which);
                if(code == 13) {
                    if($('[name=searchTerm]').val() !== "") {
                        Search.execute($('[name=searchTerm]').val());
                        userHistory.saveSearch($('[name=searchTerm]').val());
                    }
                }
            },
            start_loading: function() {
                $('#pid_loading').show("slide", {
                    direction : "up"
                }, 50);
            },
            stop_loading: function() {
             $('#pid_loading').hide("slide", {
                direction : "up"
                 }, 150, function() {
                if(!$('#pid_results').is(":visible")) {
                    $('#pid_results').show("slide", {
                        direction : "up"
                    }, 150);
                }

            });
            }
        }
        // Script
        function vivoSearchResult(data) {
            results.render(data);

        }
        </script>
        <style type="text/css">
        #pid_result_summary_container li a {
          display:inline-block
        }
        p {padding:2px;margin:0 }
        li{ list-style-type:none;
              padding:5px;
              border-bottom:solid 1px #CCC
        }
        ul{ padding:0;margin:0}
        h4{ padding:0; margin:0; font-size:1.2em; }


        #pid_hideSearch{
          padding:2px;
          margin:1px;
          float:right;
          cursor:pointer;
          border:solid 1px #FFF
        }
    
        #pid_searchContainer {
            margin-bottom:2px;
            padding:7px
        }

        #pid_loading {
           position:absolute;
           top:70px;
           left:30px;
           background-color:#FFF;
           -moz-border-radius: 4px;
           border-radius: 4px;
           }
         a { text-decoration:none;color:#2485AE;margin-right:20px}
         a:visited {color:#2485AE}
         a:hover { text-decoration:none;text-decoration:underline }
         
        #pid_main { background-color: #F3F3F0; font-size:.8em}
        
        
        #pid_refreshHistory {
            background-color: #EEEEEE;
            color: #FFFFFF;
            cursor: pointer;
            float: left;
            padding-top: 5px;
            /* float: right; */
            /* color:#FFF; */
            /* padding-left:3px; */
            /* cursor:pointer; */
            /* position:absolute; */
            /* top:18px; */
            /* left:156px; */
        }
        #pid_history {
            position:relative;
            top:-9px;
            left:4px;
            width:196px;
            background-color:#FFF;
            padding:0;
            -moz-border-radius: 2px;
            border-radius: 2px;
            border:solid 2px #000;
            -moz-box-shadow: 2px 2px 2px #333;
            -webkit-box-shadow: 2px 2px 2px #333;
            -o-box-shadow: 2px 2px 2px #333;
            box-shadow: 2px 2px 2px #333;
        }
        #pid_history li {
            padding:8px
        }
        #pid_clearAllHistory {
            border:solid 1px #000;
            padding:8px;
            cursor:pointer;
            background-color:#2485AE;
            font-weight:bold;
            color:#FFF
        }
        #pid_results_header, .header, #pid_search {
            font-size:1.1em;
            background-image: url('rcp_/images/headerbg.gif');
            color:#FFF;
            -moz-border-radius: 4px;
            border-radius: 4px;

        }
        .tablib_unselected {
            background-image: url('rcp_/images/taboff.gif');
            padding: 3px 0px;
            background-color: #85C13D;
            /*  border: 1px solid #273d6c;
            border-bottom-color: #676767;*/
            border:none;
            color: #FFF;
            width: 80px;
            cursor: pointer;
        }
        .tablib_selected {
            background-image: url('rcp_/images/tab.gif');
            padding: 3px 0px;
            /* background-color: #273d6c;*/
            /* border: 1px solid #000;*/
            border:none;
            border-bottom-width: 0px;
            color: #FFF;
            font-weight: bold;
            width: 80px;
            cursor: default;
        }
        .group {
            font-weight:bold;
            border-bottom:solid 1px #CCC;
            font-size:1.1em
        }
        .result_summary{
            font-weight:normal;
            font-size:.9em;
            border-bottom:solid 1px #CCC
        }
        #pid_result_summary_container li {
            display:inline;
            padding:3px;
            border:none
        }
        .summary_header {
            font-weight:bold;
            display:block
        }
        input {
          border:solid 1px #000;
          padding:2px;
          background-color:#F3F3F0;
          width:170px
          
        }
        button {
                        -moz-border-radius: 2px;
              border-radius: 2px;
              border:solid 1px #000;
              background-color:#F3F3F0;
              padding:2px
        }
        </style>
      <div id="pid_main">
            
        <div id="pid_search">

        <div id="pid_searchContainer">
        
        <input id="pid_searchTerm" type="text" name="searchTerm" />

        <div id="pid_refreshHistory" href="#"><img id="pid_recent_img" src="rcp_/images/recent.gif" /> </div>

        <button id="pid_searchButton" type="button" name="startSearch">Search</button>
    
        </div>

        <div style="display:none" id="pid_history">
            <ul id="pid_searchHistory"></ul>
            <div id="pid_clearAllHistory">Clear All History</div>
        </div>

        </div>

        <div id="pid_result_body">
            <ul style="display:none" id="pid_results"></ul>
        </div>
        <div id="pid_loading" style="display:none">
                <img src="rcp_/images/ajax-loader.gif" />
            </div>
        <div style="display:none" id="pid_visi">visualization</div>
        <div style="display:none" id="pid_follow"><ul><li class="header">Currently Following</li><li>You are not following anyone.</li></ul></div>
        
        </div>


<script>
var userHistory = new SearchHistory("#pid_searchHistory");
var results = new Results();

initialize();
</script>