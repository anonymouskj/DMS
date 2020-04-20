<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="templatemo_style.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div id="templatemo_background_section_top">
		<div class="templatemo_container">
			<div id="templatemo_header">
				<div id="templatemo_logo">
					<h1>DOCUMENT MANAGEMENT SYSTEM</h1>
                    <h2>WE SECURE YOUR DOCUMENTS</h2>
				</div>
                      </div></div></div>
<%
//Class.forName("com.mysql.jdbc.Driver");
//Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"dms","root","123");
Class.forName("org.postgresql.Driver");
Connection con=DriverManager.getConnection("jdbc:postgresql://localhost:5432/DMS","postgres","postgress");
Statement st1=con.createStatement();
Statement st2=con.createStatement();
String s=(String)session.getAttribute("uid");
String ans=request.getParameter("ans");
ResultSet rs=st1.executeQuery("select question,answer from public.registration where userid='"+s+"'");
rs.next();
if(rs.getString("answer").equals(ans)){
	ResultSet rs2=st2.executeQuery("select password from public.registration where userid='"+s+"'");
	rs2.next();
	
%>
	<h3 align="center">your password is: <%=rs2.getString("password") %></h3>
	<h3 align="center"><a href="index.html"> click here to login</a></h3>
<%
}
%>

</body>
</html>