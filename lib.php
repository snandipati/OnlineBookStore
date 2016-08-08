<?php
session_start();
require_once 'db.php';
function isAdmin() {  //function to check if he is a admin
	return isset($_SESSION['isadmin']);
}

function isUserLoggedin() {  //function to check if the user has logged in
	return isset($_SESSION['userid']);
}

function getLoggedInUserId() { //function to get userid of loggedin user .
	if (isUserLoggedin()) {
		return $_SESSION['userid'];
	}
	return false;
}