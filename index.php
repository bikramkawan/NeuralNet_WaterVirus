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
<!-- js -->
<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.js"> </script>
<script src="js/paper/addnewmodel.js"></script>
<!-- <script type="text/javascript" src="js/library/Ajaxfileupload-jquery-1.3.2.js" ></script>
<script type="text/javascript" src="js/library/ajaxupload.3.5.js" ></script> -->

<!-- <script src="firstscene.js"></script> -->
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
						<li class="hvr-bounce-to-bottom"><a href="animation.html"> Animation</a></li>
					  </ul>
					</div><!-- /.navbar-collapse -->
				</nav>
			</div>
		</div>
	</div>
<!-- //header -->

 <div id="Stats-output"> </div>

<!-- banner -->

<!-- //banner -->
<!-- banner-bottom -->
	<div class="banner-bottom">
		<div class="container">
			<div id="webgloutput">
			<center><img src="img/waterbg.jpg" width="600" height="500"></center>
			
			</div>
			<h3>Welcome To Our Neural Network Prototype</h3>
			<p class="velit">This application will illustrate how we can implemenet Neural Network for the prediction of Virus in Water.</p>
			<div class="banner-bottom-grids">
				<div class="col-md-4 banner-bottom-grid">
					<h4>About Our Application</h4>
					<p>This is demonstration for Virus in Water</p>
					<div class="more">
						<a href="#" class="hvr-bounce-to-bottom">Read More</a>
					</div>
				</div>
				<div class="col-md-4 banner-bottom-grid">
					<h4>Our Frame Work</h4>
					<p>	
					<select id="addmodel" class="selectbox">
					 <option value="">Select Method</option>
				           <?php

$json = file_get_contents('Matlab/models/listofmodels.json');

$json = utf8_encode($json);
$jsond=json_decode($json,true);
//echo($jsond[0]['nameofmodel'][1]);
//echo($jsond[0]['matlabscriptname'][1]);
$c=count($jsond[0]['nameofmodel']);
//echo $c;
for ($i=0; $i <$c; $i++) { 
	//print_r($i);
	$bb=$jsond[0]['nameofmodel'][$i];
	print('<option value="'.($i).'" >'.$bb.'</option>');
}



?>			     
</select> <br>
<br>
	<button id="deletemodel">Delete Model</button>

</a><br></p>
				</div>
				<div class="col-md-4 banner-bottom-grid">
					<h4>Upload New Modeling</h4>

					Name: <input type="text" name="modelname" value="" id="modelname"><br>
						
				<input id="sortpicture" type="file" name="sortpic" />
				<button id="upload">Upload</button>

						</div>
					<br>
					
				</div>
				<div class="clearfix"> </div>
			</div>
			

			<div><p> To start using the application. Please upload the file. Currently we support .txt and .CSV only.
				<div class="get-in-grids">
					<div class="get-in-grid-left">
						<p>Upload Your Files Here</p>
					</div id="modelfile">
					<div class="get-in-grid-right">
					<input id="updata" type="file" name="updata" />
					<br></br>
					<button id="uploaddata">Upload Dataset</button>
						
					</div>
					<div class="clearfix"> </div>

				</div>


			</div>	

				<div class="col-md-6" style="float: right;">
					<ul class="pagination pagination-lg">
											
						<li><a href="datacleaning.html"><i class="fa fa-angle-right">Next</i></a></li>
					<li><a href="datacleaning.html"><i class="fa fa-angle-right">»</i></a></li>
					</ul>
			
				</div>

			
			
		</div>

	</div>
<!-- //banner-bottom -->


<!-- footer -->

	<div class="footer-copy">
		<p>© 2016 Edition. | Application Made and Design by <a href="http://bikramkawan.com.np"> Bikram Kawan </a></p>
		<br>
			<p> <a href="http://blog.hials.no/bigdata/"> Product of Big Data Lab </a>, NTNU, Aalesund</p>
		
	</div>

<!-- //footer -->
<!-- for bootstrap working -->
	
<!-- //for bootstrap working -->




</body>
</html>