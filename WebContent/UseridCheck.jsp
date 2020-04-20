<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
<%
	// Class.forName("com.mysql.jdbc.Driver");     old database class file
	Class.forName("org.postgresql.Driver");
	// Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"dms","root","root"); old connection path
	Connection con=DriverManager.getConnection("jdbc:postgresql://localhost:5432/DMS","postgres","postgress");
	Statement st=con.createStatement();
	String uid=request.getParameter("uid");
	ResultSet rs=st.executeQuery("select userid from public.registration");
	int i=2;
	while(rs.next())
	{	String s=rs.getString("userid");
		if(s.equalsIgnoreCase(uid)){
			i=1;
			break;
		}
			
		else i=0;
		
	}
	if(i==1) out.println("false");
	else  out.println("true");
%>		

