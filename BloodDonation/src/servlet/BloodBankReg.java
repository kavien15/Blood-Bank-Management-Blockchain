package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbcon.Dbcon;


@WebServlet("/BloodBankReg")
public class BloodBankReg extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public BloodBankReg() {
        super();
        
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		Connection con;
		String bloodbankId=request.getParameter("id");
		String name=request.getParameter("name");
		String email=request.getParameter("mail");
		String pass=request.getParameter("pass");
		String location = request.getParameter("location");
		String address = request.getParameter("address");
		
		HttpSession id=request.getSession();
		id.setAttribute("bloodbankId", id);
		
		int z=0;
		try {
			con=Dbcon.create();
			PreparedStatement ps=con.prepareStatement("INSERT INTO `blood`.`bloodbank` VALUES (id,?,?,?,?,?,?)");
			ps.setString(1, name);
			ps.setString(2, email);
			ps.setString(3, pass);
			ps.setString(4, bloodbankId);
			ps.setString(5, location);
			ps.setString(6, address);
			
			int row=ps.executeUpdate();
			z=1;
			if (z==row) {
				response.sendRedirect("bloodbanklogin.jsp");
				}else{
				
					response.sendRedirect("error.jsp?");
				
				}
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

}
