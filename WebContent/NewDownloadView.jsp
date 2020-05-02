<%@ page language="java"  import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
  <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
  <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<style>
table th,td {
  border: 1px solid black; 
/*  background-color:#1f5c7b;	 */
  color: black;
  font-size:15px;
}

body {font-family: Arial;}

/* Style the tab */
.tab {
  overflow: hidden;
 
}

/* Style the buttons inside the tab */
.tab button {
  background-color: inherit;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  transition: 0.3s;
  font-size: 17px;
}

/* Change background color of buttons on hover */
.tab button:hover {
  background-color: #ddd;
}

/* Create an active/current tablink class */
.tab button.active {
  background-color: #ccc;
}

/* Style the tab content */
.tabcontent {
  display: none;
  padding: 6px 12px;
  border: 1px solid #ccc;
  border-top: none;
}
</style>
</head>
<body>

<jsp:include page="header.jsp"></jsp:include>
<div class="tab">

	<table align="center">
	<td><button class="tablinks" id="1" onclick="openCity(event, 'Circular')">Circular</button></td>
   	<td><button class="tablinks" id="2" onclick="openCity(event, 'Letter')">Letter</button></td>
   	<td><button class="tablinks" id="3" onclick="openCity(event, 'LearningFile')">LearningFile</button></td>
	</table>
 </div> 
  

	
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
	<div id="LearningFile" class="tabcontent">
	

		 <form  action="removedoc.jsp" onsubmit="return valids2()" name="form3">
		 
		 <table  id="example" class="display" style="width:100%">
			<%	ResultSet rs2=st1.executeQuery("select * from public.documentshared where sharedby!='"+uid+"' and sharedto='All' and status!='deleted' and doctype = 'LearningFile'");
				boolean z3=rs2.next();
				
				if(z3){
			%><thead>
				<tr>
					<th>Document Name</th>
					<th>Author</th>
					<th>Description</th>
					<th>Document id</th>
					<th>Shared by</th>
					<th>Shared on</th>
					<th>Version</th>
					<th>Size in bytes</th>
					<!-- <th>Status</th> -->
					<!-- <th>DocType</th> -->
				</tr>
			</thead>	
				<%    int count=0;
				     //String id=rs2.getString("sharedby");
				     //int ans=id.compareTo(uid);
					while(z3){ 
						      //System.out.println(ans);
						      count++;
						ResultSet rs5=st4.executeQuery("select * from public.documentload where docid='"+rs2.getString("docid")+"'");
						rs5.next();
						//ResultSet rs3=st2.executeQuery("select status,approvalby from public.approval where docid='"+rs2.getString("docid")+"' ");
						//String Doc =rs5.getString("DocType");
						  //System.out.println(Doc);
						 // if(Doc.equals("Circular")){
				%>
			<tbody>	
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
						<% /* if(z2=rs3.next())
								while(z2){
								out.println( rs3.getString("status")+" by"+ rs3.getString("approvalby")); 
								z2=rs3.next();
								}
								else out.print("none"); */
								/* out.print("none"); */
								
						%>
				    </td>
				   <%--  <td><label id="docType" name="docType"><%=rs5.getString("doctype")%></label></td> --%>
				</tr>
				<% z3=rs2.next();}
				if(count!=0){%> 
				<tr>
					<td colspan="8"><input type="submit" value="delete" name="s" ></td>
					<!-- &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Share" name="s"> -->
					<!-- &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Approval" name="s"></td> -->
					
				</tr>
				</tbody>
				<%
				}	
				}%>
				</table> 
			</form>
	
	

  </div> 
  
  <div id="Circular" class="tabcontent">
	<table border="1" align="center">
	<tr><td>
		 <form  action="removedoc.jsp" onsubmit="return valids2()" name="form3">
			<%	ResultSet rs20=st1.executeQuery("select * from public.documentshared where sharedby!='"+uid+"' and sharedto='All' and status!='deleted' and doctype = 'Circular'");
				boolean z30=rs20.next();
				
				if(z30){
			%>	
				<tr>
					<th>Document Name</th>
					<th>Author</th>
					<th>Description</th>
					<th>Document id</th>
					<!-- <th>Shared by</th> -->
					<th>Shared on</th>
					<th>Version</th>
					<th>Size in bytes</th>
					<!--<th>Status</th> -->
					<!-- <th>DocType</th> -->
				</tr>
				<%   
				int count=0;
				     /* String id=rs20.getString("sharedby");
				      System.out.println(id);
				     int ans=id.compareTo(uid);
				      */
					while(z30){ 
						    count++;// System.out.println(ans);
						ResultSet rs5=st4.executeQuery("select * from public.documentload where docid='"+rs20.getString("docid")+"'");
						rs5.next();
						//ResultSet rs3=st2.executeQuery("select status,approvalby from public.approval where docid='"+rs2.getString("docid")+"' ");
						//String Doc =rs5.getString("DocType");
						  //System.out.println(Doc);
						 // if(Doc.equals("Circular")){
				%>
				<tr>
					<td><input type="checkbox" name="share" value="<%=rs20.getString("docid")%>">
					<a href="DownloadFile.jsp?path=C:/dms/<%=rs5.getString("filepath")%>"><%=rs5.getString("docname")%></a></td>
					<td><%=rs5.getString("author")%></td>
					<td><%=rs5.getString("description")%></td>
					<td><%=rs20.getString("docid")%></td>
					<%-- <td><%=rs20.getString("sharedby") %></td> --%>
					<td><%=rs20.getString("sharedat")%></td>
					<td><%=rs5.getString("version")%></td>
					<td><%=rs5.getString("size")%></td>
					<td>
						<% /* if(z2=rs3.next())
								while(z2){
								out.println( rs3.getString("status")+" by"+ rs3.getString("approvalby")); 
								z2=rs3.next();
								}
								else out.print("none"); */
							/* 	out.print("none"); */
								
						%>
				    </td>
				   <%--  <td><label id="docType" name="docType"><%=rs5.getString("doctype")%></label></td> --%>
				</tr>
				<% z30=rs20.next();}
				
				if(count!=0){%> 
				<tr>
					<td colspan="8"><input type="submit" value="delete" name="s" >
					<!--  &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Share" name="s"> -->
					<!-- &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Approval" name="s"></td> -->
					
				</tr>
				
				<%
				}
				}%>
			
			</form>
	
	
	</table> 
  </div> 
  
  <div id="Letter" class="tabcontent">
	<table border="1" align="center">
	<tr><td>
		 <form  action="removedoc.jsp" onsubmit="return valids2()" name="form3">
			<%	ResultSet rs21=st1.executeQuery("select * from public.documentshared where sharedto='"+uid+"' and status!='deleted' and doctype = 'Letter'");
				boolean z31=rs21.next();
				
				if(z31){
			%>	
				<tr>
					<th>Document Name</th>
					<th>Author</th>
					<th>Description</th>
					<th>Document id</th>
				    <th>Shared by</th>
					<th>Shared on</th>
					<th>Version</th>
					<th>Size in bytes</th>
					<!--<th>Status</th> -->
					<!-- <th>DocType</th> -->
				</tr>
				<%  int count=0;
				
				    /*  String id=rs21.getString("sharedby");
				      System.out.println(id);
				     int ans=id.compareTo(uid);
				      */
					while(z31){ 
						count++; 
						// System.out.println(ans);
						ResultSet rs5=st4.executeQuery("select * from public.documentload where docid='"+rs21.getString("docid")+"'");
						rs5.next();
						//ResultSet rs3=st2.executeQuery("select status,approvalby from public.approval where docid='"+rs2.getString("docid")+"' ");
						//String Doc =rs5.getString("DocType");
						  //System.out.println(Doc);
						 // if(Doc.equals("Circular")){
				%>
				<tr>
					<td><input type="checkbox" name="share" value="<%=rs21.getString("docid")%>">
					<a href="DownloadFile.jsp?path=C:/dms/<%=rs5.getString("filepath")%>"><%=rs5.getString("docname")%></a></td>
					<td><%=rs5.getString("author")%></td>
					<td><%=rs5.getString("description")%></td>
					<td><%=rs21.getString("docid")%></td>
				    <td><%=rs21.getString("sharedby") %></td>
					<td><%=rs21.getString("sharedat")%></td>
					<td><%=rs5.getString("version")%></td>
					<td><%=rs5.getString("size")%></td>
					<td>
						<% /* if(z2=rs3.next())
								while(z2){
								out.println( rs3.getString("status")+" by"+ rs3.getString("approvalby")); 
								z2=rs3.next();
								}
								else out.print("none"); */
							/* 	out.print("none"); */
								
						%>
				    </td>
				   <%--  <td><label id="docType" name="docType"><%=rs5.getString("doctype")%></label></td> --%>
				</tr>
				<% z31=rs21.next();}
				
						 if(count!=0){%> 
				<tr>
					<td colspan="8"><input type="submit" value="delete" name="s" >
				     &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Share" name="s">
					<!-- &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Approval" name="s"></td> -->
					
				</tr>
				
				<%
						 }
				}%>
			
			</form>
	
	
	</table> 
  </div> 
  
  
  
	<script type="text/javascript">
	 
	$(document).ready(function() {
	    $('#example').DataTable();
	} );
	$(document).ready(function() {
	    $('#lett').DataTable();
	} );
	$(document).ready(function() {
	    $('#learn').DataTable();
	} );
	
	function openCity(evt, cityName) {
		  var i, tabcontent, tablinks;
		  tabcontent = document.getElementsByClassName("tabcontent");
		  for (i = 0; i < tabcontent.length; i++) {
		    tabcontent[i].style.display = "none";
		  }
		  tablinks = document.getElementsByClassName("tablinks");
		  for (i = 0; i < tablinks.length; i++) {
		    tablinks[i].className = tablinks[i].className.replace(" active", "");
		  }
		  document.getElementById(cityName).style.display = "block";
		  evt.currentTarget.className += " active";
		}
	
       function valids1(){
			var len=document.form2.mine.length;
			if(len>0)
				for(i=0;i<len;i++){
					if(document.form2.mine[i].checked){
						//sendRequest();	
						return true;
					}
				}
			else
				if(document.form2.mine.checked){
					//sendRequest();
					return true;
				}
			return false;
		}
		function valids2(){
			var len=document.form3.share.length;
			if(len>0)
				for(i=0;i<len;i++){
					if(document.form3.share[i].checked){
						//sendRequest();	
						return true;
					}
				}
			else
				if(document.form3.share.checked){
					//sendRequest();
					return true;
				}
			return false;
		}
	</script>
	</body>
</html>