<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="dbcon.Dbcon"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<% 
String id=request.getParameter("id");


try{
	
	Connection con=Dbcon.create();
	Statement st=con.createStatement();
	st.executeUpdate("UPDATE `blood`.`campdonate` SET status='notdonated' WHERE id='"+id+"' ");
	
	response.sendRedirect("addcertificate.jsp");
}
catch(Exception e){
	response.sendRedirect("error.jsp?inval id");
	System.out.println(e);
}
%>

</body>
</html>