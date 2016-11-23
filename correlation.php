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
 <script src="js/library/jquery.min.js"></script>
  <script src="js/library/jquery-ui.js"></script>

  <script src="js/library/vis.js"></script>

  <script src="js/library/plotly-latest.min.js"></script>

    <script src="js/paper/datacleaning.js"></script>
    <script src="js/paper/correlationdata.js"></script>
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
		<h3>Correleation Coefficents with Attributes</h3>
	
		<div class="clearfix"> </div>
		<div class="grid_3 grid_5">
		
				<div class="well">
					The correlation coefficient of two random variables is a measure of their linear dependence. Read more from <a href="http://uk.mathworks.com/help/matlab/ref/corrcoef.html"> Matlab </a>. Before we start selecting parameters for inputs and targets it is wise to see the overview of relation between each other attributes. There are two important parameters to understand the Correlation Coefficients.
					<br>
					<br>
					<ul class="list-group">
						  <li class="list-group-item">R = corrcoef(A) returns the matrix of correlation coefficients for A, where the columns of A represent random variables and the rows represent observations. </li>
						  <br>
						  <li class="list-group-item">P-values. It range from 0 to 1, where values close to 0 correspond to a significant correlation in R and a low probability of observing the null hypothesis.</li>
					</ul>
					Now to start the process Click the Process Correlation button below.

				</div>
		<!-- 		End of First Block -->

				<center>
					<h1>				
					<button id="generatecorrdata" class="label label-primary">Process Correlation</button>
					</h1>
					<div id="wait" style="width: 251px; height: 105px; border: 2px solid black; top: 70%; left: 50%; margin-bottom:5px; display:none;">
					<img src='img/loading.gif' width="200" height="100"/><br>Matlab is Working Please Wait..
					</div>
				</center>	

	<!-- 	Second Block 	 -->
			
			
				<div class="clearfix"> </div>
				<br>
				<div class="well">
			Matlab Will run background after you start process correlation.The Result is stored in R x P Matrix format in JSON files. The left select option is attribute which you want to find relationship with other(multiple select option). For example click Roll from left and you may want to see how it is correlated and significant with others from seccond option say choose Surge Velocity , Sway Velocity and Yaw Velocity.Once You are done with selection of attributes then click on "Display Result" button to the see plot.Press Control button on Key board for multiple selection.
				</div>

<!-- End of second Blocks	 -->


<!-- Starting of select Box to show plot -->

			<div align="center">
		<!-- 		<select name="plotwhole" class="selectbox" id="corrx" style="margin-right: 100px;">
				   			<option >Select Option</option>
					 <option value="koliforme" id="1">Koliforme Bakterier</option>
					 <option value="termotol" id="2">Termotol Koliforme</option>
					 <option value="kimtall" id="3">Kimtall v/22°C</option>
					  <option value="fargetall" id="4">Fargetall</option>
					 <option value="turbiditet" id="5">Turbiditet</option>
					 <option value="ph" id="6">pH surhetsgrad</option>
					  <option value="kondukt" id="7">Konduktivitet/Led.ev</option>
			
				</select>
	 -->

					<select name="plotwhole" class="selectbox" id="corrx" style="margin-right: 100px;">
				   			<option >Select Option</option>
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
	
<!-- 	HTML Select  -->
		<!-- 		<select id="multiple" class="selectbox" size="5" multiple="multiple" name="multiple" align="left">
				          
					 
				 <option value="0">Koliforme Bakterier</option>
					 <option value="1" >Termotol Koliforme</option>
					 <option value="2" >Kimtall v/22°C</option>
					  <option value="3" >Fargetall</option>
					 <option value="4" >Turbiditet</option>
					 <option value="5" >pH surhetsgrad</option>
					  <option value="6">Konduktivitet/Led.ev</option>
				 </select>  
 -->


				<select id="multiple" class="selectbox" size="5" multiple="multiple" name="multiple" align="left">
				          
					 
			<option >Select Option</option>
										 <?php

$json = file_get_contents('Matlab/dataclean/labels.json');

$json = utf8_encode($json);
$jsond=json_decode($json,true);

$c=count($jsond['labels'][0]);
//echo $c;
for ($i=1; $i <$c; $i++) { 
	echo $i;
	$bb=$jsond['labels'][1][$i];
	print('<option value="'.($i-1).'" >'.$bb.'</option>');
}

?>

					 
				 </select>  



					</div>		


<!-- End of Plots	 -->
			<br>	
				<div class="well">
			To see the result , Please click on Display Result
				</div>
			<center>
						<h1>
						<button id="corrbar" class="label label-primary">Display Result</button>

						</h1>
				
		</center>
							
	</div>
<!-- 	Chart Area Div -->
		<div class="tags-cate">
			<div id="corrchartarea">
			
			</div>
	
			<div class="clearfix"> </div>
		</div>

<!-- End Chart Area Div	 -->	
	
				<div class="well">
			Note: To see the effect of modification, Please refresh the page and choose your modification.
				</div>



						<div class="col-md-6" style="float: left;">
					<ul class="pagination pagination-lg">
						<li ><a href="datacleaning.html"><i class="fa fa-angle-left">«</i></a></li>
							
						<li><a href="datacleaning.html"><i class="fa fa-angle-right">Previous</i></a></li>
					</ul>
			
				</div>


			<div class="col-md-6" style="float: right;">
					<ul class="pagination pagination-lg">
												
						<li><a href="timelineview.html"><i class="fa fa-angle-right">Next</i></a></li>
						<li><a href="timelineview.html"><i class="fa fa-angle-right">»</i></a></li>
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