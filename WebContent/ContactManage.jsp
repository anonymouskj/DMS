<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
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
String s[]=request.getParameterValues("checkBoxName");
String ds=request.getParameter("s");
String uid=(String)session.getAttribute("userid");
if(ds.equals("delete contact")){
	for(int i=0;i<s.length;i++){	
		st.executeUpdate("delete from public.addressbook where userid='"+uid+"' and contactid='"+s[i]+"'");
	}
%>
	<jsp:forward page="AddressBook.jsp"></jsp:forward>
<%	
}
else{session.setAttribute("smlength",String.valueOf(s.length));
	for(int i=0;i<s.length;i++){
		session.setAttribute("sm"+i,s[i]);
	}
%>
	<jsp:forward page="ManyMsg.jsp"></jsp:forward>
<%
}
%>
</body>
</html>