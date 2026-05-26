<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="dbcon.Dbcon"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.ParseException"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Blood Bank - Donor Management</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    :root {
        --primary: #c62828;
        --primary-dark: #8e0000;
        --primary-light: #ff5f52;
        --secondary: #2c3e50;
        --light: #f8f9fa;
        --gray: #e9ecef;
        --dark-gray: #6c757d;
        --success: #28a745;
        --warning: #ffc107;
        --danger: #dc3545;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    
    body {
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        color: var(--secondary);
        line-height: 1.6;
        min-height: 100vh;
    }
    
    .container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 20px;
    }
    
   
    .back-button {
        background: var(--secondary);
        color: var(--light);
        border: none;
        padding: 12px 25px;
        border-radius: 8px;
        font-weight: 600;
        cursor: pointer;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 10px;
        transition: all 0.3s ease;
        margin-bottom: 20px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }

    .back-button:hover {
        background: #1a252f;
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        text-decoration: none;
        color: var(--light);
    }
    
    
    header {
        background: linear-gradient(135deg, var(--primary), var(--primary-dark));
        color: white;
        padding: 2.5rem;
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(198, 40, 40, 0.3);
        margin-bottom: 2rem;
        text-align: center;
        position: relative;
        overflow: hidden;
    }

    header::before {
        content: '';
        position: absolute;
        top: -50%;
        left: -50%;
        width: 200%;
        height: 200%;
        background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
        background-size: 20px 20px;
        animation: float 20s linear infinite;
    }

    @keyframes float {
        0% { transform: translate(0, 0) rotate(0deg); }
        100% { transform: translate(-20px, -20px) rotate(360deg); }
    }

    .header-content {
        position: relative;
        z-index: 2;
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
        background: var(--light);
        border: 2px solid var(--gray);
        border-radius: 8px;
        padding: 0 1rem;
        flex-grow: 1;
        max-width: 500px;
        transition: all 0.3s;
    }

    .search-box:focus-within {
        border-color: var(--primary);
        box-shadow: 0 0 0 3px rgba(198, 40, 40, 0.1);
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
        color: var(--dark-gray);
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
        min-width: 150px;
        background: white;
        cursor: pointer;
        transition: all 0.3s;
    }

    .filter-group select:focus {
        border-color: var(--primary);
        box-shadow: 0 0 0 3px rgba(198, 40, 40, 0.1);
        outline: none;
    }

    .btn-clear {
        background: var(--dark-gray);
        color: var(--light);
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
        background: #5a6268;
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
        border-top: 4px solid var(--primary);
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
        background: linear-gradient(90deg, var(--primary), var(--primary-dark));
    }

    .stat-number {
        font-size: 2.5rem;
        font-weight: bold;
        color: var(--primary);
        margin-bottom: 0.5rem;
    }

    .stat-label {
        color: var(--dark-gray);
        font-size: 0.9rem;
        font-weight: 600;
    }
    
   
    .dashboard {
        background: white;
        border-radius: 12px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        overflow: hidden;
        margin-bottom: 2rem;
    }
    
    .table-container {
        overflow-x: auto;
    }
    
    table {
        width: 100%;
        border-collapse: collapse;
        min-width: 1000px;
    }
    
    thead {
        background: linear-gradient(135deg, var(--primary), var(--primary-dark));
    }
    
    th {
        padding: 1.2rem 1rem;
        text-align: left;
        font-weight: 600;
        color: white;
        font-size: 0.95rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    td {
        padding: 1.2rem 1rem;
        color: var(--secondary);
        font-size: 0.95rem;
        border-bottom: 1px solid var(--gray);
    }
    
    tbody tr {
        transition: all 0.3s;
    }
    
    tbody tr:hover {
        background: rgba(198, 40, 40, 0.05);
        transform: scale(1.01);
    }
    
    .blood-group {
        background: rgba(198, 40, 40, 0.1);
        color: var(--primary);
        padding: 6px 12px;
        border-radius: 20px;
        font-weight: bold;
        font-size: 0.85rem;
        display: inline-block;
    }
    
    .contact-info {
        font-size: 0.9rem;
        color: var(--dark-gray);
    }
    
    .donation-type {
        background: rgba(44, 62, 80, 0.1);
        color: var(--secondary);
        padding: 6px 12px;
        border-radius: 20px;
        font-weight: 500;
        font-size: 0.85rem;
        display: inline-block;
    }
    
    .days-remaining {
        padding: 6px 12px;
        border-radius: 20px;
        font-weight: bold;
        text-align: center;
        font-size: 0.85rem;
        display: inline-block;
    }
    
    .eligible {
        background: rgba(40, 167, 69, 0.1);
        color: var(--success);
    }
    
    .waiting {
        background: rgba(255, 193, 7, 0.1);
        color: var(--warning);
    }
    
    .empty-state {
        text-align: center;
        padding: 3rem;
        background: white;
        border-radius: 12px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        margin-bottom: 2rem;
    }

    .empty-state i {
        font-size: 4rem;
        color: var(--gray);
        margin-bottom: 1rem;
    }

    .empty-state h3 {
        color: var(--dark-gray);
        margin-bottom: 0.5rem;
    }

    .no-results {
        text-align: center;
        padding: 3rem;
        background: white;
        border-radius: 12px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        display: none;
    }
    
    footer {
        text-align: center;
        padding: 2rem;
        color: var(--dark-gray);
        margin-top: 2rem;
    }
    
   
    @media (max-width: 768px) {
        .container {
            padding: 10px;
        }
        
        header {
            padding: 1.5rem;
        }
        
        .logo-text {
            font-size: 2rem;
        }
        
        .page-title {
            font-size: 1.8rem;
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
        
        .back-button, .btn-clear {
            width: 100%;
            justify-content: center;
        }
    }
</style>
</head>
<body>
    <div class="container">
       
        <a href="doctorhome.jsp" class="back-button">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>

        
        <header>
            <div class="header-content">
                <div class="logo">
                    <i class="fas fa-tint logo-icon"></i>
                    <div class="logo-text">
LifeStream Blood Bank</div>
                </div>
                <h1 class="page-title">Donor Management System</h1>
                <p class="page-subtitle">Manage donor records and track donation eligibility</p>
            </div>
        </header>

        
        <div class="search-section">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="search-input" placeholder="Search by patient name, hospital, donor email...">
            </div>
            <div class="filter-group">
                <label for="blood-group-filter">Blood Group</label>
                <select id="blood-group-filter">
                    <option value="all">All Blood Groups</option>
                    <option value="A+">A+</option>
                    <option value="A-">A-</option>
                    <option value="B+">B+</option>
                    <option value="B-">B-</option>
                    <option value="O+">O+</option>
                    <option value="O-">O-</option>
                    <option value="AB+">AB+</option>
                    <option value="AB-">AB-</option>
                </select>
            </div>
            <div class="filter-group">
                <label for="eligibility-filter">Eligibility</label>
                <select id="eligibility-filter">
                    <option value="all">All Donors</option>
                    <option value="eligible">Eligible Now</option>
                    <option value="waiting">Waiting Period</option>
                </select>
            </div>
            <button class="btn-clear" onclick="clearFilters()">
                <i class="fas fa-times"></i> Clear Filters
            </button>
        </div>

       
        <div class="stats-cards">
            <div class="stat-card">
                <div class="stat-number" id="total-donors">0</div>
                <div class="stat-label">Total Donors</div>
            </div>
            <div class="stat-card">
                <div class="stat-number" id="eligible-donors">0</div>
                <div class="stat-label">Eligible Now</div>
            </div>
            <div class="stat-card">
                <div class="stat-number" id="waiting-donors">0</div>
                <div class="stat-label">In Waiting Period</div>
            </div>
            <div class="stat-card">
                <div class="stat-number" id="blood-groups">0</div>
                <div class="stat-label">Blood Groups</div>
            </div>
        </div>

       
        <div class="dashboard">
            <div class="table-container">
                <table id="donors-table">
                    <thead>
                        <tr>
                            <th>Patient Name</th>
                            <th>Hospital Name</th>
                            <th>Blood Group</th>
                            <th>Donation Type</th>
                            <th>Donor Email</th>
                            <th>Donor Contact</th>
                            <th>Next Donation</th>
                        </tr>
                    </thead>
                    <tbody id="donors-tbody">
                        <%
                        Connection con = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;
                        
                        int totalDonors = 0;
                        int eligibleDonors = 0;
                        int waitingDonors = 0;
                        int bloodGroupsCount = 0;
                        
                        try {
                            con = Dbcon.create();
                            ps = con.prepareStatement("SELECT * FROM `blood`.`donatedetails`");
                            rs = ps.executeQuery();
                            
                            if (!rs.isBeforeFirst()) {
                        %>
                                <tr>
                                    <td colspan="7">
                                        <div class="empty-state">
                                            <i class="fas fa-users"></i>
                                            <h3>No Donor Records Found</h3>
                                            <p>There are currently no donor records in the system.</p>
                                        </div>
                                    </td>
                                </tr>
                        <%
                            } else {
                                while(rs.next()) {
                                    totalDonors++;
                                    String join_date = rs.getString(8);  
                                    String end_date = rs.getString(9);  
                                    
                                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd-MM-yyyy");  
                                    LocalDateTime now = LocalDateTime.now();  
                                    
                                    String type = "";
                                    boolean isEligible = false;
                                    try {   
                                        SimpleDateFormat obj = new SimpleDateFormat("dd-MM-yyyy");   
                                        Date date1 = obj.parse(dtf.format(now));   
                                        Date date2 = obj.parse(end_date);   
                                        
                                        long time_difference = date2.getTime() - date1.getTime();  
                                        long days_difference = (time_difference / (1000*60*60*24));   
                                        
                                        type = String.valueOf(days_difference);
                                        if (days_difference <= 0) {
                                            isEligible = true;
                                            eligibleDonors++;
                                        } else {
                                            waitingDonors++;
                                        }
                                    } catch(Exception e) {
                                        type = "Error";
                                        System.out.println("Error calculating date difference: " + e.getMessage());
                                    }
                        %>
                        <tr data-patient-name="<%=rs.getString(2).toLowerCase()%>" 
                            data-hospital="<%=rs.getString(3).toLowerCase()%>"
                            data-blood-group="<%=rs.getString(4)%>"
                            data-donor-email="<%=rs.getString(6).toLowerCase()%>"
                            data-eligibility="<%=isEligible ? "eligible" : "waiting"%>">
                            <td><strong><%=rs.getString(2)%></strong></td>
                            <td><%=rs.getString(3)%></td>
                            <td><span class="blood-group"><%=rs.getString(4)%></span></td>
                            <td><span class="donation-type"><%=rs.getString(5)%></span></td>
                            <td class="contact-info"><%=rs.getString(6)%></td>
                            <td class="contact-info"><%=rs.getString(7)%></td>
                            <td>
                                <%
                                    int days = 0;
                                    try {
                                        days = Integer.parseInt(type);
                                    } catch (NumberFormatException e) {
                                        days = 0;
                                    }
                                    
                                    if (days <= 0) {
                                %>
                                        <span class="days-remaining eligible">
                                            <i class="fas fa-check-circle"></i> Eligible Now
                                        </span>
                                <% } else { %>
                                        <span class="days-remaining waiting">
                                            <i class="fas fa-clock"></i> <%=days%> days
                                        </span>
                                <% } %>
                            </td>
                        </tr>
                        <% 
                                }
                            }
                           
                            bloodGroupsCount = Math.min(totalDonors, 8);
                        } catch (Exception e) {
                            System.out.println("Database error: " + e.getMessage());
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (ps != null) ps.close();
                                if (con != null) con.close();
                            } catch (SQLException e) {
                                System.out.println("Error closing resources: " + e.getMessage());
                            }
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

       
        <div class="no-results" id="no-results">
            <i class="fas fa-search"></i>
            <h3>No Matching Donors Found</h3>
            <p>Try adjusting your search criteria or filters</p>
        </div>
        
        <footer>
            <p>Blood Bank Management System &copy; 2025 | Saving Lives Through Donation</p>
        </footer>
    </div>

    <script>
        
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('total-donors').textContent = '<%= totalDonors %>';
            document.getElementById('eligible-donors').textContent = '<%= eligibleDonors %>';
            document.getElementById('waiting-donors').textContent = '<%= waitingDonors %>';
            document.getElementById('blood-groups').textContent = '<%= bloodGroupsCount %>';
            
           
            const rows = document.querySelectorAll('#donors-tbody tr');
            rows.forEach((row, index) => {
                row.style.animationDelay = `${index * 0.1}s`;
                row.style.opacity = '0';
                row.style.transform = 'translateY(20px)';
                row.style.animation = 'fadeInUp 0.5s ease forwards';
            });
            
            
            applyFilters();
        });
        
        
        function applyFilters() {
            const searchTerm = document.getElementById('search-input').value.toLowerCase();
            const bloodGroupFilter = document.getElementById('blood-group-filter').value;
            const eligibilityFilter = document.getElementById('eligibility-filter').value;
            const rows = document.querySelectorAll('#donors-tbody tr');
            
            const emptyState = document.querySelector('.empty-state');
            const noResults = document.getElementById('no-results');
            
            let visibleCount = 0;
            let eligibleCount = 0;
            let waitingCount = 0;
            let bloodGroups = new Set();
            
            rows.forEach(row => {
                if (row.querySelector('.empty-state')) return;
                
                const patientName = row.getAttribute('data-patient-name');
                const hospital = row.getAttribute('data-hospital');
                const bloodGroup = row.getAttribute('data-blood-group');
                const donorEmail = row.getAttribute('data-donor-email');
                const eligibility = row.getAttribute('data-eligibility');
                
               
                const searchMatch = searchTerm === '' || 
                    patientName.includes(searchTerm) || 
                    hospital.includes(searchTerm) || 
                    donorEmail.includes(searchTerm);
                
               
                const bloodGroupMatch = bloodGroupFilter === 'all' || bloodGroup === bloodGroupFilter;
                
                
                const eligibilityMatch = eligibilityFilter === 'all' || eligibility === eligibilityFilter;
                
                if (searchMatch && bloodGroupMatch && eligibilityMatch) {
                    row.style.display = '';
                    visibleCount++;
                    
                   
                    if (eligibility === 'eligible') {
                        eligibleCount++;
                    } else {
                        waitingCount++;
                    }
                    bloodGroups.add(bloodGroup);
                } else {
                    row.style.display = 'none';
                }
            });
            
           
            if (emptyState) {
                emptyState.style.display = 'none';
            }
            
            if (visibleCount === 0 && rows.length > 0) {
                noResults.style.display = 'block';
            } else {
                noResults.style.display = 'none';
            }
            
           
            document.getElementById('total-donors').textContent = visibleCount;
            document.getElementById('eligible-donors').textContent = eligibleCount;
            document.getElementById('waiting-donors').textContent = waitingCount;
            document.getElementById('blood-groups').textContent = bloodGroups.size;
        }

        function clearFilters() {
            document.getElementById('search-input').value = '';
            document.getElementById('blood-group-filter').value = 'all';
            document.getElementById('eligibility-filter').value = 'all';
            applyFilters();
            
            
            document.getElementById('total-donors').textContent = '<%= totalDonors %>';
            document.getElementById('eligible-donors').textContent = '<%= eligibleDonors %>';
            document.getElementById('waiting-donors').textContent = '<%= waitingDonors %>';
            document.getElementById('blood-groups').textContent = '<%= bloodGroupsCount %>';
        }

        
        document.getElementById('search-input').addEventListener('input', applyFilters);
        document.getElementById('blood-group-filter').addEventListener('change', applyFilters);
        document.getElementById('eligibility-filter').addEventListener('change', applyFilters);
        
        
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