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

</head>

<body>
<jsp:include page="header.jsp"></jsp:include>
<%
	String uid=(String)session.getAttribute("userid");
System.out.println("Sender Id:"+uid);
	String rec=request.getParameter("to");
	System.out.println("Receiver Id:"+rec);
	String sub=request.getParameter("sub");
	System.out.println("Subject:"+sub);
	String msg=request.getParameter("msg");
	System.out.println("Subject:"+msg);
	//Class.forName("com.mysql.jdbc.Driver");
	//Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"dms","root","root");
	Class.forName("org.postgresql.Driver");
 Connection con=DriverManager.getConnection("jdbc:postgresql://localhost:5432/DMS","postgres","postgress");
	Statement st=con.createStatement();
	Date s1=new Date();
		SimpleDateFormat f=new SimpleDateFormat("yyyy-MM-dd"); 
	
	if(rec==null){
		int slen=Integer.parseInt(session.getAttribute("smlength").toString());
		for(int i=0;i<slen;i++){
			rec=(String)session.getAttribute("sm"+i);
			st.executeUpdate("insert into public.message (sender,reciever,subject,message,at,senderstatus,recieverstatus) values('"+uid+"','"+rec+"','"+sub+"','"+msg+"','"+f.format(s1)+"','yes','yes')");
		}
	%>
	<h3 align="center"> message sent success fully</h3>
	<%
	}
	else{
	try{
		st.executeUpdate("insert into public.message (sender,reciever,subject,message,at,senderstatus,recieverstatus) values('"+uid+"','"+rec+"','"+sub+"','"+msg+"','"+f.format(s1)+"','yes','yes')");
	
	%>
<h3 align="center"> message sent success fully</h3>
<%
	}
	catch(Exception e){
%>
		<h3 align="center" style="color: red"> message sending failed</h3>
<%	} 
	}
%>
</body>
</html>