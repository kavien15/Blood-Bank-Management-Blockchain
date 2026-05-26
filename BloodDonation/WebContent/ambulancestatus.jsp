<%@ page import="java.sql.*" %>
<%@ page import="dbcon.Dbcon" %>

<%
String id = request.getParameter("id");

HttpSession s = request.getSession();



String ambno = s.getAttribute("ambno").toString();

String drivername = s.getAttribute("drivername").toString();

String contact = s.getAttribute("contact").toString();

String status = "Accepted";

try {
    Connection con = Dbcon.create();

    PreparedStatement ps = con.prepareStatement(
        "UPDATE patient SET ambulanceno=?,drivername=?,ambcontact=?,ambstatus=? WHERE id=?"
    );

    ps.setString(1, ambno);
    ps.setString(2, drivername);
    ps.setString(3, contact);
    ps.setString(4, status);
    ps.setString(5, id);
   

    ps.executeUpdate();

    response.sendRedirect("ambuancemainpage.jsp");

} catch(Exception e) {
    out.println("Error: " + e.getMessage());
}
%>
