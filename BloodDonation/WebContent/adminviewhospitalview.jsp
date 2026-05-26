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
<title>Hospital Details - Blood Bank</title>
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
        --search-bg: rgba(255, 255, 255, 0.95);
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

    .header h1 {
        font-size: 2.2rem;
        margin-bottom: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 15px;
    }

    .header h1 i {
        color: var(--light-red);
    }

    .header p {
        font-size: 1rem;
        opacity: 0.9;
    }

    .hospital-count {
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
        background: var(--search-bg);
        border-radius: 15px;
        padding: 20px;
        margin-bottom: 25px;
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        max-width: 1200px;
        margin-left: auto;
        margin-right: auto;
    }

    .search-container {
        display: flex;
        gap: 15px;
        align-items: center;
        flex-wrap: wrap;
    }

    .search-box {
        position: relative;
        flex: 1;
        min-width: 300px;
    }

    .search-box input {
        width: 100%;
        padding: 14px 20px 14px 50px;
        border: 2px solid var(--light-gray);
        border-radius: 12px;
        font-size: 1rem;
        background: var(--white);
        transition: all 0.3s ease;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .search-box input:focus {
        outline: none;
        border-color: var(--primary-red);
        box-shadow: 0 2px 15px rgba(139, 0, 0, 0.2);
    }

    .search-box i {
        position: absolute;
        left: 20px;
        top: 50%;
        transform: translateY(-50%);
        color: var(--dark-gray);
        font-size: 1.1rem;
    }

    .filter-group {
        display: flex;
        gap: 10px;
        align-items: center;
    }

    .filter-select {
        padding: 12px 16px;
        border: 2px solid var(--light-gray);
        border-radius: 10px;
        background: var(--white);
        font-size: 0.9rem;
        cursor: pointer;
        transition: all 0.3s ease;
        min-width: 150px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .filter-select:focus {
        outline: none;
        border-color: var(--primary-red);
    }

    .clear-btn {
        background: var(--dark-gray);
        color: var(--white);
        border: none;
        padding: 12px 20px;
        border-radius: 10px;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 0.9rem;
        font-weight: 600;
        transition: all 0.3s ease;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .clear-btn:hover {
        background: #555;
        transform: translateY(-2px);
    }

    .results-info {
        background: var(--light-red);
        color: var(--dark-red);
        padding: 10px 20px;
        border-radius: 10px;
        font-weight: 600;
        margin-top: 15px;
        display: flex;
        align-items: center;
        gap: 10px;
        font-size: 0.9rem;
    }

   
    .hospital-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
        gap: 20px;
        max-width: 1400px;
        margin: 0 auto;
        padding: 10px;
    }

    
    .hospital-card {
        background: var(--white);
        border-radius: 15px;
        padding: 0;
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        transition: all 0.3s ease;
        border: 2px solid transparent;
        position: relative;
        overflow: hidden;
    }

    .hospital-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.25);
        border-color: var(--light-red);
    }

    .hospital-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: linear-gradient(90deg, var(--primary-red), var(--secondary-red));
    }

    .card-header {
        padding: 20px;
        background: linear-gradient(135deg, var(--primary-red), var(--dark-red));
        color: var(--white);
    }

    .hospital-title {
        display: flex;
        align-items: center;
        gap: 12px;
        margin-bottom: 10px;
    }

    .hospital-icon {
        width: 40px;
        height: 40px;
        background: rgba(255, 255, 255, 0.2);
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.2rem;
        flex-shrink: 0;
    }

    .hospital-name {
        font-size: 1.2rem;
        font-weight: 600;
        margin-bottom: 5px;
    }

    .hospital-id {
        background: var(--light-red);
        color: var(--dark-red);
        padding: 4px 12px;
        border-radius: 15px;
        font-size: 0.8rem;
        font-weight: 600;
        display: inline-block;
    }

    .specialty {
        font-size: 0.9rem;
        opacity: 0.9;
        display: flex;
        align-items: center;
        gap: 8px;
        margin-top: 8px;
    }

    .specialty i {
        color: var(--light-red);
    }

    .card-body {
        padding: 20px;
    }

    .info-item {
        display: flex;
        align-items: center;
        gap: 12px;
        margin-bottom: 15px;
        padding: 8px 0;
    }

    .info-item:last-child {
        margin-bottom: 0;
    }

    .info-icon {
        width: 32px;
        height: 32px;
        background: var(--light-red);
        color: var(--primary-red);
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 0.9rem;
        flex-shrink: 0;
    }

    .info-content {
        flex: 1;
    }

    .info-label {
        font-size: 0.8rem;
        color: var(--dark-red);
        font-weight: 600;
        margin-bottom: 2px;
        text-transform: uppercase;
    }

    .info-value {
        font-size: 0.9rem;
        color: var(--dark-gray);
        font-weight: 500;
    }

    .contact-tag {
        background: var(--primary-red);
        color: var(--white);
        padding: 4px 10px;
        border-radius: 12px;
        font-size: 0.75rem;
        font-weight: 600;
        display: inline-block;
        margin-top: 4px;
    }

    .medical-tags {
        display: flex;
        flex-wrap: wrap;
        gap: 6px;
        margin-top: 15px;
        padding-top: 15px;
        border-top: 1px solid var(--light-gray);
    }

    .medical-tag {
        background: var(--light-red);
        color: var(--dark-red);
        padding: 4px 10px;
        border-radius: 12px;
        font-size: 0.75rem;
        font-weight: 600;
        border: 1px solid rgba(139, 0, 0, 0.2);
    }

    .card-footer {
        padding: 15px 20px;
        background: var(--light-gray);
        border-top: 1px solid rgba(139, 0, 0, 0.1);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .status-badge {
        background: #4CAF50;
        color: white;
        padding: 6px 12px;
        border-radius: 15px;
        font-size: 0.8rem;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .status-badge i {
        font-size: 0.6rem;
    }

    .action-buttons {
        display: flex;
        gap: 8px;
    }

    .btn {
        padding: 8px 16px;
        border: none;
        border-radius: 8px;
        font-size: 0.8rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .btn-view {
        background: var(--primary-red);
        color: white;
    }

    .btn-view:hover {
        background: var(--dark-red);
        transform: translateY(-1px);
    }

    .btn-contact {
        background: transparent;
        color: var(--primary-red);
        border: 1px solid var(--primary-red);
    }

    .btn-contact:hover {
        background: var(--primary-red);
        color: white;
        transform: translateY(-1px);
    }

    .no-data {
        text-align: center;
        padding: 60px 20px;
        color: var(--white);
        grid-column: 1 / -1;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 15px;
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .no-data i {
        font-size: 3rem;
        margin-bottom: 15px;
        color: var(--light-red);
    }

    .no-data h2 {
        font-size: 1.5rem;
        margin-bottom: 10px;
    }

    .no-data p {
        font-size: 1rem;
        opacity: 0.9;
    }

    
    @media (max-width: 768px) {
        .hospital-grid {
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 15px;
            padding: 5px;
        }
        
        .header h1 {
            font-size: 1.8rem;
        }
        
        .back-button {
            top: 15px;
            left: 15px;
            padding: 10px 16px;
            font-size: 0.8rem;
        }
        
        .search-container {
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
        
        .card-footer {
            flex-direction: column;
            gap: 10px;
            text-align: center;
        }
        
        .action-buttons {
            width: 100%;
            justify-content: center;
        }
    }

    @media (max-width: 480px) {
        body {
            padding: 15px 10px;
        }
        
        .hospital-grid {
            grid-template-columns: 1fr;
        }
        
        .hospital-card {
            border-radius: 12px;
        }
        
        .card-header, .card-body, .card-footer {
            padding: 15px;
        }
        
        .btn {
            padding: 10px 15px;
            font-size: 0.85rem;
        }
        
        .search-section {
            padding: 15px;
        }
    }
</style>
</head>
<body>
    
    <a href="Aadminhomepage.jsp" class="back-button">
        <i class="fas fa-arrow-left"></i>
        Back to Dashboard
    </a>

    <div class="header">
        <h1><i class="fas fa-hospital"></i> Hospital Network</h1>
        <p>Blood Bank Partner Hospitals</p>
        <div class="hospital-count">
            <i class="fas fa-hospital-alt"></i> Registered Hospitals
        </div>
    </div>

    
    <div class="search-section">
        <div class="search-container">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search hospitals by name, specialty, location, or contact...">
            </div>
            <div class="filter-group">
                <select class="filter-select" id="specialtyFilter">
                    <option value="">All Specialties</option>
                    <option value="General">General Hospital</option>
                    <option value="Multi-specialty">Multi-specialty</option>
                    <option value="Emergency">Emergency Care</option>
                    <option value="Surgical">Surgical</option>
                    <option value="Cardiac">Cardiac Care</option>
                </select>
                <button class="clear-btn" id="clearFilters">
                    <i class="fas fa-times"></i>
                    Clear
                </button>
            </div>
        </div>
        <div class="results-info" id="resultsInfo">
            <i class="fas fa-info-circle"></i>
            Showing <span id="visibleCount">0</span> of <span id="totalCount">0</span> hospitals
        </div>
    </div>

    <div class="hospital-grid" id="hospitalGrid">
        <% 
        Connection con = Dbcon.create();
        PreparedStatement ps = con.prepareStatement("SELECT * FROM `blood`.`hospitaldetails`");
        ResultSet rs = ps.executeQuery();
        
        boolean hasData = false;
        int totalCount = 0;
        
        while(rs.next()) {
            hasData = true;
            totalCount++;
        %>
        
        <div class="hospital-card" 
             data-name="<%= rs.getString(2).toLowerCase() %>"
             data-specialty="<%= rs.getString(6).toLowerCase() %>"
             data-location="<%= rs.getString(7).toLowerCase() %>"
             data-contact="<%= rs.getString(5) %>"
             data-email="<%= rs.getString(4).toLowerCase() %>">
            <div class="card-header">
                <div class="hospital-title">
                    <div class="hospital-icon">
                        <i class="fas fa-hospital-alt"></i>
                    </div>
                    <div>
                        <div class="hospital-name"><%=rs.getString(2) %></div>
                        <div class="hospital-id">ID: <%=rs.getString(3) %></div>
                    </div>
                </div>
                <div class="specialty">
                    <i class="fas fa-stethoscope"></i>
                    <%=rs.getString(6) %>
                </div>
            </div>
            
            <div class="card-body">
                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-envelope"></i>
                    </div>
                    <div class="info-content">
                        <div class="info-label">Email</div>
                        <div class="info-value"><%=rs.getString(4) %></div>
                    </div>
                </div>
                
                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-phone-alt"></i>
                    </div>
                    <div class="info-content">
                        <div class="info-label">Contact</div>
                        <div class="info-value">
                            <%=rs.getString(5) %>
                            <div class="contact-tag">24/7</div>
                        </div>
                    </div>
                </div>
                
                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-map-marker-alt"></i>
                    </div>
                    <div class="info-content">
                        <div class="info-label">Address</div>
                        <div class="info-value"><%=rs.getString(7) %></div>
                    </div>
                </div>
                
                
            </div>
            
          
        </div>
        
        <% } 
        
        if (!hasData) {
        %>
        
        <div class="no-data">
            <i class="fas fa-hospital-user"></i>
            <h2>No Hospital Data Available</h2>
            <p>There are currently no hospitals registered in the system.</p>
        </div>
        
        <% } %>
    </div>

    <script>
      
        document.addEventListener('DOMContentLoaded', function() {
            const totalCount = <%= totalCount %>;
            document.getElementById('totalCount').textContent = totalCount;
            document.getElementById('visibleCount').textContent = totalCount;
            
            setupSearchFunctionality();
        });

        function setupSearchFunctionality() {
            const searchInput = document.getElementById('searchInput');
            const specialtyFilter = document.getElementById('specialtyFilter');
            const clearFiltersBtn = document.getElementById('clearFilters');
            const hospitalCards = document.querySelectorAll('.hospital-card');
            
            function performSearch() {
                const searchTerm = searchInput.value.toLowerCase();
                const selectedSpecialty = specialtyFilter.value.toLowerCase();
                let visibleCount = 0;
                
                hospitalCards.forEach(card => {
                    const name = card.getAttribute('data-name');
                    const specialty = card.getAttribute('data-specialty');
                    const location = card.getAttribute('data-location');
                    const contact = card.getAttribute('data-contact');
                    const email = card.getAttribute('data-email');
                    
                    const matchesSearch = name.includes(searchTerm) || 
                                         specialty.includes(searchTerm) || 
                                         location.includes(searchTerm) ||
                                         contact.includes(searchTerm) ||
                                         email.includes(searchTerm);
                    
                    const matchesSpecialty = !selectedSpecialty || specialty.includes(selectedSpecialty);
                    
                    if (matchesSearch && matchesSpecialty) {
                        card.style.display = 'block';
                        visibleCount++;
                    } else {
                        card.style.display = 'none';
                    }
                });
                
              
                document.getElementById('visibleCount').textContent = visibleCount;
                
                
                const noDataElement = document.querySelector('.no-data');
                if (visibleCount === 0 && hospitalCards.length > 0) {
                    if (!noDataElement) {
                        const hospitalGrid = document.getElementById('hospitalGrid');
                        const noResults = document.createElement('div');
                        noResults.className = 'no-data';
                        noResults.innerHTML = `
                            <i class="fas fa-search"></i>
                            <h2>No Hospitals Found</h2>
                            <p>Try adjusting your search criteria or filters</p>
                        `;
                        hospitalGrid.appendChild(noResults);
                    }
                } else if (noDataElement) {
                    noDataElement.remove();
                }
            }
            
            
            searchInput.addEventListener('input', performSearch);
            specialtyFilter.addEventListener('change', performSearch);
            
            
            clearFiltersBtn.addEventListener('click', function() {
                searchInput.value = '';
                specialtyFilter.value = '';
                performSearch();
            });
            
          
            performSearch();
        }
    </script>
</body>
</html>