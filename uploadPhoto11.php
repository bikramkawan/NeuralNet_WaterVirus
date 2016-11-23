<?php
$uploaddir = 'Matlab/models/'; 
$file = $uploaddir .basename($_FILES['uploadfile']['name']); 
$file_name= $_FILES['uploadfile']['name']; 
 
if (move_uploaded_file($_FILES['uploadfile']['tmp_name'], $file)) { 
  echo "success"; 
} else {
	echo "error";
}
?>
