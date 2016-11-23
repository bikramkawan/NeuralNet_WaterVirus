<!--
Author URL: http://bikramkawan.com.np
Email : bikramkawan@gmail.com
Version: 18.03.2016
-->
<!DOCTYPE html>
<html>
<head>
<title>Neural Network Prototype for time series Modeling</title>
<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Erudition Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
		function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- //for-mobile-apps -->
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<link href="css/select.css" rel="stylesheet" type="text/css" media="all" />

<!-- js -->
 <script src="js/library/jquery.min.js"></script>
  <script src="js/library/jquery-ui.js"></script>



  <script src="js/library/plotly-latest.min.js"></script>

    <script src="js/paper/datacleaning.js"></script>
 
<!-- //js -->
<link href='//fonts.googleapis.com/css?family=Raleway:400,100,200,300,500,600,700,900,800' rel='stylesheet' type='text/css'>
<link href='//fonts.googleapis.com/css?family=Audiowide' rel='stylesheet' type='text/css'>
</head>
	
<body>
<!-- header -->
	<div class="header">
		<div class="container">
			<div class="header-top">
				<div class="header-top-left">
									<p>Neural Network Prototype</p>
				</div>
				<div class="header-top-left1">
					 <!-- start search-->
						<div class="search-box">
							
						</div>
						<!-- search-scripts -->
					
						<!-- //search-scripts -->
				</div>
				<div class="header-top-right">
					
				</div>
				<div class="clearfix"> </div>
			</div>
		</div>
	</div>
	<div class="header-logo">
		<div class="container">
			<div class="header-nav">
				<nav class="navbar navbar-default">
					<!-- Brand and toggle get grouped for better mobile display -->
					<div class="navbar-header">
					  <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					  </button>
						<div class="logo">
										<a class="navbar-brand" href="index.php">NTNU</a>
						</div>
					</div>

					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse nav-wil" id="bs-example-navbar-collapse-1">
					 <ul class="nav navbar-nav">
							<li class="hvr-bounce-to-bottom active"><a href="index.php">Home</a></li>
						<li class="hvr-bounce-to-bottom"><a href="datacleaning.php">Data Cleaning</a></li>
						<li class="hvr-bounce-to-bottom"><a href="correlation.php">Correlation</a></li>
						<!-- <li class="hvr-bounce-to-bottom"><a href="timelineview.html">Time Line View</a></li> -->
						<li class="hvr-bounce-to-bottom"><a href="modeling.php">Modeling</a></li>
						<li class="hvr-bounce-to-bottom"><a href="animation.html"> Animation</a></li>	  </ul>
					</div><!-- /.navbar-collapse -->
				</nav>
			</div>
		</div>
	</div>
<!-- //header -->
<!-- single -->
	<div class="single">
	<div class="container">
		<h3>Data Cleaning</h3>
	
		<div class="clearfix"> </div>
		<div class="grid_3 grid_5">
		
				<div class="well">
					Considering the raw data may contains noisy, discontinu- ous and redundant information, it is necessary to clear the data so that its affection on further analysis and modeling can be minimized.
					Noise reduction is the first step in data cleaning process.In our paper we have discussed three types of cleaning techinques which are
					<br>
					<br>
					<ul class="list-group">
						  
						  <li class="list-group-item"><a href="http://uk.mathworks.com/help/matlab/ref/interp1.html">Fill Missing Values</a></li>
						  
					</ul>
					We have used Linear Interpolation Method for Missing Values.
					<br>Select an Interpolation from the dropdown.
				</div>
		<!-- 		End of First Block -->

				<center>
					<select id="dataclean" class="selectbox">
					 <option value="">Select Method</option>
					 <option value="lpf" id="1">Low Pass Filter</option>
					 <option value="resampling" id="2">Median Filtering</option>
					 <option value="phase" id="3">Interpolation</option>
					</select>
				</center>	

	<!-- 	Second Block 	 -->
			
			
				<div class="clearfix"> </div>
				<br>
				<div class="well">
				To Process Click on Clean Data. Once you press submit Matlab will be working on background and result will be stored in JSON format.
				</div>

<!-- End of second Blocks	 -->
				<center>
					<h1>
					<button id="cleaning" class="label label-primary">Clean data</button>
					</h1>
					<br>
					<div id="wait" style="width: 251px; height: 105px; border: 2px solid black; top: 70%; left: 50%; margin-bottom:5px; display:none;">
					<img src='img/loading.gif' width="200" height="100"/><br>Matlab is Working Please Wait..
					</div>
				</center>
				<br>
					<div class="well">
			To see the result created by Matlab Select Feature Attribute and Click Plot to see  Result
				</div>
				<br>
				<center>
				<?php

// $json = file_get_contents('Matlab/dataclean/labels.json');

// $json = utf8_encode($json);
// $jsond=json_decode($json,true);

// $c=count($jsond['labels'][1]);
// //echo $c;
// for ($i=0; $i <$c; $i++) { 

	
// 	echo ($jsond['labels'][1][$i]);


// }

?>

<select id="featureattr" class="selectbox">
					 <option value="">Select Attribute</option>
					 <?php

$json = file_get_contents('Matlab/dataclean/labels.json');

$json = utf8_encode($json);
$jsond=json_decode($json,true);

$c=count($jsond['labels'][0]);
//echo $c;
for ($i=1; $i <$c; $i++) { 
	echo $i;
	$bb=$jsond['labels'][1][$i];
	print('<option value="'.$bb.'" id="'.$i.'">'.$bb.'</option>');
}

?>

					
	</select>

	
			<!-- 
					<select id="featureattr" class="selectbox">
					 <option value="">Select Attribute</option>
					 <option value="koliforme" id="1">Koliforme Bakterier</option>
					 <option value="termotol" id="2">Termotol Koliforme</option>
					 <option value="kimtall" id="3">Kimtall v/22°C</option>
					  <option value="fargetall" id="4">Fargetall</option>
					 <option value="turbiditet" id="5">Turbiditet</option>
					 <option value="ph" id="6">pH surhetsgrad</option>
					  <option value="kondukt" id="7">Konduktivitet/Led.ev</option>
					</select> -->
				<br><br><br>
				<h1>
				<button id="termotol" class="label label-primary">Plot Termotol </button>
				</h1>
				</center>
	</div>
<!-- Starting of select Box to show plot -->


<!-- End of Plots	 -->	
				
	
<!-- 	Chart Area Div -->
		<div class="tags-cate">
		<center>
	
				<div id="rawdatadiv">
				
				</div>

			</center>
	
			<div class="clearfix"> </div>
		</div>

<!-- End Chart Area Div	 -->	
	
				<div class="well">
			Note: To see the effect of modification, Please refresh the page and choose your modification.
				</div>



					<div class="col-md-6" style="float: left;">
					<ul class="pagination pagination-lg">
						<li ><a href="neuralindex.php"><i class="fa fa-angle-left">«</i></a></li>
							
						<li><a href="neuralindex.php"><i class="fa fa-angle-right">Previous</i></a></li>
					</ul>
			
				</div>


			<div class="col-md-6" style="float: right;">
					<ul class="pagination pagination-lg">
						
							
						<li><a href="correlation.html"><i class="fa fa-angle-right">Next</i></a></li>
						<li><a href="correlation.html"><i class="fa fa-angle-right">»</i></a></li>
					</ul>
			
				</div>
	</div>

			
	</div>
<!-- //single -->
<!-- footer -->
	<div class="footer-copy">
		<p>© 2016 Edition. | Application Made and Design by <a href="http://bikramkawan.com.np"> Bikram Kawan </a></p>
		<br>
			<p> <a href="http://blog.hials.no/bigdata/"> Product of Big Data Lab </a>, NTNU, Aalesund</p>
		
	</div>
<!-- //footer -->
<!-- for bootstrap working -->
		<script src="js/bootstrap.js"> </script>
<!-- //for bootstrap working -->
</body>
</html>