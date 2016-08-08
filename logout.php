<?php
session_start();              //Starting the session for the registered or admin as user.
$_SESSION = array();
header ('Location: index.php') ; // Adding Logout option under menu bar.