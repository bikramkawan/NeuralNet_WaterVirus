<?php  



shell_exec('/Applications/MATLAB_R2015b.app/bin/matlab -nosplash -nodesktop -nodisplay -r fillnandata -logfile filename.log v=variant');
//echo "<pre>$output</pre>";
//echo gettype($output);
$str = file_get_contents('cleandata.json');

//$jsonTable = json_encode($str);
echo $str;
  ?>
