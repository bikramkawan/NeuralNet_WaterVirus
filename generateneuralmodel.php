<?php

	$uploads_dir = 'Matlab/';
	
    if ( 0 < $_FILES['file']['error'] ) {
        echo 'Error: ' . $_FILES['file']['error'] . '<br>';
    }
    else {
    		$filename=$_FILES['file']['name'];
        move_uploaded_file($_FILES['file']['tmp_name'], $uploads_dir.$filename);
    }



 
    $jsonObj=array($filename);
    $fp = fopen('Matlab/datasetfilename.json', 'w');
    fwrite($fp, json_encode($jsonObj));
    fclose($fp);

   // echo ($uploads_dir.$filename);


?>