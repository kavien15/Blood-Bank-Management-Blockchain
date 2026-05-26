package servlet;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.Part;

import dbcon.Dbcon;


@WebServlet("/Doctorreg")
public class Doctorreg extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public Doctorreg() {
        super();
        
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String mobile = request.getParameter("number");
		String gender = request.getParameter("hosname");
		String age = request.getParameter("address");
		String hospital = request.getParameter("password");
		String hosid = request.getParameter("id");
		
		
		
		
		 Part filePart = request.getPart("file");
	        String fileName = null;
	        InputStream fileContent = null;
	        long fileSize = 0;

	        if (filePart != null) {
	            fileName = getFileName(filePart);
	            fileContent = filePart.getInputStream();
	            fileSize = filePart.getSize();
	        }
	        
	        
	        
	        
	        
	        Connection con = Dbcon.create();
	        try {
	        PreparedStatement ps = con.prepareStatement(
	        "INSERT INTO blood.hospitaldetails VALUES(id,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

	        ps.setString(1, name);
	        ps.setString(2, hosid);
	        ps.setString(3, email);
	        ps.setString(4, mobile);
	        ps.setString(5, gender);
	        ps.setString(6, age);
	        ps.setString(7, hospital);
	
	   

	        if (filePart != null && fileSize > 0) {
                filePart = request.getPart("file"); 
                ps.setBinaryStream(8, filePart.getInputStream(), (int) fileSize);
            } else {
                ps.setNull(8, java.sql.Types.BLOB);
            }
	        ps.setString(9, "requested");

	        ps.executeUpdate();

	        response.sendRedirect("doctorlogin.jsp?success");
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        
	        
	      
	    		
	}
	
	
	  
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    
	}

}
