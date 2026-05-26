<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
    if (session == null || session.getAttribute("admin") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Blood Bank Admin Dashboard</title>
<link href="https://fonts.googleapis.com/css2?family=Fragment+Mono&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    :root {
        --primary-red: #8b0000;
        --secondary-red: #b22222;
        --light-red: #ffcccc;
        --dark-red: #660000;
        --white: #ffffff;
        --light-gray: #f5f5f5;
        --dark-gray: #333333;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
        background-color: var(--light-gray);
        color: var(--dark-gray);
        overflow-x: hidden;
    }

    .dashboard-container {
        display: flex;
        min-height: 100vh;
    }

   
    .sidebar {
        width: 250px;
        background: linear-gradient(to bottom, var(--primary-red), var(--dark-red));
        color: var(--white);
        height: 100vh;
        position: fixed;
        overflow-y: auto;
        transition: all 0.3s;
        box-shadow: 3px 0 10px rgba(0, 0, 0, 0.2);
        z-index: 1000;
    }

    .sidebar-header {
        padding: 20px;
        text-align: center;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .sidebar-header h2 {
        font-size: 22px;
        margin-bottom: 5px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
    }

    .sidebar-header p {
        font-size: 12px;
        opacity: 0.8;
    }

    .sidebar-menu {
        padding: 20px 0;
    }

    .menu-item {
        padding: 15px 20px;
        display: flex;
        align-items: center;
        gap: 15px;
        cursor: pointer;
        transition: all 0.3s;
        border-left: 4px solid transparent;
    }

    .menu-item:hover {
        background-color: rgba(255, 255, 255, 0.1);
        border-left: 4px solid var(--light-red);
    }

    .menu-item.active {
        background-color: rgba(255, 255, 255, 0.15);
        border-left: 4px solid var(--light-red);
    }

    .menu-item i {
        font-size: 18px;
        width: 24px;
        text-align: center;
    }

    
    .main-content {
        flex: 1;
        margin-left: 250px;
        padding: 20px;
        transition: all 0.3s;
    }

    .top-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px 20px;
        background-color: var(--white);
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
    }

    .search-bar {
        display: flex;
        align-items: center;
        background-color: var(--light-gray);
        border-radius: 30px;
        padding: 8px 15px;
        width: 300px;
    }

    .search-bar input {
        border: none;
        background: transparent;
        padding: 5px 10px;
        width: 100%;
        outline: none;
    }

    .search-bar button {
        background: transparent;
        border: none;
        color: var(--primary-red);
        cursor: pointer;
    }

    .user-info {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .user-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background-color: var(--primary-red);
        color: var(--white);
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
    }

   
    .stats-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }

    .stat-card {
        background-color: var(--white);
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        display: flex;
        align-items: center;
        gap: 15px;
        transition: transform 0.3s;
    }

    .stat-card:hover {
        transform: translateY(-5px);
    }

    .stat-icon {
        width: 60px;
        height: 60px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
    }

    .stat-icon.hospitals {
        background-color: rgba(139, 0, 0, 0.1);
        color: var(--primary-red);
    }

    .stat-icon.users {
        background-color: rgba(0, 100, 0, 0.1);
        color: green;
    }

    .stat-icon.camps {
        background-color: rgba(0, 0, 139, 0.1);
        color: blue;
    }

    .stat-icon.blood {
        background-color: rgba(255, 0, 0, 0.1);
        color: red;
    }

    .stat-info h3 {
        font-size: 24px;
        margin-bottom: 5px;
    }

    .stat-info p {
        font-size: 14px;
        color: #666;
    }

   
    .content-section {
        background-color: var(--white);
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
    }

    .section-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 1px solid #eee;
    }

    .section-header h2 {
        color: var(--primary-red);
        font-size: 20px;
    }

    .view-all {
        color: var(--primary-red);
        text-decoration: none;
        font-size: 14px;
        font-weight: 500;
    }

    .quick-actions {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 15px;
    }

    .action-card {
        background-color: var(--light-gray);
        border-radius: 8px;
        padding: 15px;
        text-align: center;
        transition: all 0.3s;
        cursor: pointer;
    }

    .action-card:hover {
        background-color: var(--primary-red);
        color: var(--white);
        transform: translateY(-3px);
    }

    .action-card i {
        font-size: 24px;
        margin-bottom: 10px;
    }

    .action-card h3 {
        font-size: 16px;
    }

   
    .activity-list {
        list-style: none;
    }

    .activity-item {
        display: flex;
        align-items: center;
        gap: 15px;
        padding: 15px 0;
        border-bottom: 1px solid #eee;
    }

    .activity-item:last-child {
        border-bottom: none;
    }

    .activity-icon {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background-color: rgba(139, 0, 0, 0.1);
        color: var(--primary-red);
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .activity-details h4 {
        font-size: 15px;
        margin-bottom: 5px;
    }

    .activity-details p {
        font-size: 13px;
        color: #666;
    }

    .activity-time {
        margin-left: auto;
        font-size: 12px;
        color: #999;
    }

   
    .mobile-header {
        display: none;
        background: linear-gradient(to right, var(--primary-red), var(--dark-red));
        color: var(--white);
        padding: 15px 20px;
        justify-content: space-between;
        align-items: center;
    }

    .mobile-menu-btn {
        background: transparent;
        border: none;
        color: var(--white);
        font-size: 24px;
        cursor: pointer;
    }

    @media screen and (max-width: 992px) {
        .sidebar {
            width: 70px;
        }

        .sidebar-header h2 span, 
        .menu-item span {
            display: none;
        }

        .sidebar-header {
            padding: 15px 10px;
        }

        .main-content {
            margin-left: 70px;
        }

        .menu-item {
            justify-content: center;
            padding: 15px 10px;
        }

        .menu-item i {
            margin-right: 0;
        }
    }

    @media screen and (max-width: 768px) {
        .sidebar {
            transform: translateX(-100%);
        }

        .sidebar.active {
            transform: translateX(0);
        }

        .main-content {
            margin-left: 0;
        }

        .mobile-header {
            display: flex;
        }

        .stats-container {
            grid-template-columns: 1fr 1fr;
        }

        .search-bar {
            width: 200px;
        }
    }

    @media screen and (max-width: 576px) {
        .stats-container {
            grid-template-columns: 1fr;
        }

        .search-bar {
            width: 150px;
        }

        .quick-actions {
            grid-template-columns: 1fr;
        }
    }
</style>
</head>
<body>
    <div class="dashboard-container">
       
        <div class="mobile-header">
            <button class="mobile-menu-btn" id="mobileMenuBtn">
                <i class="fas fa-bars"></i>
            </button>
            <h2>LifeStream Blood Bank Admin</h2>
            <div class="user-info">
                <div class="user-avatar">A</div>
            </div>
        </div>

        
        <div class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <h2><i class="fas fa-tint"></i> <span>LifeStream Blood Bank Admin</span></h2>
                <p>Management System</p>
            </div>
            <div class="sidebar-menu">
                <div class="menu-item active">
                    <i class="fas fa-home"></i>
                    <span>Dashboard</span>
                </div>
                <a href="adminviewpatient.jsp" style="text-decoration: none; color: inherit;">
                    <div class="menu-item">
                        <i class="fas fa-hospital"></i>
                        <span>patient view </span>
                    </div>
                </a>
                <a href="adminviewhospitalview.jsp" style="text-decoration: none; color: inherit;">
                    <div class="menu-item">
                        <i class="fas fa-info-circle"></i>
                        <span>Hospital Details</span>
                    </div>
                </a>
                <a href="adminviewdonor.jsp" style="text-decoration: none; color: inherit;">
                    <div class="menu-item">
                        <i class="fas fa-users"></i>
                        <span>Donor list</span>
                    </div>
                </a>
                <a href="adminviewcamp.jsp" style="text-decoration: none; color: inherit;">
                    <div class="menu-item">
                        <i class="fas fa-campground"></i>
                        <span>Camp Details</span>
                    </div>
                </a>
                <a href="logout.jsp" style="text-decoration: none; color: inherit;">
                    <div class="menu-item">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Logout</span>
                    </div>
                </a>
            </div>
        </div>

        
        <div class="main-content">
            <div class="top-bar">
                <div class="search-bar">
                    <input type="text" placeholder="Search...">
                    <button><i class="fas fa-search"></i></button>
                </div>
                <div class="user-info">
                    <div class="user-avatar">A</div>
                    <div>
                        <div style="font-weight: 500;">Admin User</div>
                        <div style="font-size: 12px; color: #666;">Administrator</div>
                    </div>
                </div>
            </div>

           
            
            <div class="content-section">
                <div class="section-header">
                    <h2>Quick Actions</h2>
                </div>
                <div class="quick-actions">
                    <a href="adminviewblooddonation.jsp" style="text-decoration: none; color: inherit;">
                        <div class="action-card">
                            <i class="fas fa-hospital"></i>
                            <h3>Blood Donation Records</h3>
                        </div>
                    </a>
                    <a href="adminviewhospitalview.jsp" style="text-decoration: none; color: inherit;">
                        <div class="action-card">
                            <i class="fas fa-info-circle"></i>
                            <h3>Hospital Details</h3>
                        </div>
                    </a>
                    <a href="adminviewdonor.jsp" style="text-decoration: none; color: inherit;">
                        <div class="action-card">
                            <i class="fas fa-users"></i>
                            <h3>Donor Management</h3>
                        </div>
                    </a>
                    <a href="adminviewcamp.jsp" style="text-decoration: none; color: inherit;">
                        <div class="action-card">
                            <i class="fas fa-campground"></i>
                            <h3>Camps Management</h3>
                        </div>
                    </a>
                    <a href="adminviewambulance.jsp" style="text-decoration: none; color: inherit;">
                            <div class="action-card">
                            <i class="fas fa-ambulance"></i>
                            <h3>Ambulance Details</h3>
                        </div>
                    </a>  
                    <a href="adminviewbloodstock.jsp" style="text-decoration: none; color: inherit;">
                            <div class="action-card">
                            <i class="fas fa-tint"></i>
                            <h3>View BloodStock</h3>
                        </div>
                    </a>  
                              
            </div>

           
            <div class="content-section">
                <div class="section-header">
                    <h2>Recent Activity</h2>
                    <a href="#" class="view-all">View All</a>
                </div>
                <ul class="activity-list">
                    <li class="activity-item">
                        <div class="activity-icon">
                            <i class="fas fa-user-plus"></i>
                        </div>
                        <div class="activity-details">
                            <h4>New donor registered</h4>
                            <p>John Doe registered as a blood donor</p>
                        </div>
                        <div class="activity-time">2 hours ago</div>
                    </li>
                    <li class="activity-item">
                        <div class="activity-icon">
                            <i class="fas fa-hospital"></i>
                        </div>
                        <div class="activity-details">
                            <h4>Hospital added</h4>
                            <p>City General Hospital added to the system</p>
                        </div>
                        <div class="activity-time">5 hours ago</div>
                    </li>
                    <li class="activity-item">
                        <div class="activity-icon">
                            <i class="fas fa-tint"></i>
                        </div>
                        <div class="activity-details">
                            <h4>Blood stock updated</h4>
                            <p>O+ blood stock increased by 15 units</p>
                        </div>
                        <div class="activity-time">1 day ago</div>
                    </li>
                    <li class="activity-item">
                        <div class="activity-icon">
                            <i class="fas fa-campground"></i>
                        </div>
                        <div class="activity-details">
                            <h4>New camp scheduled</h4>
                            <p>Blood donation camp at Central Park</p>
                        </div>
                        <div class="activity-time">2 days ago</div>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <script>
        
        document.getElementById('mobileMenuBtn').addEventListener('click', function() {
            document.getElementById('sidebar').classList.toggle('active');
        });

       
        document.addEventListener('click', function(event) {
            const sidebar = document.getElementById('sidebar');
            const mobileMenuBtn = document.getElementById('mobileMenuBtn');
            
            if (window.innerWidth <= 768 && 
                !sidebar.contains(event.target) && 
                !mobileMenuBtn.contains(event.target)) {
                sidebar.classList.remove('active');
            }
        });
        
       
        window.history.forward();
        function noBack() {
            window.history.forward();
        }
    

   

    </script>
     <body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
</body>
</html>