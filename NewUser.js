function Validate1()
{
	//Used for verifying whether the details entered are null or not
    var p=document.forms["ValidateLogin"]["email"].value;
	var q=document.forms["ValidateLogin"]["password"].value;
	if (p==null || p==""|| q==null || q=="")
	{
               alert("All the Fields should be filled up!!");
              return false;
      }
	  
	  else
	  {
			ValidateLogin.submit(); // Submits the form 'ValidateLogin' details if not empty.
	  }
	  
}
function Validate2()
{
      //this function to check if fields are empty while signing up.
    var p=document.forms["registerblock"]["email"].value;
	var q=document.forms["registerblock"]["password"].value;
	var r=document.forms["registerblock"]["firstname"].value;
	var s=document.forms["registerblock"]["lastname"].value;
	var t=document.forms["registerblock"]["street"].value;
    var u=document.forms["registerblock"]["city"].value;
    var v=document.forms["registerblock"]["zipcode"].value;
	var x=document.forms["registerblock"]["state"].value;
    var y=document.forms["registerblock"]["phone"].value;
	      if (p==null || p==""|| q==null || q==""||r==null || r==""||s==null || s==""||t==null || t==""||u==null || u==""||v==null || v=="" || x==null || x=="" || y==null ||y=="")
             {
              alert("All the Fields should be filled up!!");
			  return false;
			  }
			  else
			  {
			  registerblock.submit(); // Submits the form 'registerblock' details if not empty.
		      }
}


