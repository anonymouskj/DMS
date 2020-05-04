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
  padding: 12px;
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
	String uid=(String)session.getAttribute("userid");
	ResultSet rs1=st1.executeQuery("select * from public.documentload where author='"+uid+"' and status='created' and doctype = 'Circular'");
	boolean z1=rs1.next(),z2;
	%>
	<div id="Circular" class="tabcontent">
	
	
		<%
		 	
		if(z1){ %>
		<!-- <h2>Your Documents</h2> -->
		<form  action="removedoc.jsp" onsubmit="return valids1()" name="form2">
		<table  id="example" class="display" style="width:100%">
			<thead>
			<tr>
				<th>Document Name</th>
				<th>Author</th>
				<th>Description</th>
				<th>Document id</th>
				<th>Created on</th>
				<th>Version</th>
				<th>Size in bytes</th>
				<th>Status</th>
			    <th>View History</th>
			</tr>
	      </thead>		
			<%	
			 
			//System.out.println(Doc);
			while(z1){ 
				   
				ResultSet rs2=st2.executeQuery("select status,approvalby from public.approval where docid='"+rs1.getString("docid")+"'");
		
				%>
			<tbody>	
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
			  <td align="center"><button value="<%=rs1.getString("docid")%>">View</button></td>
			</tr>
			
			<% 
			 
			 z1=rs1.next();	
			}
			%>
			<tr>
				<td colspan="10">
					<input type="submit" value="delete" name="s" >
				    &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="share" name="s">
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="approval" name="s">
					
				</td>
			</tr>
		</tbody>
		  
			<%
			}%>
		</table>
	</form>
</div> 
  <div id="Letter" class="tabcontent">
	  
	 
	  <%
	  ResultSet rs3=st1.executeQuery("select * from public.documentload where author='"+uid+"' and status='created' and doctype = 'Letter'");
		boolean z3=rs3.next(),z4;
		if(z3){ %>
		<!-- <h2>Your Documents</h2> -->
		<form  action="removedoc.jsp" onsubmit="return valids1()" name="form2">
		<table  id="lett" class="display" style="width:100%">
			<thead>	
			<tr>
				<th>Document Name</th>
				<th>Author</th>
				<th>Description</th>
				<th>Document id</th>
				<th>Created on</th>
				<th>Version</th>
				<th>Size in bytes</th>
				<th>Status</th>
			    <th>View History</th>
			</tr>
			</thead>
			<%	
			 
			//System.out.println(Doc);
			while(z3){ 
				   
				ResultSet rs4=st2.executeQuery("select status,sharedto from public.documentshared where docid='"+rs3.getString("docid")+"'");
		
				%>
			<tbody>
			<tr>
				<td><input type="checkbox" name="mine" value="<%=rs3.getString("docid")%>">
			<a href="DownloadFile.jsp?path=C:/dms/<%=rs3.getString("filepath")%>"><%=rs3.getString("docname")%></a></td> 
				
                <td><%=rs3.getString("author")%></td>
				<td><%=rs3.getString("description")%></td>
				<td><%=rs3.getString("docid")%></td>
				<td><%=rs3.getString("createdon")%></td>
				<td><%=rs3.getString("version")%></td>
				<td><%=rs3.getString("size")%></td>
				
				<td>
					<%if(z4=rs4.next())
						while(z4){
						out.println(rs4.getString("status")+" to"+ rs4.getString("sharedto")); 
						z4=rs4.next();
						}
						else out.print("none");
					%> 
				</td>
			  <td align="center"><button  value="<%=rs3.getString("docid")%>">View</button></td>
			</tr>
			<% 
			 
			 z3=rs3.next();	
			}
			%>
			<tr>
					<td colspan="10"><input type="submit" value="delete" name="s" >
					 &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="share" name="s">
					<!-- &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Approval" name="s"> -->
					
					</td>
		  </tr>
		 </tbody> 	
					
	<%        
			}%>
		
		</table>
		
		</form>
</div>

  <div id="LearningFile" class="tabcontent">
    
	  <%
	  ResultSet rs5=st1.executeQuery("select * from public.documentload where author='"+uid+"' and status='created' and doctype = 'LearningFile'");
		boolean z5=rs5.next(),z6;
		if(z5){ %>
		<!-- <h2>Your Documents</h2> -->
		<form  action="removedoc.jsp" onsubmit="return valids1()" name="form2">
		<table  id="learn" class="display" style="width:100%">
		<thead>
			<tr>
				<th>Document Name</th>
				<th>Author</th>
				<th>Description</th>
				<th>Document id</th>
				<th>Created on</th>
				<th>Version</th>
				<th>Size in bytes</th>
				<th>Status</th>
			    <th>View History</th>
			</tr>
		</thead>	
			<%	
			 
			//System.out.println(Doc);
			while(z5){ 
				   
				ResultSet rs7=st2.executeQuery("select status,approvalby from public.approval where docid='"+rs5.getString("docid")+"'");
		
				%>
		<tbody>
			<tr>
				<td><input type="checkbox" name="mine" value="<%=rs5.getString("docid")%>">
			<a href="DownloadFile.jsp?path=C:/dms/<%=rs5.getString("filepath")%>"><%=rs5.getString("docname")%></a></td> 
				
                <td><%=rs5.getString("author")%></td>
				<td><%=rs5.getString("description")%></td>
				<td><%=rs5.getString("docid")%></td>
				<td><%=rs5.getString("createdon")%></td>
				<td><%=rs5.getString("version")%></td>
				<td><%=rs5.getString("size")%></td>
				
				<td>
					<%if(z6=rs7.next())
						while(z6){
						out.println(rs7.getString("status")+" by"+ rs7.getString("approvalby")); 
						z6=rs7.next();
						}
						else out.print("none");
					%> 
				</td>
			  <td align="center" ><button  value="<%=rs5.getString("docid")%>">View</button></td>
			</tr>
			<% 
			 
			 z5=rs5.next();	
			}
			%>
			<tr>
					<td colspan="10"><input type="submit" value="delete" name="s" >
					<!-- &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Forward" name="s"> -->
					</td>
				</tr>
			</tbody>		    
	<%        
			}%>
		</table>
		
		</form>
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
	
	var btn;
	function openCity(evt, cityName) {
		  var i, tabcontent, tablinks;
		   btn=evt.target.id;
		   //alert(btn);
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
						return true;					}
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