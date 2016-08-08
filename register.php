<?php
require_once 'lib.php'; //includes header,lib and makes connection with db.
require_once 'db.php'; 
require_once 'header.php';
?>

			 <div id="PageSection">
			     <?php
			     	if (isset($_GET['error'])) {
						echo "Error in registration\n";
					}
				?>
				<!-- Registration Form to be filled while signing up !-->
			    <form name="registerblock" method="post" action="SignUp.php">
	                           Email : <input type="text" size="30px" id="email" name="email" /> <br></br>
	                           Password : <input type="password" name="password" size="30px" id="password" /> <br></br>
	                           First Name :  <input type="text" id="firstname" size="30px" name="firstname" /> <br></br>
	                           Last Name :  <input type="text" id="lastname" size="30px" name="lastname" /> <br></br>
							   Street :   <input type="text" id="street" size="30px" name="street" /> <br></br>
	                           City :  <input type="text" id="city" size="30px" name="city" /> <br></br>
	                           State :  <input type="text" id="state" size="30px" name="state" /> <br></br>
							   ZipCode : <input type="text" id="zipcode" size="30px" name="zipcode" maxlength="10"/> <br></br>
							   phone :  <input type="text" id="phone" size="30px" name="phone" maxlength="10"/> <br></br>
							   <button id="b2" type="button" class="button" onclick="Validate2()" >SIGN UP</button>  
			    </form>

			 </div>
			 <!--includes footer to the web page.--!>
<?php require_once 'footer.php';?>