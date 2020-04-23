<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>

<%@page import="javax.servlet.RequestDispatcher"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

</head>
<body>
<%

Class.forName("org.postgresql.Driver");
Connection con=DriverManager.getConnection("jdbc:postgresql://localhost:5432/DMS","postgres","postgress");
Statement st=con.createStatement();
String uid=request.getParameter("uname");
String pwd=request.getParameter("pwd");
ResultSet rs=st.executeQuery("select * from public.registration where status!='deleted'");
while(rs.next()){
	String userid=(String)rs.getString("userid");
	String pass=(String)rs.getString("password");
	if((userid.equals(uid))&&(pass.equals(pwd))){
		session.setAttribute("userid",userid );
	%>	
	<jsp:forward page="home.jsp"></jsp:forward>

<%		
	}
}
%>
  
 <jsp:forward page="home.html"></jsp:forward>

</body>
</html>