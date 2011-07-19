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
<!-- do not remove or move this comment -->

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
  <link rel="stylesheet" type="text/css" href="rcp_/css/jquery-ui-autocomplete.css"
  media="all" />

  <div class="portlet-container" id="pid_main">
    <script src="rcp_/js/jquery-1.5.1.js" type="text/javascript">
</script> <script src="rcp_/js/jquery.ui.core.js" type="text/javascript">
</script> <script src="rcp_/js/jquery.ui.widget.js" type="text/javascript">
</script> <script src="rcp_/js/jquery.ui.button.js" type="text/javascript">
</script> <script src="rcp_/js/jquery.ui.position.js" type="text/javascript">
</script> <script src="rcp_/js/jquery.ui.autocomplete.js" type="text/javascript">
</script> <script type="text/javascript">
//<![CDATA[
        (function( $ ) {
                $.widget( "ui.combobox", {
                        _create: function() {
                                var self = this,
                                        select = this.element.hide(),
                                        selected = select.children( ":selected" ),
                                        value = selected.val() ? selected.text() : "";
                                var input = this.input = $( "<input>" )
                                        .insertAfter( select )
                                        .val( value )
                                        .autocomplete({
                                                delay: 0,
                                                minLength: 0,
                                                source: function( request, response ) {
                                                        var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
                                                        response( select.children( "option" ).map(function() {
                                                                var text = $( this ).text();
                                                                if ( this.value && ( !request.term || matcher.test(text) ) )
                                                                        return {
                                                                                label: text.replace(
                                                                                        new RegExp(
                                                                                                "(?![^&;]+;)(?!<[^<>]*)(" +
                                                                                                $.ui.autocomplete.escapeRegex(request.term) +
                                                                                                ")(?![^<>]*>)(?![^&;]+;)", "gi"
                                                                                        ), "<strong>$1<\/strong>" ),
                                                                                value: text,
                                                                                option: this
                                                                        };
                                                        }) );
                                                },
                                                select: function( event, ui ) {
                                                        ui.item.option.selected = true;
                                                        self._trigger( "selected", event, {
                                                                item: ui.item.option
                                                        });
                                                },
                                                change: function( event, ui ) {
                                                        if ( !ui.item ) {
                                                                var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( $(this).val() ) + "$", "i" ),
                                                                        valid = false;
                                                                select.children( "option" ).each(function() {
                                                                        if ( $( this ).text().match( matcher ) ) {
                                                                                this.selected = valid = true;
                                                                                return false;
                                                                        }
                                                                });
                                                                if ( !valid ) {
                                                                        // remove invalid value, as it didn't match anything
                                                                        $( this ).val( "" );
                                                                        select.val( "" );
                                                                        input.data( "autocomplete" ).term = "";
                                                                        return false;
                                                                }
                                                        }
                                                }
                                        })
                                        .addClass( "ui-widget ui-widget-content ui-corner-left" );

                                input.data( "autocomplete" )._renderItem = function( ul, item ) {
                                        return $( "<li><\/li>" )
                                                .data( "item.autocomplete", item )
                                                .append( "<a>" + item.label + "<\/a>" )
                                                .appendTo( ul );
                                };

                                this.button = $( "<button type='button'>&nbsp;<\/button>" )
                                        .attr( "tabIndex", -1 )
                                        .attr( "title", "Show All Items" )
                                        .insertAfter( input )
                                        .button({
                                                icons: {
                                                        primary: "ui-icon-triangle-1-s"
                                                },
                                                text: false
                                        })
                                        .removeClass( "ui-corner-all" )
                                        .addClass( "ui-corner-right ui-button-icon" )
                                        .click(function() {
                                                // close if already visible
                                                if ( input.autocomplete( "widget" ).is( ":visible" ) ) {
                                                        input.autocomplete( "close" );
                                                        return;
                                                }

                                                // work around a bug (likely same cause as #5265)
                                                $( this ).blur();

                                                // pass empty string as value to search for, displaying all results
                                                input.autocomplete( "search", "" );
                                                input.focus();
                                        });
                        },

                        destroy: function() {
                                this.input.remove();
                                this.button.remove();
                                this.element.show();
                                $.Widget.prototype.destroy.call( this );
                        }
                });
        })( jQuery );

        $(function() {
                $( "#pid_combobox" ).combobox();
        });
    //]]>
    </script> <script type="text/javascript">

    // TODO: need to prefix functions, etc. with portlet namespace or is not jsr286 compliant

    // The following two lines must stay as-is. They get automatically replaced as part of Maven war packaging.
    var vivoGetUrl = 'replaced_during_packaging_see_pom.xml';
    var vivoUpdateUrl = 'replaced_during_packaging_see_pom.xml';

    /** http://net.tutsplus.com/tutorials/javascript-ajax/5-ways-to-make-ajax-calls-with-jquery/ */

    /** Spinner **/

    <div id="pid_loadingDiv">
    LOADING . . .
    <\/div>

    /** TODO: namespace since is portlet, otherwise will get spinner when other portlets calling ajaxStart... http://stackoverflow.com/questions/1191485/how-to-call-ajaxstart-on-specific-ajax-calls/1212728#1212728 */
    $('#pid_loadingDiv')
      .hide()  // hide it initially
      .ajaxStart(function() {
          $(this).show();
      })
      .ajaxStop(function() {
          $(this).hide();
      })
    ;

    /** Persist search history **/
    function saveSearch(key){
      if (key.length != 0) {
          $("#pid_query").val("{key='music|games|apple'}");
          //$.getJSON(
          //    "<%=renderResponse.encodeURL(vivoUpdateUrl.toString())%>",
          //    {key: key},
          //    function(json) {
          //        $("#pid_query").val(result);
          //    }
          //);
      }
      return false;
    });

    function initialize() {
        //console.log('starting up!');

        // 1. load query text field and backing select with history
    $(document).ready(function(){

        $("#pid_query").val("{key='music|games'}");
        //$.getJSON(
        //    "<%=renderResponse.encodeURL(vivoGetUrl.toString())%>",
        //    {},
        //    function(json) {
        //        var searchTermsArray = json.key.split('|');
            //        var lastSearch = searchTermsArray.pop();
            //        if(searchTermsArray.length > 0) {
                //          if(lastSearch !== "") {
                //                executeSearch(lastSearch);
                //                settings.currentTerm = lastSearch;
                //          }
        //        }
        //        $("#pid_query").val(json);
        //        // $("#pid_query").val(lastSearch);
        //        // TODO: loop through array and repopulate select w/id:pid_combobox
        //    }
        //);
        $("#pid_query").val("{key='music|games|apple'}");

        return false;
    })

        // 2. attach click handler for search
        $('#pid_searchButton').click( function() {
                if($("#pid_query").val() !== "") {
                        executeSearch($("#pid_query").val());
                        saveSearch($("#pid_query").val());
                }
        });
        $('#pid_showSearch').click( function() {
                stopSearchAnimations();
        });
        $('#pid_hideSearch').click( function() {
                $('#pid_searchContainer').hide("slide", {
                        direction: "up"
                }, 150, function() {
                        $('#pid_showSearch').show("slide", {
                                direction: "up"
                        }, 150);

                });
        });
        $('#pid_refreshHistory').click( function() {
                updateHistory();
        });
        $('#pid_clearAllHistory').click( function() {
                clearAllHistory();
        });
        $('.read_list').live('change', function() {
                if($(this).is(':checked') && searchReadList($(this).prev().attr('href')) === false) {
                        $(this).prev().removeClass('unread');
                        $(this).attr("disabled", true);
                        // TODO: remove readlist?
                        //var read_list = prefs.p_getString("readList");
                        var read_list = 'music';
                        //prefs.p_set("readList", read_list + '|' +  $(this).prev().attr('href'));
                }
        });
        $('.recent_search').live('click', function() {
                //tabs.setSelectedTab(0);
                executeSearch($(this).html());
                saveSearch($(this).html());
                return false;
        });
        $('#pid_search input').bind('keydown', function(e) {
                var code = (e.keyCode ? e.keyCode : e.which);
                if(code == 13) { // 13 = user clicked enter/return key in search field
                        if($('[name=searchTerm]').val() !== "") {
                                executeSearch($('[name=searchTerm]').val());
                                saveSearch($('[name=searchTerm]').val());
                        }
                }
        });
        updateHistory();
    }

    function executeSearch(term) {
        startSearchAnimations();
        searchVivo(term);
    }

    function startSearchAnimations() {
        $('#pid_loading').show("slide", {
                direction: "up"
        }, 50);
        $('#pid_searchContainer').hide("slide", {
                direction: "up"
        }, 150, function() {
                $('#pid_showSearch').show("slide", {
                        direction: "up"
                }, 150);
        });
    }

    function stopSearchAnimations() {
        $('#pid_showSearch').hide("slide", {
                direction: "up"
        }, 150, function() {
                $('#pid_searchContainer').show("slide", {
                        direction: "up"
                }, 150);
        });
    }

    function loadData(url) {
        var surl = url + '&callback=?';
        $.getJSON(surl);
    }

    function scanForDuplicateSearch(term, searchArray) {
        var searchArrayLength = searchArray.length;
        for(var i=0; i < searchArrayLength; i++ ) {
                if(searchArray[i] === term) {
                        var caughtSearch = searchArray.splice(i,1);
                        searchArray.push(caughtSearch);
                        return {
                                result: true,
                                patchedArray: searchArray
                        }
                }
        }
        return {
                result: false,
                patchedArray: undefined
        };
    }

    function searchVivo(search) {
        loadData(settings.endPoint + search + '*');
    }

    function sortResults(searchArray, groups) {
        var resultsString = ['<ul id="pid_result_summary_container">'];
        var searchArrayLength = searchArray.length;
        var filteredResults = {};
        if($.isEmptyObject(groups)) {
                console.log(groups);
                return searchArray;
        }
        for (var key in groups) {
                //var obj = groups[key];
                // alert(prop + " = " + obj[prop]);
                filteredResults[key] = [{
                        uri:'#',
                        name:key
                }];
                resultsString.push('<li><a href="#' + key + '">' + key + ': ' + groups[key] + '<\/a><\/li>');
        }
        resultsString.push("<\/ul>");
        for(var i=0; i < searchArrayLength; i++) {
                if(filteredResults[searchArray[i].group]) {
                        filteredResults[searchArray[i].group].push(searchArray[i]);
                }
        }
        var sortedResults = [{
                uri:'#result',
                name:resultsString.join(" ")
        }];

        for (var key in groups) {
                sortedResults = sortedResults.concat(filteredResults[key]);
        }
        return sortedResults;
    }

    function vivoSearchResult(data) {
        $('#pid_loading').hide("slide", {
                direction: "up"
        }, 150, function() {
                $('#pid_results').show("slide", {
                        direction: "up"
                }, 150);
        });
        var search_terms = prefs.p_getString("searchList");
        var searchArray = search_terms.split('|');
        var groups = data.groups;
        var finalArray = sortResults(data.items, groups);
        var dataItems = finalArray.length;
        var finalStr = [];
        finalStr.push('<li id="pid_results_header">Search Term: <strong>' + settings.currentTerm + '<\/strong> Results: <strong>' + dataItems  + '<\/strong><\/li>');
        for (var i = 0; i < dataItems; i++) {
                if(finalArray[i].uri !== '#' && finalArray[i].uri !== '#result') {
                        if(!searchReadList(finalArray[i].uri)) {
                                finalStr.push('<li><a target="_blank" class="unread" href="' + finalArray[i].uri + '">' + finalArray[i].name + '<\/a><input class="read_list" type="checkbox" /><\/li>');
                        } else {
                                finalStr.push('<li><a target="_blank" href="' + finalArray[i].uri + '">' + finalArray[i].name + '<\/a><input class="read_list" checked="true" disabled="true" type="checkbox" /><\/li>')
                        }
                } else {
                        if(finalArray[i].uri === '#result') {
                                finalStr.push('<li class="group result_summary">' + finalArray[i].name + '<\/li>');
                        } else {
                                finalStr.push('<li id="pid_' + finalArray[i].name + '" class="group">' + finalArray[i].name + '<\/li>');
                        }
                }
        };
        $('#pid_results').html(finalStr.join(" "));
    }

    function prefToArray(pref) {
        var prefArray = pref.split('|');
        var finalArray = [];
        var prefLength = prefArray.length;
        for(var i=0; i<prefLength; i++) {
                if(prefArray[i] !== " ") {
                        //alert(prefArray[i].charCodeAt(0));
                        finalArray.push(prefArray[i]);
                }
        }
        return finalArray;
    }

    function renderSearchList(listArray) {
        finalHtml = ["<ul>"];
        var listArrayLength = listArray.length;
        for(var i = 0; i < listArrayLength; i++) {
                finalHtml.push('<li><a class="recent_search" href="' + settings.endPoint + listArray[i] + '*">' + listArray[i] + '<\/li>');
                console.log("<li>" + listArray[i] + "<\/li>");
        }
        finalHtml.push("<\/ul>");
        return finalHtml;
    }

    function updateHistory() {
        $('#pid_searchHistory').html(renderSearchList(prefToArray(prefs.p_getString("searchList"))).join(" "));
        $('#pid_readHistory').html('<h4>Read Item URLs<\/h4>' + prefToArray("").join('<br />') );
        return false;
    }

    function clearAllHistory() {
        prefs.p_set("searchList", ' ');
        updateHistory();
        return false;
    }

    //<![CDATA[
    $(function() { initialize(); });
    //]]>

    </script>

    <div id="pid_search">
      <div style="display:none" id="pid_showSearch">
        New Search
      </div>

      <div id="pid_searchContainer">
        <div id="pid_hideSearch">
          Hide
        </div>

        <form id="pid_search">
          <div class="demo">
            <div class="ui-widget">
              <label>Enter Search Term:</label> <select style="display: none;" id=
              "pid_combobox">
                <option value="">
                  Select one...
                </option>

                <option value="Music">
                  Music
                </option>

                <option value="Games">
                  Games
                </option>

                <option value="Basketball">
                  Basketball
                </option>

                <option value="Theoretical Physics">
                  Theoretical Physics
                </option>

                <option value="Monsters">
                  Monsters
                </option>
              </select> <input id="pid_query" value="" aria-haspopup="true"
              aria-autocomplete="list" role="textbox" autocomplete="off" class=
              "ui-autocomplete-input ui-widget ui-widget-content ui-corner-left" />
              <button aria-disabled="false" role="button" class=
              "ui-button ui-widget ui-state-default ui-button-icon-only ui-corner-right ui-button-icon"
              title="Show All Items" tabindex="-1" type="button"> <span class=
              "ui-button-text">&nbsp;</span></button>
            </div>
          </div>
        </form>
      </div><!-- End demo -->
      <button id="pid_searchButton" type="button" name="startSearch">Search</button>
    </div>

    <div id="pid_loading" style="display:none"><img src=
    "rcp_/images/ajax-loader.gif" /></div>

    <div>
      <ul style="display:none" id="pid_results"></ul>
    </div>
  </div>

  <div style="display:none" id="pid_history">
    <div id="pid_refreshHistory" href="#">
      Show latest history
    </div>

    <div id="pid_clearAllHistory">
      Clear All History
    </div>

    <ul>
      <li class="header">Search History</li>

      <li>
        <div id="pid_searchHistory"></div>
      </li>

      <li style="display:none">
        <div id="pid_readHistory"></div>
      </li>
    </ul>
  </div><br />

  <ul style="z-index: 1; top: 0px; left: 0px; display: none;" aria-activedescendant=
  "ui-active-menuitem" role="listbox" class=
  "ui-autocomplete ui-menu ui-widget ui-widget-content ui-corner-all"></ul>
