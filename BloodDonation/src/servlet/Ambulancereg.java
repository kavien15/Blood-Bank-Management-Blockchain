package servlet;

import java.io.IOException;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbcon.Dbcon;




@WebServlet("/Ambulancereg")
public class Ambulancereg extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public Ambulancereg() {
        super();
       
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		 String drivername = request.getParameter("drivername");
	        String ambulanceno = request.getParameter("ambulanceno");
	        String phone = request.getParameter("phone");
	        String email = request.getParameter("email");
	        String password = request.getParameter("password");
	        String location = request.getParameter("location");

	        try {
	            java.sql.Connection con = Dbcon.create();

	            PreparedStatement ps = con.prepareStatement(
	                "INSERT INTO ambulance VALUES (id,?,?,?,?,?,?)"
	            );

	            ps.setString(1, drivername);
	            ps.setString(2, ambulanceno);
	            ps.setString(3, phone);
	            ps.setString(4, email);
	            ps.setString(5, password);
	            ps.setString(6, location);

	            ps.executeUpdate();

	            response.sendRedirect("ambulancelog.jsp");

	        } catch (Exception e) {
	            response.getWriter().println("Error: " + e.getMessage());
	        }
	}

}
