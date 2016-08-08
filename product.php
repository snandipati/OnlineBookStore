<?php
require_once 'lib.php';
//Allows user to post reviews for the product.
if (isset($_POST) && isset($_POST['productid']) && isset($_POST['review']) && isUserLoggedin()) {
	$sql = " insert into comments (userid, productid, comment) values ( ".getLoggedInUserId().", {$_POST['productid']}, '{$_POST['review']}') on duplicate key update comment='{$_POST['review']}'";
	$result = mysql_query($sql);
	if ($result) {
		header('Location: product.php?productid='.$_POST['productid']);
		return;
	}
}
if (!isset($_GET['productid'])) {
    //Searches and displays each product which was searched from the UI
	header ('Location: Search.php') ;
} else {
	$sql = mysql_query("select p.productid, p.productname,  p.image, p.price, p.productdescription , m.manufacturername , m.URL, c.categorytype from product as p, manufacturer as m , category as c  where p.manufacturerid = m.manufacturerid and p.categorytype = c.categorytype and p.productid = {$_GET['productid']}");
	if (!$sql) {
		header ('Location: Search.php') ;
	}
	$product = mysql_fetch_array($sql);
	if (!$product) {
		header ('Location: Search.php') ;       //Leads to search page.
	}
	$reviews = array();
	$sql = mysql_query("select c.commentid, c.comment , u.firstname, u.lastname from comments as c , user as u where c.userid = u.userid and c.productid =  {$product['productid']}");
	if ($sql) {
		while($row = mysql_fetch_array($sql)) {
			$reviews[] = $row;
		}
	} 
}
require_once 'header.php';
?>
<div id="PageSection">
<!-- Displays each product with its name,price,productdescription,productimage,manufacturername,categorytype -->
<div class="productpage"> <img alt="" class="individualproductimage" src="<?php echo $product['image']?>"></div> 
<div>Name: <?php echo $product['productname']?></div>
<div>Price: <?php echo $product['price']?></div>
<div>Description:<?php echo $product['productdescription']?></div>
<div>Manufacturer: <?php echo $product['manufacturername']?></div>
<div>Category: <?php echo $product['categorytype']?></div>
<div>Manufacturer website: <?php echo $product['URL']?></div>

<?php
	foreach ($reviews as $review) {
		?>
		<!-- Displays user who has commented along with his firstname and lastname-->
		<div class="reviews">
			<div> <?php echo $review['firstname']." ".$review['lastname']?> Says: <?php echo $review['comment']?> </div>
		</div>
		
		<?php 
	} 
	
	if (isUserLoggedin()) {	
?>
<div class="reviews">
<form method="post" action="product.php">
	<p>
	<!-- Form to enter review for each product-->
	<b>Enter your review. </b>
	<input type="hidden" name="productid" value=<?php echo $_GET['productid']?>>
	<input type="text" name="review" size="40">
	<button id="reviewbutton" type="submit" class="button" >Post review </button>
	</p> 
</form>
</div>
<?php
		} 
?>
</div>
<?php
require_once 'footer.php';