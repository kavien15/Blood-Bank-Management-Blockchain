package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbcon.Dbcon;


@WebServlet("/BloodBankLogin")
public class BloodBankLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public BloodBankLogin() {
        super();
        
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		Connection con;
        String bloodbankId = request.getParameter("bloodbankId");
        String email = request.getParameter("email");
        String password = request.getParameter("password");    
        try {
            con = Dbcon.create();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM blood.bloodbank WHERE bid = ? AND email = ? AND password = ?"
            );
            ps.setString(1, bloodbankId);
            ps.setString(2, email);
            ps.setString(3, password);    
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("bloodbankId", bloodbankId);
                session.setAttribute("bloodbankName", rs.getString("name"));
                session.setAttribute("email", email);
                session.setAttribute("bloodbankEmail", email);
                
                response.sendRedirect("bloodbankdashboard.jsp");
            } else {
              
                request.setAttribute("errorMsg", "Email or Password does not match");
    		    request.getRequestDispatcher("bloodbanklogin.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            
        }
    }
	

}
