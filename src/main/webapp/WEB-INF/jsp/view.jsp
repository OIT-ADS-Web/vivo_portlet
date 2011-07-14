<%--
* @author Jeremy Bandini
* @author Gary S. Weaver
--%>
<%@ page contentType="text/html" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="portlet" uri="http://java.sun.com/portlet" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<portlet:defineObjects/>
<portlet:actionURL var="actionURL" portletMode="view"/>

<div class="portlet-container" id="<portlet:namespace/>main">
  <style type="text/css">
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

  #<portlet:namespace/>searchContainer {
  	background-image:url(<%=request.getContextPath()%>/images/headerbg.gif);
  	border-bottom:solid 2px #FFF;
  	color:#FFF;
  	padding:0 0 7px 7px;
  }

  #<portlet:namespace/>showSearch,#<portlet:namespace/>hideSearch,#<portlet:namespace/>refreshHistory,#<portlet:namespace/>clearAllHistory {
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

  #<portlet:namespace/>clearAllHistory {
  	-moz-border-radius-bottomright:9px;
  	border-bottom-right-radius:8px;
  }

  #<portlet:namespace/>search,#<portlet:namespace/>history {
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

  #<portlet:namespace/>main {
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

  #<portlet:namespace/>readHistory,#<portlet:namespace/>searchHistory {
  	font-size:1em;
  }

  #<portlet:namespace/>results_header,.header {
  	-moz-border-radius-bottomleft:8px;
  	-moz-border-radius-bottomright:8px;
  	background-image:url(<%=request.getContextPath()%>/images/headerbg.gif);
  	border-bottom-left-radius:8px;
  	border-bottom-right-radius:8px;
  	color:#FFF;
  	font-size:1.1em;
  }

  .tablib_unselected {
  	background-color:#85C13D;
  	background-image:url(<%=request.getContextPath()%>/images/taboff.gif);
  	border:none;
  	color:#FFF;
  	cursor:pointer;
  	padding:3px 0;
  	width:80px;
  }

  .tablib_selected {
  	background-image:url(<%=request.getContextPath()%>/images/tab.gif);
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

  #<portlet:namespace/>result_summary_container li {
  	border:none;
  	display:inline;
  }

  .summary_header {
  	display:block;
  	font-weight:700;
  }

  /* */
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
  </style>
  	<script src="<%=request.getContextPath()%>/js/jquery-1.5.1.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.ui.core.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.ui.widget.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.ui.button.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.ui.position.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.ui.autocomplete.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/index.css" media="all">

	<script>
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
											), "<strong>$1</strong>" ),
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
					return $( "<li></li>" )
						.data( "item.autocomplete", item )
						.append( "<a>" + item.label + "</a>" )
						.appendTo( ul );
				};

				this.button = $( "<button type='button'>&nbsp;</button>" )
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
		$( "#combobox" ).combobox();
		$( "#toggle" ).click(function() {
			$( "#combobox" ).toggle();
		});
	});
	</script>



  <script type="text/javascript">

  // TODO: need to prefix functions, etc. with portlet namespace or is not jsr286 compliant

  /**
   * TODO: Adapter for persistence via portlet that works similar to OpenSocial so we can update semi-easily.
   */
  <portlet:resourceURL escapeXml='false' id='vivoGet' var='vivoGetUrl'/>
  <portlet:resourceURL escapeXml='false' id='vivoUpdate' var='vivoUpdateUrl'/>

  /** http://net.tutsplus.com/tutorials/javascript-ajax/5-ways-to-make-ajax-calls-with-jquery/ **/

  var jsonUrl = "<%=renderResponse.encodeURL(vivoGetUrl.toString())%>";
    $("#<portlet:namespace/>search").submit(function(){
        var key = $("#<portlet:namespace/>query").val();
        if (key.length == 0) {
            $("#<portlet:namespace/>query").focus();
        } else {
            $("#<portlet:namespace/>query").attr("selectBoxOptions", ajax_load)
            $.getJSON(
                jsonUrl,
                {key: key},
                function(json) {
                    $("#<portlet:namespace/>query").attr("selectBoxOptions", result);
                }
            );
        }
        return false;
    });

  var _PortletPrefs =
    p_getString: function (key) {
        $.ajax({
            type: "GET",
            url: "<%=renderResponse.encodeURL(vivoGetUrl.toString())%>",
            data: "key=" + key,
            success: function(json){
              alert("get ajax call returned: " + json.data);
            }
        });
    }

    p_set: function (key, value) {
        $.ajax({
            type: "POST",
            url: "<%=renderResponse.encodeURL(vivoUpdateUrl.toString())%>",
            data: "key="+key"&value="+value,
            success: function(json){
              alert("update ajax call returned: " + json.data);
            }
        });
    }
  }

  /**
   * app.js from vivo opensocial adapted to portlet
   *
   * hide search menu after search X
   * add section/filters for organization etc... X
   * scrunch things up X
   * Read/unread toggle
   * implement search history X
   *
   */
  //var prefs = new _IG_Prefs();
  var prefs = _PortletPrefs;
  //alert('vivoUrl is ${vivoUrl}');
  var settings = {
  	currentTerm: '',
  	endPoint: '${vivoUrl}'
  };
  function initialize() {
  	//console.log('starting up!');
  	//tabs = new gadgets.TabSet("vivo_social", "Main");
  	//tabs.addTab("Search", "search");
  	//tabs.addTab("History", "history");
  	//tabs.setSelectedTab("search");
  	var search_terms = prefs.p_getString("searchList");
  	//var search_terms = 'music';
  	var searchTermsArray = search_terms.split('|');
  	var lastSearch = searchTermsArray.pop();
  	if(searchTermsArray.length > 0) {
  		if(lastSearch !== "") {
  			executeSearch(lastSearch);
  			settings.currentTerm = lastSearch;
  		}
  	}
  	$('#<portlet:namespace/>searchButton').click( function() {

  		if($('[name=searchTerm]').val() !== "") {
  			executeSearch($('[name=searchTerm]').val());
  			saveSearch($('[name=searchTerm]').val());
  		}
  	});
  	$('#<portlet:namespace/>showSearch').click( function() {
  		stopSearchAnimations();
  	});
  	$('#<portlet:namespace/>hideSearch').click( function() {
  		$('#<portlet:namespace/>searchContainer').hide("slide", {
  			direction: "up"
  		}, 150, function() {
  			$('#<portlet:namespace/>showSearch').show("slide", {
  				direction: "up"
  			}, 150);

  		});
  	});
  	$('#<portlet:namespace/>refreshHistory').click( function() {
  		updateHistory();
  	});
  	$('#<portlet:namespace/>clearAllHistory').click( function() {
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
  	$('#<portlet:namespace/>search input').bind('keydown', function(e) {
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
  	$('#<portlet:namespace/>loading').show("slide", {
  		direction: "up"
  	}, 50);
  	$('#<portlet:namespace/>searchContainer').hide("slide", {
  		direction: "up"
  	}, 150, function() {
  		$('#<portlet:namespace/>showSearch').show("slide", {
  			direction: "up"
  		}, 150);
  	});
  }

  function stopSearchAnimations() {
  	$('#<portlet:namespace/>showSearch').hide("slide", {
  		direction: "up"
  	}, 150, function() {
  		$('#<portlet:namespace/>searchContainer').show("slide", {
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

  function saveSearch(search) {
  	item = search;
  	var search_terms = prefToArray(prefs.p_getString("searchList"));
  	//var search_terms = ['music'];
  	var testResult = scanForDuplicateSearch(item, search_terms);
  	if(!testResult.result) {
  		search_terms.push(item); // 1994 character max!
  		prefs.p_set("searchList", search_terms.join('|'));
  	} else {
  		prefs.p_set("searchList", testResult.patchedArray.join('|'));
  	}
  	settings.currentTerm = item;
  }

  function searchVivo(search) {
  	loadData(settings.endPoint + search + '*');
  }

  function searchReadList(term) {
  	//var read_list = prefs.p_getString("readList");
  	var read_list = 'music';
  	var readArray = read_list.split('|');
  	var loopCount = readArray.length;
  	for(var i=0; i < loopCount; i++) {
  		if (readArray[i] === term) {
  			return true;
  		}
  	}
  	return false;
  }

  function sortResults(searchArray, groups) {
  	var resultsString = ['<ul id="<portlet:namespace/>result_summary_container">'];
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
  		resultsString.push('<li><a href="#' + key + '">' + key + ': ' + groups[key] + '</a></li>');
  	}
  	resultsString.push("</ul>");
  	for(var i=0; i < searchArrayLength; i++) {
  		//console.log(searchArray[i].group);
  		if(filteredResults[searchArray[i].group]) {
  			filteredResults[searchArray[i].group].push(searchArray[i]);
  		}
  	}
  	var sortedResults = [{
  		uri:'#result',
  		name:resultsString.join(" ")
  	}];

  	for (var key in groups) {
  		//	var obj = groups[key];
  		// alert(prop + " = " + obj[prop]);
  		sortedResults = sortedResults.concat(filteredResults[key]);

  	}
  	//var sortedResults = filteredResults.publications.concat(filteredResults.activities,filteredResults.organizations, filteredResults.people, filteredResults.locations);
  	return sortedResults;
  }

  function vivoSearchResult(data) {
  	$('#<portlet:namespace/>loading').hide("slide", {
  		direction: "up"
  	}, 150, function() {
  		$('#<portlet:namespace/>results').show("slide", {
  			direction: "up"
  		}, 150);
  	});
  	//console.profile()
  	var search_terms = prefs.p_getString("searchList");
  	//var search_terms = 'music';
  	var searchArray = search_terms.split('|');
  	var groups = data.groups;
  	var finalArray = sortResults(data.items, groups);
  	var dataItems = finalArray.length;
  	var finalStr = [];
  	finalStr.push('<li id="<portlet:namespace/>results_header">Search Term: <strong>' + settings.currentTerm + '</strong> Results: <strong>' + dataItems  + '</strong></li>');
  	for (var i = 0; i < dataItems; i++) {
  		if(finalArray[i].uri !== '#' && finalArray[i].uri !== '#result') {
  			if(!searchReadList(finalArray[i].uri)) {
  				finalStr.push('<li><a target="_blank" class="unread" href="' + finalArray[i].uri + '">' + finalArray[i].name + '</a><input class="read_list" type="checkbox" /></li>');
  			} else {
  				finalStr.push('<li><a target="_blank" href="' + finalArray[i].uri + '">' + finalArray[i].name + '</a><input class="read_list" checked="true" disabled="true" type="checkbox" /></li>')
  			}
  		} else {
  			if(finalArray[i].uri === '#result') {
  				finalStr.push('<li class="group result_summary">' + finalArray[i].name + '</li>');
  			} else {
  				finalStr.push('<li id="<portlet:namespace/>' + finalArray[i].name + '" class="group">' + finalArray[i].name + '</li>');
  			}
  		}
  	};
  	$('#<portlet:namespace/>results').html(finalStr.join(" "));
  	//console.profileEnd()
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
  		finalHtml.push('<li><a class="recent_search" href="' + settings.endPoint + listArray[i] + '*">' + listArray[i] + '</li>');
  		console.log("<li>" + listArray[i] + "</li>");
  	}
  	finalHtml.push("</ul>");
  	return finalHtml;
  }

  function updateHistory() {
  	$('#<portlet:namespace/>searchHistory').html(renderSearchList(prefToArray(prefs.p_getString("searchList"))).join(" "));
  	//$('#<portlet:namespace/>searchHistory').html(renderSearchList(prefToArray("")).join(" "));
  	//$('#<portlet:namespace/>readHistory').html('<h4>Read Item URLs</h4>' + prefToArray(prefs.p_getString("readList")).join('<br />') );
  	$('#<portlet:namespace/>readHistory').html('<h4>Read Item URLs</h4>' + prefToArray("").join('<br />') );
  	return false;
  }

  function clearAllHistory() {
  	prefs.p_set("searchList", ' ');
  	//prefs.p_set("readList", ' ');
  	updateHistory();
  	return false;
  }
  
//<![CDATA[
  // var msg = new gadgets.MiniMessage(__MODULE_ID__);
  $(function() { initialize(); });
  //]]>
  </script>
  <div id="<portlet:namespace/>search">
    <div style="display:none" id="<portlet:namespace/>showSearch">New Search</div>
    <div id="<portlet:namespace/>searchContainer">
      <div id="<portlet:namespace/>hideSearch">Hide</div>
      <form id="<portlet:namespace/>search">
      <div class="demo">

<div class="ui-widget">
	<label>Enter Search Term: </label>
	<select style="display: none;" id="combobox">
		<option value="">Select one...</option>
		<option value="Music">Music</option>
		<option value="Games">Games</option>
		<option value="Basketball">Basketball</option>
		<option value="Theoretical Physics">Theoretical Physics</option>
		<option value="Monsters">Monsters</option>
	</select>
	<input id="<portlet:namespace/>query" value="" aria-haspopup="true" aria-autocomplete="list" role="textbox" autocomplete="off" class="ui-autocomplete-input ui-widget ui-widget-content ui-corner-left">
	<button aria-disabled="false" role="button" class="ui-button ui-widget ui-state-default ui-button-icon-only ui-corner-right ui-button-icon" title="Show All Items" tabindex="-1" type="button">
	<span class="ui-button-icon-primary ui-icon ui-icon-triangle-1-s"></span>
	<span class="ui-button-text">&nbsp;</span>
	</button>
</div>
<button id="toggle">Show underlying select</button>

</div><!-- End demo -->
      <button id="<portlet:namespace/>searchButton" type="button" name="startSearch">Search</button>
      </form>
    </div>
    <div id="<portlet:namespace/>loading" style="display:none"><img src="<%=request.getContextPath()%>/images/ajax-loader.gif" /></div>
    <div>
      <ul style="display:none" id="<portlet:namespace/>results"></ul>
    </div>
  </div>
  <div style="display:none" id="<portlet:namespace/>history">
    <div id="<portlet:namespace/>refreshHistory" href="#">Show latest history</div>
    <div id="<portlet:namespace/>clearAllHistory">Clear All History</div>
    <ul>
      <li class="header">Search History</li>
      <li><div id="<portlet:namespace/>searchHistory"></div></li>
      <li style="display:none"><div id="<portlet:namespace/>readHistory"></div></li>
    </ul>
  </div>
</div>

<br/>

<!-- TODO: remove -->
<a href="<portlet:resourceURL escapeXml='false' id='info'/>">Test portlet resource URL and get stats</a><br/>

<ul style="z-index: 1; top: 0px; left: 0px; display: none;" aria-activedescendant="ui-active-menuitem" role="listbox" class="ui-autocomplete ui-menu ui-widget ui-widget-content ui-corner-all"></ul>
