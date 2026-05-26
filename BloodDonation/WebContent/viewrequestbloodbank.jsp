<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="dbcon.Dbcon" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Donor Requests - LifeBlood Bank</title>
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
            background: linear-gradient(135deg, #750000 0%, #750000 100%);
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
            width: 200px;
            height: 200px;
            top: 10%;
            right: 5%;
            animation-delay: 0s;
        }

        .circle-2 {
            width: 150px;
            height: 150px;
            bottom: 15%;
            left: 5%;
            animation-delay: 2s;
        }

        .circle-3 {
            width: 100px;
            height: 100px;
            top: 60%;
            right: 20%;
            animation-delay: 4s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-25px) rotate(180deg); }
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        
        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 15px;
            padding: 25px 30px;
            margin-bottom: 25px;
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

        .logo-section {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-red), var(--dark-red));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.8rem;
            box-shadow: 0 5px 15px rgba(200, 16, 46, 0.3);
        }
        .header-actions {
    display: flex;
    align-items: center;
    gap: 20px;
}

.nav-btn {
    padding: 10px 16px;
    background-color: #e63946;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 15px;
    font-weight: 600;
    transition: 0.3s ease;
}

.nav-btn:hover {
    background-color: #d62828;
}
        

        .header-text h1 {
            font-size: 2rem;
            font-weight: 700;
            background: linear-gradient(135deg, var(--primary-red), var(--dark-red));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 5px;
        }

        .header-text p {
            color: var(--secondary-color);
            font-size: 1rem;
            opacity: 0.8;
        }

        .stats-badge {
            background: var(--light-red);
            padding: 12px 20px;
            border-radius: 10px;
            border: 1px solid rgba(200, 16, 46, 0.2);
            text-align: center;
        }

        .stats-count {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary-red);
        }

        .stats-label {
            font-size: 0.9rem;
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
            padding-bottom: 20px;
            border-bottom: 2px solid var(--light-red);
        }

        .content-title {
            font-size: 1.6rem;
            font-weight: 600;
            color: var(--secondary-color);
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .content-title i {
            color: var(--primary-red);
            font-size: 1.8rem;
        }

        .controls {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .search-box {
            position: relative;
        }

        .search-box input {
            padding: 12px 15px 12px 40px;
            border: 2px solid var(--medium-gray);
            border-radius: 8px;
            width: 300px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }

        .search-box input:focus {
            border-color: var(--primary-red);
            outline: none;
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
            align-items: center;
        }

        .filter-select {
            padding: 12px 15px;
            border: 2px solid var(--medium-gray);
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

        .action-btn {
            background: var(--primary-red);
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .action-btn:hover {
            background: var(--dark-red);
            transform: translateY(-2px);
        }

        .back-btn {
            background: var(--secondary-color);
        }

        .back-btn:hover {
            background: #1a252f;
        }

        .refresh-btn {
            background: var(--primary-red);
        }

        
        .results-counter {
            background: var(--light-red);
            padding: 12px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 500;
            color: var(--secondary-color);
        }

        .results-counter i {
            color: var(--primary-red);
        }

       
        .table-container {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }

        table {
            width: 100%;
            border-collapse: collapse;
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
            position: relative;
        }

        th:not(:last-child)::after {
            content: '';
            position: absolute;
            right: 0;
            top: 20%;
            height: 60%;
            width: 1px;
            background: rgba(255, 255, 255, 0.3);
        }

        tbody tr {
            transition: all 0.3s ease;
            border-bottom: 1px solid var(--medium-gray);
        }

        tbody tr:hover {
            background-color: var(--light-red);
            transform: scale(1.002);
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

        .patient-info {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .patient-name {
            font-weight: 600;
            color: var(--secondary-color);
            font-size: 1rem;
        }

        .patient-contact {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.85rem;
            color: var(--dark-gray);
        }

        .patient-contact i {
            color: var(--primary-red);
            width: 14px;
        }

        .hospital-info {
            font-weight: 500;
            color: var(--secondary-color);
        }

        .blood-group {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 15px;
            background: var(--light-red);
            color: var(--primary-red);
            border-radius: 20px;
            font-weight: 700;
            font-size: 0.9rem;
        }

        .blood-group i {
            font-size: 0.8rem;
        }

        .request-type {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 0.85rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .type-blood {
            background: #ffeaa7;
            color: #e17055;
        }

        .type-plasma {
            background: #a29bfe;
            color: #2d3436;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn {
            padding: 10px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            font-size: 0.85rem;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            min-width: 80px;
            justify-content: center;
        }

        .btn-accept {
            background: var(--success);
            color: white;
        }

        .btn-accept:hover {
            background: #218838;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(40, 167, 69, 0.3);
        }

        .btn-reject {
            background: var(--danger);
            color: white;
        }

        .btn-reject:hover {
            background: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(220, 53, 69, 0.3);
        }

        .btn-view {
            background: var(--secondary-color);
            color: white;
        }

        .btn-view:hover {
            background: #1a252f;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(44, 62, 80, 0.3);
        }

        
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: var(--dark-gray);
        }

        .empty-state i {
            font-size: 4rem;
            color: var(--medium-gray);
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: var(--secondary-color);
        }

        .empty-state p {
            font-size: 1rem;
            max-width: 400px;
            margin: 0 auto;
            line-height: 1.6;
        }

        
        .footer {
            text-align: center;
            margin-top: 30px;
            color: white;
            opacity: 0.8;
            font-size: 0.9rem;
        }

        
        @media (max-width: 1200px) {
            .table-container {
                overflow-x: auto;
            }
            
            table {
                min-width: 1000px;
            }
        }

        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                text-align: center;
            }

            .content-header {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }

            .controls {
                width: 100%;
                justify-content: space-between;
                flex-wrap: wrap;
            }

            .search-box input {
                width: 100%;
            }

            .filter-group {
                width: 100%;
                justify-content: space-between;
            }

            .filter-select {
                flex: 1;
            }

            th, td {
                padding: 14px 16px;
            }
        }

        @media (max-width: 480px) {
            .controls {
                flex-direction: column;
                gap: 10px;
            }

            .action-buttons {
                flex-direction: column;
                gap: 5px;
            }

            .btn {
                min-width: 70px;
                padding: 8px 12px;
                font-size: 0.8rem;
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
        <div class="logo-section">
            <div class="logo">
                <i class="fas fa-tint"></i>
            </div>
            <div class="header-text">
                <h1>User Blood Requests	</h1>
                <p>Donor Requests Management System</p>
            </div>
        </div>

        <div class="header-actions">
            <div class="stats-badge">
                <div class="stats-count" id="requestCount">0</div>
                <div class="stats-label">Pending Requests</div>
            </div>

            <button class="nav-btn" onclick="window.location.href='bloodbankdonatedhistory.jsp'">
                Donated History
            </button>
        </div>
    </div>
</div>


       
        <div class="main-content">
            <div class="content-header">
                <h2 class="content-title">
                    <i class="fas fa-hand-holding-medical"></i>
                    All Donor Requests
                </h2>
                <div class="controls">
                    <a href="bloodbankdashboard.jsp" class="action-btn back-btn">
                        <i class="fas fa-arrow-left"></i>
                        Back
                    </a>
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="searchInput" placeholder="Search by patient name, hospital, blood group...">
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
                        <button class="action-btn refresh-btn" onclick="location.reload()">
                            <i class="fas fa-sync-alt"></i>
                            Refresh
                        </button>
                    </div>
                </div>
            </div>

          
            <div class="results-counter" id="resultsCounter">
                <i class="fas fa-list"></i>
                Showing <span id="visibleCount">0</span> of <span id="totalCount">0</span> requests
            </div>

            <div class="table-container">
                <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                int requestCount = 0;
                
                HttpSession s= request.getSession();
                
                String bid= s.getAttribute("bloodbankId").toString();
                String email= s.getAttribute("email").toString();
                
                System.out.println(bid);
                System.out.println(email);
               

                if (bid == null) {
                    response.sendRedirect("bloodbanklogin.jsp?msg=Please login first");
                    return;
                }

                
                try {
                    con = Dbcon.create();
                    ps = con.prepareStatement("SELECT * FROM donorbloodrequest WHERE status='requested' AND bid='"+bid+"'");
                    rs = ps.executeQuery();
                    
                    if (!rs.isBeforeFirst()) {
                %>
                <div class="empty-state">
                    <i class="fas fa-inbox"></i>
                    <h3>No Pending Requests</h3>
                    <p>All donor requests have been processed. New requests will appear here automatically.</p>
                </div>
                <%
                    } else {
                %>
                <table>
                    <thead>
                        <tr>
                            <th>Patient Details</th>
                            <th>Hospital</th>
                            <th>Blood Group</th>
                            <th>Quantity</th>
                            <th>Reason</th>
                            <th>Medical Document</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="requestTable">
                        <%
                        while(rs.next()) {
                            requestCount++;
                            
                           
                        %>
                        <tr data-name="<%= rs.getString(3).toLowerCase() %>" 
                            data-hospital="<%= rs.getString(5).toLowerCase() %>" 
                            data-bloodgroup="<%= rs.getString(6) %>"
                            data-reason="<%= rs.getString(8).toLowerCase() %>">
                            <td>
                                <div class="patient-info">
                                    <div class="patient-name"><%=rs.getString(3)%></div>
                                    <div class="patient-contact">
                                        <i class="fas fa-user"></i>
                                       Age: <%=rs.getString(4)%>
                                    </div>
                                    <div class="patient-contact">
                                        <i class="fas fa-map-marker-alt"></i>
                                      <%=rs.getString(5)%>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="hospital-info">
                                    <i class="fas fa-hospital"></i> <%=rs.getString(5)%>
                                </div>
                            </td>
                            <td>
                                <span class="blood-group">
                                    <i class="fas fa-tint"></i> <%=rs.getString(6)%>
                                </span>
                            </td>
                            <td>
                                <span class="request-type type-blood">
                                    <%=rs.getString(7)%> ml
                                </span>
                            </td>
                            <td>
                                <span class="request-type type-plasma">
                                    <%=rs.getString(8)%>
                                </span>
                            </td>
                             <td>
                                <div class="action-buttons">
                                    <a href="view.jsp?id=<%=rs.getInt("id")%>" 
                                       class="btn btn-view" 
                                       target="_blank">
                                        <i class="fas fa-eye"></i> View
                                    </a>
                                </div>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <a href="bloodbankupdatestatus.jsp?id=<%=rs.getInt("id")%>&status=accepted&from=bloodbank" 
                                       class="btn btn-accept" 
                                       onclick="return confirm('Accept this donor request?')">
                                        <i class="fas fa-check"></i> Accept
                                    </a>
                                    <a href="bloodbankupdatestatus.jsp?id=<%=rs.getInt("id")%>&status=rejected&from=bloodbank" 
                                       class="btn btn-reject"
                                       onclick="return confirm('Reject this donor request?')">
                                        <i class="fas fa-times"></i> Reject
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
                %>
                <div class="empty-state">
                    <i class="fas fa-exclamation-triangle"></i>
                    <h3>Database Connection Error</h3>
                    <p>Unable to load donor requests. Please check your database connection and try again.</p>
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
            const totalCount = <%= requestCount %>;
            document.getElementById('requestCount').textContent = totalCount;
            document.getElementById('totalCount').textContent = totalCount;
            document.getElementById('visibleCount').textContent = totalCount;
            
            
            setupSearchAndFilters();
        });

        function setupSearchAndFilters() {
            const searchInput = document.getElementById('searchInput');
            const bloodGroupFilter = document.getElementById('bloodGroupFilter');
            const tableRows = document.querySelectorAll('#requestTable tr');
            
            function performSearch() {
                const searchTerm = searchInput.value.toLowerCase();
                const selectedBloodGroup = bloodGroupFilter.value;
                let visibleCount = 0;
                
                tableRows.forEach(row => {
                    const name = row.getAttribute('data-name');
                    const hospital = row.getAttribute('data-hospital');
                    const bloodGroup = row.getAttribute('data-bloodgroup');
                    const reason = row.getAttribute('data-reason');
                    
                    const matchesSearch = name.includes(searchTerm) || 
                                         hospital.includes(searchTerm) || 
                                         reason.includes(searchTerm);
                    
                    const matchesBloodGroup = !selectedBloodGroup || bloodGroup === selectedBloodGroup;
                    
                    if (matchesSearch && matchesBloodGroup) {
                        row.style.display = '';
                        visibleCount++;
                    } else {
                        row.style.display = 'none';
                    }
                });
                
               
                document.getElementById('visibleCount').textContent = visibleCount;
            }
            
            
            searchInput.addEventListener('input', performSearch);
            bloodGroupFilter.addEventListener('change', performSearch);
            
            
            performSearch();
        }
    </script>
</body>
</html>	