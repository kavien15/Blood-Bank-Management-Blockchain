<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="dbcon.Dbcon"%>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Camp Booking</title>
</head>
<body>

<%
try {

    HttpSession s = request.getSession();
    String email = s.getAttribute("email").toString();  

   
    String hname = request.getParameter("hname");
    String hmail = request.getParameter("hmail");
    String hcontact = request.getParameter("hcontact");
    String date = request.getParameter("date");

    System.out.println("hname = " + hname);
    System.out.println("hmail = " + hmail);
    System.out.println("hcontact = " + hcontact);
    System.out.println("date = " + date);

   
    String dname = "";
    String dmail = "";
    String dnumber = "";

    Connection con = Dbcon.create();

    
    PreparedStatement ps1 = con.prepareStatement(
        "SELECT * FROM blood.donorlist WHERE donor_email=?"
    );
    ps1.setString(1, email);

    ResultSet rs = ps1.executeQuery();

    if (rs.next()) {
        dname = rs.getString(2);     
        dmail = rs.getString(3);    
        dnumber = rs.getString(11);  
    } else {
        out.println("<script>alert('Donor not found!'); window.location='error.jsp';</script>");
        return;
    }

   
    String status = "requested";
    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO blood.campdonate VALUES (id,?,?,?,?,?,?,?,?)"
    );

    ps.setString(1, dname);
    ps.setString(2, dmail);
    ps.setString(3, dnumber);
    ps.setString(4, hname);
    ps.setString(5, hmail);
    ps.setString(6, hcontact);
    ps.setString(7, date);
    ps.setString(8, status);

    int reg = ps.executeUpdate();

    if (reg > 0) {
        out.println("<script>alert('Booking completed successfully!'); window.location='donorviewcamp.jsp';</script>");
    } else {
        out.println("<script>alert('Booking failed!'); window.location='error.jsp';</script>");
    }

} catch (Exception e) {
    e.printStackTrace();
    out.println("<script>alert('Something went wrong!'); window.location='error.jsp';</script>");
}
%>

</body>
</html>
