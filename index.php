<?php
require_once 'lib.php';
if (isUserLoggedin()){
	header('Location:Search.php'); //if user has Logs in leads her to search page
	return;
}
require_once 'header.php';
?>
	 <div id="PageSection">
	 
	 		<?php 
			//Displays error and success messages acordingly.
	 			if (isset($_GET['error'])) {
					echo "<h3> Could not login, try again \n</h3>";
				} else if (isset($_GET['success'])){
					echo "<h3> You have been successfully signed up. Please login. </h3>";
					
				}
	 		?>         <!-- Allows users to sign in -->
			         <h4>Registered Members Login here! </h4>
					<form name="ValidateLogin" method="post" action="LogIn.php">
						<p><b>Email:&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;  </b><input type="text" name="email" size="20"></p>
						<p><b>Password:        </b><input type="password" name="password" size="20"></p>
						<button id="b1" type="button" class="button" onclick="Validate1()" >Login </button> 
					</form>
					<p> <b><a href="register.php"> Not a Member yet? </a> </b></p>
                    <p> <b>Register to get 5% discount </a> </b></p>
					<br></br>
					<br></br>
					
		</div>
<?php 
require_once 'footer.php';