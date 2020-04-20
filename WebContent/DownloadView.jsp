<%@ page language="java"  import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script type="text/javascript">
		function valids1(){
			var len=document.form2.mine.length;
			if(len>0)
				for(i=0;i<len;i++){
					if(document.form2.mine[i].checked)
					  		return true;
				}
			else
				if(document.form2.mine.checked)
					return true;
		
			return false;
		}
		function valids2(){
			var len=document.form3.share.length;
			if(len>0)
				for(i=0;i<len;i++){
					if(document.form3.share[i].checked)
					  		return true;
				}
			else
				if(document.form3.share.checked)
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
	Statement st1=con.createStatement();
	Statement st2=con.createStatement();
	Statement st4=con.createStatement();
	String uid=(String)session.getAttribute("userid");
	ResultSet rs1=st1.executeQuery("select * from public.documentload where author='"+uid+"' and status='created'");
	boolean z1=rs1.next(),z2;
	%>
	
	<table border="1" align="center">
	<tr><td>
		<%if(z1){ %>
		<h2>Your Documents</h2>
		<form  action="removedoc.jsp" onsubmit="return valids1()" name="form2">
		<table title="YOUR DOCUMENTS" align="center" border="0">
			<tr>
				<th>Document Name</th>
				<th>Author</th>
				<th>Description</th>
				<th>Document id</th>
				<th>Created on</th>
				<th>Version</th>
				<th>Size in bytes</th>
				<th>Status</th>
			</tr>
			<%	while(z1){ 
				ResultSet rs2=st2.executeQuery("select status,approvalby from public.approval where docid='"+rs1.getString("docid")+"' ");
			%>
			<tr>
				<td><input type="checkbox" name="mine" value="<%=rs1.getString("docid")%>">
			<a href="DownloadFile.jsp?path=C:/dms/<%=rs1.getString("filepath")%>"><%=rs1.getString("docname")%></a></td> 
				
                <td><%=rs1.getString("author")%></td>
				<td><%=rs1.getString("description")%></td>
				<td><%=rs1.getString("docid")%></td>
				<td><%=rs1.getString("createdon")%></td>
				<td><%=rs1.getString("version")%></td>
				<td><%=rs1.getString("size")%></td>
				<td>
					<%if(z2=rs2.next())
						while(z2){
						out.println(rs2.getString("status")+" by"+ rs2.getString("approvalby")); 
						z2=rs2.next();
						}
						else out.print("none");
					%> 
				</td>
			</tr>
			<% z1=rs1.next();	
			}
			%>
			<tr>
				<td colspan="8">
					<input type="submit" value="delete" name="s" >
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="share" name="s">
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="approval" name="s">
				</td>
			</tr>
			<%} %>
		</table>
		</form>
	</td></tr>
	<tr><td>
		<form  action="removedoc.jsp" onsubmit="return valids2()" name="form3">
			<%	ResultSet rs2=st1.executeQuery("select * from public.documentshared where sharedto='"+uid+"' and status!='deleted'");
				boolean z3=rs2.next();
				if(z3){
			%>	<h3 align="center">Documents shared to you</h3>
			<table title="documents shared to you" border="0" align="center">
				<tr>
					<th>Document Name</th>
					<th>Author</th>
					<th>Description</th>
					<th>Document id</th>
					<th>Shared by</th>
					<th>Shared on</th>
					<th>Version</th>
					<th>Size in bytes</th>
					<th>Status</th>
				</tr>
				<%
					
					while(z3){ 
						ResultSet rs5=st4.executeQuery("select * from public.documentload where docid='"+rs2.getString("docid")+"'");
						rs5.next();
						ResultSet rs3=st2.executeQuery("select status,approvalby from public.approval where docid='"+rs2.getString("docid")+"' ");
				%>
				<tr>
					<td><input type="checkbox" name="share" value="<%=rs2.getString("docid")%>">
					<a href="DownloadFile.jsp?path=C:/dms/<%=rs5.getString("filepath")%>"><%=rs5.getString("docname")%></a></td>
					<td><%=rs5.getString("author")%></td>
					<td><%=rs5.getString("description")%></td>
					<td><%=rs2.getString("docid")%></td>
					<td><%=rs2.getString("sharedby") %></td>
					<td><%=rs2.getString("sharedat")%></td>
					<td><%=rs5.getString("version")%></td>
					<td><%=rs5.getString("size")%></td>
					<td>
						<% if(z2=rs3.next())
								while(z2){
								out.println( rs3.getString("status")+" by"+ rs3.getString("approvalby")); 
								z2=rs3.next();
								}
								else out.print("none");
						%>
				    </td>
				</tr>
				<% z3=rs2.next();}%>
				<tr>
					<td colspan="8"><input type="submit" value="Delete" name="s" >
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Share" name="s">
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Approval" name="s"></td>
					
				</tr>
				<%}%>
			</table>
			</form>
		</td></tr>
	</table>
	</body>
</html>