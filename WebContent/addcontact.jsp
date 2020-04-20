<%@ page import="java.util.*" %>
<%@ page import ="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>

<%@page import="javax.servlet.RequestDispatcher"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript">
function repl(){
		document.location.replace("AddressBook.jsp");
	}
function valid(){
	var cn=document.ac.contactname.value;
	var cid=document.ac.contactid.value;
	if(cn=="")
		return false;
	else if(cid=="")
		return false;
	else return true;
}
</script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<form action="storecontact.jsp" name="ac" onsubmit="return valid()">
<table align="center">
	<tr>
		<td>contact name:</td>
		<td><input type="text" name="contactname"></td>
	</tr>
	<tr>
		<td>contact id:</td>
		<td><select name="contactid">
	<% 
	String uid=(String)session.getAttribute("userid");
	String userid="", firstName, lastName, name="";
    Class.forName("org.postgresql.Driver");
    Connection con=DriverManager.getConnection("jdbc:postgresql://localhost:5432/DMS","postgres","postgress");
  Statement st=con.createStatement();
  ResultSet rs=st.executeQuery("select userid, firstname, lastname from public.registration where status!='+deleted'");
    while(rs.next())
    {
	 userid= rs.getString(1);
	 firstName=rs.getString(2); if(firstName==null) {firstName="";}
	 lastName=rs.getString(3); if(lastName==null) {lastName="";}
	 name=firstName+" "+lastName;
	 if(!userid.equals(uid))
	 { 
	 %>
	 <option value=<%=userid%>><%=name%></option>
<% 

	 }
    }
 %>	
		</select></td>
	</tr>
	<tr>
		<td><input type="submit" value="add"></td>
		<td><input type="button" value="cancel" onclick="repl()"></td>
	</tr>
</table> 
</form>
</body>
</html>