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

  <script src="js/library/jquery.colorbox-min.js"></script>
  <script src="js/library/plotly-latest.min.js"></script>


<!-- Javascript for User Interface -->



        <script src="js/paper/neuralnetmodeling.js"></script>
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
						<li class="hvr-bounce-to-bottom"><a href="datacleaning.html">Data Cleaning</a></li>
						<li class="hvr-bounce-to-bottom"><a href="correlation.html">Correlation</a></li>
					<!-- 	<li class="hvr-bounce-to-bottom"><a href="timelineview.html">Time Line View</a></li> -->
						<li class="hvr-bounce-to-bottom"><a href="neuralnetmodel.html">Neural Network Modeling</a></li>
						<li class="hvr-bounce-to-bottom"><a href="animation.html">Animation</a></li>
					  </ul>
					</div><!-- /.navbar-collapse -->
				</nav>
			</div>
		</div>
	</div>
<!-- //header -->
<!-- single -->
	<div class="single">
	<div class="container">
		<h3>Neural Network  Modeling</h3>
	
		<div class="clearfix"> </div>
		<div class="grid_3 grid_5">
		
				<div class="well">
					Now you are on the step for Neural Network Modeling. You can choose the number of inputs upon your experience or you can get some idea from the <a href="http://localhost:8888/Thesis/PaperVer1/Demo/correlation.html"> correlation page.</a> We are using the The nonlinear autoregressive network with exogenous inputs (NARX) method in our background for our time series modeling. You can read more about this alogrithm from <a href="http://uk.mathworks.com/help/nnet/ug/design-time-series-narx-feedback-neural-networks.html?searchHighlight=narx">Matlab. </a> <!-- Considering a case for our paper. We will walk you through the process for the prediction of trajectory.
					<br>
					We have condiser inputs for our trajectory are Sway Velocity, Surge Velocity, Position East and Position North.
					<br>
					For output We have condiser Position East and Position North.<br> -->
				
					Now to start selecting your inputs , desired number of hidden neurons and outputs. Once you finished Press the "Start Modeling"  Button.
					<br> Press control to multiple selection.

				</div>

		<!-- 		End of First Block -->

				<center>
	<!-- Table --> 	

	<div class="bs-docs-example">		
			<table class="table table-striped" border="1">
				<tr><th rowspan="1">Inputs</th><th>Hidden Neurons</th><th>Outputs</th></tr>
					<tr>
						<td rowspan="1">
							<select id="inputs" class="selectbox" size="5" multiple="multiple" name="multiple">
				           <?php

$json = file_get_contents('Matlab/dataclean/labels.json');

$json = utf8_encode($json);
$jsond=json_decode($json,true);

$c=count($jsond['labels'][0]);
//echo $c;
for ($i=1; $i <$c; $i++) { 
	echo $i;
	$bb=$jsond['labels'][1][$i];
	print('<option value="'.($i).'" >'.$bb.'</option>');
}

?>			     
	    					</select>  
    					</td>
						<td>
							<input type="text" id="hiddennet" class="textbox" />
						</td>

						<td id="">
							<select id="outputs" class="selectbox" size="5" multiple="multiple" name="multiple">
				          <?php

$json = file_get_contents('Matlab/dataclean/labels.json');

$json = utf8_encode($json);
$jsond=json_decode($json,true);

$c=count($jsond['labels'][0]);
//echo $c;
for ($i=1; $i <$c; $i++) { 
	print_r($i);
	$bb=$jsond['labels'][1][$i];
	print('<option value="'.($i).'" >'.$bb.'</option>');
}

?>	
				            </select> 
				        </td>
				    </tr>
					<tr><td colspan="3" align="center"><h1><button id="neuralnetmodel" class="label label-primary">Show Me Model </button></h1></td></tr>
					
			</table>
	</div>

	<div class="well">
			Now You are ready to start modeling based on your configuration.Please proceed to modeling by pressing the "Start Modeling" Button. Press control to multiple selection.
				</div>


		<h1><button id="neuralnet" class="label label-primary">Start Modeling</button></h1>
<!-- END Table -->
					<div id="wait" style="width: 251px; height: 105px; border: 2px solid black; top: 70%; left: 50%; margin-bottom:5px; display:none;">
					<img src='img/loading.gif' width="200" height="100"/><br>Matlab is Working Please Wait..
					</div>
				</center>	

	<!-- 	Second Block 	 -->
			
			
				<div class="clearfix"> </div>
				<br>
				<div class="well">
			Matlab Will run background after you start Modeling.The Result is stored in JSON files. Now Click on Display results to see the Neural Network result. 
				</div>

<!-- End of second Blocks	 -->
<!-- 		display Time line blocks -->
		<center>
			<h1>
				<button id="nnresult" class="label label-primary">Display Results</button>

			</h1>
		</center>
<!-- End of display Time line block -->

	</div>
<!-- 	End of Boxes. -->


<!-- 	Time line  Area Div -->
		<div class="tags-cate">
		<center>
			<div id="chartarea">
				
			</div>
			<br><br><br>
			<div id="chartarea1">
				
			</div>
		</center>
		
		</div>

<!-- End Timeline Area Div	 -->	
	
				<div class="well">
			Note: To see the effect of modification, Please refresh the page and choose your modification.
				</div>

			<div class="col-md-6" style="float: left;">
					<ul class="pagination pagination-lg">
						<li ><a href="timelineview.html"><i class="fa fa-angle-left">«</i></a></li>
							
						<li><a href="timelineview.html"><i class="fa fa-angle-right">Previous</i></a></li>
					</ul>
			
				</div>


			<div class="col-md-6" style="float: right;">
					<ul class="pagination pagination-lg">
					
							
						<li><a href="simulationvessel.html"><i class="fa fa-angle-right">Next</i></a></li>
						<li><a href="simulationvessel.html"><i class="fa fa-angle-right">»</i></a></li>
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