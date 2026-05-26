<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="dbcon.Dbcon"%>
 <%
    if (session == null || session.getAttribute("donoremail") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BloodCare - Donor Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        :root {
            --primary: #c62828;
            --primary-dark: #8e0000;
            --primary-light: #ff5f52;
            --secondary: #2c3e50;
            --light: #f8f9fa;
            --gray: #e9ecef;
            --dark-gray: #6c757d;
        }

        body {
            background: linear-gradient(135deg, #f8d7d7 0%, #f0f4f8 100%);
            color: #333;
            min-height: 100vh;
        }

        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }

       
        .sidebar {
            width: 280px;
            background: linear-gradient(to bottom, var(--primary), var(--primary-dark));
            color: white;
            padding: 20px 0;
            box-shadow: 3px 0 15px rgba(0, 0, 0, 0.2);
            z-index: 100;
        }

        .logo {
            display: flex;
            align-items: center;
            padding: 0 20px 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            margin-bottom: 20px;
        }

        .logo i {
            font-size: 28px;
            margin-right: 10px;
        }

        .logo h1 {
            font-size: 22px;
            font-weight: 700;
        }

        .profile-section {
            padding: 0 20px 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            margin-bottom: 20px;
            text-align: center;
        }

        .profile-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            font-size: 30px;
            margin: 0 auto 15px;
            border: 3px solid white;
        }

        .profile-name {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .profile-blood-type {
            font-size: 14px;
            opacity: 0.9;
            background: rgba(255, 255, 255, 0.2);
            padding: 5px 15px;
            border-radius: 15px;
            display: inline-block;
            font-weight: 600;
        }

        .nav-links {
            list-style: none;
        }

        .nav-links li {
            margin-bottom: 5px;
        }

        .nav-links a {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            color: white;
            text-decoration: none;
            transition: all 0.3s;
            border-left: 4px solid transparent;
        }

        .nav-links a:hover, .nav-links a.active {
            background-color: rgba(255, 255, 255, 0.1);
            border-left: 4px solid white;
        }

        .nav-links i {
            margin-right: 10px;
            font-size: 18px;
            width: 24px;
            text-align: center;
        }

       
        .main-content {
            flex: 1;
            padding: 30px;
            overflow-y: auto;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><path fill="%23c62828" opacity="0.03" d="M50,15 C60,5 80,5 90,15 C100,25 100,45 90,55 C80,65 60,65 50,55 C40,65 20,65 10,55 C0,45 0,25 10,15 C20,5 40,5 50,15 Z"/></svg>');
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid var(--gray);
        }

        .welcome h2 {
            color: var(--secondary);
            font-size: 28px;
            margin-bottom: 8px;
            font-weight: 600;
        }

        .welcome p {
            color: var(--dark-gray);
            font-size: 16px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
            background: white;
            padding: 12px 20px;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
        }

        .user-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 20px;
        }

      
        .hero-section {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 40px;
            border-radius: 15px;
            margin-bottom: 30px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .hero-section::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><path fill="white" opacity="0.05" d="M50,15 C60,5 80,5 90,15 C100,25 100,45 90,55 C80,65 60,65 50,55 C40,65 20,65 10,55 C0,45 0,25 10,15 C20,5 40,5 50,15 Z"/></svg>');
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .hero-title {
            font-size: 32px;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .hero-subtitle {
            font-size: 18px;
            margin-bottom: 25px;
            opacity: 0.9;
        }

        .hero-stats {
            display: flex;
            justify-content: center;
            gap: 40px;
            margin-top: 30px;
        }

        .hero-stat {
            text-align: center;
        }

        .stat-number {
            font-size: 36px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 14px;
            opacity: 0.8;
        }

      
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            border-left: 5px solid var(--primary);
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        }

        .card-header {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .card-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 24px;
            background: rgba(198, 40, 40, 0.1);
            color: var(--primary);
        }

        .card-title {
            font-size: 18px;
            color: var(--secondary);
            margin-bottom: 8px;
            font-weight: 600;
        }

        .card-value {
            font-size: 32px;
            font-weight: 700;
            color: var(--secondary);
            margin-bottom: 10px;
        }

        .card-footer {
            font-size: 14px;
            color: var(--dark-gray);
            padding-top: 15px;
            border-top: 1px solid var(--gray);
        }

       
        .quick-actions {
            margin-bottom: 40px;
        }

        .section-title {
            font-size: 24px;
            color: var(--secondary);
            margin-bottom: 20px;
            font-weight: 600;
        }

        .action-buttons {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .action-btn {
            display: flex;
            align-items: center;
            padding: 20px;
            background: white;
            border-radius: 12px;
            text-decoration: none;
            color: var(--secondary);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .action-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            border-color: var(--primary);
            color: var(--primary);
        }

        .action-btn i {
            margin-right: 15px;
            font-size: 24px;
            color: var(--primary);
            width: 40px;
            text-align: center;
        }

        .action-text {
            flex: 1;
        }

        .action-title {
            font-weight: 600;
            margin-bottom: 5px;
            font-size: 16px;
        }

        .action-desc {
            font-size: 13px;
            color: var(--dark-gray);
        }

       
        .recent-activity {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        .activity-list {
            list-style: none;
        }

        .activity-item {
            display: flex;
            padding: 20px 0;
            border-bottom: 1px solid var(--gray);
            align-items: center;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 20px;
            font-size: 18px;
            background: rgba(198, 40, 40, 0.1);
            color: var(--primary);
        }

        .activity-details {
            flex: 1;
        }

        .activity-title {
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--secondary);
        }

        .activity-time {
            font-size: 13px;
            color: var(--dark-gray);
        }

        .activity-badge {
            background: var(--primary);
            color: white;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        
        @media (max-width: 1024px) {
            .dashboard-container {
                flex-direction: column;
            }
            
            .sidebar {
                width: 100%;
            }
            
            .nav-links {
                display: flex;
                overflow-x: auto;
                padding-bottom: 10px;
            }
            
            .nav-links li {
                flex-shrink: 0;
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 20px;
            }
            
            .header {
                flex-direction: column;
                gap: 20px;
                text-align: center;
            }
            
            .hero-stats {
                flex-direction: column;
                gap: 20px;
            }
            
            .dashboard-cards {
                grid-template-columns: 1fr;
            }
            
            .action-buttons {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<%
    String donorFullName="";
    String donorName = (String) session.getAttribute("email");

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    int requestCount = 0;

    try {
        con = Dbcon.create();

        String sql = "SELECT * FROM donorlist WHERE donor_email = ?";
        ps = con.prepareStatement(sql);
        ps.setString(1, donorName);

        rs = ps.executeQuery();
        while (rs.next()) {
            
           donorFullName = rs.getString(2);
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
%>

    
    <div class="dashboard-container">
        
        <div class="sidebar">
            <div class="logo">
                <i class="fas fa-tint"></i>
                <h1>LifeStream</h1>
            </div>
           
            <div class="profile-section">
                <div class="profile-avatar">
                    <i class="fas fa-user"></i>
                </div>
                <div class="profile-name"><%= donorFullName %></div>
            </div> 
            <ul class="nav-links">
                <li><a href="#" class="active"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="donorrequest.jsp"><i class="fas fa-hand-holding-heart"></i>Ask Blood</a></li>
                <li><a href="donorviewacceptance.jsp"><i class="fas fa-hospital"></i>View Acceptance Response</a></li>
                <li><a href="donorviewbloodbank.jsp"><i class="fas fa-clinic-medical"></i>View Blood Stock</a></li>
                <li><a href="viewrequestfromhospital.jsp"><i class="fas fa-hand-holding-heart"></i>Blood Required Patients</a></li>
                 <li><a href="donordonateblood.jsp"><i class="fas fa-hand-holding-heart"></i>Donate Blood</a></li>
                <li><a href="donorviewcamp.jsp"><i class="fas fa-clinic-medical"></i> Camp Details</a></li>
                <li><a href="certificate.jsp"><i class="fas fa-certificate"></i> View Certificate</a></li>
                <li><a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>
        
        <div class="main-content">
            <div class="header">
                <div class="welcome">
                    <h2>Welcome, <%= donorFullName %></h2>
                    <p>Thank you for being a life-saving blood donor!</p>
                </div>
                <div class="user-info">
                    <div class="user-avatar">
                        <i class="fas fa-user"></i>
                    </div>
                    <div>
                        <div><%= donorFullName %></div>
                    </div>
                </div>
            </div>
          
            <div class="hero-section">
                <div class="hero-content">
                    <h1 class="hero-title">Your Donation Saves Lives</h1>
                    <p class="hero-subtitle">Join thousands of heroes who donate blood and make a difference in someone's life</p>
                    
                </div>
            </div>

            
            <div class="quick-actions">
                <h3 class="section-title">Quick Actions</h3>
                <div class="action-buttons">
                    <a href="donorrequest.jsp" class="action-btn">
                        <i class="fas fa-hospital"></i>
                        <div class="action-text">
                            <div class="action-title">Ask Blood</div>
                            <div class="action-desc">Ask blood from hospitals</div>
                        </div>
                    </a>
                    <a href="donorviewacceptance.jsp" class="action-btn">
                        <i class="fas fa-hospital"></i>
                        <div class="action-text">
                            <div class="action-title">View Acceptance Response </div>
                            <div class="action-desc">View blood Response from hospitals who has accepted</div>
                        </div>
                    </a>
                    
                     <a href="donorviewbloodbank.jsp" class="action-btn">
                        <i class="fas fa-clinic-medical"></i>
                        <div class="action-text">
                            <div class="action-title">View Blood Stock</div>
                            <div class="action-desc">View all blood bank blood stocks</div>
                        </div>
                    </a>
                     <a href="viewrequestfromhospital.jsp" class="action-btn">
                        <i class="fas fa-hand-holding-heart"></i>
                        <div class="action-text">
                            <div class="action-title">Blood Required Patients</div>
                            <div class="action-desc">View emergency blood requests from hospitals</div>
                        </div>
                    </a>
                    <a href="donordonateblood.jsp" class="action-btn">
                        <i class="fas fa-hand-holding-heart"></i>
                        <div class="action-text">
                            <div class="action-title">Donate Blood</div>
                            <div class="action-desc">Schedule your next blood donation</div>
                        </div>
                    </a>
                     
                    
                    <a href="donorviewcamp.jsp" class="action-btn">
                        <i class="fas fa-clinic-medical"></i>
                        <div class="action-text">
                            <div class="action-title">Blood Donation Camps</div>
                            <div class="action-desc">Find donation camps based on locations</div>
                        </div>
                    </a>
                  
                    <a href="certificate.jsp" class="action-btn">
                        <i class="fas fa-certificate"></i>
                        <div class="action-text">
                            <div class="action-title">Donation Certificates</div>
                            <div class="action-desc">View and download your certificates</div>
                        </div>
                    </a>
                     <a href="donorviewbloodbankacceptance.jsp" class="action-btn">
                        <i class="fas fa-hospital"></i>
                        <div class="action-text">
                            <div class="action-title">View BloodBank Response </div>
                            <div class="action-desc">View blood Response from hospitals who has accepted</div>
                        </div>
                    </a>
                </div>
            </div>

         
    
        </div>
    </div>
    <script>
       
        document.addEventListener('DOMContentLoaded', function() {
            const navLinks = document.querySelectorAll('.nav-links a');
            navLinks.forEach(link => {
                link.addEventListener('click', function() {
                    navLinks.forEach(l => l.classList.remove('active'));
                    this.classList.add('active');
                });
            });
        });
        
        window.history.forward();
        function noBack() {
            window.history.forward();
        }
    </script>
     <body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
</body>
</html>