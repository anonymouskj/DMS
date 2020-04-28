<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		 <!-- <script src="SpryAssets/SpryMenuBar.js" type="text/javascript"></script>
		<link href="SpryAssets/SpryMenuBarHorizontal.css" rel="stylesheet" type="text/css" />
 -->		<style>
#nav {
list-style:none inside;
margin:0;
padding:0;
text-align:center;
}
#nav li {
display:block;
position:relative;
float:left;
background:#ffffff; /* menu background color */
}
#nav li a {	
display:block;
padding:0;
text-decoration:none;
width:191px; /* this is the width of the menu items */
line-height:35px; /* this is the hieght of the menu items */
color:0066CC; /* list item font color */
}
#nav li li a {font-size:80%;} /* smaller font size for sub menu items */
#nav li:hover {background:#E0E0E0;} /* highlights current hovered list item and the parent list items when hovering over sub menues */
#nav ul {
position:absolute;
padding:0;
left:0;
display:none; /* hides sublists */
}
#nav li:hover ul ul {display:none;} /* hides sub-sublists */
#nav li:hover ul {display:block;} /* shows sublist on hover */
#nav li li:hover ul {
display:block; /* shows sub-sublist on hover */
margin-left:200px; /* this should be the same width as the parent list item */
margin-top:-35px; /* aligns top of sub menu with top of list item */
}
</style>
</head>
	<body>
	<%
		String uid=(String)session.getAttribute("userid");
		
	%>   
	

<ul id="nav">
		  <li><a href="home.jsp" >Home</a> </li>
		  <li><a href="profile.jsp" >Profile</a></li>
		  <li><a href="#">Messages</a>
		    <ul>
		      <li><a href="SendMessage.jsp">compose</a></li>
		      <li><a href="inbox.jsp" >Inbox</a></li>
		      <li><a href="outbox.jsp" >outbox</a></li>
		    </ul>
		  </li>
		 <li><a href="#">My Account</a>
		  <%
		  if(uid.equals("admin")){
		  %>
		  	 <ul>
		      <li><a  href="users.jsp" >manage users</a></li>
		      <li><a href="documents.jsp">manage documents</a></li>
		      <li><a href="report.jsp" >generate report</a></li>
		       <li><a href="Approve.jsp" >Approve documents</a></li>
		    </ul>
		  <%}
		  else{ %>
			   <ul>
			      <li><a  href="upload.jsp">create document</a></li>
			       <li><a  href="#">View</a>
		    <ul>
		      <li><a href="DownloadView.jsp">My Documents</a></li>
		      <li><a href="NewDownloadView.jsp" >Shared Documents</a></li>
		    </ul>
		  </li>
			      <li><a href="Approve.jsp" >Approve documents</a></li>
 			   </ul>
		   <%} %>
		  </li>
		  <li><a href="#">settings</a>
		  		<ul>
		  			<li><a href="changepwd.jsp" >change password</a></li>
		  		</ul>
		  </li>
		  <li><a href="AddressBook.jsp" >Address Book</a></li>
		    <li><a href="help.jsp" >Help</a></li>
		  <li><a href="logout.jsp" >Logout</a></li>
		  
		  
	</ul>
		
		
		<!-- <script type="text/javascript">
		<!--
		var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"SpryAssets/SpryMenuBarDownHover.gif", imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
	
		</script>  -->
		<br /><br /><br />
	</body>
</html>
