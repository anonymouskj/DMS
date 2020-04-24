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
	Statement st2=con.createStatement();
	Statement st1=con.createStatement();
	String uid=(String)session.getAttribute("userid");
	String appBy=request.getParameter("approvalby");
	//String DocType=(String)session.getAttribute("docType");
//	System.out.println("approval"+DocType);
	if(appBy!=null){
		int slength=Integer.parseInt(session.getAttribute("slength").toString());
		int vlength=Integer.parseInt(session.getAttribute("vlength").toString());
		try{
			for(int i=0;i<slength;i++)
			{	String s=(String)session.getAttribute("s"+i);
			ResultSet rs=st1.executeQuery("select * from public.documentload where docid='"+s+"'");
			rs.next();
			String Doctype=rs.getString(10);
				st2.executeUpdate("insert into public.approval values('documentload','"+s+"','"+uid+"','"+appBy+"','Yet to','"+Doctype+"')");	
			}
			for(int i=0;i<vlength;i++)
			{	String s=(String)session.getAttribute("v"+i);
			ResultSet rs=st1.executeQuery("select * from public.documentload where docid='"+s+"'");
			rs.next();
			String Doctype=rs.getString(10);
				st2.executeUpdate("insert into public.approval values('documentshared','"+s+"','"+uid+"','"+appBy+"','Yet to','"+Doctype+"')");
			}
%>
		<jsp:forward page="DownloadView.jsp"></jsp:forward>
<%
		}
		catch(Exception e){
	%>
			<h3 style="color: red">document(s) is not send for approval. try agin</h3>
	<% 	
		}
	}
	%>
</body>
</html>