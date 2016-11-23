<?php  

$featureid=$_GET["featureid"];
$decriptive_mode=$_GET["decriptive_mode"];
$jsonObj=array($featureid,$decriptive_mode);
$fp = fopen('decriptive_mode.json', 'w');
fwrite($fp, json_encode($jsonObj));
fclose($fp);



shell_exec('/Applications/MATLAB_R2015b.app/bin/matlab -nosplash -nodesktop -nodisplay -r descriptive -logfile filename.log v=variant');



  ?>
