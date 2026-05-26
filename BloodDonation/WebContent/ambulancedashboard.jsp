<%@page import="dbcon.Dbcon"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
 <%
    if (session == null || session.getAttribute("ambulanceEmail") == null) {
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
    <title>Ambulance Dispatch Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-blue: #1a73e8;
            --secondary-blue: #4285f4;
            --light-blue: #e8f0fe;
            --dark-blue: #0d47a1;
            --accent-red: #ea4335;
            --accent-green: #34a853;
            --accent-amber: #fbbc05;
            --text-dark: #202124;
            --text-light: #5f6368;
            --border-color: #dadce0;
            --white: #ffffff;
            --card-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            --hover-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
            --gradient-primary: linear-gradient(135deg, #1a73e8 0%, #0d47a1 100%);
            --gradient-secondary: linear-gradient(135deg, #4285f4 0%, #1a73e8 100%);
            --gradient-green: linear-gradient(135deg, #34a853 0%, #2e7d32 100%);
            --gradient-red: linear-gradient(135deg, #ea4335 0%, #c62828 100%);
            --gradient-amber: linear-gradient(135deg, #fbbc05 0%, #ff8f00 100%);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            color: var(--text-dark);
            min-height: 100vh;
            display: flex;
        }
        
        .container {
            display: flex;
            width: 100%;
        }
        
 
        .sidebar {
            width: 260px;
            background: var(--gradient-primary);
            color: var(--white);
            height: 100vh;
            position: fixed;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            z-index: 100;
            transition: all 0.3s ease;
        }
        
        .logo {
            padding: 25px 20px;
            display: flex;
            align-items: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .logo i {
            font-size: 28px;
            margin-right: 12px;
            background: rgba(255, 255, 255, 0.2);
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
        }
        
        .logo h1 {
            font-size: 20px;
            font-weight: 600;
        }
        
        .nav-links {
            padding: 20px 0;
        }
        
        .nav-item {
            padding: 14px 25px;
            display: flex;
            align-items: center;
            cursor: pointer;
            transition: all 0.3s;
            border-left: 4px solid transparent;
            margin: 5px 10px;
            border-radius: 8px;
        }
        
        .nav-item.active {
            background-color: rgba(255, 255, 255, 0.15);
            border-left: 4px solid var(--accent-green);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .nav-item:hover {
            background-color: rgba(255, 255, 255, 0.1);
            transform: translateX(5px);
        }
        
        .nav-item i {
            font-size: 18px;
            margin-right: 15px;
            width: 24px;
            text-align: center;
        }
        
        .nav-item span {
            font-size: 15px;
            font-weight: 500;
        }
        
       
        .main-content {
            flex: 1;
            margin-left: 260px;
            padding: 25px;
            transition: margin-left 0.3s ease;
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            background: var(--white);
            padding: 20px 25px;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
        }
        
        .header h2 {
            font-size: 24px;
            font-weight: 600;
            color: var(--dark-blue);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .header h2::before {
            content: "";
            display: block;
            width: 4px;
            height: 24px;
            background: var(--gradient-primary);
            border-radius: 4px;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .user-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: var(--gradient-secondary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
   
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: var(--white);
            border-radius: 12px;
            padding: 20px;
            box-shadow: var(--card-shadow);
            display: flex;
            align-items: center;
            transition: transform 0.3s, box-shadow 0.3s;
            position: relative;
            overflow: hidden;
        }
        
        .stat-card::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
        }
        
        .stat-card.pending::before {
            background: var(--gradient-amber);
        }
        
        .stat-card.accepted::before {
            background: var(--gradient-green);
        }
        
        .stat-card.completed::before {
            background: var(--gradient-secondary);
        }
        
        .stat-card.rejected::before {
            background: var(--gradient-red);
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }
        
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 24px;
        }
        
        .pending .stat-icon {
            background: var(--gradient-amber);
            color: white;
            box-shadow: 0 4px 10px rgba(251, 188, 5, 0.3);
        }
        
        .accepted .stat-icon {
            background: var(--gradient-green);
            color: white;
            box-shadow: 0 4px 10px rgba(52, 168, 83, 0.3);
        }
        
        .completed .stat-icon {
            background: var(--gradient-secondary);
            color: white;
            box-shadow: 0 4px 10px rgba(26, 115, 232, 0.3);
        }
        
        .rejected .stat-icon {
            background: var(--gradient-red);
            color: white;
            box-shadow: 0 4px 10px rgba(234, 67, 53, 0.3);
        }
        
        .stat-info h3 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 5px;
        }
        
        .stat-info p {
            color: var(--text-light);
            font-size: 14px;
        }
        
      
        .dashboard-layout {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 25px;
            margin-bottom: 30px;
        }
        
        
        .about-section {
            background: var(--white);
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            padding: 25px;
            position: relative;
            overflow: hidden;
        }
        
        .about-section::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--gradient-primary);
        }
        
        .about-header {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .about-header i {
            font-size: 24px;
            color: var(--primary-blue);
            margin-right: 12px;
            background: var(--light-blue);
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
        }
        
        .about-header h3 {
            font-size: 18px;
            font-weight: 600;
            color: var(--dark-blue);
        }
        
        .about-content {
            color: var(--text-light);
            line-height: 1.6;
        }
        
        .about-content p {
            margin-bottom: 15px;
        }
        
        .features {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-top: 20px;
        }
        
        .feature {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px;
            border-radius: 8px;
            transition: background 0.3s;
        }
        
        .feature:hover {
            background: var(--light-blue);
        }
        
        .feature i {
            color: var(--accent-green);
            font-size: 16px;
            background: rgba(52, 168, 83, 0.1);
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }
        
      
        .quick-actions {
            background: var(--white);
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            padding: 25px;
            position: relative;
            overflow: hidden;
        }
        
        .quick-actions::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--gradient-amber);
        }
        
        .actions-header {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .actions-header i {
            font-size: 24px;
            color: var(--primary-blue);
            margin-right: 12px;
            background: var(--light-blue);
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
        }
        
        .actions-header h3 {
            font-size: 18px;
            font-weight: 600;
            color: var(--dark-blue);
        }
        
        .action-buttons-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 15px;
        }
        
        .action-btn {
            display: flex;
            align-items: center;
            padding: 15px;
            background: var(--light-blue);
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
            width: 100%;
            text-align: left;
            position: relative;
            overflow: hidden;
        }
        
        .action-btn::before {
            content: "";
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            transition: left 0.5s;
        }
        
        .action-btn:hover::before {
            left: 100%;
        }
        
        .action-btn:hover {
            background: var(--primary-blue);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .action-btn i {
            font-size: 20px;
            margin-right: 12px;
            width: 24px;
            text-align: center;
        }
        
        
        .dashboard-card {
            background: var(--white);
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
            margin-bottom: 30px;
            position: relative;
        }
        
        .dashboard-card::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--gradient-primary);
        }
        
        .card-header {
            padding: 20px 25px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .card-header h3 {
            font-size: 18px;
            font-weight: 600;
            color: var(--dark-blue);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .card-header h3::before {
            content: "";
            display: block;
            width: 4px;
            height: 20px;
            background: var(--gradient-primary);
            border-radius: 4px;
        }
        
        .view-all {
            color: var(--primary-blue);
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: all 0.3s;
        }
        
        .view-all:hover {
            gap: 8px;
        }
        
        .table-container {
            overflow-x: auto;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        thead {
            background-color: var(--light-blue);
        }
        
        th {
            padding: 16px 20px;
            text-align: left;
            color: var(--primary-blue);
            font-weight: 600;
            font-size: 14px;
        }
        
        td {
            padding: 16px 20px;
            border-bottom: 1px solid var(--border-color);
            font-size: 14px;
        }
        
        tr:last-child td {
            border-bottom: none;
        }
        
        tr:hover {
            background-color: #f9fafb;
        }
        
        .status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
            display: inline-block;
        }
        
        .status-pending {
            background-color: #fff8e1;
            color: #ff8f00;
        }
        
        .status-accepted {
            background-color: #e8f5e9;
            color: var(--accent-green);
        }
        
        .status-rejected {
            background-color: #ffebee;
            color: var(--accent-red);
        }
        
        .action-buttons {
            display: flex;
            gap: 8px;
        }
        
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s;
            font-size: 13px;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .btn-accept {
            background: var(--gradient-green);
            color: var(--white);
            box-shadow: 0 2px 5px rgba(52, 168, 83, 0.3);
        }
        
        .btn-reject {
            background: var(--gradient-red);
            color: var(--white);
            box-shadow: 0 2px 5px rgba(234, 67, 53, 0.3);
        }
        
        .btn:hover {
            opacity: 0.9;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        
        .priority-high {
            position: relative;
        }
        
        .priority-high::before {
            content: "";
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 4px;
            background-color: var(--accent-red);
        }
        
        .priority-medium {
            position: relative;
        }
        
        .priority-medium::before {
            content: "";
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 4px;
            background-color: var(--accent-amber);
        }
        
       
        .map-container {
            background: var(--white);
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            padding: 20px;
            margin-bottom: 30px;
            position: relative;
        }
        
        .map-container::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--gradient-green);
        }
        
        .map-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .map-header h3 {
            font-size: 18px;
            font-weight: 600;
            color: var(--dark-blue);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .map-header h3::before {
            content: "";
            display: block;
            width: 4px;
            height: 20px;
            background: var(--gradient-green);
            border-radius: 4px;
        }
        
        .map-placeholder {
            height: 300px;
            background: linear-gradient(135deg, #a8c6f0 0%, #c2d6f5 100%);
            border-radius: 8px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: var(--dark-blue);
            position: relative;
            overflow: hidden;
        }
        
        .map-placeholder::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><rect width="100" height="100" fill="none" stroke="%231a73e8" stroke-width="0.5"/></svg>');
            opacity: 0.2;
        }
        
        .map-placeholder i {
            font-size: 48px;
            margin-bottom: 15px;
            z-index: 1;
        }
        
        .map-placeholder p {
            z-index: 1;
            font-weight: 500;
        }
        
    
        @media (max-width: 992px) {
            .sidebar {
                width: 80px;
            }
            
            .logo h1, .nav-item span {
                display: none;
            }
            
            .nav-item {
                justify-content: center;
                padding: 18px 0;
            }
            
            .nav-item i {
                margin-right: 0;
            }
            
            .main-content {
                margin-left: 80px;
            }
            
            .dashboard-layout {
                grid-template-columns: 1fr;
            }
        }
        
        @media (max-width: 768px) {
            .stats-container {
                grid-template-columns: 1fr 1fr;
            }
            
            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .features {
                grid-template-columns: 1fr;
            }
        }
        
        @media (max-width: 576px) {
            .stats-container {
                grid-template-columns: 1fr;
            }
            
            .main-content {
                padding: 15px;
            }
            
            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>

<%
   
    Connection con = Dbcon.create();

    PreparedStatement ps = con.prepareStatement("SELECT * FROM patient WHERE status=? AND ambstatus=? ORDER BY id DESC");
   
    ps.setString(1, "Allocate");
    ps.setString(2, "");
    ResultSet rs = ps.executeQuery();

    int pendingrequestsCount = 0;
   

    java.util.ArrayList<String[]> rows = new java.util.ArrayList<>();

    while(rs.next()){
    	pendingrequestsCount++;

        String status = rs.getString("status");

      
        rows.add(new String[]{
            rs.getString(12),  
            rs.getString(13),  
            rs.getString(8),  
            rs.getString(4),   
            rs.getString(5),   
            status,
            rs.getString("id")
        });
    }
    
%>

<%
    
   

    PreparedStatement ps1 = con.prepareStatement("SELECT * FROM patient WHERE AND status=? AND ambstatus=? ORDER BY id DESC");
   
    ps1.setString(1, "Allocate");
    ps1.setString(2, "Accepted");
    
    ResultSet rs1 = ps.executeQuery();

    int acceptedtotalCount = 0;
   

    java.util.ArrayList<String[]> rows1 = new java.util.ArrayList<>();

    while(rs1.next()){
    	acceptedtotalCount++;

        String status = rs.getString("status");
        String ambstatus = rs.getString("ambstatus");

      
    }
    con.close();
%>


    <div class="container">
       
        <div class="sidebar">
            <div class="logo">
                <i class="fas fa-ambulance"></i>
                <h1>LifeStream Ambulance</h1>
            </div>
            <div class="nav-links">
                <div class="nav-item active">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </div>
                <div class="nav-item">
                    <i class="fas fa-hospital"></i>
                    <a style="text-decoration: none; color: white;" href="ambuancemainpage.jsp"><span>Hospital Requests</span></a>
                </div>       
                <div class="nav-item">
                    <i class="fas fa-history"></i>
                    <a style="text-decoration: none; color: white;" href="ambuancehistorypage.jsp"><span>History</span></a>
                </div>
                <div class="nav-item">
                   <i class="fas fa-right-from-bracket"></i>
                    <a style="text-decoration: none; color: white;" href="logout.jsp"><span>Logout</span></a>
                </div>
            </div>
        </div>
        
        
        <div class="main-content">
            <div class="header">
                <h2>LifeStream Ambulance Dashboard</h2>
                <div class="user-info">
                    <div class="user-avatar">AD</div>
                </div>
            </div>
            
           
            <div class="stats-container">
                <div class="stat-card pending">
                    <div class="stat-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="stat-info">
                        <h3><%= pendingrequestsCount %></h3>
                        <p>Pending Requests</p>
                    </div>
                </div>
                <div class="stat-card accepted">
                    <div class="stat-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="stat-info">
                        <h3><%= acceptedtotalCount %></h3>
                        <p>Accepted Requests</p>
                    </div>
                </div>
               <!--  <div class="stat-card completed">
                    <div class="stat-icon">
                        <i class="fas fa-flag-checkered"></i>
                    </div>
                    <div class="stat-info">
                        <h3>24</h3>
                        <p>Completed Today</p>
                    </div>
                </div>
                <div class="stat-card rejected">
                    <div class="stat-icon">
                        <i class="fas fa-times-circle"></i>
                    </div>
                    <div class="stat-info">
                        <h3>3</h3>
                        <p>Rejected Requests</p>
                    </div>
                </div> -->
            </div>
            
           
            <div class="dashboard-layout">
                
                <div class="about-section">
                    <div class="about-header">
                        <i class="fas fa-info-circle"></i>
                        <h3>About Our Service</h3>
                    </div>
                    <div class="about-content">
                        <p>Our Ambulance Dispatch System is a state-of-the-art platform designed to streamline emergency medical response and coordination between hospitals, ambulance services, and patients.</p>
                        <p>We provide efficient resource allocation, and seamless communication to ensure timely medical assistance when it matters most.</p>
                        
                        <div class="features">
                       
                            <div class="feature">
                                <i class="fas fa-user-md"></i>
                                <span>Medical Team Coordination</span>
                            </div>
                            <div class="feature">
                                <i class="fas fa-chart-line"></i>
                                <span>Performance Analytics</span>
                            </div>
                        </div>
                    </div>
                </div>
                
               
                <div class="quick-actions">
                    <div class="actions-header">
                        <i class="fas fa-bolt"></i>
                        <h3>Quick Actions</h3>
                    </div>
                    <div class="action-buttons-grid">
                        <button class="action-btn">
                            <i class="fas fa-hospital"></i>
                            <a style="text-decoration: none; color: inherit;" href="ambuancemainpage.jsp"><span>Hospital Requests</span></a>
                        </button>
                        <button class="action-btn">
                            <i class="fas fa-history"></i>
                            <a style="text-decoration: none; color: inherit;" href="ambuancehistorypage.jsp"><span>History</span></a>
                        </button>
                        <button class="action-btn">
                            <i class="fas fa-right-from-bracket"></i>
                            <a style="text-decoration: none; color: inherit;" href="index.jsp"><span>Logout</span></a>
                        </button>
                    </div>
                </div>
            </div>
          
            
            
        </div>
    </div>

    <script>
        
        document.addEventListener('DOMContentLoaded', function() {
           
            const statCards = document.querySelectorAll('.stat-card');
            statCards.forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-5px)';
                });
                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                });
            });
            
            
            const actionButtons = document.querySelectorAll('.action-btn');
            actionButtons.forEach(button => {
                button.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-2px)';
                });
                button.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
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