<div id="MenuBar">
<ul class="Menu">
<li><a href="index.php">Home</a></li>             
<li><a href="Search.php">Search</a></li>
<li><a href="fitness.php">Fitness</a></li>   
<li><a href="clothes.php">Clothes</a></li>   
<li><a href="shoes.php">Shoes</a></li>  
<li><a href="games.php">Games</a></li>   
<li><a href="teamsports.php">Teamsports</a></li>  
<li><a href="actionsports.php">Actionsports</a></li>
<li><a href="accessories.php">Accessories</a></li>
<li><a href="aboutus.php">Contact Us</a></li>
<?php 
if(isadmin()) {
?>
<li><a href="adminhome.php">Admin Page</a></li>
<?php 
}
?>
<?php 
if(isUserLoggedin()) {
?>
<li><a href="logout.php">Logout</a></li>
<?php 
} 
?>


</ul>
</div>