<%@page import="java.sql.*"%>
<%@page import="dbcon.Dbcon"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ambulance Request Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary-blue: #1a73e8;
            --secondary-blue: #4285f4;
            --light-blue: #e8f0fe;
            --dark-blue: #0d47a1;
            --accent-red: #ea4335;
            --accent-green: #34a853;
            --accent-amber: #fbbc05;
            --text-dark: #202124;
            --text-light: #5f6368;
            --border-color: #dadce0;
            --white: #ffffff;
            --card-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            --hover-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
            --gradient-primary: linear-gradient(135deg, var(--primary-blue), var(--dark-blue));
            --gradient-green: linear-gradient(135deg, var(--accent-green), #2e7d32);
            --gradient-amber: linear-gradient(135deg, var(--accent-amber), #ff8f00);
            --gradient-red: linear-gradient(135deg, var(--accent-red), #c62828);
        }

        * { 
            margin: 0; 
            padding: 0; 
            box-sizing: border-box; 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body { 
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%); 
            min-height: 100vh;
            padding: 20px; 
        }

        .container { 
            max-width: 1500px; 
            margin: auto; 
        }

        header {
            background: var(--gradient-primary);
            color: white;
            padding: 25px;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            margin-bottom: 25px;
            position: relative;
            overflow: hidden;
        }

        header::before {
            content: "";
            position: absolute;
            top: -50%;
            right: -50%;
            width: 100%;
            height: 200%;
            background: rgba(255, 255, 255, 0.1);
            transform: rotate(30deg);
        }

        .logo { 
            display: flex; 
            align-items: center; 
            gap: 15px;
            position: relative;
            z-index: 1;
        }

        .logo-icon {
            width: 50px;
            height: 50px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .logo i { 
            font-size: 24px; 
        }

        .logo h1 {
            font-size: 28px;
            font-weight: 700;
        }

        .header-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
            position: relative;
            z-index: 1;
        }

        .dashboard { 
            background: white; 
            border-radius: 16px; 
            box-shadow: var(--card-shadow);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .dashboard-header {
            display: flex; 
            justify-content: space-between;
            align-items: center;
            padding: 20px 25px; 
            border-bottom: 1px solid var(--border-color);
            background: var(--white);
        }

        .dashboard-header h2 {
            font-size: 22px;
            font-weight: 600;
            color: var(--dark-blue);
        }

        .search-container {
            position: relative;
        }

        .search-input {
            padding: 12px 20px 12px 45px;
            border: 1px solid var(--border-color);
            border-radius: 50px;
            width: 280px;
            font-size: 14px;
            transition: all 0.3s;
            background: var(--light-blue);
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 2px rgba(26, 115, 232, 0.2);
            width: 320px;
        }

        .search-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-light);
        }

        table { 
            width: 100%; 
            border-collapse: collapse; 
        }

        thead {
            background: var(--light-blue);
        }

        th, td {
            padding: 16px 20px;
            border-bottom: 1px solid var(--border-color);
            text-align: left;
        }

        th {
            color: var(--primary-blue);
            font-weight: 600;
            font-size: 14px;
        }

        tr:hover {
            background-color: #f9fafb;
        }

        .status {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            display: inline-block;
        }

        .status-allocate { 
            background: #fff8e1; 
            color: #ff8f00; 
        }
        
        .status-accepted { 
            background: #e8f5e9; 
            color: var(--accent-green); 
        }

        .btn {
            padding: 10px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            color: white;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .btn-accept { 
            background: var(--accent-green); 
        }
        
        .btn-back { 
            background: var(--primary-blue); 
        }

    
        .stats {
            display: flex;
            gap: 20px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            flex: 1;
            display: flex;
            align-items: center;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 24px;
            color: white;
        }

        .stat-total .stat-icon {
            background: var(--gradient-primary);
        }

        .stat-pending .stat-icon {
            background: var(--gradient-amber);
        }

        .stat-accepted .stat-icon {
            background: var(--gradient-green);
        }

        .stat-info h2 {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-info p {
            color: var(--text-light);
            font-size: 15px;
        }

     
        .empty-state {
            padding: 50px 20px;
            text-align: center;
            color: var(--text-light);
        }

        .empty-state i {
            font-size: 64px;
            margin-bottom: 20px;
            color: var(--border-color);
        }

     
        @media (max-width: 992px) {
            .stats {
                flex-direction: column;
            }
            
            .dashboard-header {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }
            
            .search-input {
                width: 100%;
            }
            
            .search-input:focus {
                width: 100%;
            }
        }

        @media (max-width: 768px) {
            .table-container {
                overflow-x: auto;
            }
            
            table {
                min-width: 800px;
            }
            
            .logo h1 {
                font-size: 22px;
            }
        }
    </style>
</head>

<body>
<div class="container">

<header>
    <div class="logo">
        <div class="logo-icon">
            <i class="fas fa-ambulance"></i>
        </div>
        <h1>Ambulance Request Management</h1>
    </div>
    <div class="header-actions">
        <div></div> <!-- Empty div for spacing -->
        <a href="ambulancedashboard.jsp" class="btn btn-back">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>
</header>

<%
    HttpSession s = request.getSession();
    String location = s.getAttribute("location").toString();
    Connection con = Dbcon.create();

    PreparedStatement ps = con.prepareStatement("SELECT * FROM patient WHERE location=? AND status=? AND ambstatus=? ORDER BY id DESC");
    ps.setString(1, location);
    ps.setString(2, "Allocate");
    ps.setString(3, "");
    ResultSet rs = ps.executeQuery();

    int totalCount = 0;
    int pendingCount = 0;
    int acceptedCount = 0;

    java.util.ArrayList<String[]> rows = new java.util.ArrayList<>();

    while(rs.next()){
        totalCount++;

        String status = rs.getString("status");

        if(status.equalsIgnoreCase("Allocate")) pendingCount++;
        if(status.equalsIgnoreCase("Accepted")) acceptedCount++;

        rows.add(new String[]{
            rs.getString(12),  
            rs.getString(13),  
            rs.getString(8),  
            rs.getString(4),   
            rs.getString(5),   
            status,
            rs.getString("id")
        });
    }
    con.close();
%>


<div class="stats">
    <div class="stat-card stat-total">
        <div class="stat-icon">
            <i class="fas fa-list-alt"></i>
        </div>
        <div class="stat-info">
            <h2><%= totalCount %></h2>
            <p>Total Requests</p>
        </div>
    </div>

    <div class="stat-card stat-pending">
        <div class="stat-icon">
            <i class="fas fa-clock"></i>
        </div>
        <div class="stat-info">
            <h2><%= pendingCount %></h2>
            <p>Pending Requests</p>
        </div>
    </div>

    <div class="stat-card stat-accepted">
        <div class="stat-icon">
            <i class="fas fa-check-circle"></i>
        </div>
        <div class="stat-info">
            <h2><%= acceptedCount %></h2>
            <p>Accepted Requests</p>
        </div>
    </div>
</div>


<div class="dashboard">
    <div class="dashboard-header">
        <h2>Ambulance Requests</h2>

        <div class="search-container">
            <i class="fas fa-search search-icon"></i>
            <input type="text" id="searchInput" class="search-input" placeholder="Search requests...">
        </div>
    </div>

    <div class="table-container">
        <table id="requestsTable">
            <thead>
            <tr>
                <th>Donor Email</th>
                <th>Donor Contact</th>
                <th>Hospital Name</th>
                <th>Hospital Contact</th>
                <th>Hospital Address</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            </thead>

            <tbody>
            <%
                if (rows.isEmpty()) {
            %>
            <tr>
                <td colspan="7">
                    <div class="empty-state">
                        <i class="fas fa-inbox"></i>
                        <h3>No Requests Found</h3>
                        <p>There are currently no ambulance requests matching your criteria.</p>
                    </div>
                </td>
            </tr>
            <%
                } else {
                    for(String[] r : rows){
            %>
            <tr>
                <td><%= r[0] %></td>
                <td><%= r[1] %></td>
                <td><%= r[2] %></td>
                <td><%= r[3] %></td>
                <td><%= r[4] %></td>

                <td>
                    <span class="status status-<%= r[5].toLowerCase() %>">
                        <%= r[5] %>
                    </span>
                </td>

                <td>
                    <% if(r[5].equalsIgnoreCase("Allocate")){ %>
                        <a href="ambulancestatus.jsp?id=<%= r[6] %>"
                           class="btn btn-accept">
                            <i class="fas fa-check"></i> Accept
                        </a>
                    <% } else { %>
                        <span style="color:green; font-weight:bold;">
                            <i class="fas fa-check-circle"></i> Done
                        </span>
                    <% } %>
                </td>
            </tr>
            <% 
                    }
                } 
            %>
            </tbody>
        </table>
    </div>
</div>

</div>

<script>
  
    document.getElementById('searchInput').addEventListener('input', function() {
        const filter = this.value.toLowerCase();
        const rows = document.querySelectorAll('#requestsTable tbody tr');
        
        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            if (text.includes(filter)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });


    document.addEventListener('DOMContentLoaded', function() {
        const buttons = document.querySelectorAll('.btn');
        buttons.forEach((button, index) => {
            button.style.opacity = '0';
            button.style.transform = 'translateY(10px)';
            
            setTimeout(() => {
                button.style.transition = 'opacity 0.3s, transform 0.3s';
                button.style.opacity = '1';
                button.style.transform = 'translateY(0)';
            }, 100 * index);
        });
    });
</script>

</body>
</html>