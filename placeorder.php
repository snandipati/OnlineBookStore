<?php
require_once 'lib.php';
require_once 'db.php';   //establishes the db_connection from php
require_once 'header.php'; //includes options for header
if (isUserLoggedin()) {
	$userid = getLoggedInUserId();
} else {
	$userid = 'NULL';
}
$orderitems = array();
foreach($_POST as $key=>$value) {
	if (is_int($key)) {
		$orderitems[$key] = $value;      //gets the title,description or any other search factor.
	}	
}

if (empty($orderitems)) {
	header ('Location: Search.php') ;   // returns to search page if there are no items.
	return;
}

if (!$_POST['addressid'] == 0) {
	$addressid = $_POST['addressid'];
} else {
	$sql = "insert into address (addressline1, addressline2, city, state, zipcode ) values ('{$_POST['addressline1']}','{$_POST['addressline2']}', '{$_POST['city']}' , '{$_POST['state']}', {$_POST['zipcode']})";
	$result = mysql_query($sql);
	$addressid = mysql_insert_id(); 
}

//generate orderid. 

$sql = "insert into onlineorders (userid, addressid, ordereddate) values ( $userid,$addressid, CURRENT_DATE())";
mysql_query($sql);
$orderid = mysql_insert_id();

foreach ($orderitems as $productid => $quantity) {
	if (isUserLoggedin()) {
		$multiplefactor = 0.95; // provides 5% discount for registered user
	} else {
		$multiplefactor = 1;  //If not a member, no discount and the price remains the same.
	}
	//inserts values into onlineorder table when a customer makes an order.
	$sql = "insert into onlineorderitems ( orderid, productid, price, quantity) values ( $orderid, $productid, (select price * $multiplefactor  from product where productid = $productid ) , $quantity )";
	mysql_query($sql);

	//update the stockavaliable in the product table which further helps in trigger.
	$sql = "update product set stockavailable = stockavailable - $quantity where productid = $productid";
	mysql_query($sql);
}
$sql2="select sum(price) from onlineorderitems where orderid=$orderid";
$result= mysql_query($sql2);
$row = mysql_fetch_row($result);
//If registered user, gets the registered details while signing up 
//If not a memeber, asks user to enter address

//credit card info is asked by both kind of members.
$sql2="select * from address where addressid =$addressid";
$result= mysql_query($sql2);
$addressrow = mysql_fetch_assoc($result);
$address = isset($addressrow['nickname'])?$addressrow['nickname']:'';
$test = isset($addressrow['addressline1'])?$addressrow['addressline1']:'';
$address = $address."<br>".(isset($addressrow['addressline1'])?$addressrow['addressline1']:'');
$address = $address."<br>".(isset($addressrow['addressline2'])?$addressrow['addressline2']:'');
$address = $address."<br>".(isset($addressrow['city'])?$addressrow['city']:'');
$address = $address."<br>".(isset($addressrow['state'])?$addressrow['state']:'');
$address = $address."<br>".(isset($addressrow['zipcode'])?$addressrow['zipcode']:'');
?>
<!-- Displays Order summary!-->
<div id="PageSection">
<h3>Your order is submitted</h3>
<h2>Order summary</h2>
<h3>Order id : <?php echo $orderid?></h3>
<h3>Price : <?php echo number_format((float)$row[0], 2, '.', '')?></h3>
<h3>Shpping Address : <?php echo $address?></h3>
</div>

<?php 
require_once 'footer.php';