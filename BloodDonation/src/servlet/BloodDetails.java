package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbcon.Dbcon;


@WebServlet("/BloodDetails")
public class BloodDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public BloodDetails() {
        super();
       
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String donorName = request.getParameter("donorname");
        String bloodGroup = request.getParameter("bloodgroup");
        String quantityStr = request.getParameter("quantity");
        String dateStr = request.getParameter("date");
        String location = request.getParameter("location");
        
        
        if (donorName == null || donorName.trim().isEmpty() ||
            bloodGroup == null || bloodGroup.trim().isEmpty() ||
            quantityStr == null || quantityStr.trim().isEmpty() ||
            dateStr == null || dateStr.trim().isEmpty() ||
            location == null || location.trim().isEmpty()) {
            
            out.println("<html><body>");
            out.println("<h2 style='color:red;'>Error: All fields are required!</h2>");
            out.println("<a href='bloodbankdashboard.jsp'>Go Back</a>");
            out.println("</body></html>");
            return;
        }
        
        int quantity;
        try {
            quantity = Integer.parseInt(quantityStr);
            if (quantity <= 0) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            out.println("<html><body>");
            out.println("<h2 style='color:red;'>Error: Quantity must be a positive number!</h2>");
            out.println("<a href='bloodbankdashboard.jsp'>Go Back</a>");
            out.println("</body></html>");
            return;
        }
        
        
        Date donationDate = null;
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			donationDate = dateFormat.parse(dateStr);
		} catch (java.text.ParseException e) {
			
			e.printStackTrace();
		}
        
        
        Connection con = null;
        try {
        	
        	HttpSession session= request.getSession();
        	
        	String bid=session.getAttribute("bloodbankId").toString();
        	String email=session.getAttribute("email").toString();
        	
        	
             final String INSERT_BLOOD_SQL = 
                    "INSERT INTO blooddetails VALUES (id, ?, ?, ?, ?, ?, ?, ?);";
            con=Dbcon.create();
            PreparedStatement preparedStatement = con.prepareStatement(INSERT_BLOOD_SQL);
            preparedStatement.setString(1, donorName);
            preparedStatement.setString(2, bloodGroup);
            preparedStatement.setInt(3, quantity);
            preparedStatement.setDate(4, new java.sql.Date(donationDate.getTime()));
            preparedStatement.setString(5, location);
            preparedStatement.setString(6, bid);
            preparedStatement.setString(7, email);
            
            int result = preparedStatement.executeUpdate();
            
            if (result > 0) {
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Success</title>");
                out.println("<style>");
                out.println("body { font-family: Arial, sans-serif; background-color: #f5f5f5; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }");
                out.println(".success-box { background-color: white; padding: 30px; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); text-align: center; max-width: 500px; }");
                out.println(".success-icon { color: #4CAF50; font-size: 48px; margin-bottom: 20px; }");
                out.println("h2 { color: #333; margin-bottom: 15px; }");
                out.println(".btn { display: inline-block; background-color: #c8102e; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; margin-top: 15px; }");
                out.println("</style>");
                out.println("</head>");
                out.println("<body>");
                out.println("<div class='success-box'>");
               
                out.println("<h2>Blood Donation Record Added Successfully!</h2>");
                out.println("<p><strong>Donor Name:</strong> " + donorName + "</p>");
                out.println("<p><strong>Blood Group:</strong> " + bloodGroup + "</p>");
                out.println("<p><strong>Quantity:</strong> " + quantity + " ml</p>");
                out.println("<p><strong>Donation Date:</strong> " + dateStr + "</p>");
                out.println("<p><strong>Location:</strong> " + location + "</p>");
                out.println("<a href='updatebloodstcok.jsp' class='btn'>Add Another Donation</a>");
                out.println("</div>");
                out.println("</body>");
                out.println("</html>");
            } else {
                throw new SQLException("Failed to insert blood details");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<html><body>");
            out.println("<h2 style='color:red;'>Error: Database error occurred!</h2>");
            out.println("<p>" + e.getMessage() + "</p>");
            out.println("<a href='bloodbankdashboard.jsp'>Go Back</a>");
            out.println("</body></html>");
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
	}

}
