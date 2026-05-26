<%@page import="com.itextpdf.text.log.SysoCounter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="dbcon.Dbcon"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="java.time.*" %>
<%@page import="java.time.format.DateTimeFormatter" %>
<%@page import="java.time.format.DateTimeParseException" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Blood Donation Camps</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    :root {
        --primary-red: #c8102e;
        --dark-red: #9c0d24;
        --light-red: #f8d7da;
        --light-pink: #ffe6e6;
        --white: #ffffff;
        --dark-gray: #333;
        --light-gray: #f8f9fa;
        --success-green: #28a745;
        --warning-orange: #ffc107;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
        background: linear-gradient(135deg, #ffe6e6 0%, #ffcccc 50%, #ffb3b3 100%);
        color: #333;
        line-height: 1.6;
        min-height: 100vh;
        position: relative;
        overflow-x: hidden;
    }

   
    .medical-background {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        pointer-events: none;
        z-index: -1;
        opacity: 0.1;
    }

    .medical-background i {
        position: absolute;
        font-size: 2rem;
        color: var(--primary-red);
    }

    .medical-background i:nth-child(1) { top: 10%; left: 5%; }
    .medical-background i:nth-child(2) { top: 20%; right: 10%; }
    .medical-background i:nth-child(3) { bottom: 30%; left: 15%; }
    .medical-background i:nth-child(4) { bottom: 15%; right: 5%; }
    .medical-background i:nth-child(5) { top: 50%; left: 8%; }
    .medical-background i:nth-child(6) { top: 60%; right: 15%; }

    .container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 20px;
    }

  
    .btn-back {
        background: var(--dark-gray);
        color: var(--white);
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
        margin-bottom: 20px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }

    .btn-back:hover {
        background: #495057;
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(0,0,0,0.15);
    }

    .header {
        background: linear-gradient(135deg, var(--primary-red), var(--dark-red));
        color: white;
        padding: 2rem;
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(200, 16, 46, 0.3);
        margin-bottom: 2rem;
        text-align: center;
        position: relative;
        overflow: hidden;
    }

    .header-content {
        position: relative;
        z-index: 1;
    }

    .logo {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 15px;
        margin-bottom: 1rem;
    }

    .logo-icon {
        font-size: 3rem;
        color: white;
        animation: pulse 2s infinite;
    }

    @keyframes pulse {
        0% { transform: scale(1); }
        50% { transform: scale(1.1); }
        100% { transform: scale(1); }
    }

    .logo-text {
        font-size: 2.5rem;
        font-weight: 700;
    }

    .page-title {
        font-size: 2.2rem;
        margin-bottom: 0.5rem;
    }

    .page-subtitle {
        font-size: 1.2rem;
        opacity: 0.9;
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

    .eligibility-banner.eligible {
        border-left: 4px solid var(--success-green);
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

    .eligibility-banner.eligible .eligibility-icon {
        background: var(--success-green);
    }

    .eligibility-content {
        flex: 1;
    }

    .eligibility-title {
        font-weight: 600;
        color: var(--dark-gray);
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

    
    .search-section {
        background: white;
        border-radius: 12px;
        padding: 1.5rem;
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        margin-bottom: 2rem;
        display: flex;
        flex-wrap: wrap;
        gap: 1rem;
        align-items: center;
    }

    .search-box {
        display: flex;
        align-items: center;
        background: var(--light-gray);
        border: 2px solid #e9ecef;
        border-radius: 8px;
        padding: 0 1rem;
        flex-grow: 1;
        max-width: 500px;
        transition: all 0.3s;
    }

    .search-box:focus-within {
        border-color: var(--primary-red);
        box-shadow: 0 0 0 3px rgba(200, 16, 46, 0.1);
    }

    .search-box input {
        border: none;
        padding: 12px 0;
        width: 100%;
        outline: none;
        font-size: 1rem;
        background: transparent;
    }

    .search-box i {
        color: #666;
        margin-right: 10px;
    }

    .filter-group {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }

    .filter-group label {
        font-size: 0.9rem;
        font-weight: 600;
        color: #555;
    }

    .filter-group select {
        padding: 10px 15px;
        border: 2px solid #e9ecef;
        border-radius: 8px;
        font-size: 0.9rem;
        min-width: 180px;
        background: white;
        cursor: pointer;
        transition: all 0.3s;
    }

    .filter-group select:focus {
        border-color: var(--primary-red);
        box-shadow: 0 0 0 3px rgba(200, 16, 46, 0.1);
        outline: none;
    }

    .btn-apply {
        background: var(--primary-red);
        color: var(--white);
        border: none;
        padding: 10px 20px;
        border-radius: 8px;
        cursor: pointer;
        font-weight: 600;
        transition: background 0.3s;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .btn-apply:hover {
        background: var(--dark-red);
    }

    .btn-clear {
        background: var(--dark-gray);
        color: var(--white);
        border: none;
        padding: 10px 20px;
        border-radius: 8px;
        cursor: pointer;
        font-weight: 600;
        transition: background 0.3s;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .btn-clear:hover {
        background: #495057;
    }

    .stats-cards {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 1.5rem;
        margin-bottom: 2rem;
    }

    .stat-card {
        background: white;
        padding: 1.5rem;
        border-radius: 10px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        text-align: center;
        border-top: 4px solid var(--primary-red);
        transition: transform 0.3s;
        position: relative;
        overflow: hidden;
    }

    .stat-card:hover {
        transform: translateY(-5px);
    }

    .stat-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 3px;
        background: linear-gradient(90deg, var(--primary-red), var(--dark-red));
    }

    .stat-number {
        font-size: 2.5rem;
        font-weight: bold;
        color: var(--primary-red);
        margin-bottom: 0.5rem;
    }

    .stat-label {
        color: #666;
        font-size: 0.9rem;
        font-weight: 600;
    }

    .camps-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
        gap: 1.5rem;
        margin-bottom: 2rem;
    }

    .camp-card {
        background: white;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        transition: all 0.3s ease;
        border-left: 5px solid var(--primary-red);
        position: relative;
    }

    .camp-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 30px rgba(0,0,0,0.15);
    }

    .camp-badge {
        position: absolute;
        top: 15px;
        right: 15px;
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 600;
        z-index: 2;
    }

    .badge-active {
        background: var(--success-green);
        color: white;
    }

    .badge-upcoming {
        background: var(--warning-orange);
        color: var(--dark-gray);
    }

    .badge-past {
        background: #6c757d;
        color: white;
    }

    .camp-header {
        background: linear-gradient(135deg, var(--primary-red), var(--dark-red));
        color: white;
        padding: 1.5rem;
        position: relative;
    }

    .camp-title {
        font-size: 1.4rem;
        font-weight: 600;
        margin-bottom: 0.5rem;
    }

    .camp-date {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        font-size: 1rem;
        opacity: 0.9;
    }

    .camp-body {
        padding: 1.5rem;
    }

    .camp-detail {
        display: flex;
        align-items: flex-start;
        gap: 1rem;
        margin-bottom: 1rem;
    }

    .camp-detail i {
        color: var(--primary-red);
        margin-top: 0.2rem;
        min-width: 20px;
        text-align: center;
    }

    .camp-detail-content h4 {
        font-weight: 600;
        margin-bottom: 0.2rem;
        color: var(--dark-gray);
        font-size: 0.95rem;
    }

    .camp-detail-content p {
        color: #666;
        font-size: 0.9rem;
    }

    .camp-actions {
        display: flex;
        gap: 0.5rem;
        margin-top: 1.5rem;
        padding-top: 1rem;
        border-top: 1px solid #eee;
    }

    .donate-btn {
        flex: 1;
        padding: 0.8rem 1.5rem;
        background: var(--primary-red);
        color: white;
        border: none;
        border-radius: 6px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        text-decoration: none;
        font-size: 0.95rem;
    }

    .donate-btn:hover {
        background: var(--dark-red);
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(200, 16, 46, 0.3);
    }

    .donate-btn:disabled {
        background: #6c757d;
        cursor: not-allowed;
        transform: none;
        box-shadow: none;
        opacity: 0.6;
    }

    .empty-state {
        text-align: center;
        padding: 3rem;
        background: white;
        border-radius: 12px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        grid-column: 1 / -1;
    }

    .empty-state i {
        font-size: 4rem;
        color: #ddd;
        margin-bottom: 1rem;
    }

    .empty-state h3 {
        color: #666;
        margin-bottom: 0.5rem;
    }

    .no-results {
        text-align: center;
        padding: 3rem;
        background: white;
        border-radius: 12px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        grid-column: 1 / -1;
        display: none;
    }

    .footer {
        text-align: center;
        padding: 2rem;
        color: #666;
        margin-top: 2rem;
    }

    .emergency-contact {
        background: var(--primary-red);
        color: white;
        padding: 1rem 2rem;
        border-radius: 10px;
        display: inline-block;
        margin-top: 1rem;
        font-weight: 600;
        box-shadow: 0 5px 15px rgba(200, 16, 46, 0.3);
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
        color: var(--dark-gray);
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
        .container {
            padding: 10px;
        }
        
        .header {
            padding: 1.5rem;
        }
        
        .logo-text {
            font-size: 2rem;
        }
        
        .page-title {
            font-size: 1.8rem;
        }
        
        .camps-grid {
            grid-template-columns: 1fr;
        }
        
        .stats-cards {
            grid-template-columns: repeat(2, 1fr);
        }
        
        .search-section {
            flex-direction: column;
            align-items: stretch;
        }
        
        .search-box {
            max-width: 100%;
        }
    }

    @media (max-width: 480px) {
        .stats-cards {
            grid-template-columns: 1fr;
        }
        
        .camp-card {
            margin: 0 10px;
        }
        
        .camp-actions {
            flex-direction: column;
        }
    }
</style>
</head>
<body>
<%
Object donorobj=session.getAttribute("email");
String donor=(donorobj!=null)?donorobj.toString() : " ";


String donorBeforeDateStr = "";
String donorAfterDateStr = "";
boolean donorEligible = false;
long millisUntilAfterDate = 0L;
boolean isNewDonor = false;

try {
    Connection conCheck = Dbcon.create();
    PreparedStatement psCheck = conCheck.prepareStatement("SELECT * FROM `blood`.`donatedetails` WHERE `Doner mail` = ? ORDER BY beforedate DESC LIMIT 1");
    psCheck.setString(1, donor);
    ResultSet rsCheck = psCheck.executeQuery();
    
    if (rsCheck.next()) {
        try {
            donorBeforeDateStr = rsCheck.getString("beforedate");
        } catch(Exception ex) {
            donorBeforeDateStr = "";
        }
        try {
            donorAfterDateStr = rsCheck.getString("afterdate");
        } catch(Exception ex) {
            donorAfterDateStr = "";
        }
    } else {
 
        isNewDonor = true;
    }
    

    if (rsCheck != null) rsCheck.close();
    if (psCheck != null) psCheck.close();
    if (conCheck != null) conCheck.close();
    
    
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
} catch(Exception e) {
   
    donorEligible = false;
}
%>


<div class="medical-background">
    <i class="fas fa-heartbeat"></i>
    <i class="fas fa-tint"></i>
    <i class="fas fa-stethoscope"></i>
    <i class="fas fa-ambulance"></i>
    <i class="fas fa-hospital"></i>
    <i class="fas fa-user-md"></i>
</div>

<div class="container">

    <a href="donorhome.jsp" class="btn-back">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>

    <div class="header">
        <div class="header-content">
            <div class="logo">
                <i class="fas fa-tint logo-icon"></i>
                <div class="logo-text">LifeStream Blood Bank</div>
            </div>
            <h1 class="page-title">Available Blood Donation Camps</h1>
            <p class="page-subtitle">Find and register for blood donation camps near you</p>
        </div>
    </div>

    
    <div class="eligibility-banner <%= donorEligible ? "eligible" : "" %>" id="eligibilityBanner">
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
        
    </div>

   
    <div class="search-section">
        <div class="search-box">
            <i class="fas fa-search"></i>
            <input type="text" id="search-input" placeholder="Search camps by name, location, or hospital...">
        </div>
        <div class="filter-group">
            <label for="date-filter">Filter by Date</label>
            <select id="date-filter">
                <option value="all">All Dates</option>
                <option value="today">Today</option>
                <option value="upcoming">Upcoming</option>
                <option value="past">Past Camps</option>
            </select>
        </div>
        <button class="btn-apply" onclick="applyFilters()">
            <i class="fas fa-filter"></i> Apply Filters
        </button>
        <button class="btn-clear" onclick="clearFilters()">
            <i class="fas fa-times"></i> Clear
        </button>
    </div>

    <div class="stats-cards">
        <div class="stat-card">
            <div class="stat-number" id="total-camps">0</div>
            <div class="stat-label">Available Camps</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="active-camps">0</div>
            <div class="stat-label">Active Today</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="upcoming-camps">0</div>
            <div class="stat-label">Upcoming Camps</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="your-donations">0</div>
            <div class="stat-label">Your Donations</div>
        </div>
    </div>

    <div class="camps-grid" id="camps-container">
        <%
        Connection con= Dbcon.create();
        PreparedStatement ps=con.prepareStatement("SELECT * FROM `blood`.`campdetails`");
        ResultSet rs=ps.executeQuery();
        
        int campCount = 0;
        int activeCount = 0;
        int upcomingCount = 0;
        
        while(rs.next()) {
            campCount++;
            
            String campDate = rs.getString(9);
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
            java.util.Date dateObj = sdf.parse(campDate);
            java.util.Date today = new java.util.Date();
            
            String badgeClass = "badge-upcoming";
            String badgeText = "Upcoming";
            
            if (dateObj.equals(today)) {
                activeCount++;
                badgeClass = "badge-active";
                badgeText = "Active Today";
            } else if (dateObj.after(today)) {
                upcomingCount++;
                badgeClass = "badge-upcoming";
                badgeText = "Upcoming";
            } else {
                badgeClass = "badge-past";
                badgeText = "Completed";
            }
        %>
        
        <div class="camp-card" data-camp-name="<%=rs.getString(2).toLowerCase()%>" 
             data-location="<%=rs.getString(5).toLowerCase()%>"
             data-hospital="<%=rs.getString(3).toLowerCase()%>"
             data-date="<%=campDate%>"
             data-date-status="<%=badgeText.toLowerCase().replace(' ', '-')%>">
            <div class="camp-badge <%=badgeClass%>">
                <i class="fas fa-circle"></i> <%=badgeText%>
            </div>
            <div class="camp-header">
                <div class="camp-title"><%=rs.getString(2)%></div>
                <div class="camp-date">
                    <i class="far fa-calendar-alt"></i>
                    <%=rs.getString(9)%>
                </div>
            </div>
            <div class="camp-body">
                <div class="camp-detail">
                    <i class="fas fa-envelope"></i>
                    <div class="camp-detail-content">
                        <h4>Hospital Email</h4>
                        <p><%=rs.getString(3)%></p>
                    </div>
                </div>
                <div class="camp-detail">
                    <i class="fas fa-phone"></i>
                    <div class="camp-detail-content">
                        <h4>Contact Number</h4>
                        <p><%=rs.getString(4)%></p>
                    </div>
                </div>
                <div class="camp-detail">
                    <i class="fas fa-map-marker-alt"></i>
                    <div class="camp-detail-content">
                        <h4>Address</h4>
                        <p><%=rs.getString(5)%></p>
                    </div>
                </div>
               
                <div class="camp-actions">
                    <% if (donorEligible) { %>
                        <a href="campdonateupdate.jsp?
                         bp=<%= rs.getString(9) %>
                                   &hname=<%= rs.getString(2) %>
                                   &hmail=<%= rs.getString(3) %>
                                   &hcontact=<%= rs.getString(4) %>
                                   &date=<%= rs.getString(9) %>
                                   " class="donate-btn">
                            <i class="fas fa-hand-holding-medical"></i> Register for Donation
                        </a>
                    <% } else { %>
                        <button class="donate-btn" disabled onclick="showNotEligibleModal()">
                            <i class="fas fa-hand-holding-medical"></i> Not Eligible
                        </button>
                    <% } %>
                </div>
            </div>
        </div>
        <% } 
        
        if (campCount == 0) { %>
        <div class="empty-state">
            <i class="fas fa-clipboard-list"></i>
            <h3>No Available Camps</h3>
            <p>There are currently no blood donation camps available for registration.</p>
        </div>
        <% } %>
        
        
        <div class="no-results" id="no-results">
            <i class="fas fa-search"></i>
            <h3>No Matching Camps Found</h3>
            <p>Try adjusting your search criteria or filters</p>
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
    
    document.getElementById('total-camps').textContent = '<%= campCount %>';
    document.getElementById('active-camps').textContent = '<%= activeCount %>';
    document.getElementById('upcoming-camps').textContent = '<%= upcomingCount %>';
    document.getElementById('your-donations').textContent = '0'; 
    
    
    <% if (!donorEligible && !isNewDonor) { %>
    initializeCountdown();
    <% } %>

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

   
    function applyFilters() {
        const searchTerm = document.getElementById('search-input').value.toLowerCase();
        const dateFilter = document.getElementById('date-filter').value;
        const campCards = document.querySelectorAll('.camp-card');
        
        let visibleCount = 0;
        
        campCards.forEach(card => {
            const campName = card.getAttribute('data-camp-name');
            const location = card.getAttribute('data-location');
            const hospital = card.getAttribute('data-hospital');
            const dateStatus = card.getAttribute('data-date-status');
            
            
            const searchMatch = searchTerm === '' || 
                campName.includes(searchTerm) || 
                location.includes(searchTerm) || 
                hospital.includes(searchTerm);
            
            
            let dateMatch = true;
            if (dateFilter !== 'all') {
                if (dateFilter === 'today') {
                    dateMatch = dateStatus === 'active-today';
                } else if (dateFilter === 'upcoming') {
                    dateMatch = dateStatus === 'upcoming';
                } else if (dateFilter === 'past') {
                    dateMatch = dateStatus === 'completed';
                }
            }
            
            if (searchMatch && dateMatch) {
                card.style.display = 'block';
                visibleCount++;
            } else {
                card.style.display = 'none';
            }
        });
        
        
        const noResults = document.getElementById('no-results');
        const emptyState = document.querySelector('.empty-state');
        
        if (visibleCount === 0 && emptyState) {
            emptyState.style.display = 'none';
            noResults.style.display = 'block';
        } else if (visibleCount === 0) {
            noResults.style.display = 'block';
        } else {
            noResults.style.display = 'none';
            if (emptyState) emptyState.style.display = 'block';
        }
        
        
        document.getElementById('total-camps').textContent = visibleCount;
    }

    function clearFilters() {
        document.getElementById('search-input').value = '';
        document.getElementById('date-filter').value = 'all';
        applyFilters();
        
        document.getElementById('total-camps').textContent = '<%= campCount %>';
    }

    function showNotEligibleModal() {
        const modalBackdrop = document.getElementById('modalBackdrop');
        const modalMessage = document.getElementById('modalMessage');
        const countdownDisplay = document.getElementById('countdownDisplay');
        
        <% if (!donorEligible && !isNewDonor) { %>
        modalMessage.innerHTML = `You are not eligible to donate blood yet. <br><strong>Time remaining: ${countdownDisplay.textContent}</strong>`;
        <% } else { %>
        modalMessage.innerHTML = `You are not eligible to donate blood at this time. Please check your eligibility status.`;
        <% } %>
        modalBackdrop.style.display = 'flex';
    }

    function closeModal() {
        const modalBackdrop = document.getElementById('modalBackdrop');
        modalBackdrop.style.display = 'none';
    }

    
    document.getElementById('search-input').addEventListener('input', applyFilters);
    document.getElementById('date-filter').addEventListener('change', applyFilters);

    
    document.addEventListener('DOMContentLoaded', function() {
        const cards = document.querySelectorAll('.camp-card');
        cards.forEach((card, index) => {
            card.style.animationDelay = `${index * 0.1}s`;
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';
            card.style.animation = 'fadeInUp 0.5s ease forwards';
        });
        
        
        applyFilters();
    });

   
    const style = document.createElement('style');
    style.textContent = `
        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    `;
    document.head.appendChild(style);
</script>
</body>
</html>