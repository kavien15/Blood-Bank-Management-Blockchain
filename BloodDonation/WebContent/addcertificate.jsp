<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="dbcon.Dbcon"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Certificate Management</title>
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

    .btn-certificate {
        background: var(--primary);
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 6px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s;
        display: flex;
        align-items: center;
        gap: 6px;
        font-size: 0.9rem;
    }

    .btn-certificate:hover {
        background: var(--primary-dark);
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(198, 40, 40, 0.3);
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
    }

    @media (max-width: 480px) {
        .stats-cards {
            grid-template-columns: 1fr;
        }
        
        .btn-back, .btn-certificate, .btn-clear {
            width: 100%;
            justify-content: center;
        }
    }
</style>
</head>
<body>
    <div class="container">
       
        <a href="doctorhome.jsp" class="btn-back">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>

       
        <div class="header">
            <div class="header-content">
                <div class="logo">
                    <i class="fas fa-certificate logo-icon"></i>
                    <div class="logo-text">
LifeStream Blood Bank</div>
                </div>
                <h1 class="page-title">Certificate Management</h1>
                <p class="page-subtitle">Manage and issue certificates for blood donations</p>
            </div>
        </div>

        
        <div class="search-section">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="search-input" placeholder="Search by donor name, email, hospital...">
            </div>
            <button class="btn-clear" onclick="clearSearch()">
                <i class="fas fa-times"></i> Clear Search
            </button>
        </div>

        
        <div class="stats-cards">
            <div class="stat-card">
                <div class="stat-number" id="total-requests">0</div>
                <div class="stat-label">Total Requests</div>
            </div>
            <div class="stat-card">
                <div class="stat-number" id="pending-certificates">0</div>
                <div class="stat-label">Pending Certificates</div>
            </div>
            <div class="stat-card">
                <div class="stat-number" id="issued-certificates">0</div>
                <div class="stat-label">Issued Certificates</div>
            </div>
        </div>

       
        <form action="AddCertificate" method="post">
            <%
            Connection con= Dbcon.create();
            PreparedStatement ps=con.prepareStatement("SELECT * FROM `blood`.`campdonate` where status='requested'");
            ResultSet rs=ps.executeQuery();
            
            int requestCount = 0;
            
            if (!rs.isBeforeFirst()) {
            %>
                <div class="empty-state">
                    <i class="fas fa-inbox"></i>
                    <h3>No Certificate Requests</h3>
                    <p>There are currently no pending certificate requests.</p>
                </div>
            <%
            } else {
            %>
                <div class="table-container">
                    <table id="requests-table">
                        <thead>
                            <tr>
                                <th>Donor Name</th>
                                <th>Donor Email</th>
                                <th>Donor Contact</th>
                                <th>Hospital Name</th>
                                <th>Hospital Email</th>
                                <th>Hospital Contact</th>
                                <th>Date</th>
                                <th>Approve</th>
                                <th>Not Donated</th>
                            </tr>
                        </thead>
                        <tbody id="requests-tbody">
                            <%
                            while(rs.next()) {
                                requestCount++;
                            %>
                            <tr data-donor-name="<%=rs.getString(2).toLowerCase()%>" 
                                data-donor-email="<%=rs.getString(3).toLowerCase()%>"
                                data-hospital-name="<%=rs.getString(5).toLowerCase()%>">
                                <td><%=rs.getString(2)%></td>
                                <td><%=rs.getString(3)%></td>
                                <td><%=rs.getString(4)%></td>
                                <td><%=rs.getString(5)%></td>
                                <td><%=rs.getString(6)%></td>
                                <td><%=rs.getString(7)%></td>
                                <td><%=rs.getString(8)%></td>
                                <td>
                                    <button type="submit" class="btn-certificate">
                                        <i class="fas fa-file-certificate"></i> Add Certificate
                                    </button>
                                    
                                </td>
                                 <td>
                                    <button type="submit" class="btn-certificate">
                                        <i class="fas fa-file-certificate"></i> Remove
                                    </button>
                                    
                                </td>
                            </tr>
                            <input type="hidden" name="dname" value="<%=rs.getString(2)%>">
                            <input type="hidden" name="dmail" value="<%=rs.getString(3)%>">
                            <input type="hidden" name="dnumber" value="<%=rs.getString(4)%>">
                            <input type="hidden" name="hname" value="<%=rs.getString(5)%>">
                            <input type="hidden" name="hmail" value="<%=rs.getString(6)%>">
                            <input type="hidden" name="hnumber" value="<%=rs.getString(7)%>">
                            <input type="hidden" name="date" value="<%=rs.getString(8)%>">
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
            
           
            <div class="no-results" id="no-results">
                <i class="fas fa-search"></i>
                <h3>No Matching Requests Found</h3>
                <p>Try adjusting your search criteria</p>
            </div>
        </form>
    </div>

    <script>
       
        document.getElementById('total-requests').textContent = '<%= requestCount %>';
        document.getElementById('pending-certificates').textContent = '<%= requestCount %>';
        document.getElementById('issued-certificates').textContent = '0'; 
        
        
        function filterRequests() {
            const searchTerm = document.getElementById('search-input').value.toLowerCase();
            const rows = document.querySelectorAll('#requests-tbody tr');
            const emptyState = document.querySelector('.empty-state');
            const noResults = document.getElementById('no-results');
            
            let visibleCount = 0;
            
            rows.forEach(row => {
                const donorName = row.getAttribute('data-donor-name');
                const donorEmail = row.getAttribute('data-donor-email');
                const hospitalName = row.getAttribute('data-hospital-name');
                
                const searchMatch = searchTerm === '' || 
                    donorName.includes(searchTerm) || 
                    donorEmail.includes(searchTerm) || 
                    hospitalName.includes(searchTerm);
                
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
            
           
            document.getElementById('total-requests').textContent = visibleCount;
            document.getElementById('pending-certificates').textContent = visibleCount;
        }
        
        function clearSearch() {
            document.getElementById('search-input').value = '';
            filterRequests();
            
            document.getElementById('total-requests').textContent = '<%= requestCount %>';
            document.getElementById('pending-certificates').textContent = '<%= requestCount %>';
        }
        
       
        document.getElementById('search-input').addEventListener('input', filterRequests);
        
        
        document.addEventListener('DOMContentLoaded', function() {
            const rows = document.querySelectorAll('#requests-tbody tr');
            rows.forEach((row, index) => {
                row.style.animationDelay = `${index * 0.1}s`;
                row.style.opacity = '0';
                row.style.transform = 'translateY(20px)';
                row.style.animation = 'fadeInUp 0.5s ease forwards';
            });
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
</html> --%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="dbcon.Dbcon"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Certificate Management</title>
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

    .btn-certificate {
        background: var(--primary);
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 6px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s;
        display: flex;
        align-items: center;
        gap: 6px;
        font-size: 0.9rem;
    }

    .btn-certificate:hover {
        background: var(--primary-dark);
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(198, 40, 40, 0.3);
    }

    .btn-remove {
        background: var(--dark-gray);
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 6px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s;
        display: flex;
        align-items: center;
        gap: 6px;
        font-size: 0.9rem;
    }

    .btn-remove:hover {
        background: #5a6268;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(108, 117, 125, 0.3);
    }

    .action-buttons {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
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
        
        .btn-back, .btn-certificate, .btn-remove, .btn-clear {
            width: 100%;
            justify-content: center;
        }
    }
</style>
</head>
<body>
    <div class="container">
        <a href="doctorhome.jsp" class="btn-back">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>

        <div class="header">
            <div class="header-content">
                <div class="logo">
                    <i class="fas fa-certificate logo-icon"></i>
                    <div class="logo-text">LifeStream Blood Bank</div>
                </div>
                <h1 class="page-title">Certificate Management</h1>
                <p class="page-subtitle">Manage and issue certificates for blood donations</p>
            </div>
        </div>

        <div class="search-section">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="search-input" placeholder="Search by donor name, email, hospital...">
            </div>
            <button class="btn-clear" onclick="clearSearch()">
                <i class="fas fa-times"></i> Clear Search
            </button>
        </div>

        <div class="stats-cards">
            <div class="stat-card">
                <div class="stat-number" id="total-requests">0</div>
                <div class="stat-label">Total Requests</div>
            </div>
            <div class="stat-card">
                <div class="stat-number" id="pending-certificates">0</div>
                <div class="stat-label">Pending Certificates</div>
            </div>
            <div class="stat-card">
                <div class="stat-number" id="issued-certificates">0</div>
                <div class="stat-label">Issued Certificates</div>
            </div>
        </div>

        <%
        Connection con = Dbcon.create();
        PreparedStatement ps = con.prepareStatement("SELECT * FROM `blood`.`campdonate` where status='requested'");
        ResultSet rs = ps.executeQuery();
        
        int requestCount = 0;
        
        if (!rs.isBeforeFirst()) {
        %>
            <div class="empty-state">
                <i class="fas fa-inbox"></i>
                <h3>No Certificate Requests</h3>
                <p>There are currently no pending certificate requests.</p>
            </div>
        <%
        } else {
        %>
            <div class="table-container">
                <table id="requests-table">
                    <thead>
                        <tr>
                            <th>Donor Name</th>
                            <th>Donor Email</th>
                            <th>Donor Contact</th>
                            <th>Hospital Name</th>
                            <th>Hospital Email</th>
                            <th>Hospital Contact</th>
                            <th>Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="requests-tbody">
                        <%
                        while(rs.next()) {
                            requestCount++;
                        %>
                        <tr data-donor-name="<%=rs.getString(2).toLowerCase()%>" 
                            data-donor-email="<%=rs.getString(3).toLowerCase()%>"
                            data-hospital-name="<%=rs.getString(5).toLowerCase()%>">
                            <td><%=rs.getString(2)%></td>
                            <td><%=rs.getString(3)%></td>
                            <td><%=rs.getString(4)%></td>
                            <td><%=rs.getString(5)%></td>
                            <td><%=rs.getString(6)%></td>
                            <td><%=rs.getString(7)%></td>
                            <td><%=rs.getString(8)%></td>
                            <td>
                                <div class="action-buttons">
                                   
                                    <form action="AddCertificate" method="post" style="display: inline;">
                                        <input type="hidden" name="dname" value="<%=rs.getString(2)%>">
                                        <input type="hidden" name="dmail" value="<%=rs.getString(3)%>">
                                        <input type="hidden" name="dnumber" value="<%=rs.getString(4)%>">
                                        <input type="hidden" name="hname" value="<%=rs.getString(5)%>">
                                        <input type="hidden" name="hmail" value="<%=rs.getString(6)%>">
                                        <input type="hidden" name="hnumber" value="<%=rs.getString(7)%>">
                                        <input type="hidden" name="date" value="<%=rs.getString(8)%>">
                                        <button type="submit" class="btn-certificate">
                                            <i class="fas fa-file-certificate"></i> Add Certificate
                                        </button>
                                    </form>
                                    
                                   
                                    <form action="notdonated.jsp" method="post" style="display: inline;">
                                        <input type="hidden" name="id" value="<%=rs.getString(1)%>">
                                        
                                        <button type="submit" class="btn-remove" onclick="return confirmRemove()">
                                            <i class="fas fa-trash-alt"></i> Remove
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>
        
        <div class="no-results" id="no-results">
            <i class="fas fa-search"></i>
            <h3>No Matching Requests Found</h3>
            <p>Try adjusting your search criteria</p>
        </div>
    </div>

    <script>
        document.getElementById('total-requests').textContent = '<%= requestCount %>';
        document.getElementById('pending-certificates').textContent = '<%= requestCount %>';
        
        <%
        // Get issued certificates count
        PreparedStatement ps2 = con.prepareStatement("SELECT COUNT(*) FROM `blood`.`campdonate` WHERE status='issued'");
        ResultSet rs2 = ps2.executeQuery();
        int issuedCount = 0;
        if (rs2.next()) {
            issuedCount = rs2.getInt(1);
        }
        %>
        document.getElementById('issued-certificates').textContent = '<%= issuedCount %>';
        
        function filterRequests() {
            const searchTerm = document.getElementById('search-input').value.toLowerCase();
            const rows = document.querySelectorAll('#requests-tbody tr');
            const emptyState = document.querySelector('.empty-state');
            const noResults = document.getElementById('no-results');
            
            let visibleCount = 0;
            
            rows.forEach(row => {
                const donorName = row.getAttribute('data-donor-name');
                const donorEmail = row.getAttribute('data-donor-email');
                const hospitalName = row.getAttribute('data-hospital-name');
                
                const searchMatch = searchTerm === '' || 
                    donorName.includes(searchTerm) || 
                    donorEmail.includes(searchTerm) || 
                    hospitalName.includes(searchTerm);
                
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
            
            document.getElementById('total-requests').textContent = visibleCount;
            document.getElementById('pending-certificates').textContent = visibleCount;
        }
        
        function clearSearch() {
            document.getElementById('search-input').value = '';
            filterRequests();
            
            document.getElementById('total-requests').textContent = '<%= requestCount %>';
            document.getElementById('pending-certificates').textContent = '<%= requestCount %>';
        }
        
        function confirmRemove() {
            return confirm('Are you sure you want to remove this request? This action cannot be undone.');
        }
        
        document.getElementById('search-input').addEventListener('input', filterRequests);
        
        document.addEventListener('DOMContentLoaded', function() {
            const rows = document.querySelectorAll('#requests-tbody tr');
            rows.forEach((row, index) => {
                row.style.animationDelay = `${index * 0.1}s`;
                row.style.opacity = '0';
                row.style.transform = 'translateY(20px)';
                row.style.animation = 'fadeInUp 0.5s ease forwards';
            });
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