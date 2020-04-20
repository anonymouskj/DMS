<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
    <%@ page import="java.util.*" %>

<%@ page import="java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script type="text/javascript">
		function valids1(){
			var len=document.docform.docs.length;
			if(len>0)
				for(i=0;i<len;i++){
					if(document.docform.docs[i].checked)
					  		return true;
				}
			else
				if(document.docform.docs.checked)
					return true;
		
			return false;
		}
	</script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<%
//Class.forName("com.mysql.jdbc.Driver");
//Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"dms","root","root");
Class.forName("org.postgresql.Driver");
Connection con=DriverManager.getConnection("jdbc:postgresql://localhost:5432/DMS","postgres","postgress");
Statement st=con.createStatement();
ResultSet rs=st.executeQuery("select * from public.documentload where status!='deleted'");
boolean z=rs.next();
if(z){
%><form action="managedocs.jsp" method="get" name="docform"  onsubmit="return valids1()">
	<table align="center" border="1">
		<tr>
			<th>document name</th>
			<th>document id</th>
			<th>author</th>
			<th>size</th>
		</tr>
<%
	while(z){
		%>
		<tr>
			<td><input type="checkbox" name="docs" value="<%=rs.getString("docid")%>"><%=rs.getString("docname")%></td>
			<td><%=rs.getString("docid") %></td>
			<td><%=rs.getString("author") %></td>
			<td><%= rs.getString("size")%></td>
		</tr>
<%
	z=rs.next();
	}
%>
	<tr>
		<td colspan="5"><input type="submit" value="delete"></td>
	</tr>
	</table></form>
<% 
}
%>
</body>
</html>