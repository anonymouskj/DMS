<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@ page language="java"  import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<%
//Class.forName("com.mysql.jdbc.Driver");
//Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"dms","root","root");
Class.forName("org.postgresql.Driver");
Connection con=DriverManager.getConnection("jdbc:postgresql://localhost:5432/DMS","postgres","postgress");
Statement st=con.createStatement();
Statement st1=con.createStatement();
Statement st2=con.createStatement();
Date s1=new Date();
SimpleDateFormat f=new SimpleDateFormat("yyyy-MM-dd"); 
String uid=(String)session.getAttribute("userid");
String s[]=request.getParameterValues("selec");
String app=request.getParameter("approval");
String  remarks=request.getParameter("remarks");
System.out.println("heloi");
if(app.equals("approve")){
	for(int i=0;i<s.length;i++){
		ResultSet rs=st1.executeQuery("select * from public.documentload where docid='"+s[i]+"'");
		rs.next();
		String Doctype=rs.getString(10);
		String author=rs.getString(5);      
		
		st.executeUpdate("update public.approval set status='approved' , remarks='"+remarks+"' where approvalby='"+uid+"' and docid='"+s[i]+"'");
		                                
		st2.executeUpdate("insert into public.documentshared values('"+s[i]+"','All','"+author+"','"+ f.format(s1)+"','shared','"+Doctype+"','"+remarks+"')");
	}	
}
else{
	for(int i=0;i<s.length;i++){
		st.executeUpdate("update public.approval set status='discarded' and remarks='"+remarks+"' where approvalby='"+uid+"' and docid='"+s[i]+"' ");
	}
}
%>
 
<jsp:forward page="Approve.jsp"></jsp:forward>
</body>
</html>