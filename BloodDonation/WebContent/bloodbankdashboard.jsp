<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="dbcon.Dbcon" %>
<%
    if (session == null || session.getAttribute("bloodbankEmail") == null) {
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
    <title>LifeStream Blood Bank Management System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        :root {
            --primary: rgba(198, 40, 40, 0.9);
            --primary-dark: rgba(142, 0, 0, 0.9);
            --primary-light: rgba(255, 95, 82, 0.7);
            --secondary: #2c3e50;
            --light: #f8f9fa;
            --dark: #343a40;
            --success: #28a745;
            --warning: #ffc107;
            --danger: #dc3545;
            --info: #17a2b8;
            --card-bg: rgba(255, 255, 255, 0.95);
            --glass-bg: rgba(255, 255, 255, 0.2);
            --glass-border: rgba(255, 255, 255, 0.3);
        }

        body {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            color: var(--dark);
            line-height: 1.6;
            min-height: 100vh;
        }

        
        .header {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            padding: 1rem 2rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
            backdrop-filter: blur(10px);
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo i {
            font-size: 2.2rem;
            filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.2));
        }

        .logo h1 {
            font-size: 1.8rem;
            font-weight: 700;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .nav-menu {
            display: flex;
            gap: 10px;
        }

        .nav-btn {
            padding: 12px 25px;
            background: var(--glass-bg);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
            border: 1px solid var(--glass-border);
            backdrop-filter: blur(5px);
        }

        .nav-btn:hover, .nav-btn.active {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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
            background: rgba(255, 255, 255, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 1.2rem;
            border: 1px solid var(--glass-border);
            backdrop-filter: blur(5px);
        }

       
        .main-content {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .page-header {
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid rgba(0, 0, 0, 0.1);
        }

        .page-title {
            font-size: 2.2rem;
            color: var(--primary);
            font-weight: 700;
            margin-bottom: 0.5rem;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
        }

        .page-subtitle {
            font-size: 1.1rem;
            color: var(--secondary);
        }

        
        .dashboard-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 3rem;
        }

        .stat-card {
            background: var(--card-bg);
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s, box-shadow 0.3s;
            border-top: 4px solid var(--primary);
            backdrop-filter: blur(5px);
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(198, 40, 40, 0.05) 0%, rgba(142, 0, 0, 0.05) 100%);
            z-index: -1;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
        }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .stat-title {
            font-size: 1rem;
            color: #6c757d;
            font-weight: 500;
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            background: var(--primary);
            font-size: 1.5rem;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .stat-value {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 10px;
            color: var(--dark);
        }

        .stat-change {
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .positive {
            color: var(--success);
        }

        .negative {
            color: var(--danger);
        }

        
        .blood-stock-overview {
            background: var(--card-bg);
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            margin-bottom: 30px;
            backdrop-filter: blur(5px);
        }

        .section-title {
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--secondary);
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }

        .blood-groups-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 20px;
        }

        .blood-group-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s;
            border-top: 4px solid;
        }

        .blood-group-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .blood-group-A { border-color: #e74c3c; }
        .blood-group-B { border-color: #3498db; }
        .blood-group-AB { border-color: #9b59b6; }
        .blood-group-O { border-color: #2ecc71; }
        .blood-group-Ap { border-color: #e67e22; }
        .blood-group-Bp { border-color: #1abc9c; }
        .blood-group-ABp { border-color: #34495e; }
        .blood-group-Op { border-color: #f39c12; }

        .blood-group-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 10px;
            color: var(--dark);
        }

        .blood-group-units {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .blood-group-status {
            font-size: 0.85rem;
            padding: 4px 10px;
            border-radius: 20px;
            display: inline-block;
        }

        .status-available {
            background: #d4edda;
            color: #155724;
        }

        .status-low {
            background: #fff3cd;
            color: #856404;
        }

        .status-critical {
            background: #f8d7da;
            color: #721c24;
        }

       
        .recent-activity {
            background: var(--card-bg);
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            margin-bottom: 30px;
            backdrop-filter: blur(5px);
        }

        .activity-list {
            list-style: none;
        }

        .activity-item {
            display: flex;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: white;
            background: var(--primary);
        }

        .activity-content {
            flex: 1;
        }

        .activity-title {
            font-weight: 500;
            margin-bottom: 5px;
        }

        .activity-time {
            font-size: 0.85rem;
            color: #6c757d;
        }

        
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .action-card {
            background: var(--card-bg);
            border-radius: 12px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s, box-shadow 0.3s;
            backdrop-filter: blur(5px);
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
            background: linear-gradient(135deg, var(--card-bg) 0%, rgba(255, 255, 255, 1) 100%);
        }

.blood-group-percentage {
    font-size: 0.85rem;
    color: #666;
    margin-bottom: 8px;
    font-weight: 500;
    background: rgba(255, 255, 255, 0.7);
    padding: 3px 8px;
    border-radius: 12px;
    display: inline-block;
}
        .action-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            color: white;
            background: var(--primary);
            font-size: 1.5rem;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .action-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 10px;
            color: var(--dark);
        }

        .action-desc {
            font-size: 0.9rem;
            color: #6c757d;
            margin-bottom: 15px;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 6px;
            border: none;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        
        .page {
            display: none;
        }

        .page.active {
            display: block;
        }

      
        @media (max-width: 992px) {
            .header-content {
                flex-direction: column;
                gap: 15px;
            }
            
            .nav-menu {
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .dashboard-stats {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .form-row {
                flex-direction: column;
                gap: 0;
            }
            
            .table-header {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }
            
            .nav-btn {
                padding: 10px 15px;
                font-size: 0.9rem;
            }
            
            .blood-groups-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .quick-actions {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    
    <div class="header">
        <div class="header-content">
            <div class="logo">
                <i class="fas fa-tint"></i>
                <h1>LifeStream Blood Bank</h1>
            </div>
            
            <div class="nav-menu">
                <a href="#" class="nav-btn active" data-page="dashboard">
                    <i class="fas fa-home"></i>
                    <span>Dashboard</span>
                </a>
                <a href="viewrequestbloodbank.jsp" class="nav-btn" data-page="view-blood-requests">
                    <i class="fas fa-hand-holding-medical"></i>
                    <span>Blood Requests</span>
                </a>
                <a href="updatebloodstcok.jsp" class="nav-btn" data-page="update-blood-details">
                    <i class="fas fa-edit"></i>
                    <span>Add Blood</span>
                </a>
                <a href="viewbloodstock.jsp" class="nav-btn" data-page="view-blood-details">
                    <i class="fas fa-box"></i>
                    <span>Blood Stock</span>
                </a>
                 <a href="logout.jsp" class="nav-btn" data-page="view-blood-details">
                    <i class="fas fa-Logout"></i>
                    <span>Logout</span>
                </a>
            </div>
            
           
        </div>
    </div>

    
    <div class="main-content">
       
        <div id="dashboard-page" class="page active">
            <div class="page-header">
                <h1 class="page-title">Blood Bank Dashboard</h1>
                <p class="page-subtitle">Manage blood inventory and save lives efficiently</p>
            </div>

            
           
            <div class="quick-actions">
                <div class="action-card">
                    <div class="action-icon">
                        <i class="fas fa-syringe"></i>
                    </div>
                    <div class="action-title">Process Request</div>
                    <div class="action-desc">Review and process pending blood requests</div>
                    <a href="viewrequestbloodbank.jsp" class="btn btn-primary">View Requests</a>
                </div>
                <div class="action-card">
                    <div class="action-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <div class="action-title">Update Blood Stock</div>
                    <div class="action-desc">Create inventory and usage reports</div>
                    <a href="updatebloodstcok.jsp" class="btn btn-primary">Update Blood</a>
                </div>
                <div class="action-card">
                    <div class="action-icon">
                        <i class="fas fa-box"></i>
                    </div>
                    <div class="action-title">Blood Stock</div>
                    <div class="action-desc">Notify donors about critical blood needs</div>
                    <a href="viewbloodstock.jsp" class="btn btn-primary">View Stock</a>
                </div>
            </div>

           
            <div class="recent-activity">
                <h3 class="section-title">Recent Activity</h3>
                <ul class="activity-list">
                    <li class="activity-item">
                        <div class="activity-icon">
                            <i class="fas fa-tint"></i>
                        </div>
                        <div class="activity-content">
                            <div class="activity-title">Blood donation received from John Doe</div>
                            <div class="activity-time">2 hours ago</div>
                        </div>
                    </li>
                    <li class="activity-item">
                        <div class="activity-icon">
                            <i class="fas fa-hand-holding-medical"></i>
                        </div>
                        <div class="activity-content">
                            <div class="activity-title">Blood request approved for City Hospital</div>
                            <div class="activity-time">5 hours ago</div>
                        </div>
                    </li>
                    <li class="activity-item">
                        <div class="activity-icon">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                        <div class="activity-content">
                            <div class="activity-title">Critical stock alert for B- blood type</div>
                            <div class="activity-time">Yesterday</div>
                        </div>
                    </li>
                    <li class="activity-item">
                        <div class="activity-icon">
                            <i class="fas fa-user-plus"></i>
                        </div>
                        <div class="activity-content">
                            <div class="activity-title">15 new donors registered this week</div>
                            <div class="activity-time">2 days ago</div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
      <script>
        
       
       
        window.history.forward();
        function noBack() {
            window.history.forward();
        }
    

   

    </script>
     <body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
</body>
</html>