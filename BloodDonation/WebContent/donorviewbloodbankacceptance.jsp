<%@page import="java.sql.*"%>
<%@page import="dbcon.Dbcon"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accepted Blood Requests | BloodCare</title>
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

        
        .results-count {
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

        .status-accepted {
            background: rgba(40, 167, 69, 0.15);
            color: var(--success);
        }

        .doctor-name {
            font-weight: 600;
            color: var(--secondary-color);
        }

        .doctor-details {
            color: var(--dark-gray);
            font-size: 0.9rem;
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

       
        .no-results {
            text-align: center;
            padding: 40px 20px;
            color: var(--dark-gray);
            display: none;
        }

        .no-results.show {
            display: block;
        }

        .no-results i {
            font-size: 3rem;
            color: var(--medium-gray);
            margin-bottom: 15px;
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
                        <h1>BloodCare</h1>
                        <div class="subtitle">Accepted Blood Requests</div>
                    </div>
                </div>
            </div>
        </div>

        
        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-value" id="acceptedCount">0</div>
                <div class="stat-label">Accepted Requests</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-user-md"></i>
                </div>
                <div class="stat-value" id="doctorCount">0</div>
                <div class="stat-label">Blood Banks</div>
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
                <div class="stat-label">Total Records</div>
            </div>
        </div>

        
        <div class="main-content">
            <div class="content-header">
                <h2 class="content-title">
                    <i class="fas fa-check-circle"></i>
                    Accepted Blood Requests
                </h2>
                <div class="controls">
                    <a href="javascript:history.back()" class="back-btn">
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

            
            <div class="results-count" id="resultsCount">
                <i class="fas fa-list"></i>
                Showing <span id="visibleCount">0</span> of <span id="totalCountDisplay">0</span> records
            </div>

           
            <div class="no-results" id="noResults">
                <i class="fas fa-search"></i>
                <h3>No Matching Records Found</h3>
                <p>Try adjusting your search criteria or filters</p>
            </div>

            <div class="table-container">
                <%
                HttpSession s = request.getSession();
                String email = s.getAttribute("email") != null ? s.getAttribute("email").toString() : "";
                
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                int requestCount = 0;
                
                try {
                    con = Dbcon.create();
                    
                    
                    String sql = "SELECT * FROM donorbloodrequest WHERE status='accepted' AND email=?";
                    ps = con.prepareStatement(sql);
                    ps.setString(1, email);
                    rs = ps.executeQuery();

                    if (!rs.isBeforeFirst()) {
                %>
                <div class="empty-state">
                    <i class="fas fa-check-circle"></i>
                    <h3>No Accepted Requests</h3>
                    <p>There are no accepted blood requests at the moment.</p>
                </div>
                <%
                    } else {
                %>
                <table id="requestsTable">
                    <thead>
                        <tr>
                            <th>Patient Details</th>
                            <th>Blood Group</th>
                            <th>Accepted By (Blood Bank)</th>
                            <th>Donor Contact</th>
                            <th>Hospital</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                        <%
                        while(rs.next()) {
                            requestCount++;
                            String patientName = rs.getString(3) != null ? rs.getString(3) : "";
                            String patientAge = rs.getString(4) != null ? rs.getString(4) : "";
                            String bloodGroup = rs.getString(6) != null ? rs.getString(6) : "";
                            String bloodBank = rs.getString(2) != null ? rs.getString(2) : "";
                            String donorContact = rs.getString(12) != null ? rs.getString(12) : "";
                            String hospital = rs.getString(5) != null ? rs.getString(5) : "";
                        %>
                        <tr data-name="<%= patientName.toLowerCase() %>" 
                            data-hospital="<%= hospital.toLowerCase() %>" 
                            data-bloodgroup="<%= bloodGroup %>"
                            data-bloodbank="<%= bloodBank.toLowerCase() %>"
                            data-contact="<%= donorContact.toLowerCase() %>">
                            <td>
                                <div class="patient-name">Name: <%= patientName %></div>
                                <div class="patient-email">Age: <%= patientAge %></div>
                            </td>
                            <td>
                                <span class="blood-group"><%= bloodGroup %></span>
                            </td>
                            <td>
                                <div class="doctor-name"><%= bloodBank %></div>
                            </td>
                            <td>
                                <div class="doctor-details"><%= donorContact %></div>
                            </td>
                            <td><%= hospital %></td>
                            <td>
                                <span class="status-badge status-accepted">
                                    <i class="fas fa-check"></i> Accepted
                                </span>
                            </td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
                <%
                    }
                } catch(Exception e) {
                %>
                <div class="empty-state">
                    <i class="fas fa-exclamation-triangle"></i>
                    <h3>Database Error</h3>
                    <p>Unable to load accepted requests. Please try again later.</p>
                    <p style="color: var(--danger); font-size: 0.9rem; margin-top: 10px;"><%= e.getMessage() %></p>
                </div>
                <%
                } finally {
                    if(rs != null) rs.close();
                    if(ps != null) ps.close();
                    if(con != null) con.close();
                }
                %>
            </div>
        </div>
    </div>

    <script>
       
        document.addEventListener('DOMContentLoaded', function() {
            const acceptedCount = <%= requestCount %>;
            
           
            updateStatistics(acceptedCount);
            
            
            populateHospitalFilter();
            
            
            setupSearchAndFilters();
        });

        
        function updateStatistics(totalCount) {
            document.getElementById('acceptedCount').textContent = totalCount;
            document.getElementById('totalCount').textContent = totalCount;
            document.getElementById('totalCountDisplay').textContent = totalCount;
            document.getElementById('visibleCount').textContent = totalCount;
            
           
            const bloodBanks = new Set();
            const hospitals = new Set();
            
            
            const bloodBankCells = document.querySelectorAll('td:nth-child(3)');
            const hospitalCells = document.querySelectorAll('td:nth-child(5)');
            
            bloodBankCells.forEach(cell => {
                const bloodBankName = cell.querySelector('.doctor-name').textContent.trim();
                if (bloodBankName) bloodBanks.add(bloodBankName);
            });
            
            hospitalCells.forEach(cell => {
                const hospital = cell.textContent.trim();
                if (hospital) hospitals.add(hospital);
            });
            
            document.getElementById('doctorCount').textContent = bloodBanks.size;
            document.getElementById('hospitalCount').textContent = hospitals.size;
        }

       
        function populateHospitalFilter() {
            const hospitalFilter = document.getElementById('hospitalFilter');
            const hospitals = new Set();
            
           
            const hospitalCells = document.querySelectorAll('td:nth-child(5)');
            hospitalCells.forEach(cell => {
                const hospital = cell.textContent.trim();
                if (hospital && hospital !== "") {
                    hospitals.add(hospital);
                }
            });
            
          
            while (hospitalFilter.children.length > 1) {
                hospitalFilter.removeChild(hospitalFilter.lastChild);
            }
            
            
            hospitals.forEach(hospital => {
                if (hospital) {
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
            const noResultsMessage = document.getElementById('noResults');
            const tableBody = document.getElementById('tableBody');
            
          
            function performSearch() {
                const searchTerm = searchInput.value.toLowerCase();
                const selectedBloodGroup = bloodGroupFilter.value;
                const selectedHospital = hospitalFilter.value;
                
                let visibleCount = 0;
                let hasVisibleRows = false;
                
                tableRows.forEach(row => {
                    const name = row.getAttribute('data-name') || '';
                    const hospital = row.getAttribute('data-hospital') || '';
                    const bloodGroup = row.getAttribute('data-bloodgroup') || '';
                    const bloodBank = row.getAttribute('data-bloodbank') || '';
                    const contact = row.getAttribute('data-contact') || '';
                    
                    
                    const matchesSearch = searchTerm === '' || 
                                         name.includes(searchTerm) || 
                                         hospital.includes(searchTerm) || 
                                         bloodGroup.toLowerCase().includes(searchTerm) ||
                                         bloodBank.includes(searchTerm) ||
                                         contact.includes(searchTerm);
                    
                    const matchesBloodGroup = selectedBloodGroup === '' || bloodGroup === selectedBloodGroup;
                    const matchesHospital = selectedHospital === '' || hospital.includes(selectedHospital.toLowerCase());
                    
                    if (matchesSearch && matchesBloodGroup && matchesHospital) {
                        row.style.display = '';
                        visibleCount++;
                        hasVisibleRows = true;
                    } else {
                        row.style.display = 'none';
                    }
                });
                
               
                document.getElementById('visibleCount').textContent = visibleCount;
                document.getElementById('acceptedCount').textContent = visibleCount;
                
               
                if (hasVisibleRows || tableRows.length === 0) {
                    noResultsMessage.classList.remove('show');
                } else {
                    noResultsMessage.classList.add('show');
                }
                
                
                updateVisibleStatistics();
            }
            
           
            function updateVisibleStatistics() {
                const visibleBloodBanks = new Set();
                const visibleHospitals = new Set();
                
                document.querySelectorAll('#requestsTable tbody tr').forEach(row => {
                    if (row.style.display !== 'none') {
                        const bloodBankCell = row.querySelector('td:nth-child(3)');
                        const hospitalCell = row.querySelector('td:nth-child(5)');
                        
                        if (bloodBankCell) {
                            const bloodBankName = bloodBankCell.querySelector('.doctor-name').textContent.trim();
                            if (bloodBankName) visibleBloodBanks.add(bloodBankName);
                        }
                        
                        if (hospitalCell) {
                            const hospital = hospitalCell.textContent.trim();
                            if (hospital) visibleHospitals.add(hospital);
                        }
                    }
                });
                
                document.getElementById('doctorCount').textContent = visibleBloodBanks.size;
                document.getElementById('hospitalCount').textContent = visibleHospitals.size;
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