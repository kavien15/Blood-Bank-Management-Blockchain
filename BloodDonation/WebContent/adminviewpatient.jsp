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
<title>Patient Management - Blood Bank</title>
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

    .patient-count {
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

   
    .patient-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
        gap: 25px;
        margin-bottom: 30px;
    }

    .patient-card {
        background: var(--white);
        border-radius: 20px;
        padding: 0;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        transition: all 0.4s ease;
        border: 2px solid transparent;
        position: relative;
        overflow: hidden;
    }

    .patient-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
        border-color: var(--light-red);
    }

    .patient-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 6px;
        background: linear-gradient(90deg, var(--primary-red), var(--secondary-red));
    }

    .card-header {
        background: linear-gradient(135deg, var(--primary-red), var(--dark-red));
        color: var(--white);
        padding: 25px;
        position: relative;
        overflow: hidden;
    }

    .card-header::after {
        content: '❤️';
        position: absolute;
        top: 15px;
        right: 20px;
        font-size: 3rem;
        opacity: 0.1;
    }

    .patient-main {
        display: flex;
        align-items: center;
        gap: 15px;
        margin-bottom: 10px;
    }

    .patient-avatar {
        width: 60px;
        height: 60px;
        background: rgba(255, 255, 255, 0.2);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        border: 2px solid rgba(255, 255, 255, 0.3);
    }

    .patient-info h3 {
        font-size: 1.4rem;
        font-weight: 700;
        margin-bottom: 5px;
    }

    .patient-id {
        background: var(--light-red);
        color: var(--dark-red);
        padding: 5px 12px;
        border-radius: 15px;
        font-size: 0.8rem;
        font-weight: 600;
        display: inline-block;
    }

    .patient-details {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-top: 8px;
        font-size: 0.9rem;
        opacity: 0.9;
    }

    .card-body {
        padding: 25px;
    }

    .info-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 15px;
        margin-bottom: 20px;
    }

    .info-item {
        display: flex;
        flex-direction: column;
        gap: 5px;
    }

    .info-label {
        font-size: 0.8rem;
        color: var(--dark-red);
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .info-value {
        font-size: 0.95rem;
        color: var(--dark-gray);
        font-weight: 500;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .blood-group {
        background: var(--primary-red);
        color: var(--white);
        padding: 6px 12px;
        border-radius: 15px;
        font-size: 0.9rem;
        font-weight: 600;
        display: inline-block;
        margin-top: 5px;
    }

    .contact-info {
        background: var(--light-gray);
        padding: 15px;
        border-radius: 12px;
        margin-top: 15px;
        border-left: 4px solid var(--primary-red);
    }

    .contact-item {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 8px;
        font-size: 0.9rem;
    }

    .contact-item:last-child {
        margin-bottom: 0;
    }

    .contact-item i {
        color: var(--primary-red);
        width: 16px;
    }

    .card-footer {
        background: var(--light-gray);
        padding: 20px 25px;
        border-top: 1px solid rgba(139, 0, 0, 0.1);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .status-badge {
        background: #4CAF50;
        color: white;
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .status-badge i {
        font-size: 0.6rem;
    }

    .urgency-indicator {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 0.85rem;
        color: var(--dark-gray);
        font-weight: 500;
    }

    .urgency-dot {
        width: 10px;
        height: 10px;
        background: #4CAF50;
        border-radius: 50%;
        animation: pulse 2s infinite;
    }

    .urgency-high .urgency-dot {
        background: #f44336;
    }

    .urgency-medium .urgency-dot {
        background: #FF9800;
    }

   
    .no-results {
        text-align: center;
        padding: 60px 20px;
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
        font-size: 4rem;
        color: var(--light-red);
        margin-bottom: 20px;
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

        .patient-grid {
            grid-template-columns: 1fr;
        }

        .info-grid {
            grid-template-columns: 1fr;
        }

        .card-footer {
            flex-direction: column;
            gap: 15px;
            text-align: center;
        }
    }

    @media screen and (max-width: 480px) {
        .header h1 {
            font-size: 1.6rem;
        }

        .stats-container {
            grid-template-columns: 1fr;
        }

        .patient-card {
            border-radius: 15px;
        }

        .card-header, .card-body, .card-footer {
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
            <h1><i class="fas fa-user-injured"></i> Patient Management</h1>
            <p>Blood Requisition & Patient Care System</p>
            <div class="patient-count">
                <i class="fas fa-hospital-user"></i> Active Patients
            </div>
        </div>
    </div>

    
    <div class="search-section">
        <div class="search-container">
            <div class="search-box">
                <input type="text" id="patientSearch" class="search-input" placeholder="Search patients by name, ID, or blood group...">
                <i class="fas fa-search search-icon"></i>
            </div>
            <div class="filter-buttons">
                <button class="filter-btn active" data-filter="all">
                    <i class="fas fa-users"></i> All Patients
                </button>
                <button class="filter-btn" data-filter="urgent">
                    <i class="fas fa-exclamation-triangle"></i> Urgent
                </button>
                <button class="filter-btn" data-filter="clear">
                    <i class="fas fa-times"></i> Clear
                </button>
            </div>
        </div>
    </div>

    
    <div class="stats-container">
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-user-injured"></i>
            </div>
            <div class="stat-number" id="totalPatients">0</div>
            <div class="stat-label">Total Patients</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-tint"></i>
            </div>
            <div class="stat-number">18</div>
            <div class="stat-label">Blood Requests</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-clock"></i>
            </div>
            <div class="stat-number">7</div>
            <div class="stat-label">Pending Cases</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="stat-number">24</div>
            <div class="stat-label">Completed</div>
        </div>
    </div>

   
    <div class="no-results" id="noResults">
        <i class="fas fa-user-slash"></i>
        <h3>No Patients Found</h3>
        <p>No patients match your search criteria. Try adjusting your search terms.</p>
    </div>

    
    <div class="patient-grid" id="patientGrid">
        <% 
        Connection con = Dbcon.create();
        PreparedStatement ps = con.prepareStatement("SELECT * FROM `blood`.`patient` ");
        ResultSet rs = ps.executeQuery();
        int patientCount = 0;
        
        while(rs.next()) {
            patientCount++;
            String patientName = rs.getString(2);
            String patientInitial = patientName.substring(0, 1).toUpperCase();
            
            String[] urgencies = {"low", "medium", "high"};
            String urgency = urgencies[(int)(Math.random() * urgencies.length)];
        %>
        
        <div class="patient-card" data-name="<%= patientName.toLowerCase() %>" data-id="<%= rs.getString(10).toLowerCase() %>" data-blood="<%= rs.getString(9).toLowerCase() %>">
            <div class="card-header">
                <div class="patient-main">
                    <div class="patient-avatar">
                        <i class="fas fa-user"></i>
                    </div>
                    <div class="patient-info">
                        <h3><%= patientName %></h3>
                        <div class="patient-id">ID: <%= rs.getString(10) %></div>
                        <div class="patient-details">
                            <span><i class="fas fa-venus-mars"></i> <%= rs.getString(6) %></span>
                            <span>•</span>
                            <span><i class="fas fa-birthday-cake"></i> <%= rs.getString(7) %> years</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="card-body">
                <div class="info-grid">
                    <div class="info-item">
                        <div class="info-label">Blood Group</div>
                        <div class="info-value">
                            <span class="blood-group"><%= rs.getString(9) %></span>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Hospital</div>
                        <div class="info-value">
                            <i class="fas fa-hospital"></i>
                            <%= rs.getString(8) %>
                        </div>
                    </div>
                </div>
                
                <div class="contact-info">
                    <div class="contact-item">
                        <i class="fas fa-envelope"></i>
                        <span><%= rs.getString(3) %></span>
                    </div>
                    <div class="contact-item">
                        <i class="fas fa-phone"></i>
                        <span><%= rs.getString(4) %></span>
                    </div>
                    <div class="contact-item">
                        <i class="fas fa-map-marker-alt"></i>
                        <span><%= rs.getString(5) %></span>
                    </div>
                </div>
            </div>
            
            <div class="card-footer">
                <div class="status-badge">
                    <i class="fas fa-circle"></i>
                    Active Treatment
                </div>
                <div class="urgency-indicator <%= "urgency-" + urgency %>">
                    <div class="urgency-dot"></div>
                    <span>Priority: <%= urgency.substring(0, 1).toUpperCase() + urgency.substring(1) %></span>
                </div>
            </div>
        </div>
        
        <% } %>
    </div>

    <script>
       
        document.getElementById('totalPatients').textContent = <%= patientCount %>;

        
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('patientSearch');
            const noResults = document.getElementById('noResults');
            const patientGrid = document.getElementById('patientGrid');
            const patientCards = document.querySelectorAll('.patient-card');
            const filterButtons = document.querySelectorAll('.filter-btn');
            
           
            function performSearch(searchText) {
                searchText = searchText.toLowerCase().trim();
                let hasResults = false;
                
                patientCards.forEach(card => {
                    const name = card.getAttribute('data-name');
                    const id = card.getAttribute('data-id');
                    const blood = card.getAttribute('data-blood');
                    
                    if (searchText === '' || 
                        name.includes(searchText) || 
                        id.includes(searchText) || 
                        blood.includes(searchText)) {
                        card.style.display = 'block';
                        hasResults = true;
                    } else {
                        card.style.display = 'none';
                    }
                });
                
               
                if (searchText !== '' && !hasResults) {
                    noResults.classList.add('show');
                    patientGrid.style.display = 'none';
                } else {
                    noResults.classList.remove('show');
                    patientGrid.style.display = 'grid';
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
                    } else if (filter === 'urgent') {
                       
                        patientCards.forEach(card => {
                            const urgency = card.querySelector('.urgency-indicator').classList.contains('urgency-high');
                            card.style.display = urgency ? 'block' : 'none';
                        });
                    }
                });
            });
            
            
            performSearch('');
        });
    </script>
</body>
</html>