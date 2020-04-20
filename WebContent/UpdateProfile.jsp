<%@ page language="java"  import="java.sql.*" %>
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Business Website Template - Free CSS Templates</title>
<meta name="keywords" content="free css templates, business template, HTML CSS" />
<meta name="description" content="Business Template - Free CSS Templates by TemplateMo.com" />
<link href="templatemo_style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<%try{
	//Class.forName("com.mysql.jdbc.Driver");
	//Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"dms","root","root");
	Class.forName("org.postgresql.Driver");
Connection con=DriverManager.getConnection("jdbc:postgresql://localhost:5432/DMS","postgres","postgress");
	Statement st=con.createStatement();
	String uid=(String)session.getAttribute("userid");
	String fn=request.getParameter("fn");
	String ln=request.getParameter("ln");
	String eid=request.getParameter("eid");
	String city=request.getParameter("city");
	String phone=request.getParameter("phone");
	String sq=request.getParameter("sq");
	String ans=request.getParameter("ans");
	
	st.executeUpdate("update public.registration set firstname='"+fn+"',lastname='"+ln+"',emailid='"+eid+"',city='"+city+"',phonenumber='"+phone+"',question='"+sq+"',answer='"+ans+"' where userid='"+uid+"'");
%><jsp:forward page="profile.jsp"></jsp:forward>	
<%}
catch(Exception e){
 %>
 	<p style="color:red;">your profile is not changed</p> 
 <% 	
}
%>	
	
       

</body>

</html>