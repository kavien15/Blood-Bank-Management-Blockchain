<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="dbcon.Dbcon" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Portal - LifeBlood Bank</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        :root {
            --primary-red: #c8102e;
            --dark-red: #a50e26;
            --light-red: #fde8ea;
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

        body {
            background: linear-gradient(
                135deg,
                rgba(100, 0, 0, 0.7) 0%,
                rgba(200, 0, 0, 0.5) 100%
            );
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
            max-width: 1200px;
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

        .doctor-info {
            display: flex;
            align-items: center;
            gap: 15px;
            background: var(--light-red);
            padding: 12px 20px;
            border-radius: 10px;
            border: 1px solid rgba(200, 16, 46, 0.2);
        }

        .doctor-avatar {
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

        .patient-email {
            color: var(--dark-gray);
            font-size: 0.9rem;
        }

        .patient-mobile {
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

        .status-requested {
            background: #fff3cd;
            color: #856404;
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
            color: white;
        }

        .btn-accept:hover {
            background: #218838;
            transform: translateY(-2px);
            box-shadow: 0 3px 8px rgba(40, 167, 69, 0.3);
        }

        .btn-reject {
            background: var(--danger);
            color: white;
        }

        .btn-reject:hover {
            background: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 3px 8px rgba(220, 53, 69, 0.3);
        }

        .btn-view {
            background: var(--secondary-color);
            color: white;
        }

        .btn-view:hover {
            background: #1a252f;
            transform: translateY(-2px);
            box-shadow: 0 3px 8px rgba(44, 62, 80, 0.3);
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
                        <h1>
LifeStream Blood Bank</h1>
                        <div class="subtitle">Hospital Portal - Donor Requests</div>
                    </div>
                </div>
                <div class="doctor-info">
                    <div class="doctor-avatar">H</div>
                    <div>
                        <div style="font-weight: 600; color: var(--secondary-color);">Hospital Portal</div>
                        <div style="font-size: 0.9rem; color: var(--dark-gray);">Manage Blood Requests</div>
                    </div>
                </div>
            </div>
        </div>

       
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
                <div class="stat-label">Accepted Today</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-times-circle"></i>
                </div>
                <div class="stat-value" id="rejectedCount">0</div>
                <div class="stat-label">Rejected Today</div>
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
                    Pending Donor Requests
                </h2>
                <div class="controls">
                    <a href="doctorhome.jsp" class="back-btn">
                        <i class="fas fa-arrow-left"></i>
                        Back
                    </a>
                    <button class="refresh-btn" onclick="location.reload()">
                        <i class="fas fa-sync-alt"></i>
                        Refresh
                    </button>
                </div>
            </div>

           
            <div class="search-section">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchInput" placeholder="Search by patient name, hospital, or blood group...">
                </div>
                <div class="filter-group">
                    <select class="filter-select" id="bloodGroupFilter">
                        <option value="">All Blood Groups</option>
                        <option value="A+">A+</option>
                        <option value="A-">A-</option>
                        <option value="B+">B+</option>
                        <option value="B-">B-</option>
                        <option value="AB+">AB+</option>
                        <option value="AB-">AB-</option>
                        <option value="O+">O+</option>
                        <option value="O-">O-</option>
                    </select>
                    <select class="filter-select" id="hospitalFilter">
                        <option value="">All Hospitals</option>
                        
                    </select>
                    <button class="clear-btn" id="clearFilters">
                        <i class="fas fa-times"></i>
                        Clear Filters
                    </button>
                </div>
            </div>

            <div class="table-container">
                <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                int requestCount = 0;
                int acceptedCount = 0;
                int rejectedCount = 0;
                
                try {
                   
                    String[] possibleTables = {"patients", "patient", "blood.patients", "blood.patient"};
                    String[] possibleStatusColumns = {"status", "p_status", "request_status"};
                    String[] possibleNameColumns = {"p_name", "patient_name", "name", "patientname"};
                    String[] possibleEmailColumns = {"p_mail", "email", "patient_email", "p_email"};
                    String[] possibleMobileColumns = {"p_mobile", "mobile", "phone", "patient_mobile"};
                    String[] possibleBloodGroupColumns = {"p_bgp", "blood_group", "bloodgroup", "bgp"};
                    String[] possibleHospitalColumns = {"hospital", "h_name", "hospital_name"};
                    
                    con = Dbcon.create();
                    
                    
                    if (con == null || con.isClosed()) {
                        throw new SQLException("Database connection failed");
                    }
                    
                    boolean tableFound = false;
                    String actualTable = "";
                    String actualStatusCol = "";
                    String actualNameCol = "";
                    String actualEmailCol = "";
                    String actualMobileCol = "";
                    String actualBloodGroupCol = "";
                    String actualHospitalCol = "";
                    
                    
                    for (String table : possibleTables) {
                        for (String statusCol : possibleStatusColumns) {
                            try {
                                String testQuery = "SELECT COUNT(*) FROM " + table + " WHERE " + statusCol + " = 'requested' LIMIT 1";
                                ps = con.prepareStatement(testQuery);
                                rs = ps.executeQuery();
                                if (rs.next()) {
                                    actualTable = table;
                                    actualStatusCol = statusCol;
                                    tableFound = true;
                                    break;
                                }
                                if (rs != null) rs.close();
                                if (ps != null) ps.close();
                            } catch (SQLException e) {
                                
                                if (rs != null) try { rs.close(); } catch (SQLException ex) {}
                                if (ps != null) try { ps.close(); } catch (SQLException ex) {}
                            }
                        }
                        if (tableFound) break;
                    }
                    
                    if (!tableFound) {
                        throw new SQLException("Could not find the patients table with requested status");
                    }
                    
                   
                    String mainQuery = "SELECT * FROM " + actualTable + " WHERE " + actualStatusCol + " = 'requested'";
                    ps = con.prepareStatement(mainQuery);
                    rs = ps.executeQuery();
                    
                    if (!rs.isBeforeFirst()) {
                %>
                <div class="empty-state">
                    <i class="fas fa-inbox"></i>
                    <h3>No Pending Requests</h3>
                    <p>All blood requests have been processed. Check back later for new requests.</p>
                </div>
                <%
                    } else {
                %>
                <table id="requestsTable">
                    <thead>
                        <tr>
                            <th>Patient Details</th>
                            <th>Gender</th>
                            <th>Age</th>
                           
                            <th>Blood Group</th>
                            <th>Health Document</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        while(rs.next()) {
                            requestCount++;
                            
                            
                            String patientName = "";
                            String patientEmail = "";
                            String patientMobile = "";
                            String hospital = "";
                            String bloodGroup = "";
                            String status = "";
                            int id = 0;
                            
                            try { id = rs.getInt("id"); } catch (SQLException e) { 
                                try { id = rs.getInt("patient_id"); } catch (SQLException ex) {}
                            }
                            
                            
                            for (String col : possibleNameColumns) {
                                try { 
                                    patientName = rs.getString(col); 
                                    if (patientName != null) break;
                                } catch (SQLException e) {}
                            }
                            
                            for (String col : possibleEmailColumns) {
                                try { 
                                    patientEmail = rs.getString(col); 
                                    if (patientEmail != null) break;
                                } catch (SQLException e) {}
                            }
                            
                            for (String col : possibleMobileColumns) {
                                try { 
                                    patientMobile = rs.getString(col); 
                                    if (patientMobile != null) break;
                                } catch (SQLException e) {}
                            }
                            
                            for (String col : possibleHospitalColumns) {
                                try { 
                                    hospital = rs.getString(col); 
                                    if (hospital != null) break;
                                } catch (SQLException e) {}
                            }
                            
                            for (String col : possibleBloodGroupColumns) {
                                try { 
                                    bloodGroup = rs.getString(col); 
                                    if (bloodGroup != null) break;
                                } catch (SQLException e) {}
                            }
                            
                            for (String col : possibleStatusColumns) {
                                try { 
                                    status = rs.getString(col); 
                                    if (status != null) break;
                                } catch (SQLException e) {}
                            }
                        %>
                        <tr data-name="<%= (patientName != null ? patientName : "").toLowerCase() %>" 
                            data-hospital="<%= (hospital != null ? hospital : "").toLowerCase() %>" 
                            data-bloodgroup="<%= (bloodGroup != null ? bloodGroup : "").toLowerCase() %>">
                            <td>
                                <div class="patient-name"><%= patientName != null ? patientName : "N/A" %></div>
                                <div class="patient-email"><%= patientEmail != null ? patientEmail : "N/A" %></div>
                                <div class="patient-mobile"><%= patientMobile != null ? patientMobile : "N/A" %></div>
                            </td>
                            <td><%= rs.getString(5) %></td>
                            <td><%= rs.getString(6) %></td>
                           
                            
                            <td>
                                <span class="blood-group"><%= bloodGroup != null ? bloodGroup : "N/A" %></span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <a href="viewbloodreuestpatientdocument.jsp?id=<%= id %>" 
                                       class="btn btn-view" 
                                       target="_blank">
                                        <i class="fas fa-eye"></i> View
                                    </a>
                                </div>
                            </td>
                            <td>
                                <span class="status-badge status-requested">
                                    <i class="fas fa-clock"></i> <%= status != null ? status : "requested" %>
                                </span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <a href="updatestatus.jsp?id=<%= id %>&status=accepted&from=doctor" 
                                       class="btn btn-accept" 
                                       onclick="return confirm('Are you sure you want to accept this request?')">
                                        <i class="fas fa-check"></i> Accept
                                    </a>
                                   
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
                } catch (Exception e) {
                   
                    String errorMessage = e.getMessage();
                %>
                <div class="empty-state">
                    <i class="fas fa-exclamation-triangle"></i>
                    <h3>Database Error</h3>
                    <p>Unable to load requests. Please try again later.</p>
                    <div style="margin-top: 20px; padding: 15px; background: #ffe6e6; border-radius: 8px; text-align: left; max-width: 600px; margin: 20px auto;">
                        <h4 style="color: var(--danger); margin-bottom: 10px;">Debug Information:</h4>
                        <p style="color: #666; font-family: monospace; font-size: 12px; word-break: break-all;">
                            Error: <%= errorMessage %><br>
                            Please check:
                            <ul style="text-align: left; margin: 10px 0; padding-left: 20px;">
                                <li>Database connection</li>
                                <li>Table name (should be 'patients' or 'patient')</li>
                                <li>Column names in the table</li>
                                <li>Database permissions</li>
                            </ul>
                        </p>
                    </div>
                </div>
                <%
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (con != null) con.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                %>
            </div>
        </div>

       
    </div>

    <script>
       
        document.addEventListener('DOMContentLoaded', function() {
            const pendingCount = <%= requestCount %>;
            document.getElementById('pendingCount').textContent = pendingCount;
            document.getElementById('totalCount').textContent = pendingCount;
            
            
            document.getElementById('acceptedCount').textContent = 0;
            document.getElementById('rejectedCount').textContent = 0;
            
          
            populateHospitalFilter();
            
            
            setupSearchAndFilters();
        });

       
        function populateHospitalFilter() {
            const hospitalFilter = document.getElementById('hospitalFilter');
            const hospitals = new Set();
            
            
            const hospitalCells = document.querySelectorAll('td:nth-child(2)');
            hospitalCells.forEach(cell => {
                hospitals.add(cell.textContent.trim());
            });
            
            
            while (hospitalFilter.children.length > 1) {
                hospitalFilter.removeChild(hospitalFilter.lastChild);
            }
            
            
            hospitals.forEach(hospital => {
                if (hospital && hospital !== "N/A") {
                    const option = document.createElement('option');
                    option.value = hospital;
                    option.textContent = hospital;
                    hospitalFilter.appendChild(option);
                }
            });
        }

       
        function setupSearchAndFilters() {
            const searchInput = document.getElementById('searchInput');
            const bloodGroupFilter = document.getElementById('bloodGroupFilter');
            const hospitalFilter = document.getElementById('hospitalFilter');
            const clearFiltersBtn = document.getElementById('clearFilters');
            const tableRows = document.querySelectorAll('#requestsTable tbody tr');
            
           
            function performSearch() {
                const searchTerm = searchInput.value.toLowerCase();
                const selectedBloodGroup = bloodGroupFilter.value;
                const selectedHospital = hospitalFilter.value;
                
                tableRows.forEach(row => {
                    const name = row.getAttribute('data-name');
                    const hospital = row.getAttribute('data-hospital');
                    const bloodGroup = row.getAttribute('data-bloodgroup');
                    
                    const matchesSearch = name.includes(searchTerm) || 
                                         hospital.includes(searchTerm) || 
                                         bloodGroup.includes(searchTerm);
                    
                    const matchesBloodGroup = !selectedBloodGroup || bloodGroup === selectedBloodGroup;
                    const matchesHospital = !selectedHospital || hospital === selectedHospital;
                    
                    if (matchesSearch && matchesBloodGroup && matchesHospital) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
                
                
                updateVisibleCount();
            }
            
            
            function updateVisibleCount() {
                const visibleRows = document.querySelectorAll('#requestsTable tbody tr[style=""]').length;
                document.getElementById('pendingCount').textContent = visibleRows;
            }
            
           
            searchInput.addEventListener('input', performSearch);
            bloodGroupFilter.addEventListener('change', performSearch);
            hospitalFilter.addEventListener('change', performSearch);
            
            
            clearFiltersBtn.addEventListener('click', function() {
                searchInput.value = '';
                bloodGroupFilter.value = '';
                hospitalFilter.value = '';
                performSearch();
            });
            
           
            performSearch();
        }
    </script>
</body>
</html>