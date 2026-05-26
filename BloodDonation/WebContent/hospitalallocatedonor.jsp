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
String bp=request.getParameter("bp");
String bg=request.getParameter("bg");
String pname=request.getParameter("pname");
String hname=request.getParameter("hname");
String gender=request.getParameter("gender");
String dmail=request.getParameter("dmail");
String status="allocat";


try{
	
	Connection con=Dbcon.create();
	Statement st=con.createStatement();
	st.executeUpdate("UPDATE `blood`.`patient` SET status='Allocate' WHERE donormail='"+dmail+"' AND hospital='"+hname+"' AND name='"+pname+"'");
	
	response.sendRedirect("viewdonorresponse.jsp");
}
catch(Exception e){
	response.sendRedirect("error.jsp?inval id");
	System.out.println(e);
}
%>

</body>
</html>