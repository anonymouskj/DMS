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
		function val(){
				var sub=document.ss.sub.value;
				if(sub==""){
					return false;
				}
				return true;
		}
	</script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<form action="pass.jsp" name="ss" onsubmit="return val()">
<table align="center">
	<tr>
	<td><b>To:</b><select name="to">
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
	</select>	
		<b>Subject:</b><input type="text" name="sub" size="50" ></td>
	</tr>
	<tr>	
		<td><textarea rows="10" cols="70" name="msg" required></textarea>
		<input type="submit" value="Send"></td>
	</tr>
</table>
</form>

</body>
</html>