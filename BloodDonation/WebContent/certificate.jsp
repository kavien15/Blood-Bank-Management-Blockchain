<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="dbcon.Dbcon"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Blood Donation Certificate</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Montserrat:wght@300;400;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
<style>
    :root {
        --primary: #c62828;
        --primary-dark: #8e0000;
        --primary-light: #ff5f52;
        --secondary: #2c3e50;
        --light: #f8f9fa;
        --gray: #e9ecef;
        --dark-gray: #6c757d;
        --gold: #d4af37;
        --silver: #c0c0c0;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        font-family: 'Montserrat', sans-serif;
        color: var(--secondary);
        min-height: 100vh;
        display: flex;
        flex-direction: column;
        align-items: center;
        padding: 2rem;
        position: relative;
    }

    
    .action-buttons {
        display: flex;
        gap: 15px;
        margin-bottom: 2rem;
        align-self: flex-start;
        position: absolute;
        top: 20px;
        left: 20px;
        z-index: 10;
    }

    .btn {
        background: var(--secondary);
        color: var(--light);
        border: none;
        padding: 12px 25px;
        border-radius: 8px;
        cursor: pointer;
        font-weight: 600;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 10px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        font-size: 14px;
    }

    .btn:hover {
        background: #1a252f;
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(0,0,0,0.15);
    }

    .btn-print {
        background: var(--primary);
    }

    .btn-download {
        background: var(--primary-dark);
    }

   
    .certificate-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 100%;
        max-width: 900px;
    }

    
    .cert {
        border: 20px solid transparent;
        width: 100%;
        max-width: 800px;
        font-family: 'Playfair Display', serif;
        color: var(--secondary);
        background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
        box-shadow: 
            0 10px 30px rgba(0,0,0,0.1),
            0 0 0 1px rgba(255,255,255,0.8),
            inset 0 0 50px rgba(198, 40, 40, 0.05);
        position: relative;
        overflow: hidden;
        margin: 2rem 0;
        border-radius: 5px;
    }

    .cert::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: 
            radial-gradient(circle at 20% 80%, rgba(198, 40, 40, 0.05) 0%, transparent 50%),
            radial-gradient(circle at 80% 20%, rgba(198, 40, 40, 0.05) 0%, transparent 50%),
            radial-gradient(circle at 40% 40%, rgba(255, 255, 255, 0.8) 0%, transparent 50%);
        pointer-events: none;
    }

    .cert::after {
        content: '';
        position: absolute;
        top: 20px;
        left: 20px;
        right: 20px;
        bottom: 20px;
        border: 2px solid rgba(198, 40, 40, 0.1);
        pointer-events: none;
    }

    .crt_logo {
        padding: 2rem 0 1rem;
        text-align: center;
        position: relative;
    }

    .crt_logo::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 200px;
        height: 2px;
        background: linear-gradient(90deg, transparent, var(--primary), transparent);
    }

    .crt_logo img {
        width: 150px;
        height: auto;
        filter: drop-shadow(0 5px 15px rgba(0,0,0,0.1));
    }

    .crt_title {
        margin-top: 1.5rem;
        font-family: 'Playfair Display', serif;
        font-size: 3rem;
        letter-spacing: 3px;
        color: var(--primary);
        text-align: center;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        position: relative;
        margin-bottom: 2rem;
    }

    .cert-subtitle {
        font-family: 'Montserrat', sans-serif;
        font-size: 1.2rem;
        color: var(--dark-gray);
        text-align: center;
        margin-bottom: 2rem;
        font-weight: 300;
        letter-spacing: 2px;
    }

    .colorGreen {
        color: var(--primary);
        text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
    }

    .crt_user {
        display: inline-block;
        width: 80%;
        padding: 1rem 2rem;
        margin: 1.5rem 0;
        font-family: 'Playfair Display', serif;
        font-size: 3.5rem;
        border-bottom: 2px dashed rgba(198, 40, 40, 0.3);
        text-align: center;
        color: var(--primary-dark);
        position: relative;
    }

    .afterName {
        font-weight: 300;
        color: var(--dark-gray);
        font-size: 1.3rem;
        text-align: center;
        margin: 1rem 0;
        font-family: 'Montserrat', sans-serif;
    }

    .donation-type {
        font-size: 1.5rem;
        color: var(--primary);
        text-align: center;
        margin: 1rem 0;
        font-weight: 600;
        font-family: 'Playfair Display', serif;
    }

    .colorGrey {
        color: var(--dark-gray);
    }

    .certSign {
        width: 180px;
        margin: 1rem 0;
        filter: drop-shadow(0 3px 6px rgba(0,0,0,0.1));
    }

    .signature-section {
        margin: 2rem 0;
        text-align: center;
        position: relative;
    }

    .signature-section::before {
        content: '';
        position: absolute;
        top: -10px;
        left: 50%;
        transform: translateX(-50%);
        width: 150px;
        height: 1px;
        background: linear-gradient(90deg, transparent, var(--primary), transparent);
    }

    .hospital-name {
        font-size: 1.3rem;
        color: var(--primary-dark);
        margin: 0.5rem 0;
        font-weight: 600;
    }

    .success-text {
        font-size: 1.1rem;
        color: var(--primary);
        margin: 0.5rem 0;
        font-weight: 500;
        letter-spacing: 1px;
    }

    .certificate-footer {
        margin-top: 2rem;
        padding: 1rem;
        text-align: center;
        font-size: 0.9rem;
        color: var(--dark-gray);
        border-top: 1px solid rgba(198, 40, 40, 0.1);
        font-family: 'Montserrat', sans-serif;
    }

    .certificate-id {
        font-size: 0.8rem;
        color: var(--dark-gray);
        text-align: right;
        padding: 0 2rem 1rem;
        font-family: 'Montserrat', sans-serif;
    }

 
    .corner-decoration {
        position: absolute;
        width: 80px;
        height: 80px;
        border: 2px solid var(--primary-light);
        opacity: 0.3;
    }

    .corner-tl {
        top: 20px;
        left: 20px;
        border-right: none;
        border-bottom: none;
    }

    .corner-tr {
        top: 20px;
        right: 20px;
        border-left: none;
        border-bottom: none;
    }

    .corner-bl {
        bottom: 20px;
        left: 20px;
        border-right: none;
        border-top: none;
    }

    .corner-br {
        bottom: 20px;
        right: 20px;
        border-left: none;
        border-top: none;
    }

   
    @media print {
        body {
            background: white;
            padding: 0;
        }
        
        .action-buttons {
            display: none;
        }
        
        .cert {
            box-shadow: none;
            border: 15px solid #c62828;
            margin: 0;
        }
    }

    
    @media (max-width: 768px) {
        .cert {
            max-width: 95%;
            border-width: 10px;
        }
        
        .crt_title {
            font-size: 2.2rem;
        }
        
        .crt_user {
            font-size: 2.5rem;
            width: 90%;
        }
        
        .action-buttons {
            position: relative;
            top: 0;
            left: 0;
            align-self: center;
            margin-bottom: 1rem;
            flex-direction: column;
            width: 100%;
        }
        
        .btn {
            width: 100%;
            justify-content: center;
        }
        
        body {
            padding: 1rem;
        }
    }

    @media (max-width: 480px) {
        .crt_title {
            font-size: 1.8rem;
        }
        
        .crt_user {
            font-size: 2rem;
        }
        
        .crt_logo img {
            width: 120px;
        }
    }
</style>
</head>
<body>
   
    <div class="action-buttons">
        <a href="javascript:history.back()" class="btn">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
        <button class="btn btn-print" onclick="printCertificate()">
            <i class="fas fa-print"></i> Print Certificate
        </button>
        <button class="btn btn-download" onclick="downloadPDF()">
            <i class="fas fa-download"></i> Download as PDF
        </button>
    </div>

    <%
    String mail=session.getAttribute("email").toString();
    System.out.println(mail);
    
    Connection con= Dbcon.create();
    

    PreparedStatement ps=con.prepareStatement("SELECT * FROM `blood`.`certificate` where dmail='"+mail+"'");
         
         ResultSet rs=ps.executeQuery();
         
         while(rs.next())
         {
    %>

    <div class="certificate-container" id="certificate-content">
        <table class="cert" cellpadding="20">
           
            <div class="corner-decoration corner-tl"></div>
            <div class="corner-decoration corner-tr"></div>
            <div class="corner-decoration corner-bl"></div>
            <div class="corner-decoration corner-br"></div>
            
           
            <div class="certificate-id">
                Certificate ID: <%=rs.getString(1) != null ? rs.getString(1) : "N/A" %>
            </div>
            
            <tr>
                <td align="center" class="crt_logo">
                    <img src="image/logo.jpg" alt="Blood Bank Logo">
                </td>
            </tr>
            
            <tr>
                <td align="center">
                    <h1 class="crt_title">Certificate of Appreciation</h1>
                    <div class="cert-subtitle">This certificate is proudly presented to</div>
                    <h1 class="colorGreen crt_user"><%=rs.getString(2) %></h1>
                    <div class="afterName">In recognition of your selfless contribution through</div>
                    <div class="donation-type"><%=rs.getString(8)%> Donation</div>
                    <div class="afterName">Your generous act of donating blood/plasma has made a significant impact<br>and helped save lives in our community.</div>
                </td>
            </tr>
            
            <tr>
                <td align="center" class="signature-section">
                    <div class="hospital-name"><%=rs.getString(5)%></div>
                    <div class="success-text">Donated Successfully</div>
                    <div class="colorGrey">On <%=rs.getString(7) != null ? rs.getString(7) : "N/A" %></div>
                </td>
            </tr>
            
            <tr>
                <td class="certificate-footer">
                    This certificate acknowledges your humanitarian contribution to the Blood Bank.<br>
                    Your donation has potentially saved up to three lives.
                </td>
            </tr>
        </table>
    </div>
    <%} %>
    
    <script>
        
        function printCertificate() {
            window.print();
        }
        
       
        function downloadPDF() {
            const element = document.getElementById('certificate-content');
            const options = {
                margin: 10,
                filename: 'Blood_Donation_Certificate.pdf',
                image: { type: 'jpeg', quality: 0.98 },
                html2canvas: { scale: 2 },
                jsPDF: { unit: 'mm', format: 'a4', orientation: 'portrait' }
            };
            
            html2pdf().set(options).from(element).save();
        }
    </script>
</body>
</html>