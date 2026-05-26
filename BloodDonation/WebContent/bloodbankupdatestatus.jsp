<%@page import="java.sql.*"%>
<%@page import="dbcon.Dbcon"%>
<%
String id = request.getParameter("id");
String status = request.getParameter("status");





Connection con = null;
PreparedStatement ps = null;

try {
    con = Dbcon.create();
    if("accepted".equals(status)) {
        String sql = "UPDATE donorbloodrequest SET status=? WHERE id=?";
        ps = con.prepareStatement(sql);
        ps.setString(1, status);
       
        ps.setString(2, id);
        
        
    } else {
    	
        String sql = "UPDATE donorbloodrequest SET status=? WHERE id=?";
        ps = con.prepareStatement(sql);
        ps.setString(1, status);
        
        ps.setString(2, id);
        
    }
    
    int updated = ps.executeUpdate();
    if(updated > 0) {
        response.sendRedirect("viewrequestbloodbank.jsp");
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
