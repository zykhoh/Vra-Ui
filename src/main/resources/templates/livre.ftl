<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
  <title>LIvRE - Lucene Image Video REtrieval</title>
  <style type='text/css'>
        
    #videoResults {
		font-size: 1.5em
    }
    
  </style>
  <!-- <link rel="stylesheet" href="//vjs.zencdn.net/4.12/video-js.css" >
  <script src="//vjs.zencdn.net/4.12/video.js"></script> -->
  
  <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" >
  <script src="http://code.jquery.com/jquery-1.11.1.min.js"> </script>
  <script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"> </script>
  
  <!-- Latest compiled and minified CSS -->
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
  <!-- Latest compiled JavaScript -->
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
  
  <!-- for capturing video frames 
  <script src="canvas2image.js"></script> -->

  <script>
        
        solrUrlPrefix = "/solr/collection1/"; // CHANGEME if needed for the Solr core i.e. /collection1/, /lire/ ...
        
        function videoResults(name, path) {
            this.videoName = name;
			this.videoPath = path; //i.e. LireSolrDataset/Videos/SI2V_201308/20130819/Early_Start_20130819_0200_cc_segment_01_700k
			this.videoId = (path.split("/").pop() ) + '_' +( name.substring(0, name.lastIndexOf("."))).replace('.','_'); //Early_Start_20130819_0200_cc_segment_01_700k
            this.videoTime = new Array();
			this.frameList = new Array();
			this.frameRank = new Array();
		}
		
        function setCurTime(vid, seconds) { 
			vid.currentTime=seconds;
		} 
		
		/*function getURIformcanvas() {
			var ImageURItoShow = "";
			var canvasFromVideo = document.getElementById("imageView");
				if (canvasFromVideo.getContext) {
					var ctx = canvasFromVideo.getContext("2d"); // Get the context for the canvas.canvasFromVideo.
					var ImageURItoShow = canvasFromVideo.toDataURL("image/png");
					window.open(ImageURItoShow, "toDataURL() image", "width=480, height=270");
				}
           			   
		    //var imgs = document.getElementById("imgs");
		   	//imgs.appendChild(Canvas2Image.convertToImage(canvasFromVideo, 480, 270, 'png'));
		}
		function capture(videoId) {
			var video = document.getElementById(videoId.id);
			var canvasDraw = document.getElementById('imageView');
			var w = canvasDraw.width;
			var h = canvasDraw.height;
			var ctxDraw = canvasDraw.getContext('2d');
			ctxDraw.clearRect(0, 0, w, h);
			ctxDraw.drawImage(video, 0, 0, w, h);
			ctxDraw.save();
			getURIformcanvas();	 
		}*/
		
        function reWriteImageUrl(imgUrlOriginal) {
            imgUrl = "http://localhost:8983/solr/" + imgUrlOriginal; //CHANGEME! must be absolute http path to the images!
			return imgUrl;
        }
		
		function getCBIRLinks(myID) {
			result = "";
			result += "<div style=\"font-size:8pt\">";
			//result += "<p>lireq: ";
			//result += "<a href=\"javascript:search('"+myID+"', 'cl_ha');\">CL</a>, ";
			//result += "<a href=\"javascript:search('"+myID+"', 'ce_ha');\">CEDD</a>, ";
			//result += "<a href=\"javascript:search('"+myID+"', 'eh_ha');\">EH</a>, ";
			//result += "<a href=\"javascript:search('"+myID+"', 'jc_ha');\">JCD</a>, ";
			//result += "<a href=\"javascript:search('"+myID+"', 'ph_ha');\">PH</a>, ";
			//result += "<a href=\"javascript:search('"+myID+"', 'sc_ha');\">SC</a> ";
			//result += "</p>";
			result += "<p>search: "
			result += "<a href=\"javascript:hashSearch('cl','"+imageUrl+"');\">CL</a>, "
			//result += "<a href=\"javascript:hashSearch('ce','"+imageUrl+"');\">CEDD</a>, "
			result += "<a href=\"javascript:hashSearch('eh','"+imageUrl+"');\">EH</a>, "
			result += "<a href=\"javascript:hashSearch('jc','"+imageUrl+"');\">JCD</a>, "
			result += "<a href=\"javascript:hashSearch('ph','"+imageUrl+"');\">PH</a>, "
			//result += "<a href=\"javascript:hashSearch('sc','"+imageUrl+"');\">SC</a> "
			result += "</p></div>";
			return result;
		}
        
        function printVideoResults(docs) {
            var lastVideo = $("#videoResults");
            var videoResultsArray = new Array();
				
			//Processing results
            for (var i =0; (i< docs.length) ; i++) {
                myID = docs[i].id.toString();
				myID = (myID.split(":\\")).pop(); //Removes WINDOWS drive letter from XML i.e. E:\, C:\ etc
				//myID = myID.replace("/introduce/path/to/remove/here",''); // This modifies XML paths from absolute to relative. Must change or add new lines for each different indexing machine unless Request-Handler is modified to already do this.
				myID=myID.replace(/\\/g,"/"); //Replaces all bar directions to conventional in case database was indexed in Windows.
				filename = myID.replace(/^.*(\\|\/|\:)/, '');
					
                frameNumber = filename.replace (".jpg",'');
				videoFolderName = myID;
				videoFolderName = videoFolderName.substring(0, videoFolderName.lastIndexOf("/")); 
				videoName = videoFolderName.replace(/^.*(\\|\/|\:)/, '');
                videoName = videoName.replace("_keyframes",".mp4");	
				videoFolderName = videoFolderName.substring(0, videoFolderName.lastIndexOf("/")); 
				
				time = parseInt(frameNumber);
                if (videoResultsArray[videoName] == null){
                    videoResultsArray[videoName] = new videoResults(videoName, videoFolderName);
				}
                              
                videoResultsArray[videoName].videoTime.push(time);
				
				videoResultsArray[videoName].frameList.push(reWriteImageUrl(myID));
                videoResultsArray[videoName].frameRank.push((i+1));
								
            }
			//Printing results	
            var i =0;
			
			for (var x in videoResultsArray){
                i++;    
				
                if ( (i <= $("#slider-maxVideos").val() ) ){  //TODO: Possible conflict if maxVideos > videoResultsArray. 
					lastVideo.append("<div class=\"row\">");
                    var value = videoResultsArray[x];
					
					//appends info
					
					lastVideo.append("<div id=\"infoRow"+i+"\" class=\"col-xs-12 col-sm-4 col-md-4 col-lg-3\">");
					var thisID = $("#infoRow"+i);
                    recentVideo = $("<br><h3>Video Query Result " + i + ": </h3> <h5>"
						+ "<font color=grey> TV Broadcast Show Name: </font>" + value.TVBroadcastShowName + "<br>"
						+ "<font color=grey> Broadcast Date: </font>" + value.broadcastDate  + "<br>"
						+ "<font color=grey> Broadcast Time: </font>" + value.broadcastTime  + "<br>"
						+ "<font color=grey> Capture type: </font>" + value.broadcastType  + "<br>"
						+ "<font color=grey> Segment ID: </font>" + value.broadcastSegmentId  + "<br>"
						+ "<font color=grey> Filename: </font>" + value.videoName + "<br></h5>" 
					+ "</div>");
					thisID.append(recentVideo);
					
					//appends video
					lastVideo.append("<div id=\"videoRow"+i+"\" class=\"col-xs-12 col-sm-8 col-md-8 col-lg-6\">");
					thisID = $("#videoRow"+i);
					recentVideo = $("<div align=\"left\"><video id="+ value.videoId +" width=\"480px\" height=\"270px\" controls><source src=\"" + value.videoPath + "/" + value.videoName +"\" type='video/mp4' /></video>" 
                        //+ "<br><button onClick=\" capture(" + value.videoId +") \" style=\"width: 128px;border: solid 2px #ccc;\">Capture Frame</button>"
						+ "</div>"
						+ "<br>"
					+ "</div>");
					thisID.append(recentVideo); 
					
					//appends matched times and Thumbnails
					var col = "col-xs-3 col-sm-1 col-md-1 col-lg-3";
					lastVideo.append("<div id=\"resultsRow"+i+"\" class=\"col-xs-12 col-sm-12 col-md-12 col-lg-3\">");
					thisID=$("#resultsRow"+i);
										
					thisID.append("<p> Matches: ");
					
					var h, m, s, seconds;
                    for (y = 0; (y < value.videoTime.length); y++) {
						console.log(value);
						seconds = (value.videoTime[y] - 3);
						h = seconds / 3600.0; //3600000.0
                        m = (h - Math.floor(h)) * 60.0;
                        s = (m - Math.floor(m)) * 60;
						var timeString = ((Math.floor(h)>0 ? (parseInt(Math.floor(h)) + ":") : "") + (m >= 10 ? parseInt(Math.floor(m)) : "0" + parseInt(Math.floor(m))) + ":" + (s >= 10 ? parseInt(Math.floor(s)) : "0" + parseInt(Math.floor(s))) );
						//<a href=\"" + myID + "\" target=\"_blank\" class=\"thumbnail\">"
						recent = $( "<div class=\""+col+"\">" 
							+ "<img class=\"thumbnail\" src=\"" + value.frameList[y] + " \"style=\"width:60px;height:60px\" onclick=\"setCurTime("+ value.videoId +", "+ seconds +")\">"
							+ "<h6>Rank:"+value.frameRank[y]+ "<br>Time:" + timeString + "</h6>"
							+ "</div>");
						thisID.append(recent);
						
                        
						//thisID.append("<p><div style=\"font-size:8pt\">");
						//thisID.append ("Rank: "+value.frameRank[y]+ "<br>Time:aaaaa");
						//thisID.append ("</div></p>");
						//var timeString = ((Math.floor(h)>0 ? (parseInt(Math.floor(h)) + ":") : "") + (m >= 10 ? parseInt(Math.floor(m)) : "0" + parseInt(Math.floor(m))) + ":" + (s >= 10 ? parseInt(Math.floor(s)) : "0" + parseInt(Math.floor(s))) );
						//thisID.append ("<button onclick=\"setCurTime("+ value.videoId +", "+ seconds +")\" type=\"button\">" + timeString + "</button>");
						//thisID.append ("<br>");
                    }
                    
					//seconds = ( value.videoTime[value.videoTime.length - 1] -2 );
					//h =  seconds / 3600.0; //3600000.0
                    //m = (h - Math.floor(h)) * 60.0;
                    //s = (m - Math.floor(m)) * 60;
                    //thisID.append ("Rank: "+value.frameRank[value.videoTime.length - 1]+ " - Time: ");
					//timeString = ((Math.floor(h)>0 ? (parseInt(Math.floor(h)) + ":") : "") + (m >= 10 ? parseInt(Math.floor(m)) : "0" + parseInt(Math.floor(m))) + ":" + (s >= 10 ? parseInt(Math.floor(s)) : "0" + parseInt(Math.floor(s))) );
					//thisID.append ("<button onclick=\"setCurTime("+ value.videoId +", "+ seconds +")\" type=\"button\">" + timeString + "</button>");
					//thisID.append ("<br></p></div>");
					
					//appends thumbnails
					//var last = $("#resultsRow"+i);
					//wrapper = $("<div class=\"row\"></div>");
					//wrapper.insertAfter(last);
					//last = wrapper;
					//for (var i =0; (i< docs.length); i++) {
						//myID = docs[i].id.toString();
						//myID = myID.replace("/home/livre/solr-4.10.2/example/solr-webapp/webapp/",''); //FOLLON XML
						//myID = myID.replace(".\\",'');
						//myID = myID.replace(/\\/g,'/'); //Windows?
						//imageUrl = reWriteImageUrl(myID);
				        //var col = "col-lg-3 col-md-12 col-sm-12 col-xs-12";
						//recent = $( "<div class=\""+col+"\"> <a href=\"" + myID + "\" target=\"_blank\" class=\"thumbnail\">"
							//+ "<img src=\"" + myID + "\"style=\"width:50px;height:50px\"></a>"
							//+ getCBIRLinks(myID)
							//+ "</div>" );
						//last.append(recent);
					//}
				
				//Closes row
				lastVideo.append ("</p></div>");
				}	
            }
		}
        
        function printResults(docs) {
            var last = $("#imageResults");
            wrapper = $("<div class=\"row\"></div>");
            wrapper.insertAfter(last);
            last = wrapper;
            for (var i =0; (i< docs.length); i++) {
                myID = docs[i].id.toString();
				myID = (myID.split(":\\")).pop(); //Removes WINDOWS drive letter from XML i.e. E:\, C:\ etc
				//myID = myID.replace("/introduce/path/to/remove/here",''); // This modifies XML paths from absolute to relative. Must change or add new lines for each different indexing machine unless Request-Handler is modified to already do this.
				myID = myID.replace(/\\/g,'/'); //WINDOWS. Comment this line if UNIX
				
				//myID = myID.replace("/home/livre/solr-4.10.2/example/solr-webapp/webapp/",''); //FOLLON XML
				//myID = myID.replace(".\\",'');
				
				imageUrl = reWriteImageUrl(myID);
				var col = "col-lg-2 col-md-3 col-sm-3 col-xs-4";
                recent = $( "<div class=\""+col+"\"> <a href=\"" + myID + "\" target=\"_blank\" class=\"thumbnail\">"
					+ "<img src=\"" + myID + "\"style=\"width:100px;height:100px\"></a>"
					+ getCBIRLinks(myID)
					+ "</div>" );
                last.append(recent);
            }
        }
                
        function clearData() {
                $(".row").remove();
                $("#videoResults").empty();
                $("#perf").html("Please stand by .... <img src=\"img/loader-light.gif\"/>");
        }
		
		
  </script>
</head>




<body>
  <div data-role="page">
    <div style="width:100%; text-align:right; background-color: #FFF"><img src="img/logo.png" /></div>

    <div class="ui-corner-all custom-corners">
      <div class="ui-bar ui-bar-a">
        <h1>LIRE Web Demo</h1>
      </div>

      <div class="ui-body ui-body-a">
        <p>This page is a simple demonstrator for the extension to video of the LIRE image search library (LIvRE). It uses a Solr back-end. Use the links below the images to trigger a new
        content based search request.</p>
      </div>
    </div>

    <div class="ui-field-contain">
      <p><label for="urlq">Search by image URL:</label><input type="text" data-mini="true" id="urlq" name="urlq" placeholder=
      "http://..." /></p>

      <p>
	  <a href="javascript:searchUrl(&#39;cl_ha&#39;);" data-role="button" data-mini="true" data-inline="true">ColorLayout</a>
      <!-- <a href="javascript:searchUrl(&#39;ce_ha&#39;);" data-role="button" data-mini="true" data-inline="true">CEDD</a>  -->
	  <a href="javascript:searchUrl(&#39;eh_ha&#39;);" data-role="button" data-mini="true" data-inline="true">EdgeHistogram</a>
	  <a href="javascript:searchUrl(&#39;jc_ha&#39;);" data-role="button" data-mini="true" data-inline="true">JCD</a> 
	  <a href="javascript:searchUrl(&#39;ph_ha&#39;);" data-role="button" data-mini="true" data-inline="true">PHOG</a>
	  <!-- <a href="javascript:searchUrl(&#39;sc_ha&#39;);" data-role="button" data-mini="true" data-inline="true">ScalableColor</a> -->
	  </p>
    </div>

	<div class="ui-corner-all custom-corners" data-role="collapsible">
      <h3>Global Parameters</h3>

      <div class="ui-field-contain">
        <label for="slider-maxVideos">Max. Video Results:</label> <input type="range" name="slider-maxVideos" id="slider-maxVideos" value="2" min="1" max="12" step="1" />
      </div>

      <div class="ui-field-contain">
        <label for="slider-maxFrames">Max. Frame Results:</label> <input type="range" name="slider-maxFrames" id="slider-maxFrames" value="20" min="4" max="200" step="4" />
      </div>
    </div>
	
    <div class="ui-corner-all custom-corners" data-role="collapsible">
      <h3>Search by tags (search handler)</h3>

      <div class="ui-field-contain">
        <label for="tagsearch">Search by tag:</label><input type="text" data-mini="true" id="tagsearch" name="tagsearch" placeholder="tags:*" />
      </div>

      <div class="ui-field-contain">
        <label for="sorthist">Order by:</label><input type="text" data-mini="true" id="sorthist" name="sorthist" data-clear-btn="true" />
      </div>
    </div>

	<div class="ui-corner-all custom-corners" data-role="collapsible">
      <h3>Query order method (search handler)</h3>

      <div class="ui-field-contain">
        <fieldset data-role="controlgroup" class="ui-controlgroup ui-controlgroup-vertical ui-corner-all">
          <div role="heading" class="ui-controlgroup-label">
            <legend>Select method for CBIR combination with tag search:</legend>
          </div>

          <div class="ui-controlgroup-controls">
            <div class="ui-radio">
              <label for="radio-v-1a" class="ui-btn ui-corner-all ui-btn-inherit ui-btn-icon-left ui-first-child ui-radio-on">boost score</label><input data-mini="true" type="radio" name="radio-v-1" id="radio-v-1a" checked="checked" data-cacheval="false" value="boost" />
            </div>

            <div class="ui-radio">
              <label for="radio-v-1b" class="ui-btn ui-corner-all ui-btn-inherit ui-btn-icon-left ui-radio-off">sort results</label><input data-mini="true" type="radio" name="radio-v-1" id="radio-v-1b" data-cacheval="false" value="sort" />
            </div>

            <div class="ui-radio">
              <label for="radio-v-1c" class="ui-btn ui-corner-all ui-btn-inherit ui-btn-icon-left ui-last-child ui-radio-off">filter query by range</label><input data-mini="true" type="radio" name="radio-v-1" id="radio-v-1c" data-cacheval="true" value="filter" />
            </div>
          </div>
        </fieldset>
      </div>
    </div>

    <div class="ui-corner-all custom-corners" data-role="collapsible">
      <h3>Search parameters (lireq handler)</h3>

      <div class="ui-field-contain">
        <label for="slider-1">Accuracy:</label> <input type="range" name="slider-1" id="slider-1" value="0.35" min="0.05" max="1.0" step="0.05" />
      </div>

      <div class="ui-field-contain">
        <label for="slider-can">Number of candidates:</label> <input type="range" name="slider-can" id="slider-can" value="10000" min="10" max="100000" step="100" />
      </div>
    </div>
	
	
	<script>
	
		$( document ).ready(function() {
                // get JSON-formatted data from the server
                $("#perf").html("Please stand by .... <img src=\"img/loader-light.gif\"/>");
                $.getJSON( solrUrlPrefix + "lireq" + "?rows=" + $("#slider-maxFrames").val() , function( myResult ) {
                        $("#perf").html("Index search time: " + myResult.responseHeader.QTime + " ms");
                        printVideoResults(myResult.docs);
                        printResults(myResult.docs);
                });
        
        });
		
		function tagSearchDo() {
			console.log($('#tagsearch').val());
			// clear the old data
			clearData();
			queryString =  solrUrlPrefix + "select?q="+$('#tagsearch').val()+"&wt=json&rows="+$("#slider-maxFrames").val();
			console.log(queryString);
			console.log($('input[name="radio-v-1"]:checked').val());
			if ($('#sorthist').val()) {
				if ($('input[name="radio-v-1"]:checked').val()=="boost") {
					queryString = queryString + "&defType=edismax&boost=div(recip(lirefunc("+$('#sorthist').val()+"),1,100,100),query($q))&randomParameter="+ Math.floor(Math.random()*50000); // boost
					console.log("Using boost");
				} else if ($('input[name="radio-v-1"]:checked').val()=="sort") {
					queryString = queryString + "&sort=lirefunc("+$('#sorthist').val()+")+asc&randomParameter="+Math.floor(Math.random()*50000); // sort
					console.log("Using sort");
				} else {
					queryString = queryString + "&fq={!frange l=0 u=40 cache=false cost=100}lirefunc("+$('#sorthist').val()+")"; // range
					console.log("Using range");
				}
			
			}
			// http://localhost:9000/solr/lire/select?q=tags%3Aaustria%0A&wt=json&indent=true
			console.log(queryString);
			$.getJSON(queryString, function( myResult ) {
				$("#perf").html("Index search time: " + myResult.responseHeader.QTime + " ms");
				$("#imageResults").html("Results for \""+$('#tagsearch').val()+"\"");
				console.log(myResult);
			
				var last = $("#imageResults");
				wrapper = $("<div class=\"row\"></div>");
				wrapper.insertAfter(last);
				last = wrapper;
				for (var i =0; i< myResult.response.docs.length; i++) {
					myID = myResult.response.docs[i].id.toString();
					myID = myID.replace("/home/livre/solr-4.10.2/example/solr-webapp/webapp/",''); //FOLLON XML
					myID = myID.replace(".\\",'');
					myID = myID.replace(/\\/g,'/');
					imageUrl = reWriteImageUrl(myID);
					tags = myResult.response.docs[i].tags[0].toString();
					if (tags.length > 60) tags = tags.substring(0, 57) + "...";
					var col = "col-lg-3 col-md-4 col-sm-6 col-xs-12";
					recent = $( "<div class=\""+col+"\"> <a href=\"" + myID + "\" target=\"_blank\" class=\"thumbnail\">"
						+ "<img src=\"" + myID + "\"style=\"width:170px;height:170px\"></a>"
						+ getCBIRLinks(myID)
						+ "<div style=\"font-size:8pt\"><p>sort: "
						+ "<a href=\"javascript:extract('cl','"+imageUrl+"');\">CL</a>, "
						//+ "<a href=\"javascript:extract('ce','"+imageUrl+"');\">CEDD</a>, "
						+ "<a href=\"javascript:extract('eh','"+imageUrl+"');\">EH</a>, "
						+ "<a href=\"javascript:extract('jc','"+imageUrl+"');\">JCD</a>, "
						+ "<a href=\"javascript:extract('ph','"+imageUrl+"');\">PH</a>, "
						+ "<a href=\"javascript:extract('sc','"+imageUrl+"');\">SC</a>"
						+ "</p></div></div>" );
					
					last.append(recent);
				}
			
			});
		}
		
		$('#tagsearch').keypress(function (e) {
			if (e.which == 13 && $('#tagsearch').val().length>=1) {
				tagSearchDo(); // do tag based search ...
			}
		});
		
		function extract(field, url) {
			serverUrl = solrUrlPrefix + "lireq?extract="+url+"&field="+field+"_ha";
			console.log(serverUrl);
			$.getJSON( serverUrl, function( myResult ) {
				console.log(myResult);
		
				if (!myResult.Error) {
					$('#sorthist').val(encodeURIComponent(field + ",\"" + myResult.histogram+"\""));
					tagSearchDo(); // do tag search ...
				}
				else {
					$("#imageResults").html("Error: \""+myResult.Error+"\"");
				}
	
			});
		}
		
		function getRange(field) {
			var result = "40";
			if (field=="cl") result = "20";
			//else if (field=="ce") result = "10";
			else if (field=="jc") result = "10";
			else if (field=="eh") result = "100";
			else if (field=="ph") result = "2000";
			//else if (field=="sc") result = "150";
			return result;
		}
		function hashSearch(field, url) {
		console.log(url);
			serverUrl = solrUrlPrefix + "lireq?extract="+url+"&field="+field+"_ha";
			console.log("Hash based search: \n " + serverUrl);
			clearData();
			$("#perf").html("Please stand by .... <img src=\"img/loader-light.gif\"/>");	
			$.getJSON( serverUrl, function( myResult ) {
				console.log(myResult);
				if (!myResult.Error) {
					var hashString = "";
					//var numHashes = 35;
					var numHashes = $("#slider-maxFrames").val();
					
					if ($("#slider-1").val()) {
						numHashes = Math.floor(myResult.hashes.length * $("#slider-1").val());
						numHashes = Math.min(myResult.hashes.length, numHashes);
					}
					for (var i =0; i< Math.max(5, numHashes); i++) {
						hashString += myResult.hashes[i] + " ";
					}
					queryString =  solrUrlPrefix + "select?q=id:*&fq="+field+"_ha:("+hashString.trim()+")&wt=json&rows="+$("#slider-maxFrames").val();
					console.log(queryString);
					if ($('input[name="radio-v-1"]:checked').val()=="boost") {
						queryString = queryString + "&defType=edismax&boost=div(recip(lirefunc("+encodeURIComponent(field + ",\"" + myResult.histogram+"\"")+"),1,100,100),query($q))"; // boost
						console.log("Using boost");
					} else if ($('input[name="radio-v-1"]:checked').val()=="sort") {
						queryString = queryString + "&sort=lirefunc("+encodeURIComponent(field + ",\"" + myResult.histogram+"\"")+")+asc"; // sort
						console.log("Using sort");
					} else {
						queryString = queryString + "&fq={!frange l=0 u="+getRange(field)+" cache=false cost=100}lirefunc("+encodeURIComponent(field + ",\"" + myResult.histogram+"\"")+")"; // range
						console.log("Using range");
					}
					console.log(queryString);
					
					// now get the results:
					$.getJSON( queryString, function( myResult2 ) {
						$("#perf").html("Search took " + myResult2.responseHeader.QTime + " ms, " + myResult2.response.numFound + " documents found");
						console.log(myResult2);
						
						if (!myResult2.Error) {
							printResults(myResult2.response.docs);
							printVideoResults(myResult2.response.docs);
						}
						else {
							$("#imageResults").html("Error: \""+myResult2.Error+"\"");
						}
					});
				}
				else {
					$("#imageResults").html("Error: \""+myResult.Error+"\"");
				}
			});
		}
		
		function search(idString, field) {
			console.log(idString);
			// clear the old data
			clearData();
			//$(".row").remove();
			$("#perf").html("Please stand by .... <img src=\"img/loader-light.gif\"/>");
			$("#imageResults").html("Results for query id \""+idString+"\"");
			
			// get all the new data from the server ...
			serverUrl = solrUrlPrefix + "lireq?rows="+$("#slider-maxFrames").val()+"&id="+idString+"&field="+field;
			console.log(serverUrl);
			if ($("#slider-1").val()) serverUrl += "&accuracy="+$("#slider-1").val();
			if ($("#slider-can").val()) serverUrl += "&candidates="+$("#slider-can").val();
			console.log(serverUrl);
			$.getJSON( serverUrl, function( myResult ) {
				$("#perf").html("Index search time: " + myResult.responseHeader.QTime + " ms (query " + myResult.RawDocsSearchTime + " ms, rank " + myResult.ReRankSearchTime  + " ms)");
				console.log(myResult);
				
				if (!myResult.Error) {
					printVideoResults(myResult.docs);
					printResults(myResult.docs);
				}
				else {
					$("#imageResults").html("Error: \""+myResult.Error+"\"");
				}
			
			});
		}
		
        function searchUrl(field) {
		   console.log($("#slider-1").val());
			// clear the old data
			clearData();
			$("#imageResults").html("Results for query \""+$("#urlq").val().substring(0,12)+"...\"");
			// get all the new data from the server ...
			serverUrl = solrUrlPrefix + "lireq?rows="+$("#slider-maxFrames").val()+"&url="+$("#urlq").val()+"&field="+field;
			console.log(serverUrl);
			if ($("#slider-1").val()) serverUrl += "&accuracy="+$("#slider-1").val();
			if ($("#slider-can").val()) serverUrl += "&candidates="+$("#slider-can").val();
			console.log(serverUrl);
			$.getJSON( serverUrl, function( myResult ) {
				$("#perf").html("Index search time: " + myResult.responseHeader.QTime + " ms (query " + myResult.RawDocsSearchTime + " ms, rank " + myResult.ReRankSearchTime  + " ms)");
				console.log(myResult);
					
				printVideoResults(myResult.docs);
				printResults(myResult.docs);
			});
		};    
    </script>

	
    <p class="otherLink"><i id="perf">Index search time</i></p>

	<!-- Video -->
    <h1>Video Query Results</h1>
    <div id="videoResults" class="container-fluid"></div>
	
	<!-- Image -->
	<h1>Image Query Results</h1>
	<div id ="imageResults" class="container-fluid"></div>
	   
	<!-- Captures -->
	<!-- <h1>Frame Captures</h1> 
	
	<div id="container" style="border:none">
		<canvas id="imageView" style="display:none; left: 0; top: 0; z-index: 0;border:none" width="480" height="270">
      
		</canvas>
    </div>
		
	<div id="imgs"> 
	
	</div>
	-->
	<br style="clear:both;" />
	
  </div>
  
</body>

</html>