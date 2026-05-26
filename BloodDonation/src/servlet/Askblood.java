package servlet;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dbcon.Dbcon;
import mail.mail1;

@WebServlet("/Askblood")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10)
public class Askblood extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public Askblood() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String number = request.getParameter("number");
        String address = request.getParameter("address");

        String age = request.getParameter("age");
        String hospital = request.getParameter("hospital");
        String bp = request.getParameter("bp");
        String gmail = request.getParameter("gmail");
        String bloodgroup = request.getParameter("bloodgroup");
        String location = request.getParameter("location");
        String gender = request.getParameter("gender");
        String blood = request.getParameter("blood");
        String id = request.getParameter("id");

        HttpSession session = request.getSession();
        session.setAttribute("email", email);

        Part filePart = request.getPart("file");
        InputStream fileContent = null;
        long fileSize = 0;

        if (filePart != null) {
            fileContent = filePart.getInputStream();
            fileSize = filePart.getSize();
        }

        try {
            Connection con = Dbcon.create();
            Connection con1 = Dbcon.create();  // second connection for donor checking

            String sql = "INSERT INTO blood.patient VALUES (id, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, number);
            ps.setString(4, address);
            ps.setString(5, gender);
            ps.setString(6, age);
            ps.setString(7, hospital);
            ps.setString(8, bp);
            ps.setString(9, bloodgroup);
            ps.setString(10, "requested");

            ps.setString(11, "");
            ps.setString(12, "");
            ps.setString(13, location);

            java.sql.Date currentDate = new java.sql.Date(System.currentTimeMillis());
            ps.setDate(14, currentDate);

            if (filePart != null && fileSize > 0) {
                ps.setBinaryStream(15, fileContent, (int) fileSize);
            } else {
                ps.setNull(15, java.sql.Types.BLOB);
            }

            ps.setString(16, "");
            ps.setString(17, "");
            ps.setString(18, "");

            ps.setString(19, "");

            int n = ps.executeUpdate();

            String time = new SimpleDateFormat("dd-MM-yyyy").format(new Date());

            if (n == 1) {

                if ("allusers".equals(gmail)) {

                    PreparedStatement ps1 = con1.prepareStatement("SELECT * FROM blood.donorlist");
                    ResultSet rs = ps1.executeQuery();

                    while (rs.next()) {

                       
                                String donorEmail = rs.getString(3);
                                mail1.main(donorEmail,
                                        "Blood needed for a patient with blood group '" + bloodgroup + "', please check your application.");
                        
                    }

                } else if ("donors".equals(gmail)) {

                    PreparedStatement ps2 = con1.prepareStatement(
                            "SELECT * FROM blood.donorlist WHERE donor_bgp='" + bloodgroup + "'");
                    ResultSet rs2 = ps2.executeQuery();

                    while (rs2.next()) {
                        
                                String donorEmail = rs2.getString(3);
                                mail1.main(donorEmail,
                                        "Blood needed for a patient with blood group '" + bloodgroup + "', please check your application.");
                         
                    }
                }

                response.sendRedirect("doctorhome.jsp?success");
            } else {
                response.sendRedirect("error.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
