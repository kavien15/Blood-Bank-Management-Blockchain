<%@page import="java.sql.*"%>
<%@page import="dbcon.Dbcon"%>
<%
String id = request.getParameter("id");
String status = request.getParameter("status");
String from = request.getParameter("from");


String doctorName = (String) session.getAttribute("h_name");
String doctorNumber = (String) session.getAttribute("d_number");
String doctorHospital = (String) session.getAttribute("d_addres");

Connection con = null;
PreparedStatement ps = null;

try {
    con = Dbcon.create();
    if("accepted".equals(status)) {
        String sql = "UPDATE patients SET status=?, h_name=?, d_number=?, h_addres=? WHERE id=?";
        ps = con.prepareStatement(sql);
        ps.setString(1, status);
        ps.setString(2, doctorName);
        ps.setString(3, doctorNumber);
        ps.setString(4, doctorHospital);
        ps.setInt(5, Integer.parseInt(id));
    } else {
        String sql = "UPDATE patients SET status=? WHERE id=?";
        ps = con.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, Integer.parseInt(id));
    }
    
    int updated = ps.executeUpdate();
    if(updated > 0) {
        response.sendRedirect("doctorhome.jsp");
    } else {
        out.println("Failed to update status");
    }
} catch(Exception e) {
    out.println(e.getMessage());
} finally {
    if(ps != null) ps.close();
    if(con != null) con.close();
}
%>
