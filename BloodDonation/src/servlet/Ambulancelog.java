package servlet;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbcon.Dbcon;


@WebServlet("/Ambulancelog")
public class Ambulancelog extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public Ambulancelog() {
        super();
       
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            java.sql.Connection con = Dbcon.create();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM ambulance WHERE email=? AND password=?"
            );

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                HttpSession session = request.getSession();
                session.setAttribute("ambulanceEmail", email);
            
                session.setAttribute("location", rs.getString(7));
                session.setAttribute("ambno", rs.getString(3));
                session.setAttribute("drivername", rs.getString(2));
                session.setAttribute("contact", rs.getString(4));

                response.sendRedirect("ambulancedashboard.jsp");

            } else {
            	request.setAttribute("errorMsg", "Email or Password does not match");
    		    request.getRequestDispatcher("ambulancelog.jsp").forward(request, response);
            }

        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
	}

}
