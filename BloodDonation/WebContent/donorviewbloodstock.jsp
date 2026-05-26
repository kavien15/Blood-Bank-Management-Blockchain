<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="dbcon.Dbcon" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Donation Records - LifeBlood Bank</title>
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
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4edf5 100%);
            color: #333;
            line-height: 1.6;
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: var(--white);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        
        .header {
            background: linear-gradient(135deg, var(--primary-red), var(--dark-red));
            color: var(--white);
            padding: 2rem;
            text-align: center;
        }

        .header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }

        .header h1 i {
            font-size: 2.8rem;
            filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.2));
        }

        .tagline {
            font-size: 1.1rem;
            opacity: 0.9;
            font-weight: 300;
        }

        
        .action-bar {
            background: var(--white);
            padding: 1.5rem 2rem;
            border-bottom: 1px solid var(--medium-gray);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .btn-group {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: linear-gradient(135deg, var(--primary-red), var(--dark-red));
            color: var(--white);
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            box-shadow: 0 4px 8px rgba(200, 16, 46, 0.25);
        }

        .btn:hover {
            background: linear-gradient(135deg, var(--dark-red), #8a0b20);
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(200, 16, 46, 0.3);
        }

        .btn-outline {
            background: transparent;
            border: 2px solid var(--primary-red);
            color: var(--primary-red);
            box-shadow: none;
        }

        .btn-outline:hover {
            background: var(--light-red);
            transform: translateY(-2px);
        }

       
        .filter-section {
            background: var(--light-gray);
            padding: 1.5rem 2rem;
            border-bottom: 1px solid var(--medium-gray);
        }

        .filter-group {
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }

        .blood-group-filter {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .blood-group-btn {
            padding: 8px 16px;
            border: 2px solid var(--primary-red);
            background: transparent;
            color: var(--primary-red);
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .blood-group-btn:hover, .blood-group-btn.active {
            background: var(--primary-red);
            color: var(--white);
            transform: translateY(-2px);
        }

        .search-box {
            position: relative;
            flex: 1;
            min-width: 250px;
        }

        .search-box input {
            width: 100%;
            padding: 10px 15px 10px 40px;
            border: 2px solid var(--medium-gray);
            border-radius: 25px;
            font-size: 1rem;
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

        
        .blood-stats {
            background: var(--white);
            padding: 1.5rem 2rem;
            border-bottom: 1px solid var(--medium-gray);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }

        .stat-card {
            background: var(--light-gray);
            padding: 1rem;
            border-radius: 10px;
            text-align: center;
            border-left: 4px solid var(--primary-red);
        }

        .blood-group {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-red);
            margin-bottom: 5px;
        }

        .blood-percentage {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--secondary-color);
            margin-bottom: 5px;
        }

        .blood-quantity {
            font-size: 0.9rem;
            color: var(--dark-gray);
        }

       
        .table-container {
            padding: 0;
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 0;
        }

        thead {
            background: linear-gradient(135deg, var(--primary-red), var(--dark-red));
        }

        th {
            color: var(--white);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
            padding: 18px 20px;
            text-align: left;
            border: none;
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
            border: none;
            font-size: 0.95rem;
        }

        .blood-group-badge {
            display: inline-block;
            padding: 6px 12px;
            background-color: var(--light-red);
            color: var(--primary-red);
            border-radius: 20px;
            font-weight: 600;
            text-align: center;
            min-width: 50px;
        }

        .quantity {
            font-weight: 600;
            color: var(--secondary-color);
        }

       
        .footer {
            background: var(--secondary-color);
            color: var(--white);
            text-align: center;
            padding: 1.5rem;
            margin-top: 2rem;
        }

        .footer-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .social-links {
            display: flex;
            gap: 15px;
        }

        .social-links a {
            color: var(--white);
            font-size: 1.2rem;
            transition: color 0.3s ease;
        }

        .social-links a:hover {
            color: var(--primary-red);
        }

      
        @media (max-width: 768px) {
            .header h1 {
                font-size: 2rem;
            }
            
            .action-bar {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .btn-group {
                width: 100%;
                justify-content: space-between;
            }
            
            .filter-group {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .search-box {
                width: 100%;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .footer-content {
                flex-direction: column;
                text-align: center;
            }
            
            table {
                display: block;
                overflow-x: auto;
            }
            
            th, td {
                padding: 12px 15px;
            }
        }

       
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .fade-in {
            animation: fadeIn 0.5s ease-out;
        }
    </style>
</head>
<body>
    <div class="container fade-in">
       
        <div class="header">
            <h1>
                <i class="fas fa-tint"></i>
                Blood Stock Details
            </h1>
            <div class="tagline">LifeBlood Bank - Saving Lives Through Donations</div>
        </div>

       
        <div class="action-bar">
            <div class="btn-group">
            
                <a href="donorviewbloodbank.jsp" class="btn btn-outline">
                    <i class="fas fa-arrow-left"></i> Go Back
                </a>
            </div>
            <div class="total-stats">
                <span style="font-weight: 600; color: var(--secondary-color);">
                    <i class="fas fa-database"></i> Total Records: 
                    <%
                    
                    
                    String bid=request.getParameter("bid");
                    String email=request.getParameter("email");
                    
                        Connection conCount = null;
                        PreparedStatement pstmtCount = null;
                        ResultSet rsCount = null;
                        int totalRecords = 0;
                        
                        try {
                            conCount = Dbcon.create();
                            String countSql = "SELECT COUNT(*) as total FROM blooddetails WHERE bid='"+bid+"' AND email='"+email+"'";
                            pstmtCount = conCount.prepareStatement(countSql);
                            rsCount = pstmtCount.executeQuery();
                            if (rsCount.next()) {
                                totalRecords = rsCount.getInt("total");
                            }
                        } catch (Exception e) {
                            
                        } finally {
                            try {
                                if (rsCount != null) rsCount.close();
                                if (pstmtCount != null) pstmtCount.close();
                                if (conCount != null) conCount.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                        out.print(totalRecords);
                    %>
                </span>
            </div>
        </div>

       
        <div class="filter-section">
            <div class="filter-group">
                <div class="blood-group-filter">
                    <button class="blood-group-btn active" data-group="all">All Groups</button>
                    <button class="blood-group-btn" data-group="A+">A+</button>
                    <button class="blood-group-btn" data-group="A-">A-</button>
                    <button class="blood-group-btn" data-group="B+">B+</button>
                    <button class="blood-group-btn" data-group="B-">B-</button>
                    <button class="blood-group-btn" data-group="AB+">AB+</button>
                    <button class="blood-group-btn" data-group="AB-">AB-</button>
                    <button class="blood-group-btn" data-group="O+">O+</button>
                    <button class="blood-group-btn" data-group="O-">O-</button>
                </div>
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchInput" placeholder="Search by donor name...">
                </div>
            </div>
        </div>

        
        <div class="blood-stats">
            <h3 style="margin-bottom: 1rem; color: var(--secondary-color);">
                <i class="fas fa-chart-pie"></i> Blood Group Distribution
            </h3>
            <div class="stats-grid">
                <%
                    
                    Connection conStats = null;
                    PreparedStatement pstmtStats = null;
                    ResultSet rsStats = null;
                    
                    Map<String, Integer> bloodGroupQuantities = new HashMap<>();
                    int totalBlood = 0;
                    
                    
                    String[] bloodGroups = {"A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"};
                    for (String group : bloodGroups) {
                        bloodGroupQuantities.put(group, 0);
                    }
                    
                    try {
                        conStats = Dbcon.create();
                        
                        
                        String totalSql = "SELECT SUM(quantity) as total FROM blooddetails WHERE bid='"+bid+"' AND email='"+email+"'";
                        pstmtStats = conStats.prepareStatement(totalSql);
                        rsStats = pstmtStats.executeQuery();
                        if (rsStats.next()) {
                            totalBlood = rsStats.getInt("total");
                        }
                        rsStats.close();
                        pstmtStats.close();
                        
                        
                        String groupSql = "SELECT blood_group, SUM(quantity) as group_total FROM blooddetails WHERE bid='"+bid+"' AND email='"+email+"' GROUP BY blood_group";
                        pstmtStats = conStats.prepareStatement(groupSql);
                        rsStats = pstmtStats.executeQuery();
                        
                        while (rsStats.next()) {
                            String bloodGroup = rsStats.getString("blood_group");
                            int groupTotal = rsStats.getInt("group_total");
                            bloodGroupQuantities.put(bloodGroup, groupTotal);
                        }
                        
                    } catch (Exception e) {
                       
                    } finally {
                        try {
                            if (rsStats != null) rsStats.close();
                            if (pstmtStats != null) pstmtStats.close();
                            if (conStats != null) conStats.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    
                    
                    for (String group : bloodGroups) {
                        int quantity = bloodGroupQuantities.get(group);
                        double percentage = totalBlood > 0 ? (quantity * 100.0 / totalBlood) : 0;
                %>
                <div class="stat-card">
                    <div class="blood-group"><%= group %></div>
                    <div class="blood-percentage"><%= String.format("%.1f", percentage) %>%</div>
                    <div class="blood-quantity"><%= quantity %> ml</div>
                </div>
                <% } %>
            </div>
        </div>

        
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Donor Name</th>
                        <th>Blood Group</th>
                        <th>Quantity (ml)</th>
                        <th>Collection Date</th>
                        <th>Location</th>
                    </tr>
                </thead>
                <tbody id="tableBody">
                    <%
                        Connection con;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                        
                        try {
                            con = Dbcon.create();                     
                            
                            String sql = "SELECT * FROM blooddetails WHERE bid='"+bid+"' AND email='"+email+"'";
                            pstmt = con.prepareStatement(sql);
                            rs = pstmt.executeQuery();
                            
                            while (rs.next()) {
                    %>
                    <tr class="fade-in" data-blood-group="<%= rs.getString("blood_group") %>" data-donor-name="<%= rs.getString("donor_name").toLowerCase() %>">
                        <td><strong>#<%= rs.getInt("id") %></strong></td>
                        <td>
                            <i class="fas fa-user" style="color: var(--primary-red); margin-right: 8px;"></i>
                            <%= rs.getString("donor_name") %>
                        </td>
                        <td><span class="blood-group-badge"><%= rs.getString("blood_group") %></span></td>
                        <td class="quantity"><%= rs.getInt("quantity") %> ml</td>
                        <td>
                            <i class="fas fa-calendar" style="color: var(--primary-red); margin-right: 8px;"></i>
                            <%= rs.getDate("donation_date") %>
                        </td>
                        <td>
                            <i class="fas fa-map-marker-alt" style="color: var(--primary-red); margin-right: 8px;"></i>
                            <%= rs.getString("location") %>
                        </td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                    %>
                    <tr>
                        <td colspan="6" style="text-align: center; padding: 30px; color: var(--primary-red);">
                            <i class="fas fa-exclamation-triangle" style="font-size: 2rem; margin-bottom: 10px;"></i>
                            <br>
                            Error: <%= e.getMessage() %>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

       
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('searchInput');
            const bloodGroupBtns = document.querySelectorAll('.blood-group-btn');
            const tableRows = document.querySelectorAll('#tableBody tr');
            
            let currentBloodGroup = 'all';
            let currentSearchTerm = '';
            
           
            bloodGroupBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    
                    bloodGroupBtns.forEach(b => b.classList.remove('active'));
                    
                    this.classList.add('active');
                    
                    currentBloodGroup = this.getAttribute('data-group');
                    filterTable();
                });
            });
            
           
            searchInput.addEventListener('input', function() {
                currentSearchTerm = this.value.toLowerCase();
                filterTable();
            });
            
            function filterTable() {
                tableRows.forEach(row => {
                    const bloodGroup = row.getAttribute('data-blood-group');
                    const donorName = row.getAttribute('data-donor-name');
                    
                    const bloodGroupMatch = currentBloodGroup === 'all' || bloodGroup === currentBloodGroup;
                    const searchMatch = donorName.includes(currentSearchTerm);
                    
                    if (bloodGroupMatch && searchMatch) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            }
        });
    </script>
</body>
</html>