<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Blood Bank Admin Dashboard</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    :root {
        --primary-red: #dc2626;
        --secondary-red: #ef4444;
        --light-red: #fecaca;
        --dark-red: #991b1b;
        --white: #ffffff;
        --light-bg: #f8fafc;
        --dark-gray: #1e293b;
        --text-gray: #64748b;
        --border-light: #e2e8f0;
        --gradient-primary: linear-gradient(135deg, #dc2626 0%, #991b1b 100%);
        --gradient-secondary: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
        --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
        --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        background: var(--light-bg);
        min-height: 100vh;
        font-family: 'Inter', 'Segoe UI', system-ui, -apple-system, sans-serif;
        color: var(--dark-gray);
        line-height: 1.6;
    }

   
    .dashboard-header {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(20px);
        border-bottom: 1px solid var(--border-light);
        padding: 1.5rem 0;
        position: sticky;
        top: 0;
        z-index: 100;
        box-shadow: var(--shadow-sm);
    }

    .header-content {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 2rem;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .logo-section {
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .logo {
        width: 50px;
        height: 50px;
        background: var(--gradient-primary);
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: var(--shadow-md);
    }

    .logo i {
        font-size: 1.5rem;
        color: var(--white);
    }

    .brand-text h1 {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--dark-gray);
        margin-bottom: 0.125rem;
    }

    .brand-text p {
        font-size: 0.875rem;
        color: var(--text-gray);
        font-weight: 500;
    }

    .user-section {
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .user-avatar {
        width: 40px;
        height: 40px;
        background: var(--gradient-secondary);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--white);
        font-weight: 600;
        box-shadow: var(--shadow-md);
    }

   
    .dashboard-main {
        max-width: 1200px;
        margin: 0 auto;
        padding: 2rem;
    }

    
    .welcome-section {
        background: var(--white);
        border-radius: 16px;
        padding: 2rem;
        margin-bottom: 2rem;
        box-shadow: var(--shadow-md);
        border: 1px solid var(--border-light);
    }

    .welcome-content h2 {
        font-size: 1.75rem;
        font-weight: 700;
        color: var(--dark-gray);
        margin-bottom: 0.5rem;
    }

    .welcome-content p {
        color: var(--text-gray);
        font-size: 1rem;
    }

   
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 1.5rem;
        margin-bottom: 2rem;
    }

    .stat-card {
        background: var(--white);
        border-radius: 16px;
        padding: 1.5rem;
        box-shadow: var(--shadow-md);
        border: 1px solid var(--border-light);
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }

    .stat-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: var(--gradient-primary);
    }

    .stat-card:hover {
        transform: translateY(-4px);
        box-shadow: var(--shadow-xl);
    }

    .stat-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 1rem;
    }

    .stat-icon {
        width: 48px;
        height: 48px;
        background: var(--light-red);
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--primary-red);
        font-size: 1.25rem;
    }

    .stat-trend {
        font-size: 0.875rem;
        font-weight: 600;
        color: #10b981;
        display: flex;
        align-items: center;
        gap: 0.25rem;
    }

    .stat-value {
        font-size: 2rem;
        font-weight: 700;
        color: var(--dark-gray);
        margin-bottom: 0.25rem;
    }

    .stat-label {
        font-size: 0.875rem;
        color: var(--text-gray);
        font-weight: 500;
    }

   
    .nav-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 1.5rem;
        margin-bottom: 2rem;
    }

    .nav-card {
        background: var(--white);
        border-radius: 16px;
        padding: 2rem;
        box-shadow: var(--shadow-md);
        border: 1px solid var(--border-light);
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }

    .nav-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: var(--gradient-primary);
        transform: scaleX(0);
        transition: transform 0.3s ease;
    }

    .nav-card:hover::before {
        transform: scaleX(1);
    }

    .nav-card:hover {
        transform: translateY(-4px);
        box-shadow: var(--shadow-xl);
    }

    .nav-icon {
        width: 64px;
        height: 64px;
        background: var(--light-red);
        border-radius: 16px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 1rem;
        color: var(--primary-red);
        font-size: 1.5rem;
        transition: all 0.3s ease;
    }

    .nav-card:hover .nav-icon {
        background: var(--gradient-primary);
        color: var(--white);
        transform: scale(1.1);
    }

    .nav-card h3 {
        font-size: 1.25rem;
        font-weight: 600;
        color: var(--dark-gray);
        margin-bottom: 0.5rem;
    }

    .nav-card p {
        color: var(--text-gray);
        font-size: 0.875rem;
        margin-bottom: 1.5rem;
        line-height: 1.5;
    }

    .nav-btn {
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.75rem 1.5rem;
        background: transparent;
        color: var(--primary-red);
        border: 2px solid var(--primary-red);
        border-radius: 8px;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.3s ease;
        font-size: 0.875rem;
    }

    .nav-btn:hover {
        background: var(--primary-red);
        color: var(--white);
        transform: translateY(-2px);
        box-shadow: var(--shadow-md);
        text-decoration: none;
    }

    
    .quick-actions {
        background: var(--white);
        border-radius: 16px;
        padding: 2rem;
        box-shadow: var(--shadow-md);
        border: 1px solid var(--border-light);
        margin-bottom: 2rem;
    }

    .section-title {
        font-size: 1.25rem;
        font-weight: 600;
        color: var(--dark-gray);
        margin-bottom: 1.5rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .section-title i {
        color: var(--primary-red);
    }

    .action-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 1rem;
    }

    .action-btn {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        padding: 1rem;
        background: var(--light-bg);
        border: 1px solid var(--border-light);
        border-radius: 12px;
        text-decoration: none;
        color: var(--dark-gray);
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .action-btn:hover {
        background: var(--primary-red);
        color: var(--white);
        transform: translateY(-2px);
        box-shadow: var(--shadow-md);
        text-decoration: none;
    }

    .action-btn i {
        font-size: 1.125rem;
        width: 20px;
    }

    
    .dashboard-footer {
        background: var(--white);
        border-top: 1px solid var(--border-light);
        padding: 2rem 0;
        margin-top: 3rem;
    }

    .footer-content {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 2rem;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .footer-text {
        color: var(--text-gray);
        font-size: 0.875rem;
    }

    .logout-btn {
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.75rem 1.5rem;
        background: transparent;
        color: var(--primary-red);
        border: 2px solid var(--primary-red);
        border-radius: 8px;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.3s ease;
        font-size: 0.875rem;
    }

    .logout-btn:hover {
        background: var(--primary-red);
        color: var(--white);
        text-decoration: none;
    }

   
    @media (max-width: 768px) {
        .header-content {
            flex-direction: column;
            gap: 1rem;
            text-align: center;
        }

        .dashboard-main {
            padding: 1rem;
        }

        .stats-grid {
            grid-template-columns: 1fr;
        }

        .nav-grid {
            grid-template-columns: 1fr;
        }

        .action-grid {
            grid-template-columns: 1fr;
        }

        .footer-content {
            flex-direction: column;
            gap: 1rem;
            text-align: center;
        }
    }

    
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .stat-card, .nav-card, .welcome-section {
        animation: fadeInUp 0.6s ease-out;
    }
</style>
</head>
<body>
   
    <div class="dashboard-header">
        <div class="header-content">
            <div class="logo-section">
                <div class="logo">
                    <i class="fas fa-tint"></i>
                </div>
                <div class="brand-text">
                    <h1>Blood Bank Admin</h1>
                    <p>Life Saving Management System</p>
                </div>
            </div>
            <div class="user-section">
                <div class="user-avatar">
                    <i class="fas fa-user-shield"></i>
                </div>
            </div>
        </div>
    </div>

    
    <div class="dashboard-main">
        <!-- Welcome Section -->
        <div class="welcome-section">
            <div class="welcome-content">
                <h2>Welcome back, Administrator</h2>
                <p>Manage your blood bank operations efficiently and save lives</p>
            </div>
        </div>

        
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-trend">
                        <i class="fas fa-arrow-up"></i> 12%
                    </div>
                </div>
                <div class="stat-value">1,247</div>
                <div class="stat-label">Active Donors</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon">
                        <i class="fas fa-tint"></i>
                    </div>
                    <div class="stat-trend">
                        <i class="fas fa-arrow-up"></i> 8%
                    </div>
                </div>
                <div class="stat-value">342</div>
                <div class="stat-label">Blood Requests</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon">
                        <i class="fas fa-hospital"></i>
                    </div>
                    <div class="stat-trend">
                        <i class="fas fa-arrow-up"></i> 15%
                    </div>
                </div>
                <div class="stat-value">28</div>
                <div class="stat-label">Active Camps</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon">
                        <i class="fas fa-heart"></i>
                    </div>
                    <div class="stat-trend">
                        <i class="fas fa-arrow-up"></i> 23%
                    </div>
                </div>
                <div class="stat-value">2,156</div>
                <div class="stat-label">Lives Saved</div>
            </div>
        </div>

       
        <div class="quick-actions">
            <h3 class="section-title">
                <i class="fas fa-bolt"></i> Quick Actions
            </h3>
            <div class="action-grid">
                <a href="askingblood.jsp" class="action-btn">
                    <i class="fas fa-plus-circle"></i>
                    <span>New Blood Request</span>
                </a>
                <a href="ARRANGECAMP.jsp" class="action-btn">
                    <i class="fas fa-calendar-plus"></i>
                    <span>Schedule Camp</span>
                </a>
                <a href="donateddlist.jsp" class="action-btn">
                    <i class="fas fa-bell"></i>
                    <span>Check Responses</span>
                </a>
                <a href="certificate.jsp" class="action-btn">
                    <i class="fas fa-award"></i>
                    <span>View Certificate</span>
                </a>
            </div>
        </div>

       
        <div class="nav-grid">
           
            <div class="nav-card">
                <div class="nav-icon">
                    <i class="fas fa-hand-holding-medical"></i>
                </div>
                <h3>Blood Requests</h3>
                <p>Manage and process incoming blood requests from patients and hospitals with priority handling</p>
                <a href="askingblood.jsp" class="nav-btn">
                    Manage Requests <i class="fas fa-arrow-right"></i>
                </a>
            </div>

            
            <div class="nav-card">
                <div class="nav-icon">
                    <i class="fas fa-user-check"></i>
                </div>
                <h3>Donor Responses</h3>
                <p>Monitor and manage responses from donors and coordinate donation schedules</p>
                <a href="donateddlist.jsp" class="nav-btn">
                    View Responses <i class="fas fa-arrow-right"></i>
                </a>
            </div>
           
            <div class="nav-card">
                <div class="nav-icon">
                    <i class="fas fa-user-friends"></i>
                </div>
                <h3>Donor Database</h3>
                <p>Access complete donor information, blood types, and donation history</p>
                <a href="donorrlist.jsp" class="nav-btn">
                    View Donors <i class="fas fa-arrow-right"></i>
                </a>
            </div>

            
            <div class="nav-card">
                <div class="nav-icon">
                    <i class="fas fa-campground"></i>
                </div>
                <h3>Camp Management</h3>
                <p>Organize, schedule, and manage blood donation camps and events</p>
                <a href="ARRANGECAMP.jsp" class="nav-btn">
                    Arrange Camp <i class="fas fa-arrow-right"></i>
                </a>
            </div>

           
            <div class="nav-card">
                <div class="nav-icon">
                    <i class="fas fa-chart-bar"></i>
                </div>
                <h3>Camp Analytics</h3>
                <p>View detailed reports and analytics for all donation camps and events</p>
                <a href="hviewcampdetails.jsp" class="nav-btn">
                    View Analytics <i class="fas fa-arrow-right"></i>
                </a>
            </div>
        </div>
    </div>

   
    <div class="dashboard-footer">
        <div class="footer-content">
            <div class="footer-text">
                &copy; 2024 Blood Bank Management System. Saving Lives Through Technology.
            </div>
            <a href="indexx.jsp" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>
</body>
</html>