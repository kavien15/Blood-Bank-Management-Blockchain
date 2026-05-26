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
<title>Blood Camp Details</title>
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

    .camp-count {
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

    .search-info {
        margin-top: 15px;
        padding: 12px 20px;
        background: var(--light-red);
        border-radius: 10px;
        color: var(--dark-red);
        font-size: 0.9rem;
        display: none;
    }

    .search-info.show {
        display: block;
        animation: fadeIn 0.3s ease;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(-10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    
    .camp-info {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 15px;
        padding: 25px;
        margin-bottom: 25px;
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
        border-left: 5px solid var(--primary-red);
    }

    .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-bottom: 20px;
    }

    .info-card {
        background: var(--white);
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        border: 1px solid var(--light-red);
        transition: all 0.3s ease;
    }

    .info-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
    }

    .info-card h3 {
        color: var(--primary-red);
        font-size: 1rem;
        margin-bottom: 10px;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .info-card p {
        color: var(--dark-gray);
        font-size: 1.1rem;
        font-weight: 500;
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
        padding: 16px 12px;
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
        padding: 14px 12px;
        font-size: 0.9rem;
        color: var(--dark-gray);
        border-bottom: 1px solid var(--light-gray);
    }

   
    .status-badge {
        padding: 6px 12px;
        border-radius: 15px;
        font-size: 0.8rem;
        font-weight: 600;
        display: inline-block;
    }

    .status-active {
        background: #4CAF50;
        color: white;
    }

    .status-upcoming {
        background: #FF9800;
        color: white;
    }

    .status-completed {
        background: #2196F3;
        color: white;
    }

   
    .camp-features {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 15px;
        margin-top: 20px;
    }

    .feature {
        background: var(--light-red);
        padding: 15px;
        border-radius: 10px;
        text-align: center;
        border: 1px solid rgba(139, 0, 0, 0.2);
    }

    .feature i {
        color: var(--primary-red);
        font-size: 1.5rem;
        margin-bottom: 8px;
    }

    .feature span {
        font-size: 0.85rem;
        font-weight: 600;
        color: var(--dark-red);
    }

    
    .cta-section {
        background: linear-gradient(135deg, var(--primary-red), var(--secondary-red));
        color: var(--white);
        padding: 30px;
        border-radius: 15px;
        text-align: center;
        margin-top: 30px;
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
    }

    .cta-section h2 {
        margin-bottom: 15px;
        font-size: 1.5rem;
    }

    .cta-section p {
        margin-bottom: 20px;
        opacity: 0.9;
    }

    .cta-button {
        background: var(--white);
        color: var(--primary-red);
        border: none;
        padding: 12px 30px;
        border-radius: 25px;
        font-size: 1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 10px;
    }

    .cta-button:hover {
        background: var(--light-red);
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
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

        .info-grid {
            grid-template-columns: 1fr;
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

        .camp-features {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    @media screen and (max-width: 480px) {
        .header h1 {
            font-size: 1.6rem;
        }

        .camp-features {
            grid-template-columns: 1fr;
        }

        .info-card {
            padding: 15px;
        }

        .cta-section {
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
            <h1><i class="fas fa-tint"></i> Blood Donation Camps</h1>
            <p>Join us in saving lives through blood donation</p>
            <div class="camp-count">
                <i class="fas fa-calendar-alt"></i> Upcoming & Active Camps
            </div>
        </div>
    </div>

    
    <div class="search-section">
        <div class="search-container">
            <div class="search-box">
                <input type="text" id="locationSearch" class="search-input" placeholder="Search by city, state, or address...">
                <i class="fas fa-search search-icon"></i>
            </div>
            <div class="filter-buttons">
                <button class="filter-btn active" data-filter="all">
                    <i class="fas fa-globe"></i> All Locations
                </button>
                <button class="filter-btn" data-filter="clear">
                    <i class="fas fa-times"></i> Clear Search
                </button>
            </div>
        </div>
        <div class="search-info" id="searchInfo">
            Showing results for: <strong id="searchTerm"></strong>
        </div>
    </div>

  
   
    <div class="no-results" id="noResults">
        <i class="fas fa-map-marker-alt"></i>
        <h3>No Camps Found</h3>
        <p>No blood donation camps found for your search location. Try searching for a different city or state.</p>
    </div>

   
    <div class="table-container" id="tableContainer">
        <table>
            <caption>Blood Camp Details</caption>
            <thead>
                <tr>
                    <th>Hospital Name</th>
                    <th>Hospital Email</th>
                    
                    <th>Contact</th>
                    <th>Address</th>
                    <th>City</th>
                    <th>State</th>
                    <th>Pincode</th>
                    <th>Camp Date</th>
                </tr>
            </thead>
            
            <tbody id="campTableBody">
                <% 
                Connection con = Dbcon.create();
                PreparedStatement ps = con.prepareStatement("SELECT * FROM `blood`.`campdetails`");
                ResultSet rs = ps.executeQuery();
                
                while(rs.next()) {
                %>
                <tr class="camp-row" data-city="<%=rs.getString(7).toLowerCase()%>" data-state="<%=rs.getString(8).toLowerCase()%>" data-address="<%=rs.getString(6).toLowerCase()%>">
                    <td data-label="Hospital Name">
                        <i class="fas fa-hospital" style="color: var(--primary-red); margin-right: 5px;"></i>
                        <%=rs.getString(2)%>
                    </td>
                    <td data-label="Hospital ID">
                        <span class="status-badge status-active"><%=rs.getString(3)%></span>
                    </td>
                    <td data-label="Email"><%=rs.getString(4)%></td>
                    <td data-label="Contact">
                        <i class="fas fa-phone" style="color: var(--primary-red); margin-right: 5px;"></i>
                        <%=rs.getString(5)%>
                    </td>
                    <td data-label="Address"><%=rs.getString(6)%></td>
                    <td data-label="City"><%=rs.getString(7)%></td>
                    <td data-label="State"><%=rs.getString(8)%></td>
                    
                    <td data-label="Camp Date">
                        <i class="fas fa-calendar" style="color: var(--primary-red); margin-right: 5px;"></i>
                        <%=rs.getString(9)%>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

 

    <script>
        
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('locationSearch');
            const searchInfo = document.getElementById('searchInfo');
            const searchTerm = document.getElementById('searchTerm');
            const noResults = document.getElementById('noResults');
            const tableContainer = document.getElementById('tableContainer');
            const campRows = document.querySelectorAll('.camp-row');
            const filterButtons = document.querySelectorAll('.filter-btn');
            
            let currentSearch = '';
            
            
            function performSearch(searchText) {
                searchText = searchText.toLowerCase().trim();
                currentSearch = searchText;
                let hasResults = false;
                let resultCount = 0;
                
                campRows.forEach(row => {
                    const city = row.getAttribute('data-city');
                    const state = row.getAttribute('data-state');
                    const address = row.getAttribute('data-address');
                    
                    if (searchText === '' || 
                        city.includes(searchText) || 
                        state.includes(searchText) || 
                        address.includes(searchText)) {
                        row.style.display = '';
                        resultCount++;
                        hasResults = true;
                    } else {
                        row.style.display = 'none';
                    }
                });
                
                
                if (searchText !== '') {
                    searchInfo.classList.add('show');
                    searchTerm.textContent = searchText;
                    
                    if (hasResults) {
                        noResults.classList.remove('show');
                        tableContainer.style.display = 'block';
                    } else {
                        noResults.classList.add('show');
                        tableContainer.style.display = 'none';
                    }
                } else {
                    searchInfo.classList.remove('show');
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
                    }
                });
            });
            
            
            performSearch('');
        });
    </script>
</body>
</html>