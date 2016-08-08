<?php
session_start();
require_once 'db.php';
$email = $_POST['email'];    //gets email and password from form from thr UI
$password=$_POST['password'];
$query = "select userid, email,password, isadmin from user where email = '{$email}'";
$result=mysql_query($query);
if ($result == false) {
	header ('Location: index.php?error=2') ;
} else {
	$row = mysql_fetch_assoc($result);
	if ($email == $row["email"] && $password == $row["password"]) // Selects the username and password from the table 
	                                                               //and compares it with the form details saved which are tried to login
	{
		// store session data
		$_SESSION['userid']=$row["userid"];
		if ($row['isadmin']) {
			$_SESSION['isadmin']=$row["isadmin"];
			header ('Location: adminhome.php') ;   //redirects to adminhomepage
		} else {
			header ('Location: Search.php') ;     //redirects to search home page
		}
	}
	else
	{
		header ('Location: index.php?error=1') ;
	}
}
