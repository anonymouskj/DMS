	<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>

<%@page import="javax.servlet.RequestDispatcher"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<script type="text/javascript">
	function check(){
		if(window.XMLHttpRequest){
			return(new XMLHttpRequest());
		}
		else if(window.ActiveXObject){
			return(new ActiveXObject("Microsoft.XMLHTTP"));
		}
		else return null;
	}
	function sendRequest(){
		var request=check();
		request.onreadystatechange=function(){handleResponse(request)};
		dns=document.form1.dn.value;
		vers=document.form1.ver.value;
		des=document.form1.des.value;
		Doctype=document.form1.Doctype.value;
		request.open("get","sess.jsp?dn="+dns+"&ver="+vers+"&des="+des+"&Doctype="+Doctype,true);
		request.send(null);
	}
	function handleResponse(request){
		if(request.readyState==4){
		}
	}
function valids(){

	dns=document.form1.dn.value;
	vers=document.form1.ver.value;
	doctype=document.form1.Doctype.value;
	//console.log("broadcast"+doctype);
	val=true;
	if(dns==""){
		f1.innerText="document name required";
		val=false;
	}
	else{
		f1.innerText="";
	}
	if(vers== ""){
		f2.innerText="version required";
		val=false ;
	}
	else{
		re=/[0-9]/;
		word=new RegExp(re);
		if(!word.exec(vers)){
			f2.innerText="version should be a number";
			val=false;
		}
		else
			 f2.innerText="";
	}
	
	if(doctype== "5"){
		f7.innerText="Select the DocType";
		val=false ;
	}
	else{
		f7.innerText="";
}
	
	if(val==true) sendRequest();
	return val;
}
function vali(){
	var tr=valids();
	file=document.form2.uploadfile.value;
	if(file==""){
		f3.innerText="select a document";
		tr=false;
	}
	else f3.innerText="";
	return tr;
}
</script>	
</head>
<body >
<jsp:include page="header.jsp"></jsp:include>
<%
//Class.forName("com.mysql.jdbc.Driver");
//Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"dms","root","root");
Class.forName("org.postgresql.Driver");
Connection con=DriverManager.getConnection("jdbc:postgresql://localhost:5432/DMS","postgres","postgress");
Statement st2=con.createStatement();
ResultSet rs2=st2.executeQuery("select docid from public.docids");
int s=1; 
boolean z;
if(z=rs2.next()) 
	while(z){
		s=Integer.parseInt(rs2.getString("docid"))+1;
		z=rs2.next();
	}
session.setAttribute("docid",String.valueOf(s));
%>

<table align="center">
	<tr>
		<td>
			<form name="form1" >
			  <table width="60%" border="0" cellspacing="1" cellpadding="1" align="center" >
			  
			    <tr>
			    	<td><label for="Author">Author:</label></td>
			    	<td><input type="text" name="Author" value="<%=session.getAttribute("userid") %>" disabled="disabled" ></td>
			    </tr>
			    <tr>
			    	<td>Document id:</td>
			    	<td><input type="text" name="docid" disabled="disabled" value="<%=session.getAttribute("docid")%>"></td>
			    </tr>
			    <tr>
			    	<td>Document name</td>
			    	<td><input type="text" name="dn"></td>
			    	<td><p id="f1"></p></td>
			    </tr>
			     <tr>
			    	<td>Document Type</td>
			    	<td>
			    	<select id="Doctype" name="Doctype">
			    	      <option value="5">Select:</option>
                         <option value="Circular">Circular</option>
                         <option value="LearningFile">LearningFile</option>
                         <option value="Letter">Letter</option>
                    </select>
                    </td>
			    	<td><p id="f7"></p></td>
			    </tr>
			     <tr>
			    	<td>Description</td>
			    	<td><textarea name="des" rows="3" cols="20"></textarea></td>
			      </tr>
			    <tr>
			    	<td>Version:</td>
			    	<td><input type="text" name="ver" onblur="valids()" ></td>
			    	<td><p id="f2"></p></td>
			    </tr>
			      <%
			      Date s1=new Date();
			   		SimpleDateFormat f=new SimpleDateFormat("yyyy-MM-dd"); 
			   	  %>
			      <tr>
			    	<td>date:</td>
			    	<td><input type="text" name="date" value="<%=f.format(s1) %>"disabled="disabled" ></td>
			   	 </tr> 
			 </table> 
		  </form>
	  </td>
	</tr>
   <tr>
   	 <td>
   	 	<form onsubmit="return vali()" method="post"  action="uploadFile.jsp" name="form2" enctype="multipart/form-data">
		    <table>
			     <tr>
			     	<td><b>Select a file to upload </b></td>
			      	<td><input type="file" name="uploadfile"> </td>
			    	<td><p id="f3"></p></td>
			    </tr>
			    <tr>
			    	<td colspan="1"><input type="hidden" name="todo" value="upload">
			        	<input type="submit" name="Submit" value="Upload">
			        	<input type="reset" name="Reset" value="Cancel">
			        </td>
		    	</tr>
		    </table>
		</form>
	</td>
 </tr>
</table> 
</body>
</html>