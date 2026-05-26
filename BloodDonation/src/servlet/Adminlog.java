package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbcon.Dbcon;


@WebServlet("/Adminlog")
public class Adminlog extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public Adminlog() {
        super();
        
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		Connection con;
		String email = request.getParameter("mail");
		
		
		String ps = request.getParameter("password");
		
		HttpSession session= request.getSession();
		
		int z=0;
		
		try {
		
			con= Dbcon.create();
			Statement st = con.createStatement();
			
			ResultSet rs= st.executeQuery("SELECT * FROM blood.admin WHERE email= '"+email+"'and pass= '"+ps+"'" );
		
		while(rs.next())
		{	
		z=1;
		  session.setAttribute("admin", email);
		}
		if(z==0) {
			
			request.setAttribute("errorMsg", "Email or Password does not match");
		    request.getRequestDispatcher("adminlogin.jsp").forward(request, response);
		
		}else{
		
			response.sendRedirect("Aadminhomepage.jsp");
			
		}
		
		}catch (SQLException e) {
			
			e.printStackTrace();
		}
	}

}
