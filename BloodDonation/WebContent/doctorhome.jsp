<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%
    if (session == null || session.getAttribute("doctoremail") == null) {
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
<title>Blood Bank Doctor Portal</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style type="text/css">
    :root {
        --primary-red: #c8102e;
        --dark-red: #9c0d24;
        --light-red: #f8d7da;
        --light-gray: #f8f9fa;
        --dark-gray: #343a40;
        --white: #ffffff;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
        background-color: #f5f5f5;
        color: #333;
        line-height: 1.6;
    }

    .header {
        background: linear-gradient(135deg, var(--primary-red), var(--dark-red));
        color: white;
        padding: 1rem 2rem;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        position: relative;
        z-index: 100;
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

    .logo-icon {
        font-size: 2.5rem;
        color: white;
    }

    .logo-text {
        font-size: 1.8rem;
        font-weight: 700;
    }

    .logo-subtitle {
        font-size: 0.9rem;
        opacity: 0.9;
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
        background-color: rgba(255, 255, 255, 0.2);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.2rem;
    }

    .nav-container {
        background-color: var(--white);
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    }

    .nav {
        max-width: 1200px;
        margin: 0 auto;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 2rem;
    }

    .nav-links {
        display: flex;
    }

    .nav-links a {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 1rem 1.5rem;
        text-decoration: none;
        color: var(--dark-gray);
        font-weight: 500;
        transition: all 0.3s ease;
        border-bottom: 3px solid transparent;
    }

    .nav-links a:hover {
        background-color: var(--light-red);
        color: var(--primary-red);
        border-bottom: 3px solid var(--primary-red);
    }

    .nav-links a i {
        font-size: 1.2rem;
    }

    .logout-btn {
        background-color: transparent;
        border: 2px solid var(--primary-red);
        color: var(--primary-red);
        padding: 0.5rem 1.5rem;
        border-radius: 4px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .logout-btn:hover {
        background-color: var(--primary-red);
        color: white;
    }

    .main-content {
        max-width: 1200px;
        margin: 2rem auto;
        padding: 0 2rem;
    }

    .welcome-section {
        background: linear-gradient(135deg, var(--primary-red), var(--dark-red));
        color: white;
        padding: 2rem;
        border-radius: 10px;
        margin-bottom: 2rem;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }

    .welcome-section h1 {
        font-size: 2.2rem;
        margin-bottom: 0.5rem;
    }

    .welcome-section p {
        font-size: 1.1rem;
        opacity: 0.9;
        max-width: 600px;
    }

    .dashboard-cards {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 1.5rem;
        margin-top: 2rem;
    }

    .card {
        background-color: white;
        border-radius: 8px;
        padding: 1.5rem;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        border-top: 4px solid var(--primary-red);
    }

    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
    }

    .card-icon {
        font-size: 2.5rem;
        color: var(--primary-red);
        margin-bottom: 1rem;
    }

    .card h3 {
        font-size: 1.3rem;
        margin-bottom: 0.5rem;
        color: var(--dark-gray);
    }

    .card p {
        color: #666;
        margin-bottom: 1rem;
    }

    .card-link {
        display: inline-flex;
        align-items: center;
        gap: 5px;
        color: var(--primary-red);
        font-weight: 600;
        text-decoration: none;
        transition: gap 0.3s ease;
    }

    .card-link:hover {
        gap: 10px;
    }

    .stats-section {
        margin-top: 3rem;
    }

    .stats-section h2 {
        font-size: 1.8rem;
        margin-bottom: 1.5rem;
        color: var(--dark-gray);
        border-left: 4px solid var(--primary-red);
        padding-left: 1rem;
    }

    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
        gap: 1.5rem;
    }

    .stat-card {
        background-color: white;
        border-radius: 8px;
        padding: 1.5rem;
        text-align: center;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }

    .stat-value {
        font-size: 2.5rem;
        font-weight: 700;
        color: var(--primary-red);
        margin-bottom: 0.5rem;
    }

    .stat-label {
        color: #666;
        font-size: 0.9rem;
    }

    .footer {
        background-color: var(--dark-gray);
        color: white;
        text-align: center;
        padding: 1.5rem;
        margin-top: 3rem;
    }

    .footer p {
        margin-bottom: 0.5rem;
    }

    .emergency-contact {
        background-color: var(--primary-red);
        color: white;
        padding: 0.5rem 1rem;
        border-radius: 4px;
        font-weight: 600;
        margin-top: 0.5rem;
        display: inline-block;
    }

    
    @media (max-width: 768px) {
        .nav {
            flex-direction: column;
            padding: 1rem;
        }

        .nav-links {
            width: 100%;
            flex-direction: column;
            margin-top: 1rem;
        }

        .nav-links a {
            justify-content: center;
            border-bottom: 1px solid #eee;
        }

        .logout-btn {
            margin-top: 1rem;
            width: 100%;
            justify-content: center;
        }

        .header-content {
            flex-direction: column;
            text-align: center;
            gap: 1rem;
        }

        .dashboard-cards, .stats-grid {
            grid-template-columns: 1fr;
        }
    }
</style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <div class="logo">
                <i class="fas fa-tint logo-icon"></i>
                <div>
                    <div class="logo-text">
LifeStream Blood Bank</div>
                    <div class="logo-subtitle">Hospital Portal</div>
                </div>
            </div>
            <div class="user-info">
                <div class="user-avatar">
                    <i class="fas fa-user-md"></i>
                </div>
                
            </div>
        </div>
    </div>

    <div class="nav-container">
        <div class="nav">
            <div class="nav-links">
                <a href="askingblood.jsp">
                    <i class="fas fa-hand-holding-medical"></i>
                    Ask Blood
                </a>
                 <a href="viewdonorresponse.jsp">
                    <i class="fas fa-hand-holding-medical"></i>
                    Allocate Donor
                </a>
                <a href="donorrlist.jsp">
                    <i class="fas fa-user-friends"></i>
                    Donor Management
                </a>
                <a href="updatecamp.jsp">
                    <i class="fas fa-clinic-medical"></i>
                    Blood Drives
                </a>
                <a href="doctorrequest.jsp">
                    <i class="fas fa-cog"></i>
                    Blood Requests
                </a>
            </div>
            <a href="logout.jsp" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i>
                Logout
            </a>
        </div>
    </div>

    <div class="main-content">
        <div class="welcome-section">
            <h1>Welcome to 
LifeStream Blood Bank Doctor Portal</h1>
            <p>Manage blood inventory, donor information, and blood drive campaigns efficiently.</p>
        </div>

        <div class="dashboard-cards">
        
        <div class="card">
                <i class="fas fa-hand-holding-medical card-icon"></i>
                <h3>Ask Blood</h3>
                <p>Update patient situation to get a blood.</p>
                <a href="askingblood.jsp" class="card-link">
                    Ask Blood <i class="fas fa-arrow-right"></i>
                </a>
            </div>
            
            <div class="card">
                <i class="fas fa-hand-holding-medical card-icon"></i>
                <h3>Allocate Donor</h3>
                <p>Allocate donors based on their past medical informations.</p>
                <a href="viewdonorresponse.jsp" class="card-link">
                    Allocate Donor <i class="fas fa-arrow-right"></i>
                </a>
            </div>
             <div class="card">
                <i class="fas fa-user-friends card-icon"></i>
                <h3>Donor Management</h3>
                <p>Search and find all donors informations and past donation records.</p>
                <a href="donorrlist.jsp" class="card-link">
                    View Donors <i class="fas fa-arrow-right"></i>
                </a>
            </div>
        <div class="card">
                <i class="fas fa-hand-holding-medical card-icon"></i>
                <h3>Blood Requests</h3>
                <p>Review and manage incoming blood requests from hospitals and patients.</p>
                <a href="doctorrequest.jsp" class="card-link">
                    View blood Requests <i class="fas fa-arrow-right"></i>
                </a>
            </div>
             
            
           
            <div class="card">
                <i class="fas fa-clinic-medical card-icon"></i>
                <h3>Blood Drives</h3>
                <p>Schedule and manage blood donation camps and donor recruitment events.</p>
                <a href="updatecamp.jsp" class="card-link">
                    Camp Arrangement <i class="fas fa-arrow-right"></i>
                </a>
            </div>
            <div class="card">
                <i class="fas fa-clinic-medical card-icon"></i>
                <h3>Provide certificate </h3>
                <p>Provide a blood donation certificate based on participants.</p>
                <a href="addcertificate.jsp" class="card-link">
                    View Generate Certificate <i class="fas fa-arrow-right"></i>
                </a>
            </div>
           
        </div>

      
    </div>

    <div class="footer">
        <p>LifeBlood Bank &copy; 2025 - Saving Lives Through Blood Donation</p>
       
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