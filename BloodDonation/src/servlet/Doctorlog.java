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


@WebServlet("/Doctorlog")
public class Doctorlog extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public Doctorlog() {
        super();
        
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		Connection con;
		String doctoremail = request.getParameter("email");
		String ps = request.getParameter("password");
		
		HttpSession session= request.getSession();
		session.setAttribute("doctoremail", doctoremail);
		
		
		int z=0;
		
		try {
		
			con= Dbcon.create();
		Statement st = con.createStatement();
			
			ResultSet rs= st.executeQuery("SELECT * FROM `blood`.`hospitaldetails` WHERE email= '"+doctoremail+"'and password= '"+ps+"'" );
		
		while(rs.next())
		{	
		z=1;
		
		session.setAttribute("h_name", rs.getString(2));
		session.setAttribute("d_number", rs.getString(5));
		session.setAttribute("d_addres", rs.getString(7));
		
		}
		if(z==0) {
			request.setAttribute("errorMsg", "Email or Password does not match");
		    request.getRequestDispatcher("doctorlogin.jsp").forward(request, response);
			
		
		}else{
			response.sendRedirect("doctorhome.jsp");
			
		}
			
		}catch (SQLException e) {
			
			e.printStackTrace();
		}
	}

}
