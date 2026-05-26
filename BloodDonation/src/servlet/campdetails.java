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


import dbcon.Dbcon;



@WebServlet("/campdetails")
public class campdetails extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public campdetails() {
        super();
       
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		int n=0; 
		
		String name=request.getParameter("hname");	
		
		String email=request.getParameter("email");
		String number=request.getParameter("number");	
		String address=request.getParameter("address");		
		String city=request.getParameter("city");		
		String state=request.getParameter("state");
		String zip=request.getParameter("zip");
		String date=request.getParameter("date");
		
		

		Connection con= Dbcon.create();
		
		try {
			PreparedStatement ps= con.prepareStatement("INSERT INTO blood.campdetails VALUES(id,?,?,?,?,?,?,?,?)"); 
			ps.setString(1, name);
			ps.setString(2, email);
			ps.setString(3, number);
			ps.setString(4, address);
			ps.setString(5, city);
			ps.setString(6, state);
			ps.setString(7, zip); 
			ps.setString(8, date);
		
		
			n=ps.executeUpdate();
			
			if(n==1)
			{
				
			
				
				response.sendRedirect("doctorhome.jsp");
			}else
			{
				response.sendRedirect("error.jsp");
			}
			  
		}
		catch (SQLException e) {
			e.printStackTrace(); 
		}
	}

	

}
