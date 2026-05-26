<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="dbcon.Dbcon"%>
<!DOCTYPE html>
<html>
<head>
<title>Blood Banks Directory</title>
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
        padding: 20px;
    }

    .container {
        max-width: 1400px;
        margin: 0 auto;
    }

   
    .header {
        background: linear-gradient(135deg, var(--primary), var(--primary-dark));
        color: white;
        padding: 2rem;
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(198, 40, 40, 0.3);
        margin-bottom: 2rem;
        text-align: center;
        position: relative;
        overflow: hidden;
    }

    .header::before {
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

   
    .btn-back {
        background: var(--secondary);
        color: var(--light);
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
        background: #1a252f;
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(0,0,0,0.15);
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

    
    .table-container {
        background: white;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        margin-bottom: 2rem;
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

    tbody tr {
        transition: all 0.3s;
        border-bottom: 1px solid var(--gray);
    }

    tbody tr:hover {
        background: rgba(198, 40, 40, 0.05);
        transform: scale(1.01);
    }

    td {
        padding: 1.2rem 1rem;
        color: var(--secondary);
        font-size: 0.95rem;
    }

    .action-buttons {
        display: flex;
        gap: 0.5rem;
        justify-content: center;
    }

    .btn {
        padding: 8px 16px;
        border: none;
        border-radius: 6px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s;
        display: flex;
        align-items: center;
        gap: 6px;
        font-size: 0.9rem;
        text-decoration: none;
    }

    .btn-view {
        background: var(--primary);
        color: white;
    }

    .btn-request {
        background: var(--secondary);
        color: white;
    }

    .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
    }

    .btn-view:hover {
        background: var(--primary-dark);
    }

    .btn-request:hover {
        background: #1a252f;
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

    
    .footer {
        text-align: center;
        padding: 2rem;
        color: var(--dark-gray);
        margin-top: 2rem;
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
        
        .action-buttons {
            flex-direction: column;
        }
    }

    @media (max-width: 480px) {
        .stats-cards {
            grid-template-columns: 1fr;
        }
        
        .btn-back, .btn-clear {
            width: 100%;
            justify-content: center;
        }
    }
</style>
</head>
<body>
    <div class="container">
       
        <a href="Aadminhomepage.jsp" class="btn-back">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>

       
        <div class="header">
            <div class="header-content">
                <div class="logo">
                    <i class="fas fa-hospital logo-icon"></i>
                    <div class="logo-text">LifeStream Blood Bank Network</div>
                </div>
                <h1 class="page-title">Available Blood Banks</h1>
                <p class="page-subtitle">Find blood banks near you and manage blood requests</p>
            </div>
        </div>

       
        <div class="search-section">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="search-input" placeholder="Search by name, location, or email...">
            </div>
            <button class="btn-clear" onclick="clearSearch()">
                <i class="fas fa-times"></i> Clear Search
            </button>
        </div>

       
        <div class="stats-cards">
            <div class="stat-card">
                <div class="stat-number" id="total-banks">0</div>
                <div class="stat-label">Total Blood Banks</div>
            </div>
            <div class="stat-card">
                <div class="stat-number" id="active-banks">0</div>
                <div class="stat-label">Active Today</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">24/7</div>
                <div class="stat-label">Emergency Service</div>
            </div>
        </div>

       
        <div class="table-container">
            <table id="banks-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Location</th>
                        <th>Address</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="banks-tbody">
                    <%
                    try {
                        Connection con = Dbcon.create();
                        PreparedStatement ps = con.prepareStatement("SELECT * FROM blood.bloodbank");
                        ResultSet rs = ps.executeQuery();
                        
                        int bankCount = 0;

                        while (rs.next()) {
                            bankCount++;
                    %>
                    <tr data-bank-name="<%= rs.getString("name").toLowerCase() %>" 
                        data-bank-location="<%= rs.getString("location").toLowerCase() %>"
                        data-bank-email="<%= rs.getString("email").toLowerCase() %>">
                        <td><%= rs.getString("bid") %></td>
                        <td><strong><%= rs.getString("name") %></strong></td>
                        <td><%= rs.getString("email") %></td>
                        <td><%= rs.getString("location") %></td>
                        <td><%= rs.getString("address") %></td>
                        <td>
                            <div class="action-buttons">
                                <form action="adminviewbloodstocks.jsp" method="get" style="display: inline;">
                                    <input type="hidden" name="bid" value="<%= rs.getString("bid") %>">
                                    <input type="hidden" name="email" value="<%= rs.getString("email") %>">
                                    <button type="submit" class="btn btn-view">
                                        <i class="fas fa-eye"></i> View Blood Stock
                                    </button>
                                </form>
                                <%-- <form action="donorrequestblood.jsp" method="get" style="display: inline;">
                                    <input type="hidden" name="bid" value="<%= rs.getString("bid") %>">
                                    <input type="hidden" name="email" value="<%= rs.getString("email") %>">
                                    <button type="submit" class="btn btn-request">
                                        <i class="fas fa-tint"></i> Request Blood
                                    </button>
                                </form> --%>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                        
                        if (bankCount == 0) {
                    %>
                    <tr>
                        <td colspan="6">
                            <div class="empty-state">
                                <i class="fas fa-hospital"></i>
                                <h3>No Blood Banks Available</h3>
                                <p>There are currently no blood banks registered in the system.</p>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    } catch(Exception e) {
                        out.println("<tr><td colspan='6' style='color: var(--primary); text-align: center; padding: 2rem;'>Error loading blood banks: " + e.getMessage() + "</td></tr>");
                    }
                    %>
                </tbody>
            </table>
        </div>

        
        <div class="no-results" id="no-results">
            <i class="fas fa-search"></i>
            <h3>No Matching Blood Banks Found</h3>
            <p>Try adjusting your search criteria</p>
        </div>
    </div>

    <script>
        
        document.addEventListener('DOMContentLoaded', function() {
            const bankCount = document.querySelectorAll('#banks-tbody tr:not([style*="display: none"])').length;
            document.getElementById('total-banks').textContent = bankCount;
            document.getElementById('active-banks').textContent = bankCount; 
            
           
            const rows = document.querySelectorAll('#banks-tbody tr');
            rows.forEach((row, index) => {
                row.style.animationDelay = `${index * 0.1}s`;
                row.style.opacity = '0';
                row.style.transform = 'translateY(20px)';
                row.style.animation = 'fadeInUp 0.5s ease forwards';
            });
        });
        
       
        function filterBanks() {
            const searchTerm = document.getElementById('search-input').value.toLowerCase();
            const rows = document.querySelectorAll('#banks-tbody tr');
            const emptyState = document.querySelector('.empty-state');
            const noResults = document.getElementById('no-results');
            
            let visibleCount = 0;
            
            rows.forEach(row => {
                const bankName = row.getAttribute('data-bank-name');
                const bankLocation = row.getAttribute('data-bank-location');
                const bankEmail = row.getAttribute('data-bank-email');
                
                const searchMatch = searchTerm === '' || 
                    bankName.includes(searchTerm) || 
                    bankLocation.includes(searchTerm) || 
                    bankEmail.includes(searchTerm);
                
                if (searchMatch) {
                    row.style.display = '';
                    visibleCount++;
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
            
           
            document.getElementById('total-banks').textContent = visibleCount;
            document.getElementById('active-banks').textContent = visibleCount;
        }
        
        function clearSearch() {
            document.getElementById('search-input').value = '';
            filterBanks();
        }
        
       
        document.getElementById('search-input').addEventListener('input', filterBanks);
        
        
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