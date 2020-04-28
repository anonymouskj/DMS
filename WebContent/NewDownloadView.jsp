<%@ page language="java"  import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
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
  

	<div id="Letter" class="tabcontent">
	   <form name="paritionFrame" id="paritionFrame">	
	    
		</form>
  </div>
   <div id="LearningFile" class="tabcontent">
    <form name="fpvc" id="fpvc">
    
    </form>
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
	ResultSet rs1=st1.executeQuery("select * from public.documentload where author='"+uid+"' and status='created' and doctype = 'Circular'");
	boolean z1=rs1.next(),z2;
	%>
	<div id="Circular" class="tabcontent">
	<table border="1" align="center">
	<tr><td>
		 <form  action="removedoc.jsp" onsubmit="return valids2()" name="form3">
			<%	ResultSet rs2=st1.executeQuery("select * from public.documentshared where sharedto='"+uid+"' and status!='deleted' and doctype = 'Circular'");
				boolean z3=rs2.next();
				if(z3){
			%>	
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
					<!-- <th>DocType</th> -->
				</tr>
				<%
					
					while(z3){ 
						
						ResultSet rs5=st4.executeQuery("select * from public.documentload where docid='"+rs2.getString("docid")+"'and doctype = 'Circular'");
						rs5.next();
						ResultSet rs3=st2.executeQuery("select status,approvalby from public.approval where docid='"+rs2.getString("docid")+"' ");
						String Doc =rs5.getString("DocType");
						  //System.out.println(Doc);
						 // if(Doc.equals("Circular")){
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
				   <%--  <td><label id="docType" name="docType"><%=rs5.getString("doctype")%></label></td> --%>
				</tr>
				<% z3=rs2.next();}%>
				<tr>
					<td colspan="8"><input type="submit" value="delete" name="s" >
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Share" name="s">
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Approval" name="s"></td>
					
				</tr>
				<%
				}%>
			</table>
			</form>
		</td></tr>
	</table>
	
	 
  </div> 
  
  
	<script type="text/javascript">
	
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