<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="dbcon.Dbcon" %>

<%
    String id = request.getParameter("id");

    if (id == null || id.trim().isEmpty()) {
        response.getWriter().println("Invalid ID");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    InputStream is = null;
    OutputStream os = null;

    try {
        con = Dbcon.create();
        ps = con.prepareStatement("SELECT p_priscription FROM patients WHERE id=?");
        ps.setString(1, id);
        rs = ps.executeQuery();

        if (rs.next()) {
            Blob blob = rs.getBlob("p_priscription");

            if (blob == null) {
                response.getWriter().println("No file found");
                return;
            }

            byte[] fileData = blob.getBytes(1, (int) blob.length());

            
            String mimeType = "";
            if (fileData.length > 4) {
                
                if (fileData[0] == '%' && fileData[1] == 'P' && fileData[2] == 'D' && fileData[3] == 'F') {
                    mimeType = "application/pdf";
                }
               
                else if (fileData[0] == (byte)137 && fileData[1] == (byte)80) {
                    mimeType = "image/png";
                }
              
                else if (fileData[0] == (byte)0xFF && fileData[1] == (byte)0xD8) {
                    mimeType = "image/jpeg";
                }
                else {
                    mimeType = "application/octet-stream";
                }
            }

            response.setContentType(mimeType);
            response.setContentLength(fileData.length);

            os = response.getOutputStream();
            os.write(fileData);
            os.flush();
        } else {
            response.getWriter().println("No record found");
        }

    } catch (Exception e) {
        response.getWriter().println("Error: " + e.getMessage());
        e.printStackTrace();
    } finally {
        try { if (os != null) os.close(); } catch (Exception ex) {}
        try { if (rs != null) rs.close(); } catch (Exception ex) {}
        try { if (ps != null) ps.close(); } catch (Exception ex) {}
        try { if (con != null) con.close(); } catch (Exception ex) {}
    }
%>
