<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*,java.text.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.Date;"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
                      
        
	</div><!--  End Of Back Ground Section Top  -->
    
                   
                <div id="templatemo_section">
	<%
	// Class.forName("com.mysql.jdbc.Driver");   old class file
	Class.forName("org.postgresql.Driver");
	// Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"dms","root","root");  //old connection
	Connection con=DriverManager.getConnection("jdbc:postgresql://localhost:5432/DMS","postgres","postgress");
	Statement st=con.createStatement();
	String fn=request.getParameter("fn");
	String ln=request.getParameter("ln");
	String uid=request.getParameter("uid");
	String pwd=request.getParameter("pwd");
	String eid=request.getParameter("eid");
	String city=request.getParameter("city");
	String phone=request.getParameter("phone");
	String qus=request.getParameter("qus");
	String ans=request.getParameter("ans");
	Date d=new Date();
	SimpleDateFormat s=new SimpleDateFormat("yyyy-MM-dd");
	try{
	st.executeUpdate("insert into public.registration values('"+fn+"','"+ln+"','"+uid+"','"+pwd+"','"+eid+"','"+city+"','"+s.format(d)+"','"+phone+"','offline','"+qus+"','"+ans+"')");
	%>
	<p align="center"> you have successfully registered.<br>click here to <a href="index.html">login</a>
	
	</p>
	   <% }
	catch(Exception e){
	%>     <p> registration failed</p> 
	<%} %>  	  
           	 
	
	</div></div></div>
       
	</body>
</html>