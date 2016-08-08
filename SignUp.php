<?php
require_once 'lib.php';
require_once 'db.php';

//Gets all the details posted from the Ui and saves them in variables.
$email = $_POST['email'];
$password=$_POST['password'];
$firstname=$_POST['firstname'];
$lastname=$_POST['lastname'];
$street=$_POST['street'];
$city=$_POST['city'];
$state=$_POST['state']; 
$zipcode=$_POST['zipcode'];
$isadmin=$_POST['isadmin'];
$phone=$_POST['phone'];

//selects email and compares with the email enetered while logging in.
$query = "SELECT * FROM user WHERE email='$email' ";
$result = mysql_query($query) or die(mysql_error());

if (mysql_num_rows($result) )
{
    header ('Location: UserExists.php') ; // Redirects to Userexists page.
}
else
{
	mysql_query("SET AUTOCOMMIT=0");
	mysql_query("START TRANSACTION");
              //Starts transaction.
	$result1 = mysql_query("INSERT INTO address (addressline1, city, state, zipcode) values ('{$street}', '{$city}','{$state}',$zipcode)");
	if ($result1){
		$addressid = mysql_insert_id();
		$result2 = mysql_query("INSERT INTO user (email, password, firstname,lastname, phone) VALUES ('$email', '$password','$firstname','$lastname',$phone)");
		if ($result2) {
			$userid = mysql_insert_id();
			$sql = "INSERT INTO user_address (userid, addressid) values ($userid , $addressid)";
			$result3 = mysql_query($sql);
			if (!$result3) {
				echo mysql_error();   //If error rollBack 
			}
		} else {
			echo mysql_error();
		}
		
	} 
	
	if ($result1 && $result2 && $result3) {
		mysql_query("COMMIT");            //Commits the trasaction
		header ('Location: index.php?success=1') ;
	} else {
		mysql_query("ROLLBACK");          //rollsback when an error occurs
		header ('Location: register.php?error=1') ;
	}
	
	
      
}

