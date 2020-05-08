<%@ page language="java"  import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
  <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
  <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css" />
 
  <!-- <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script> -->
 
<script src="https://code.jquery.com/ui/1.11.1/jquery-ui.min.js"></script>
  
<title>Insert title here</title>
</head>
<body>
<%
String val=request.getParameter("finYear");
 Class.forName("org.postgresql.Driver");
Connection con=DriverManager.getConnection("jdbc:postgresql://localhost:5432/DMS","postgres","postgress");
	Statement st1=con.createStatement();
	Statement st2=con.createStatement();
	ResultSet rs1=st1.executeQuery("select userid, noting_detail from public.noting_trans  where docid='"+val+"';"); 
	boolean z1=rs1.next();
	if(z1)
	{
		%>
		 <table  id="example" class="display" style="width:100%">
		<thead>
		<tr>
			
			<th>Remarks By:</th>
			<th>Remarks</th>
			<!-- <th>DocName </th>
			<th>DocType</th>
			<th>Version</th>
			<th>Author</th> -->
		</tr>
	</thead>
	
	<tbody>
		<%while(z1){ %>

		<tr>
		<td><%=rs1.getString("userid") %></td>
		<td><%=rs1.getString("noting_detail") %></td>
		<%-- <td><%=rs1.getString("docname") %></td>
		<td><%=rs1.getString("doctype") %></td>
		<td><%=rs1.getString("version") %></td>
		<td><%=rs1.getString("author") %></td> --%>
		</tr>
	
		<%
			
			z1=rs1.next();
		}
%>
  </tbody>
			
	  </table> 
	  <%
		}
  else {%>
  <p>No remarks given for this document.</p>
<%} %>

</body>
</html>