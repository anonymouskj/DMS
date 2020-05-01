<%@ page language="java"  import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>

<%@page import="javax.servlet.RequestDispatcher"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<html>

<body>

<jsp:include page="header.jsp"></jsp:include>
<%
	//to get the content type information from JSP Request Header
	String contentType = request.getContentType();
	//here we are checking the content type is not equal to Null and  as well as the passed 
	//data from mulitpart/form-data is greater than or equal to 0
	if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
		
 		DataInputStream in = new DataInputStream(request.getInputStream());
		//we are taking the length of Content type data
		int formDataLength = request.getContentLength();
		byte dataBytes[] = new byte[formDataLength];
		int byteRead = 0;
		int totalBytesRead = 0;
		//this loop converting the uploaded file into byte code
		while (totalBytesRead < formDataLength) {
			byteRead = in.read(dataBytes, totalBytesRead,formDataLength);
			totalBytesRead += byteRead;
			}
		String file = new String(dataBytes);
		
		//for saving the file name
		String saveFile = file.substring(file.indexOf("filename=\"") + 10);
		saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
		saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1,saveFile.indexOf("\""));
		 saveFile = saveFile.replaceAll("\\s", "");
		//out.println(saveFile);
		int lastIndex = contentType.lastIndexOf("=");
		String boundary = contentType.substring(lastIndex + 1,contentType.length());
		int pos;
		//extracting the index of file 
		pos = file.indexOf("filename=\"");
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;
		int boundaryLocation = file.indexOf(boundary, pos) - 4;
		int startPos = ((file.substring(0, pos)).getBytes()).length;
		int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
		Date s1=new Date();
   		SimpleDateFormat f=new SimpleDateFormat("yyyy-MM-dd"); 
   	  
		String author=(String)session.getAttribute("userid");
		String docname=(String)session.getAttribute("dn");
		int docid=Integer.parseInt(session.getAttribute("docid").toString());
		String version=(String)session.getAttribute("ver");
		String des=(String)session.getAttribute("des");
		String Doctype=(String)session.getAttribute("Doctype");
		saveFile=author+docname+version+saveFile;
		//Class.forName("com.mysql.jdbc.Driver");
		//Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"dms","root","root");
		Class.forName("org.postgresql.Driver");
Connection con=DriverManager.getConnection("jdbc:postgresql://localhost:5432/DMS","postgres","postgress");
		Statement st1=con.createStatement();
		Statement st2=con.createStatement();
		Statement st3=con.createStatement();
		ResultSet rs=st1.executeQuery("select docname,version from public.documentload where author='"+author+"'");
		String s=docname+version;
		String flag="true";
		while(rs.next()){
			String filepath=rs.getString("docname");
			String ver=rs.getString("version");
			String x=filepath+ver;
			if(x.equals(s)){
					
					flag="false";
%>
	<p align="center">document name <%=docname %> already exists with the version number <%=version%> </p>
<%  break;
			}
		}
				
		// creating a new file with the same name and writing the content in new file
		String filePath=null;
			if(flag.equals("true")){
				String os=System.getProperty("os.name");
				System.out.println(os);
				/* if(os.startsWith("Windows"))
				{ */
					File checkfile = new File("C:/dms");
					boolean fileExists = checkfile.exists();
					if(!fileExists)
					{
					System.out.println("Dir does not exist");
					File createfile = new File("C:/dms");
					boolean dirCreated = createfile.mkdir();
					if(dirCreated)
					{
						System.out.println("Dir created");
						
					}
					else
					{
						System.out.println("No Dir created");
					}
					}
				
					filePath = "C:/dms/" + saveFile;
					
				/*}
				 else if(os.startsWith("Unix")){

					File checkfile = new File("/dms");
					boolean fileExists = checkfile.exists();
					if(!fileExists)
					{
					System.out.println("Dir does not exist");
					File createfile = new File("/dms");
					boolean dirCreated = createfile.mkdir();
					if(dirCreated)
					{
						System.out.println("Dir created");
						
					}
					else
					{
						System.out.println("No Dir created");
					}
					}
				
					fgit ilePath = "/dms/" + saveFile;
				} */
				FileOutputStream fileOut = new FileOutputStream(filePath);
				fileOut.write(dataBytes, startPos, (endPos - startPos));
				fileOut.flush();
				fileOut.close();
				st1.executeUpdate("insert into public.documentload values('"+docname+"','"+des+"','"+docid+"','"+version+"','"+author+"','"+formDataLength+"','"+f.format(s1) +"','created','"+saveFile+"','"+Doctype+"')");	
				if(Doctype.equalsIgnoreCase("LearningFile")){
				//st3.executeUpdate("insert into public.documentshared values('"+docid+"','All','"+author+"','"+version+"','"+author+"','"+formDataLength+"','"+f.format(s1) +"','created','"+saveFile+"','"+Doctype+"')");	
				st3.executeUpdate("insert into public.documentshared values('"+docid+"','All','"+author+"','"+ f.format(s1)+"','shared','"+Doctype+"')");	
				}
				ResultSet rs1=st2.executeQuery("select docid from public.documentload where docname='"+docname+"' and version='"+version+"' and author='"+author+"'");
				rs1.next();
				String id=rs1.getString("docid");
				st1.executeUpdate("insert into public.docids values('"+id+"')");
%>
		<Br><table border="0" align="center"><tr><td><b>You have successfully upload the document by the name of:</b>
		<% out.println(docname); %></td></tr></table> 		
<%			}	
		}
	else {
			out.print("not recieved");
		}
%>

</body>
</html>