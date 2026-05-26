<%@page import="dbcon.Dbcon"%>
<%@page import="java.sql.*"%>

<%
    String newStatus = request.getParameter("status");
    String Email = request.getParameter("email"); 
    String id = request.getParameter("id");
    String mobile = request.getParameter("mobile");

    Connection con;

    try {
        con = Dbcon.create();

        PreparedStatement ps = con.prepareStatement(
            "UPDATE `blood`.`patient` SET status=?, donormail=?, donornumber=?  WHERE id=? "
        );

        ps.setString(1, newStatus);
        ps.setString(2, Email);
        ps.setString(3, mobile);
        ps.setInt(4, Integer.parseInt(id));

        ps.executeUpdate();

        response.sendRedirect("viewrequestfromhospital.jsp");

    } catch (Exception e) {
        response.getWriter().println("Error: " + e.getMessage());
    }
%>
