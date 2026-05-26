<%@page import="dbcon.Dbcon"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="java.time.*" %>
<%@page import="java.time.format.DateTimeFormatter" %>
<%@page import="java.time.format.DateTimeParseException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Request Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-red: #d32f2f;
            --dark-red: #b71c1c;
            --light-red: #ffebee;
            --secondary-color: #2c3e50;
            --light-gray: #f8f9fa;
            --medium-gray: #e9ecef;
            --dark-gray: #6c757d;
            --white: #ffffff;
            --success: #28a745;
            --warning: #ffc107;
            --danger: #dc3545;
            --glass-bg: rgba(255, 255, 255, 0.95);
            --glass-border: rgba(255, 255, 255, 0.2);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #8b0000 0%, #b22222 100%);
            min-height: 100vh;
            padding: 20px;
            position: relative;
        }

       
        .bg-elements {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            overflow: hidden;
        }

        .bg-circle {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            animation: float 8s ease-in-out infinite;
        }

        .circle-1 {
            width: 150px;
            height: 150px;
            top: 10%;
            right: 10%;
            animation-delay: 0s;
        }

        .circle-2 {
            width: 100px;
            height: 100px;
            bottom: 20%;
            left: 10%;
            animation-delay: 2s;
        }

        .circle-3 {
            width: 80px;
            height: 80px;
            top: 50%;
            left: 20%;
            animation-delay: 4s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) scale(1); }
            50% { transform: translateY(-20px) scale(1.05); }
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        
        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid var(--glass-border);
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo i {
            font-size: 2.5rem;
            color: var(--primary-red);
            filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.2));
        }

        .logo-text h1 {
            font-size: 1.8rem;
            font-weight: 700;
            background: linear-gradient(135deg, var(--primary-red), var(--dark-red));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .logo-text .subtitle {
            color: var(--secondary-color);
            font-size: 1rem;
            opacity: 0.8;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
            background: var(--light-red);
            padding: 12px 20px;
            border-radius: 10px;
            border: 1px solid rgba(200, 16, 46, 0.2);
        }

        .user-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: var(--primary-red);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 1.2rem;
        }

       
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            border: 1px solid var(--glass-border);
            text-align: center;
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: var(--light-red);
            color: var(--primary-red);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 1.3rem;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-red);
            margin-bottom: 5px;
        }

        .stat-label {
            color: var(--secondary-color);
            font-weight: 500;
        }

       
        .main-content {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid var(--glass-border);
        }

        .content-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid var(--light-red);
        }

        .content-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--secondary-color);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .content-title i {
            color: var(--primary-red);
        }

        .controls {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .back-btn {
            background: var(--secondary-color);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .back-btn:hover {
            background: #1a252f;
            transform: translateY(-2px);
        }

        .refresh-btn {
            background: var(--primary-red);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
        }

        .refresh-btn:hover {
            background: var(--dark-red);
            transform: translateY(-2px);
        }

      
        .eligibility-banner {
            background: var(--light-red);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 15px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
            border-left: 4px solid var(--primary-red);
        }

        .eligibility-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: var(--primary-red);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
        }

        .eligibility-content {
            flex: 1;
        }

        .eligibility-title {
            font-weight: 600;
            color: var(--secondary-color);
            margin-bottom: 5px;
        }

        .eligibility-text {
            color: var(--dark-gray);
            font-size: 0.9rem;
        }

        .countdown {
            background: var(--primary-red);
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .eligibility-success {
            border-left: 4px solid var(--success);
        }

        .eligibility-success .eligibility-icon {
            background: var(--success);
        }

      
        .search-section {
            background: var(--light-gray);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 25px;
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: center;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
        }

        .search-box {
            position: relative;
            flex: 1;
            min-width: 250px;
        }

        .search-box input {
            width: 100%;
            padding: 12px 20px 12px 45px;
            border: 1px solid var(--medium-gray);
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .search-box input:focus {
            outline: none;
            border-color: var(--primary-red);
            box-shadow: 0 0 0 3px rgba(200, 16, 46, 0.1);
        }

        .search-box i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--dark-gray);
        }

        .filter-group {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .filter-select {
            padding: 12px 15px;
            border: 1px solid var(--medium-gray);
            border-radius: 8px;
            background: white;
            font-size: 0.9rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .filter-select:focus {
            outline: none;
            border-color: var(--primary-red);
            box-shadow: 0 0 0 3px rgba(200, 16, 46, 0.1);
        }

        .clear-btn {
            background: var(--dark-gray);
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
        }

        .clear-btn:hover {
            background: #5a6268;
        }

     
        .results-counter {
            background: var(--light-red);
            padding: 10px 15px;
            border-radius: 8px;
            margin-bottom: 15px;
            font-weight: 500;
            color: var(--secondary-color);
            display: flex;
            align-items: center;
            gap: 8px;
        }

       
        .table-container {
            overflow-x: auto;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        thead {
            background: linear-gradient(135deg, var(--primary-red), var(--dark-red));
        }

        th {
            color: white;
            font-weight: 600;
            padding: 18px 20px;
            text-align: left;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        tbody tr {
            transition: all 0.3s ease;
            border-bottom: 1px solid var(--medium-gray);
        }

        tbody tr:hover {
            background-color: var(--light-red);
            transform: scale(1.01);
        }

        tbody tr:nth-child(even) {
            background-color: var(--light-gray);
        }

        tbody tr:nth-child(even):hover {
            background-color: var(--light-red);
        }

        td {
            padding: 16px 20px;
            color: var(--secondary-color);
        }

        .patient-name {
            font-weight: 600;
            color: var(--secondary-color);
        }

        .hospital-name {
            color: var(--dark-gray);
            font-size: 0.9rem;
        }

        .blood-group {
            display: inline-block;
            padding: 6px 12px;
            background: var(--light-red);
            color: var(--primary-red);
            border-radius: 20px;
            font-weight: 600;
            text-align: center;
            min-width: 50px;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .status-pending {
            background: rgba(255, 152, 0, 0.15);
            color: var(--warning);
        }

        .status-accepted {
            background: rgba(40, 167, 69, 0.15);
            color: var(--success);
        }

        .status-rejected {
            background: rgba(220, 53, 69, 0.15);
            color: var(--danger);
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            font-size: 0.85rem;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .btn-accept {
            background: var(--success);
            color: var(--white);
        }

        .btn-accept:hover {
            background: #218838;
            transform: translateY(-2px);
            box-shadow: 0 3px 8px rgba(40, 167, 69, 0.3);
        }

        .btn-accept:disabled {
            background: var(--dark-gray);
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
            opacity: 0.6;
        }

      
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--dark-gray);
        }

        .empty-state i {
            font-size: 4rem;
            color: var(--medium-gray);
            margin-bottom: 20px;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: var(--secondary-color);
        }

       
        .footer {
            text-align: center;
            margin-top: 30px;
            color: white;
            opacity: 0.8;
        }

      
        .modal-backdrop {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 1000;
        }

        .modal {
            background: var(--white);
            border-radius: 15px;
            padding: 30px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            text-align: center;
        }

        .modal-icon {
            width: 60px;
            height: 60px;
            background: var(--light-red);
            color: var(--primary-red);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin: 0 auto 20px;
        }

        .modal h3 {
            font-size: 1.5rem;
            margin-bottom: 15px;
            color: var(--secondary-color);
        }

        .modal p {
            color: var(--dark-gray);
            margin-bottom: 25px;
            line-height: 1.6;
        }

        .modal .btn-close {
            background: var(--primary-red);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .modal .btn-close:hover {
            background: var(--dark-red);
            transform: translateY(-2px);
        }

      
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                text-align: center;
            }

            .stats-container {
                grid-template-columns: repeat(2, 1fr);
            }

            .content-header {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }

            .controls {
                width: 100%;
                justify-content: space-between;
            }

            .search-section {
                flex-direction: column;
                align-items: stretch;
            }

            .search-box {
                min-width: 100%;
            }

            .filter-group {
                width: 100%;
                justify-content: space-between;
            }

            .filter-select {
                flex: 1;
            }

            th, td {
                padding: 12px 15px;
            }

            .action-buttons {
                flex-direction: column;
                gap: 5px;
            }
        }

        @media (max-width: 480px) {
            .stats-container {
                grid-template-columns: 1fr;
            }

            table {
                font-size: 0.85rem;
            }

            .controls {
                flex-direction: column;
                gap: 10px;
            }

            .back-btn, .refresh-btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    
    <div class="bg-elements">
        <div class="bg-circle circle-1"></div>
        <div class="bg-circle circle-2"></div>
        <div class="bg-circle circle-3"></div>
    </div>

    <div class="container">
        
        <div class="header">
            <div class="header-content">
                <div class="logo">
                    <i class="fas fa-tint"></i>
                    <div class="logo-text">
                        <h1>LifeStream Blood Bank</h1>
                        <div class="subtitle">Blood Request Management</div>
                    </div>
                </div>
                <div class="user-info">
                    <div class="user-avatar">D</div>
                    <div>
                        <div style="font-weight: 600; color: var(--secondary-color);">Donor Portal</div>
                        <div style="font-size: 0.9rem; color: var(--dark-gray);">Manage Blood Requests</div>
                    </div>
                </div>
            </div>
        </div>

        <%
            HttpSession s = request.getSession();
            String bgp = s.getAttribute("bgp") != null ? s.getAttribute("bgp").toString() : "";
            String email = s.getAttribute("email") != null ? s.getAttribute("email").toString() : "";

            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            PreparedStatement ps1 = null;
            ResultSet rs1 = null;

            String donorBeforeDateStr = "";
            String donorAfterDateStr = "";
            boolean donorEligible = false;
            long millisUntilAfterDate = 0L;
            boolean isNewDonor = false;

            int pendingCount = 0;
            int acceptedCount = 0;
            int rejectedCount = 0;
            int totalCount = 0;

            try {
                con = Dbcon.create();

                
                ps1 = con.prepareStatement("SELECT * FROM `blood`.`donatedetails` WHERE `Doner mail` = ? ORDER BY beforedate DESC LIMIT 1");
                ps1.setString(1, email);
                rs1 = ps1.executeQuery();
                
                if (rs1.next()) {
                    try {
                        donorBeforeDateStr = rs1.getString("beforedate");
                    } catch(Exception ex) {
                        donorBeforeDateStr = "";
                    }
                    try {
                        donorAfterDateStr = rs1.getString("afterdate");
                    } catch(Exception ex) {
                        donorAfterDateStr = "";
                    }
                } else {
                    
                    isNewDonor = true;
                }
                if (rs1 != null) {
                    rs1.close();
                    rs1 = null;
                }
                if (ps1 != null) {
                    ps1.close();
                    ps1 = null;
                }

                
                if (isNewDonor) {
                    
                    donorEligible = true;
                } else {
                    
                    LocalDate afterDate = null;
                    LocalDate today = LocalDate.now();

                    if (donorAfterDateStr != null && donorAfterDateStr.trim().length() > 0) {
                        String ds = donorAfterDateStr.trim();
                        DateTimeFormatter[] fmts = new DateTimeFormatter[] {
                            DateTimeFormatter.ISO_LOCAL_DATE,
                            DateTimeFormatter.ofPattern("yyyy-MM-dd"),
                            DateTimeFormatter.ofPattern("dd-MM-yyyy"),
                            DateTimeFormatter.ofPattern("MM/dd/yyyy")
                        };
                        for (DateTimeFormatter fmt : fmts) {
                            try {
                                afterDate = LocalDate.parse(ds, fmt);
                                break;
                            } catch (DateTimeParseException pe) {
                                
                            }
                        }
                    }

                    if (afterDate != null) {
                        donorEligible = !today.isBefore(afterDate);
                        ZonedDateTime zAfter = afterDate.atStartOfDay(ZoneId.systemDefault());
                        ZonedDateTime nowZ = ZonedDateTime.now(ZoneId.systemDefault());
                        millisUntilAfterDate = zAfter.toInstant().toEpochMilli() - nowZ.toInstant().toEpochMilli();
                        if (millisUntilAfterDate < 0) millisUntilAfterDate = 0L;
                    } else {
                        donorEligible = false;
                        millisUntilAfterDate = Long.MAX_VALUE;
                    }
                }

                
                ps = con.prepareStatement("SELECT * FROM `blood`.`patient` WHERE status = ? AND `blood group` = ?");
                ps.setString(1, "requested");
                ps.setString(2, bgp);
                rs = ps.executeQuery();
        %>

       
        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-hand-holding-medical"></i>
                </div>
                <div class="stat-value" id="pendingCount">0</div>
                <div class="stat-label">Pending Requests</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-value" id="acceptedCount">0</div>
                <div class="stat-label">Accepted Requests</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-hospital"></i>
                </div>
                <div class="stat-value" id="hospitalCount">0</div>
                <div class="stat-label">Hospitals</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <div class="stat-value" id="totalCount">0</div>
                <div class="stat-label">Total Requests</div>
            </div>
        </div>

        
        <div class="main-content">
            <div class="content-header">
                <h2 class="content-title">
                    <i class="fas fa-hand-holding-medical"></i>
                    Blood Requests Matching Your Blood Group
                </h2>
                <div class="controls">
                    <a href="donorhome.jsp" class="back-btn">
                        <i class="fas fa-arrow-left"></i>
                        Back to Dashboard
                    </a>
                    <button class="refresh-btn" onclick="location.reload()">
                        <i class="fas fa-sync-alt"></i>
                        Refresh
                    </button>
                </div>
            </div>

           
            <div class="eligibility-banner <%= donorEligible ? "eligibility-success" : "" %>" id="eligibilityBanner">
                <div class="eligibility-icon">
                    <i class="fas fa-heartbeat"></i>
                </div>
                <div class="eligibility-content">
                    <div class="eligibility-title" id="eligibilityTitle">
                        <%= donorEligible ? 
                            (isNewDonor ? "Welcome! You are eligible to donate blood as a new donor!" : "You are eligible to donate blood!") 
                            : "You are not eligible to donate yet" %>
                    </div>
                    <div class="eligibility-text" id="eligibilityText">
                        <% if (isNewDonor) { %>
                            As a new donor, you can start helping save lives immediately!
                        <% } else if (donorAfterDateStr != null && donorAfterDateStr.trim().length() > 0) { %>
                            Next eligible date: <strong><%= donorAfterDateStr %></strong>
                        <% } else { %>
                            Previous donation record found
                        <% } %>
                    </div>
                </div>
                <% if (!donorEligible && !isNewDonor) { %>
                <div class="countdown" id="countdownDisplay">
                    Calculating...
                </div>
                <% } %>
            </div>

           
            <div class="search-section">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchInput" placeholder="Search by patient name, hospital, or location...">
                </div>
                <div class="filter-group">
                    <select class="filter-select" id="hospitalFilter">
                        <option value="">All Hospitals</option>
                       
                    </select>
                    <select class="filter-select" id="locationFilter">
                        <option value="">All Locations</option>
                        
                    </select>
                    <button class="clear-btn" id="clearFilters">
                        <i class="fas fa-times"></i>
                        Clear Filters
                    </button>
                </div>
            </div>

           
            <div class="results-counter" id="resultsCounter">
                <i class="fas fa-list"></i>
                Showing <span id="visibleCount">0</span> of <span id="totalCountDisplay">0</span> requests
            </div>

            <div class="table-container">
                <%
                    if (!rs.isBeforeFirst()) {
                %>
                <div class="empty-state">
                    <i class="fas fa-inbox"></i>
                    <h3>No Blood Requests Found</h3>
                    <p>There are currently no blood requests matching your blood group. Check back later for new requests.</p>
                </div>
                <%
                    } else {
                %>
                <table id="requestsTable">
                    <thead>
                        <tr>
                            <th>Patient Details</th>
                            <th>Hospital</th>
                            <th>Blood Group</th>
                            <th>Location</th>
                            <th>Component</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            while(rs.next()) {
                                totalCount++;
                                String statusStr = rs.getString("status");
                                if("Accepted".equals(statusStr)) { acceptedCount++; }
                                else if("Rejected".equals(statusStr)) { rejectedCount++; }
                                else { pendingCount++; }

                                String rowBloodGroup = rs.getString("blood group");
                                String location = rs.getString("location");
                                int id = rs.getInt("id");
                                String hospital = rs.getString("hospital");
                                String name = rs.getString("name");
                                String bloodComponent = rs.getString("blood");
                        %>
                        <tr data-name="<%= name.toLowerCase() %>" 
                            data-hospital="<%= hospital.toLowerCase() %>" 
                            data-location="<%= location.toLowerCase() %>"
                            data-bloodgroup="<%= rowBloodGroup %>">
                            <td>
                                <div class="patient-name"><%= name %></div>
                            </td>
                            <td>
                                <div class="hospital-name"><%= hospital %></div>
                            </td>
                            <td>
                                <span class="blood-group"><%= rowBloodGroup %></span>
                            </td>
                            <td><%= location %></td>
                            <td><%= bloodComponent %></td>
                            <td>
                                <span class="status-badge status-pending">Pending</span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <%
                                        String acceptUrl = "updatedonorstatus.jsp?id=" + id + "&status=Accepted&email=" + java.net.URLEncoder.encode(session.getAttribute("email").toString(), "UTF-8") + "&mobile=" + java.net.URLEncoder.encode(session.getAttribute("mobile") != null ? session.getAttribute("mobile").toString() : "", "UTF-8");
                                    %>
                                    <% if (donorEligible) { %>
                                        <a href="<%= acceptUrl %>" class="btn btn-accept">
                                            <i class="fas fa-check"></i> Accept
                                        </a>
                                    <% } else { %>
                                        <button class="btn btn-accept" disabled onclick="showNotEligibleModal()">
                                            <i class="fas fa-check"></i> Accept
                                        </button>
                                    <% } %>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                <%
                    }
                %>
            </div>
        </div>

        
    </div>

  
    <div class="modal-backdrop" id="modalBackdrop">
        <div class="modal">
            <div class="modal-icon">
                <i class="fas fa-clock"></i>
            </div>
            <h3>Not Eligible Yet</h3>
            <p id="modalMessage">You are not eligible to donate blood at this time. Please check your eligibility status.</p>
            <button class="btn-close" onclick="closeModal()">Close</button>
        </div>
    </div>

    <script>
        
        document.addEventListener('DOMContentLoaded', function() {
           
            document.getElementById('pendingCount').textContent = <%= pendingCount %>;
            document.getElementById('acceptedCount').textContent = <%= acceptedCount %>;
            document.getElementById('hospitalCount').textContent = <%= pendingCount + acceptedCount + rejectedCount %>;
            document.getElementById('totalCount').textContent = <%= totalCount %>;
            document.getElementById('totalCountDisplay').textContent = <%= totalCount %>;
            document.getElementById('visibleCount').textContent = <%= totalCount %>;

           
            setupSearchAndFilters();
            
            
            <% if (!donorEligible && !isNewDonor) { %>
            initializeCountdown();
            <% } %>
        });

        function setupSearchAndFilters() {
            const searchInput = document.getElementById('searchInput');
            const hospitalFilter = document.getElementById('hospitalFilter');
            const locationFilter = document.getElementById('locationFilter');
            const clearFiltersBtn = document.getElementById('clearFilters');
            const tableRows = document.querySelectorAll('#requestsTable tbody tr');
            
            
            populateFilters();
            
            function performSearch() {
                const searchTerm = searchInput.value.toLowerCase();
                const selectedHospital = hospitalFilter.value.toLowerCase();
                const selectedLocation = locationFilter.value.toLowerCase();
                let visibleCount = 0;
                
                tableRows.forEach(row => {
                    const name = row.getAttribute('data-name');
                    const hospital = row.getAttribute('data-hospital');
                    const location = row.getAttribute('data-location');
                    
                    const matchesSearch = name.includes(searchTerm) || 
                                         hospital.includes(searchTerm) || 
                                         location.includes(searchTerm);
                    
                    const matchesHospital = !selectedHospital || hospital.includes(selectedHospital);
                    const matchesLocation = !selectedLocation || location.includes(selectedLocation);
                    
                    if (matchesSearch && matchesHospital && matchesLocation) {
                        row.style.display = '';
                        visibleCount++;
                    } else {
                        row.style.display = 'none';
                    }
                });
                
                
                document.getElementById('visibleCount').textContent = visibleCount;
            }
            
            function populateFilters() {
                const hospitals = new Set();
                const locations = new Set();
                
               
                const hospitalCells = document.querySelectorAll('td:nth-child(2)');
                const locationCells = document.querySelectorAll('td:nth-child(4)');
                
                hospitalCells.forEach(cell => {
                    const hospital = cell.querySelector('.hospital-name').textContent.trim();
                    if (hospital) hospitals.add(hospital);
                });
                
                locationCells.forEach(cell => {
                    const location = cell.textContent.trim();
                    if (location) locations.add(location);
                });
                
               
                hospitals.forEach(hospital => {
                    const option = document.createElement('option');
                    option.value = hospital;
                    option.textContent = hospital;
                    hospitalFilter.appendChild(option);
                });
                
                
                locations.forEach(location => {
                    const option = document.createElement('option');
                    option.value = location;
                    option.textContent = location;
                    locationFilter.appendChild(option);
                });
            }
            
           
            searchInput.addEventListener('input', performSearch);
            hospitalFilter.addEventListener('change', performSearch);
            locationFilter.addEventListener('change', performSearch);
            
           
            clearFiltersBtn.addEventListener('click', function() {
                searchInput.value = '';
                hospitalFilter.value = '';
                locationFilter.value = '';
                performSearch();
            });
            
            
            performSearch();
        }

        function initializeCountdown() {
            const donorEligible = <%= donorEligible ? "true" : "false" %>;
            const isNewDonor = <%= isNewDonor ? "true" : "false" %>;
            const millisUntilAfterDate = <%= (millisUntilAfterDate == Long.MAX_VALUE) ? -1L : millisUntilAfterDate %>;
            const countdownDisplay = document.getElementById('countdownDisplay');
            
            if (donorEligible || isNewDonor) {
                countdownDisplay.textContent = "Eligible Now";
                return;
            }
            
            if (millisUntilAfterDate <= 0) {
                countdownDisplay.textContent = "Eligibility Unknown";
                return;
            }
            
            function updateCountdown() {
                const now = new Date().getTime();
                const distance = millisUntilAfterDate - (now - Date.now());
                
                if (distance <= 0) {
                    countdownDisplay.textContent = "Eligible Now";
                    
                    setTimeout(() => location.reload(), 2000);
                    return;
                }
                
                const days = Math.floor(distance / (1000 * 60 * 60 * 24));
                const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                const seconds = Math.floor((distance % (1000 * 60)) / 1000);
                
                countdownDisplay.textContent = `${days}d ${hours}h ${minutes}m ${seconds}s`;
            }
            
            updateCountdown();
            setInterval(updateCountdown, 1000);
        }

        function showNotEligibleModal() {
            const modalBackdrop = document.getElementById('modalBackdrop');
            const modalMessage = document.getElementById('modalMessage');
            const countdownDisplay = document.getElementById('countdownDisplay');
            
            modalMessage.innerHTML = `You are not eligible to donate blood yet. <br><strong>Time remaining: ${countdownDisplay.textContent}</strong>`;
            modalBackdrop.style.display = 'flex';
        }

        function closeModal() {
            const modalBackdrop = document.getElementById('modalBackdrop');
            modalBackdrop.style.display = 'none';
        }
    </script>

<%
        } catch(Exception e) {
%>
    <div class="container">
        <div class="main-content">
            <div class="empty-state">
                <i class="fas fa-exclamation-triangle"></i>
                <h3>Error Loading Data</h3>
                <p><%= e.getMessage() %></p>
            </div>
        </div>
    </div>
<%
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception ex) {}
            try { if(ps != null) ps.close(); } catch(Exception ex) {}
            try { if(rs1 != null) rs1.close(); } catch(Exception ex) {}
            try { if(ps1 != null) ps1.close(); } catch(Exception ex) {}
            try { if(con != null) con.close(); } catch(Exception ex) {}
        }
%>
</body>
</html>