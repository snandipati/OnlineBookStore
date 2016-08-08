<?php
//Establishes database connection
$con = mysql_connect("localhost","root","root");
if (!$con)
  {
  die('Could not connect: ' . mysql_error());
  }

mysql_select_db("sportsera_database", $con);


?>