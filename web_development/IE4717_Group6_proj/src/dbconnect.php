<?php
@$dbcnx = new mysqli('localhost','root','','f38_dg06');
// @ to ignore error message display //
if ($dbcnx->connect_error){
	echo "Database is not online"; 
	exit;
	// above 2 statments same as die() //
	}
/*	else
	echo "Congratulations...  MySql is working..";
*/
if (!$dbcnx->select_db ("f38_dg06")){
	exit("<p>Unable to locate the f38_dg06 database</p>");
}

// echo "<script>alert('DB connected');</script>";
// $dbcnx->close();
?>