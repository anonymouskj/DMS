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
	String uid=(String)session.getAttribute("userid");
	String s[]=request.getParameterValues("mine");
	String v[]=request.getParameterValues("share");
	String ds=request.getParameter("s");
	if(ds.equals("delete")){
		if(s!=null)
		for(int i=0;i<s.length;i++)
		{	
			st.executeUpdate("delete from public.approval where docid='"+s[i]+"' and userid='"+uid+"'");
			st.executeUpdate("update public.documentload set status='deleted' where docid='"+s[i]+"'");
			
		}
		else
		for(int j=0;j<v.length;j++){
			st.executeUpdate("delete from public.approval where docid='"+v[j]+"' and userid='"+uid+"'");
			st.executeUpdate("update public.documentshared set status='deleted' where docid='"+v[j]+"' and sharedto='"+uid+"'");
		}
%>
	<jsp:forward page="DownloadView.jsp"></jsp:forward>
<%
	}
	else if(ds.equals("share")){
%>		<form action="share.jsp">
		<h3 align="center">share to:<select name="share">
	<% 
	
	String userid="", firstName, lastName, name="";
    
  Statement st1=con.createStatement();
  ResultSet rs1=st1.executeQuery("select userid, firstname, lastname from public.registration where status!='+deleted'");
    while(rs1.next())
    {
	 userid= rs1.getString(1);
	 firstName=rs1.getString(2); if(firstName==null) {firstName="";}
	 lastName=rs1.getString(3); if(lastName==null) {lastName="";}
	 name=firstName+" "+lastName;
	 if(!userid.equals(uid))
	 { 
	 %>
	 <option value=<%=userid%>><%=name%></option>
<% 

	 }
    }
 %>	
		
		</select>
			<input type="submit" value="share"></h3>
		</form>
<%
	if(s!=null){
		session.setAttribute("slength",String.valueOf(s.length));
		session.setAttribute("vlength",String.valueOf(0));
		for(int i=0;i<s.length;i++){
			session.setAttribute("s"+i,s[i]);
		}
	}
	else{	session.setAttribute("slength",String.valueOf(0));
			session.setAttribute("vlength",String.valueOf(v.length));
			for(int i=0;i<v.length;i++){
				session.setAttribute("v"+i,v[i]);
			}
	}
} 
else{ 
%>
		<form action="approval.jsp">
	<h3 align="center">Forward for Approval:<select name="approvalby">
	<% 
	
	String userid="", firstName, lastName, name="";
  
  Statement st1=con.createStatement();
  ResultSet rs1=st1.executeQuery("select userid, firstname, lastname from public.registration where status!='+deleted'");
    while(rs1.next())
    {
	 userid= rs1.getString(1);
	 firstName=rs1.getString(2); if(firstName==null) {firstName="";}
	 lastName=rs1.getString(3); if(lastName==null) {lastName="";}
	 name=firstName+" "+lastName;
	 if(!userid.equals(uid))
	 { 
	 %>
	 <option value=<%=userid%>><%=name%></option>
<% 

	 }
    }
 %>	
	
	</select>
	<input type="submit" name="send for approval"></h3>
	</form>
<%if(s!=null){
			session.setAttribute("slength",String.valueOf(s.length));
			session.setAttribute("vlength",String.valueOf(0));
			for(int i=0;i<s.length;i++){
				session.setAttribute("s"+i,s[i]);
			}
			
		}
		else{
			session.setAttribute("slength",String.valueOf(0));
			session.setAttribute("vlength",String.valueOf(v.length));
			for(int i=0;i<v.length;i++){
				session.setAttribute("v"+i,v[i]);
			}
		}
}
%>
</body>
</html>