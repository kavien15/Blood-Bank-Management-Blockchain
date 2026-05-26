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


@WebServlet("/Donorlog")
public class Donorlog extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public Donorlog() {
        super();
       
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		Connection con;
		String email = request.getParameter("email");	
		String ps = request.getParameter("password");
		
		HttpSession session= request.getSession();
		session.setAttribute("email", email);	
		session.setAttribute("donoremail", email);	
		int z=0;
		try {
			con= Dbcon.create();
		Statement st = con.createStatement();
			ResultSet rs= st.executeQuery("SELECT * FROM `blood`.`donorlist` WHERE donor_email= '"+email+"'and donor_password= '"+ps+"'" );
		while(rs.next())
		{	
		z=1;
		
		session.setAttribute("mobile", rs.getString(11));
		session.setAttribute("bgp", rs.getString(5));
		
				}
		if (z == 0) {
		    request.setAttribute("errorMsg", "Email or Password does not match");
		    request.getRequestDispatcher("donorlogin.jsp").forward(request, response);
		} else {
		    response.sendRedirect("donorhome.jsp");
		}

			
		}catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
