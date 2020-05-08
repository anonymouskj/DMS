<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="javax.servlet.RequestDispatcher"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%String contextpath=request.getContextPath(); %>
<html>
<head>
<link href="templatemo_style.css" rel="stylesheet" type="text/css" />
<%-- <link rel="stylesheet" href="<%=contextpath%>/css/bootstrap.min.css"> --%> 
</head>
<body>
<%
	String uid=(String)session.getAttribute("userid");
	if(uid==null){
%>
		 <jsp:forward page="index.html"></jsp:forward>
<%
	}
	else{
		
	
%>
<div id="templatemo_background_section_top">
		<div class="templatemo_container">
			<div id="templatemo_header">
				<div id="templatemo_logo">
					<h1>DOCUMENT MANAGEMENT SYSTEM</h1>
                    <h2>we secure your documents</h2>
				</div>
            <%if(!uid.equals("admin")){ %>
				<div id="templatemo_search_box">
					<%-- <jsp:include page="search.jsp"></jsp:include> --%>
				</div>
			<%} %>
		</div>
	</div></div>
	<div>
	<jsp:include page="menu.jsp"></jsp:include>
	</div>

<br><br><br>
<%} %>
</body>
</html>