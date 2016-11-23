<?php  

$jsonObj=$_GET["listofmodels"];

$file = "listofmodels.json";
if (!unlink($file))
  {
  echo ("Error deleting $file");
  }
else
  {
  echo ("Deleted $file");
  }


$fp = fopen('listofmodels.json', 'w');
fwrite($fp, json_encode($jsonObj));
fclose($fp);

//echo (json_encode($jsonObj));
// shell_exec('/Applications/MATLAB_R2015b.app/bin/matlab -nosplash -nodesktop -nodisplay -r '.$modelingname.' -logfile filename.log v=variant');



  ?>
