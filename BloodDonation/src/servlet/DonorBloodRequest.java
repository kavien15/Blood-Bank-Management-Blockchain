package servlet;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dbcon.Dbcon;

@WebServlet("/DonorBloodRequest")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10) 
public class DonorBloodRequest extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String gender = request.getParameter("gender");
        String age = request.getParameter("age");
     
        String bloodgroup = request.getParameter("bloodgroup");
        String type = request.getParameter("type");

        HttpSession session = request.getSession();
        String donorEmail = (String) session.getAttribute("email");

        Part filePart = request.getPart("file");
        InputStream fileContent = null;
        long fileSize = 0;

        if (filePart != null) {
            fileContent = filePart.getInputStream();
            fileSize = filePart.getSize();
        }

        try {
            Connection con = Dbcon.create();

            String sql =
                    "INSERT INTO patients VALUES (id, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, mobile);
            ps.setString(4, gender);
            ps.setString(5, age);
           
            ps.setString(6, bloodgroup);
            ps.setString(7, type);
            ps.setString(8, "requested");
            ps.setString(9, donorEmail);

            if (filePart != null && fileSize > 0) {
                ps.setBinaryStream(10, fileContent, (int) fileSize);
            } else {
                ps.setNull(10, java.sql.Types.BLOB);
            }

           
            ps.setString(11, "");
            ps.setString(12, "");
            ps.setString(13, "");

            ps.executeUpdate();

            response.sendRedirect("donorhome.jsp?success");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("donorhome.jsp?error=" + e.getMessage());
        }
    }
}
