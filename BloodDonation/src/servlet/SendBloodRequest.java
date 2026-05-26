package servlet;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dbcon.Dbcon;


@WebServlet("/SendBloodRequest")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10)
public class SendBloodRequest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public SendBloodRequest() {
        super();
        
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String bid = request.getParameter("bid");
		String patientname = request.getParameter("patientname");
		String age = request.getParameter("age");
		String hospital = request.getParameter("hospital");
		String bloodgroup = request.getParameter("bloodgroup");
		String qty = request.getParameter("qty");
		String reason = request.getParameter("reason");
		
		HttpSession s = request.getSession();
		
		String email = s.getAttribute("email").toString();
		
		String mobile = s.getAttribute("mobile").toString();
		
		
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
	        "INSERT INTO blood.donorbloodrequest VALUES(id,?,?,?,?,?,?,?,?,?,?,?)");

	        ps.setString(1, bid);
	        ps.setString(2, patientname);
	        ps.setString(3, age);
	        ps.setString(4, hospital);
	        ps.setString(5, bloodgroup);
	        ps.setString(6, qty);
	        ps.setString(7, reason);
	       
	
	   

	        if (filePart != null && fileSize > 0) {
                filePart = request.getPart("file"); 
                ps.setBinaryStream(8, filePart.getInputStream(), (int) fileSize);
            } else {
                ps.setNull(8, java.sql.Types.BLOB);
            }
	        ps.setString(9, "requested");
	        
	        ps.setString(10, email);
	        
	        ps.setString(11, mobile);

	        ps.executeUpdate();

	        response.sendRedirect("donorviewbloodbank.jsp?success");
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
