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
<title>User Management - Blood Bank</title>
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
        --gold: #ffd700;
    }

    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
        background: linear-gradient(135deg, #8b0000 0%, #b22222 100%);
        min-height: 100vh;
        padding: 20px;
        color: var(--dark-gray);
        position: relative;
    }

   
    .blood-pattern {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-image: 
            radial-gradient(circle at 20% 30%, rgba(255, 255, 255, 0.1) 2px, transparent 0),
            radial-gradient(circle at 80% 70%, rgba(255, 255, 255, 0.1) 2px, transparent 0);
        background-size: 60px 60px;
        pointer-events: none;
        z-index: -1;
    }

    
    .back-button {
        position: fixed;
        top: 20px;
        left: 20px;
        background: rgba(255, 255, 255, 0.95);
        color: var(--primary-red);
        border: none;
        padding: 12px 20px;
        border-radius: 25px;
        font-size: 0.9rem;
        font-weight: 600;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 8px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        transition: all 0.3s ease;
        z-index: 1000;
        text-decoration: none;
    }

    .back-button:hover {
        background: var(--white);
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
    }

   
    .header {
        text-align: center;
        margin-bottom: 30px;
        color: var(--white);
        padding-top: 10px;
    }

    .header-content {
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(10px);
        padding: 25px;
        border-radius: 20px;
        border: 1px solid rgba(255, 255, 255, 0.2);
        margin-bottom: 20px;
    }

    .header h1 {
        font-size: 2.5rem;
        margin-bottom: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 15px;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
    }

    .header h1 i {
        color: var(--light-red);
        animation: heartbeat 1.5s ease-in-out infinite;
    }

    @keyframes heartbeat {
        0% { transform: scale(1); }
        50% { transform: scale(1.1); }
        100% { transform: scale(1); }
    }

    .header p {
        font-size: 1.1rem;
        opacity: 0.9;
        margin-bottom: 10px;
    }

    .user-count {
        background: var(--light-red);
        color: var(--dark-red);
        padding: 8px 20px;
        border-radius: 20px;
        font-weight: 600;
        display: inline-block;
        margin-top: 10px;
        font-size: 0.9rem;
    }

   
    .search-section {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 15px;
        padding: 25px;
        margin-bottom: 25px;
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
        border-left: 5px solid var(--primary-red);
    }

    .search-container {
        display: flex;
        gap: 15px;
        align-items: center;
        flex-wrap: wrap;
    }

    .search-box {
        flex: 1;
        min-width: 300px;
        position: relative;
    }

    .search-input {
        width: 100%;
        padding: 15px 50px 15px 20px;
        border: 2px solid var(--light-red);
        border-radius: 25px;
        font-size: 1rem;
        background: var(--white);
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }

    .search-input:focus {
        outline: none;
        border-color: var(--primary-red);
        box-shadow: 0 6px 20px rgba(139, 0, 0, 0.2);
    }

    .search-icon {
        position: absolute;
        right: 20px;
        top: 50%;
        transform: translateY(-50%);
        color: var(--primary-red);
        font-size: 1.2rem;
    }

    .filter-buttons {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
    }

    .filter-btn {
        padding: 12px 20px;
        border: 2px solid var(--primary-red);
        background: transparent;
        color: var(--primary-red);
        border-radius: 25px;
        font-size: 0.9rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .filter-btn:hover, .filter-btn.active {
        background: var(--primary-red);
        color: var(--white);
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(139, 0, 0, 0.3);
    }

   
    .results-counter {
        background: var(--light-red);
        color: var(--dark-red);
        padding: 12px 20px;
        border-radius: 10px;
        margin-top: 15px;
        display: flex;
        align-items: center;
        gap: 10px;
        font-weight: 600;
        font-size: 0.9rem;
    }

    .results-counter i {
        color: var(--primary-red);
    }

    
    .stats-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }

    .stat-card {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 15px;
        padding: 25px;
        text-align: center;
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        border-left: 5px solid var(--primary-red);
        transition: all 0.3s ease;
    }

    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 12px 30px rgba(0, 0, 0, 0.2);
    }

    .stat-icon {
        width: 60px;
        height: 60px;
        background: var(--light-red);
        color: var(--primary-red);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        margin: 0 auto 15px;
    }

    .stat-number {
        font-size: 2rem;
        font-weight: 700;
        color: var(--primary-red);
        margin-bottom: 5px;
    }

    .stat-label {
        font-size: 0.9rem;
        color: var(--dark-gray);
        font-weight: 600;
    }

    
    .table-container {
        background: var(--white);
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.25);
        margin-bottom: 30px;
    }

    
    table {
        width: 100%;
        border-collapse: collapse;
        background: var(--white);
    }

    table caption {
        background: linear-gradient(135deg, var(--primary-red), var(--dark-red));
        color: var(--white);
        padding: 20px;
        font-size: 1.4rem;
        font-weight: 600;
        letter-spacing: 0.5px;
    }

    table thead {
        background: linear-gradient(135deg, var(--secondary-red), var(--primary-red));
    }

    table thead tr {
        color: var(--white);
    }

    table th {
        padding: 18px 15px;
        text-align: left;
        font-weight: 600;
        font-size: 0.9rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border-bottom: 2px solid var(--dark-red);
    }

    table tbody tr {
        transition: all 0.3s ease;
        border-bottom: 1px solid var(--light-gray);
    }

    table tbody tr:nth-child(even) {
        background-color: var(--light-gray);
    }

    table tbody tr:hover {
        background-color: var(--light-red);
        transform: scale(1.01);
    }

    table td {
        padding: 16px 15px;
        font-size: 0.95rem;
        color: var(--dark-gray);
        border-bottom: 1px solid var(--light-gray);
    }

   
    .user-avatar {
        width: 40px;
        height: 40px;
        background: linear-gradient(135deg, var(--primary-red), var(--secondary-red));
        color: var(--white);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 600;
        font-size: 1rem;
        margin-right: 10px;
    }

    .user-info {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    
    .status-badge {
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 600;
        display: inline-block;
    }

    .status-active {
        background: #4CAF50;
        color: white;
    }

    .status-pending {
        background: #FF9800;
        color: white;
    }

    .status-inactive {
        background: #f44336;
        color: white;
    }

    
    .donation-info {
        display: flex;
        align-items: center;
        gap: 8px;
        color: var(--dark-gray);
        font-size: 0.85rem;
    }

    .donation-count {
        background: var(--light-red);
        color: var(--dark-red);
        padding: 4px 8px;
        border-radius: 10px;
        font-weight: 600;
        font-size: 0.8rem;
    }

   
    .no-results {
        text-align: center;
        padding: 50px 20px;
        color: var(--dark-gray);
        background: var(--white);
        border-radius: 15px;
        margin: 20px 0;
        display: none;
    }

    .no-results.show {
        display: block;
    }

    .no-results i {
        font-size: 3rem;
        color: var(--light-red);
        margin-bottom: 15px;
    }

   
    @media screen and (max-width: 768px) {
        body {
            padding: 15px 10px;
        }

        .header h1 {
            font-size: 2rem;
        }

        .back-button {
            top: 15px;
            left: 15px;
            padding: 10px 16px;
            font-size: 0.8rem;
        }

        .search-container {
            flex-direction: column;
        }

        .search-box {
            min-width: 100%;
        }

        .filter-buttons {
            width: 100%;
            justify-content: center;
        }

        .stats-container {
            grid-template-columns: repeat(2, 1fr);
        }

        table {
            border: none;
        }

        table caption {
            padding: 15px;
            font-size: 1.2rem;
        }

        table thead {
            display: none;
        }

        table tbody tr {
            margin-bottom: 15px;
            display: block;
            border: 1px solid var(--light-gray);
            border-radius: 10px;
            padding: 0;
        }

        table td {
            display: block;
            text-align: right;
            padding: 12px 15px;
            border-bottom: 1px solid var(--light-gray);
            position: relative;
        }

        table td:before {
            content: attr(data-label);
            font-weight: 600;
            text-transform: uppercase;
            float: left;
            color: var(--primary-red);
            font-size: 0.8rem;
        }

        table td:last-child {
            border-bottom: none;
        }
    }

    @media screen and (max-width: 480px) {
        .header h1 {
            font-size: 1.6rem;
        }

        .stats-container {
            grid-template-columns: 1fr;
        }

        .stat-card {
            padding: 20px;
        }
    }
</style>
</head>
<body>
    
    <div class="blood-pattern"></div>

   
    <a href="Aadminhomepage.jsp" class="back-button">
        <i class="fas fa-arrow-left"></i>
        Back to Dashboard
    </a>

    <div class="header">
        <div class="header-content">
            <h1><i class="fas fa-users"></i> Donor Management</h1>
            <p>Blood Donor Database & Management System</p>
            <div class="user-count">
                <i class="fas fa-user-friends"></i> Registered Donors
            </div>
        </div>
    </div>

    
    <div class="search-section">
        <div class="search-container">
            <div class="search-box">
                <input type="text" id="userSearch" class="search-input" placeholder="Search users by name, email, or phone...">
                <i class="fas fa-search search-icon"></i>
            </div>
            <div class="filter-buttons">
                <button class="filter-btn active" data-filter="all">
                    <i class="fas fa-users"></i> All Users
                </button>
                <button class="filter-btn" data-filter="active">
                    <i class="fas fa-check-circle"></i> Active
                </button>
                <button class="filter-btn" data-filter="clear">
                    <i class="fas fa-times"></i> Clear
                </button>
            </div>
        </div>
       
        <div class="results-counter" id="resultsCounter">
            <i class="fas fa-list"></i>
            Showing <span id="visibleCount">0</span> of <span id="totalCount">0</span> donors
        </div>
    </div>

    
    <div class="no-results" id="noResults">
        <i class="fas fa-user-slash"></i>
        <h3>No Users Found</h3>
        <p>No users match your search criteria. Try adjusting your search terms.</p>
    </div>

    
    <div class="table-container" id="tableContainer">
        <table>
            <caption>Registered Donor Details</caption>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Age</th>
                    <th>Mobile Number</th>
                    <th>Address</th>
                    <th>Location</th>
                    <th>Past Health Records</th>
                    <th>Status</th>
                </tr>
            </thead>
            
            <tbody id="userTableBody">
                <% 
                Connection con = Dbcon.create();
                PreparedStatement ps = con.prepareStatement("SELECT * FROM `blood`.`donorlist`");
                ResultSet rs = ps.executeQuery();
                int userCount = 0;
                
                while(rs.next()) {
                    userCount++;
                    String userName = rs.getString(2);
                    String userInitial = userName.substring(0, 1).toUpperCase();
                %>
                <tr class="user-row" 
                    data-name="<%= userName.toLowerCase() %>"
                    data-email="<%= rs.getString(3).toLowerCase() %>"
                    data-phone="<%= rs.getString(11).toLowerCase() %>"
                    data-age="<%= rs.getString(4) %>"
                    data-address="<%= rs.getString(10).toLowerCase() %>"
                    data-location="<%= rs.getString(7).toLowerCase() %>"
                    data-health="<%= rs.getString(6).toLowerCase() %>">
                    <td data-label="Name">
                        <div class="user-info">
                            <div class="user-avatar"><%= userInitial %></div>
                            <strong><%= userName %></strong>
                        </div>
                    </td>
                    <td data-label="Email">
                        <i class="fas fa-envelope" style="color: var(--primary-red); margin-right: 5px;"></i>
                        <%= rs.getString(3) %>
                    </td>
                    <td data-label="Age">
                        <i class="fas fa-birthday-cake" style="color: var(--primary-red); margin-right: 5px;"></i>
                        <%= rs.getString(4) %> years
                    </td>
                    <td data-label="Mobile Number">
                        <i class="fas fa-phone" style="color: var(--primary-red); margin-right: 5px;"></i>
                        <%= rs.getString(11) %>
                    </td>
                    <td data-label="Address">
                        <i class="fas fa-map-marker-alt" style="color: var(--primary-red); margin-right: 5px;"></i>
                        <%= rs.getString(10) %>
                    </td>
                    <td data-label="Location">
                        <i class="fas fa-location-arrow" style="color: var(--primary-red); margin-right: 5px;"></i>
                        <%= rs.getString(7) %>
                    </td>
                    <td data-label="Past Health Records">
                        <i class="fas fa-file-medical" style="color: var(--primary-red); margin-right: 5px;"></i>
                        <%= rs.getString(6) %>
                    </td>
                    <td data-label="Status">
                        <span class="status-badge status-active">Active Donor</span>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <script>
       
        document.addEventListener('DOMContentLoaded', function() {
            const totalCount = <%= userCount %>;
            document.getElementById('totalCount').textContent = totalCount;
            document.getElementById('visibleCount').textContent = totalCount;
            
            setupSearchFunctionality();
        });

        function setupSearchFunctionality() {
            const searchInput = document.getElementById('userSearch');
            const noResults = document.getElementById('noResults');
            const tableContainer = document.getElementById('tableContainer');
            const userRows = document.querySelectorAll('.user-row');
            const filterButtons = document.querySelectorAll('.filter-btn');
            const visibleCountElement = document.getElementById('visibleCount');
            
            
            function performSearch(searchText) {
                searchText = searchText.toLowerCase().trim();
                let visibleCount = 0;
                
                userRows.forEach(row => {
                    const name = row.getAttribute('data-name');
                    const email = row.getAttribute('data-email');
                    const phone = row.getAttribute('data-phone');
                    const age = row.getAttribute('data-age');
                    const address = row.getAttribute('data-address');
                    const location = row.getAttribute('data-location');
                    const health = row.getAttribute('data-health');
                    
                    const matchesSearch = searchText === '' || 
                        name.includes(searchText) || 
                        email.includes(searchText) || 
                        phone.includes(searchText) ||
                        age.includes(searchText) ||
                        address.includes(searchText) ||
                        location.includes(searchText) ||
                        health.includes(searchText);
                    
                    if (matchesSearch) {
                        row.style.display = '';
                        visibleCount++;
                    } else {
                        row.style.display = 'none';
                    }
                });
                
                
                visibleCountElement.textContent = visibleCount;
                
                
                if (searchText !== '' && visibleCount === 0) {
                    noResults.classList.add('show');
                    tableContainer.style.display = 'none';
                } else {
                    noResults.classList.remove('show');
                    tableContainer.style.display = 'block';
                }
            }
            
            
            searchInput.addEventListener('input', function() {
                performSearch(this.value);
            });
            
            
            filterButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const filter = this.getAttribute('data-filter');
                    
                   
                    filterButtons.forEach(btn => btn.classList.remove('active'));
                    this.classList.add('active');
                    
                    if (filter === 'clear') {
                        searchInput.value = '';
                        performSearch('');
                    } else if (filter === 'active') {
                        
                        performSearch('active');
                    } else {
                       
                        searchInput.value = '';
                        performSearch('');
                    }
                });
            });
            
          
            performSearch('');
        }
    </script>
</body>
</html>