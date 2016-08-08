<?php
require_once 'lib.php';
if (!isUserLoggedin() || !isAdmin()) {
	header ('Location: index.php') ;
	return;
}

//selects the details to display Lowstock products in the inventory for the admin
$sql = "select l.productid, p.stockavailable, p.title from lowinventory as l, product as p 
where p.productid = l.productid  order by stockavailable";

$lowinvent = array();
$result = mysql_query($sql);
if ($result) {
	while($row = mysql_fetch_assoc($result)){
		$lowinvent[] = $row; 
	}
}

$currentorders = array();
//selects the details to display Currently ordered books to the admin.
$sql = "select o.orderid, o.userid, CONCAT(a.addressline1,' ', a.addressline2,' ', a.city,' ', a.state,' ', a.zipcode)
as address , o.orderstatus , o.ordereddate from onlineorders as o , address as a where o.addressid = a.addressid order by o.ordereddate desc";
$result = mysql_query($sql);
if ($result) {
	while($row = mysql_fetch_assoc($result)){
		$currentorders[] = $row;
	}
}
require_once 'header.php';
?>
<!--Welcome message for admin in admin home page-->
<div id="PageSection">
<h4 align="center"> Welcome Admin! </h4>
<h3 align="center"> You can see the low Stock details and Current orders below! </h3>
<h2 align="left">Low inventory products</h2>
<table border="1">
<tr>
<td>ProductId</td>
<td>Product Title</td>
<td>Quantity Available</td>
</tr>
<?php
//Displays the low stock available for products and the product. 
foreach ($lowinvent as $product) {	
	echo "<tr><td>{$product['productid']}</td>
	<td>{$product['title']}</td>
	<td>{$product['stockavailable']}</td></tr>";
} 
?>
</table>

<h2 align="left">Current orders.</h2>
<table border="1">
<tr>
<td>Order id</td>
<td>User id</td>
<td>Address</td>
<td>Status</td>
<td>Ordered Date</td>
</tr>
<?php
//Dispalys the ordereed details in the table form.
foreach ($currentorders as $order) {	
	echo "<tr><td>{$order['orderid']}</td>
	<td>{$order['userid']}</td>
	<td>{$order['address']}</td>
	<td>{$order['orderstatus']}</td>
	<td>{$order['ordereddate']}</td></tr>";
} 
?>
</table>

<br></br>
</div>
<?php
require_once 'footer.php';