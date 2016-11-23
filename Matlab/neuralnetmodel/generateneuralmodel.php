<?php  

$jsonObj=$_GET["neuralnetjson"];
$modelingid=$_GET["modelingid"];

$fp = fopen('neuraljsonObj.json', 'w');
fwrite($fp, json_encode($jsonObj));
fclose($fp);



$json = file_get_contents('../models/listofmodels.json');

$json = utf8_encode($json);
$jsond=json_decode($json,true);
$modelname = $jsond[0]['nameofmodel'][$modelingid];
$matlabscriptname= $jsond[0]['matlabscriptname'][$modelingid];

$modelingname_array= explode('.', $matlabscriptname);

$modelingname=$modelingname_array[0];
	
//echo ($modelname.'hi'.$matlabscriptname.$modelingname[0]);
//print_r($modelingname)

shell_exec('/Applications/MATLAB_R2015b.app/bin/matlab -nosplash -nodesktop -nodisplay -r '.$modelingname.' -logfile filename.log v=variant');

// shell_exec('/Applications/MATLAB_R2015b.app/bin/matlab -nosplash -nodesktop -nodisplay -r WaterNN -logfile filename.log v=variant');


  ?>
