package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbcon.Dbcon;



@WebServlet("/Donorreg")
public class Donorreg extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public Donorreg() {
        super();
        
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String name = request.getParameter("name");
        String email = request.getParameter("email");
        String age = request.getParameter("age");
        String bloodgroup = request.getParameter("bloodGroup");
        String medicalissue = request.getParameter("medicalHistory");
        String location = request.getParameter("location");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String mobile = request.getParameter("mobile");



      
        HttpSession session = request.getSession();
        session.setAttribute("email", email);

        try (Connection con = Dbcon.create()) {

         
            String sql = "INSERT INTO `blood`.`donorlist` VALUES (id, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, age);
            ps.setString(4, bloodgroup);
            ps.setString(5, medicalissue);
            ps.setString(6, location);
            ps.setString(7, password);
            ps.setString(8, "registered");
            ps.setString(9, address);
            ps.setString(10, mobile);
            int rows = ps.executeUpdate();

            if (rows > 0) {
            	response.sendRedirect("donorlogin.jsp");
            } else {
            	response.sendRedirect("error.jsp?msg=Insert+Failed");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=Database+Error");
        }
	}

}
