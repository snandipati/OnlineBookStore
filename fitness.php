<?php
require_once 'lib.php';
require_once 'header.php'; 
?>
<div id="PageSection">
<br></br>
<div id="fitness">
<!--
<form action="Search.php" method="post">
Search: <input type="text" id="term" name="term" />
<input type="submit" name="submit" value="Submit" />
-->
<form>
</form>
<br></br>
</div>
<?php

$term = isset($_POST['term'])?$_POST['term']:null;
 //Search query to search the products based on name,description,category, and manufacturer.
 $sql = mysql_query("select p.productid, p.productname, p.image, p.price, p.productdescription, p.categoryid, p.manufacturerid, p.stockavailable
 from product as p, category as c, manufacturer as m
 where (p.productname like '%$term%' or p.productdescription like'%$term%' or c.categorytype like '%$term%' or m.manufacturername like '%$term%') and p.productid = p.productid and p.categoryid = 1 and p.categoryid = c.categoryid and p.manufacturerid = m.manufacturerid order by p.productid");

 echo mysql_error();
 echo '<form method="post" action="placeorder.php">';
 while ($row = mysql_fetch_array($sql)){
	  
	//Displays the name, productid, stockavailable.
    echo '<div class="individualproduct">';
    echo "<a href=\"product.php?productid={$row['productid']}\">";
	echo "<img class=\"productimage\" src=\"{$row['image']} \" >";
	echo "<div>Product: {$row['productname']}</div>";
	echo "<div>Description: {$row['productdescription']}</div>";
	echo "<div>Price: \${$row['price']}</div>";
	echo "<div>Quantity In Stock: {$row['stockavailable']}</div>";
	echo '</a>';
	echo 'Quantity for order: <input type="number" name="'.$row['productid'].'" min="0" max="'.$row['stockavailable'].'">';
	echo '</div>';
	echo '<br></br>';
    echo '<br></br>';
}
$address = array('addressid'=>'', 'addressline1'=>'', 'addressline2' => '', 'city' => '', 'state' => '', 'zipcode' => '');
if (isUserLoggedin()) {
	$sql = "select u.addressid , a.addressline1 , a.addressline2, a.city , a.state, a.zipcode from user_address as u , address as a  where u.addressid = a.addressid and u.userid = ".getLoggedInUserId();
	$result = mysql_query($sql);
	$address = mysql_fetch_assoc($result);
	} 
 //gets and displays all the address details of the logged in user else asks for nonmember to enter details
echo '<br></br>';
echo '<div>';
echo '<h3>Shipping address </h3>';
echo '<p><input type="hidden" name="addressid" value="'.$address['addressid'].'" ></p>';
echo '<p>Address line 1  <input type="text" name="addressline1" value="'.$address['addressline1'].'" ></p>';
echo '<p>Address line 2<input type="text" name="addressline2" value="'.$address['addressline2'].'" ></p>';
echo '<p>City &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="city" value="'.$address['city'].'" ></p>';
echo '<p>State &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="state" value="'.$address['state'].'" ></p>';
echo '<p>Zipcode &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="zipcode" value="'.$address['zipcode'].'"></p>';
echo '<p>Credit card # &nbsp;&nbsp;<input type="text" name="creditcard" value=" "></p>';
echo '</div>';

echo '<button id="placeorder" type="submit" class="button" >Place order </button>';
echo '</form>';
echo '<br></br>';

?>
</div>
    

<?php require_once 'footer.php';?>