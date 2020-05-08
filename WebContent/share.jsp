<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*,java.util.Date,java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Share</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<%
try{
//Class.forName("com.mysql.jdbc.Driver");
//Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"dms","root","root");
Class.forName("org.postgresql.Driver");
Connection con=DriverManager.getConnection("jdbc:postgresql://localhost:5432/DMS","postgres","postgress");
Statement st1=con.createStatement();	
Statement st2=con.createStatement();
String uid=(String)session.getAttribute("userid");
String sharedto=request.getParameter("share");
String remarks=request.getParameter("remarks");
ResultSet rs2=st2.executeQuery("select noting_id from public.noting_ids");
int su=1; 
boolean z;
if(z=rs2.next()) 
	while(z){
		su=Integer.parseInt(rs2.getString("noting_id"))+1;
		z=rs2.next();
	}
	if(sharedto!=null){
	Date dt=new Date();
	SimpleDateFormat sdt=new SimpleDateFormat("yyyy-MM-dd");
	int slength=Integer.parseInt(session.getAttribute("slength").toString());
	int vlength=Integer.parseInt(session.getAttribute("vlength").toString());
	
		for(int i=0;i<slength;i++)
		{	String s=(String)session.getAttribute("s"+i);
			ResultSet rs=st1.executeQuery("select * from public.documentload where docid='"+s+"'");
			rs.next();
			String Doctype=rs.getString(10);
		// System.out.println("breaodud ey e"+Doctype);
			st2.executeUpdate("insert into public.documentshared values('"+s+"','"+sharedto +"','"+uid+"','"+ sdt.format(dt)+"','shared','"+Doctype+"','"+remarks+"')");	
			st2.executeUpdate("insert into public.noting_trans values('"+su+"','"+s+"','"+remarks+"','"+uid+"','"+sdt.format(dt)+"')");
			 st2.executeUpdate("insert into public.noting_ids values('"+su+"')");
			
		}
		for(int i=0;i<vlength;i++)
		{	String s=(String)session.getAttribute("v"+i);
			ResultSet rs=st1.executeQuery("select * from public.documentshared where docid='"+s+"' and sharedto='"+uid+"'");
			rs.next();
			String Doctype=rs.getString(10);
			st2.executeUpdate("insert into documentshared values(insert into public.documentshared values('"+s+"','"+sharedto +"','"+uid+"','"+ sdt.format(dt)+"','shared','"+Doctype+"','"+remarks+"')");
			st2.executeUpdate("insert into public.noting_trans values('"+su+"','"+s+"','"+remarks+"','"+uid+"','"+sdt.format(dt)+"')");
		 st2.executeUpdate("insert into public.noting_ids values('"+su+"')");
		}
		  
	  out.println("file shared");	
	
%>      
		<jsp:forward page="DownloadView.jsp"></jsp:forward>
<%		
	}
	else{
%>
	<jsp:forward page="removedoc.jsp"></jsp:forward>
<%	}
	
}
catch(Exception e){
%>
		<h3 align="center" style="color: red">user does not exists or file already shared to this user</h3>
<%
}
%>
	
</body>
</html>