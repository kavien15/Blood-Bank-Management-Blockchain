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
<title>Patient Management</title>
<style type="text/css">
:root {
    --primary-red: #c8102e;
    --dark-red: #9c0d24;
    --light-red: #f8d7da;
    --light-gray: #f8f9fa;
    --dark-gray: #343a40;
    --white: #ffffff;
    --success: #28a745;
    --danger: #dc3545;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
    background-color: var(--light-gray);
    color: var(--dark-gray);
    line-height: 1.6;
    padding: 20px;
}

.container {
    max-width: 1400px;
    margin: 0 auto;
}

.header {
    background: linear-gradient(135deg, var(--primary-red) 0%, var(--dark-red) 100%);
    color: var(--white);
    padding: 20px;
    border-radius: 10px;
    margin-bottom: 30px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.header-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.logo {
    display: flex;
    align-items: center;
    gap: 15px;
}

.logo i {
    font-size: 28px;
}

.logo h1 {
    font-size: 24px;
    font-weight: 600;
}

.user-info {
    display: flex;
    align-items: center;
    gap: 10px;
    background: rgba(255,255,255,0.2);
    padding: 8px 15px;
    border-radius: 20px;
}

.btn-back {
    background: var(--dark-gray);
    color: var(--white);
    border: none;
    padding: 10px 20px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 500;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    transition: background 0.3s;
    margin-bottom: 20px;
}

.btn-back:hover {
    background: #495057;
}

.search-section {
    background: var(--white);
    border-radius: 10px;
    padding: 20px;
    margin-bottom: 25px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.05);
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    align-items: center;
}

.search-box {
    display: flex;
    align-items: center;
    background: var(--white);
    border: 1px solid #ddd;
    border-radius: 6px;
    padding: 0 15px;
    flex-grow: 1;
    max-width: 400px;
}

.search-box input {
    border: none;
    padding: 10px 0;
    width: 100%;
    outline: none;
    font-size: 14px;
}

.search-box i {
    color: #777;
}

.filter-group {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.filter-group label {
    font-size: 14px;
    font-weight: 500;
    color: #555;
}

.filter-group select {
    padding: 10px 15px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 14px;
    min-width: 180px;
}

.btn-apply {
    background: var(--primary-red);
    color: var(--white);
    border: none;
    padding: 10px 20px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 500;
    transition: background 0.3s;
    display: flex;
    align-items: center;
    gap: 8px;
}

.btn-apply:hover {
    background: var(--dark-red);
}

.btn-clear {
    background: var(--dark-gray);
    color: var(--white);
    border: none;
    padding: 10px 20px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 500;
    transition: background 0.3s;
    display: flex;
    align-items: center;
    gap: 8px;
}

.btn-clear:hover {
    background: #495057;
}

.table-container {
    background: var(--white);
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0,0,0,0.05);
    margin-bottom: 30px;
    overflow-x: auto;
}

table {
    width: 100%;
    border-collapse: collapse;
    min-width: 1200px;
}

thead {
    background: var(--primary-red);
}

th {
    padding: 16px 20px;
    text-align: left;
    font-weight: 600;
    color: var(--white);
    border-bottom: 1px solid var(--dark-red);
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

td {
    padding: 16px 20px;
    border-bottom: 1px solid #eee;
    font-size: 14px;
}

tbody tr:hover {
    background: #f8f9fa;
}

tbody tr:nth-child(even) {
    background: #f8f9fa;
}

tbody tr:nth-child(even):hover {
    background: #e9ecef;
}

.status-accepted {
    background: #d4edda;
    color: #155724;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 500;
    display: inline-block;
}


.action-buttons {
    display: flex;
    flex-direction: column;
    gap: 8px;
    align-items: stretch;
    min-width: 120px;
}


.btn {
    padding: 8px 12px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 500;
    text-decoration: none;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
    font-size: 12px;
    transition: all 0.3s ease;
    text-align: center;
    width: 100%;
}

.btn-allocate {
    background: var(--success);
    color: var(--white);
}

.btn-allocate:hover {
    background: #218838;
    transform: translateY(-1px);
    box-shadow: 0 2px 4px rgba(40, 167, 69, 0.3);
}

.btn-reject {
    background: var(--danger);
    color: var(--white);
}

.btn-reject:hover {
    background: #c82333;
    transform: translateY(-1px);
    box-shadow: 0 2px 4px rgba(220, 53, 69, 0.3);
}

.empty-state {
    text-align: center;
    padding: 40px 20px;
    color: #666;
}

.empty-state i {
    font-size: 48px;
    margin-bottom: 15px;
    color: #ddd;
}

.no-results {
    text-align: center;
    padding: 30px;
    color: #666;
    background: var(--light-gray);
}


.results-counter {
    background: var(--light-red);
    padding: 10px 15px;
    border-radius: 8px;
    margin-bottom: 15px;
    font-weight: 500;
    color: var(--dark-red);
    display: flex;
    align-items: center;
    gap: 8px;
}

@media (max-width: 768px) {
    .search-section {
        flex-direction: column;
        align-items: stretch;
    }
    
    .search-box {
        max-width: 100%;
    }
    
    .filter-group select {
        min-width: 100%;
    }
    
    .header-content {
        flex-direction: column;
        gap: 15px;
        text-align: center;
    }
    
    .action-buttons {
        flex-direction: row;
        gap: 6px;
    }
    
    .btn {
        font-size: 11px;
        padding: 6px 10px;
    }
}

@media (max-width: 480px) {
    .action-buttons {
        flex-direction: column;
        gap: 4px;
    }
    
    .btn {
        font-size: 10px;
        padding: 5px 8px;
    }
}
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="container">
      
        <div class="header">
            <div class="header-content">
                <div class="logo">
                    <i class="fas fa-tint"></i>
                    <h1>Allocate Donors</h1>
                </div>
                <div class="user-info">
                    <i class="fas fa-user-md"></i>
                    <span>Hospital Portal</span>
                </div>
            </div>
        </div>

        
        <a href="doctorhome.jsp" class="btn-back">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>

        
        <div class="search-section">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="global-search" placeholder="Search patients, hospitals, locations...">
            </div>
            <div class="filter-group">
                <label for="blood-group-filter">Blood Group</label>
                <select id="blood-group-filter">
                    <option value="all">All Blood Groups</option>
                    <option value="A+">A+</option>
                    <option value="A-">A-</option>
                    <option value="B+">B+</option>
                    <option value="B-">B-</option>
                    <option value="AB+">AB+</option>
                    <option value="AB-">AB-</option>
                    <option value="O+">O+</option>
                    <option value="O-">O-</option>
                </select>
            </div>
            <div class="filter-group">
                <label for="component-filter">Blood Component</label>
                <select id="component-filter">
                    <option value="all">All Components</option>
                    <option value="Blood">Blood</option>
                    <option value="Plasma">Plasma</option>
                </select>
            </div>
            <button class="btn-apply" onclick="applyFilters()">
                <i class="fas fa-filter"></i> Apply Filters
            </button>
            <button class="btn-clear" onclick="clearFilters()">
                <i class="fas fa-times"></i> Clear
            </button>
        </div>

        
        <div class="results-counter" id="resultsCounter">
            <i class="fas fa-list"></i>
            Showing <span id="visibleCount">0</span> of <span id="totalCount">0</span> patients
        </div>

        
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Patient Name</th>
                        <th>Patient Email</th>
                        <th>Mobile</th>
                        <th>Gender</th>
                        <th>Age</th>
                        <th>Hospital Name</th>
                        <th>Donor Email</th>
                        <th>Donor Location</th>
                        <th>Donor Medical Issues</th>
                        <th>Blood / Plasma</th>
                        <th>Blood Group</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="patients-tbody">
                <%
                    String m = session.getAttribute("doctoremail").toString();
                    int totalCount = 0;

                    Connection con = Dbcon.create();
                    PreparedStatement ps = con.prepareStatement(
                        "SELECT * FROM blood.patient WHERE status='Accepted' AND email=?"
                    );
                    ps.setString(1, m);

                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {
                        totalCount++;
                        String donorEmail = rs.getString(12);

                        PreparedStatement ps1 = con.prepareStatement(
                            "SELECT * FROM blood.donorlist WHERE donor_email=?"
                        );
                        ps1.setString(1, donorEmail);

                        ResultSet rs1 = ps1.executeQuery();

                        String donorIssues = "";
                        if (rs1.next()) {
                            donorIssues = rs1.getString(6);
                        }
                %>
                    <tr data-patient-name="<%= rs.getString(2).toLowerCase() %>"
                        data-hospital="<%= rs.getString(8).toLowerCase() %>"
                        data-location="<%= rs.getString(13).toLowerCase() %>"
                        data-blood-group="<%= rs.getString(10) %>"
                        data-component="<%= rs.getString(9) %>">
                        <td><%= rs.getString(2) %></td>
                        <td><%= rs.getString(3) %></td>
                        <td><%= rs.getString(4) %></td>
                        <td><%= rs.getString(6) %></td>
                        <td><%= rs.getString(7) %></td>
                        <td><%= rs.getString(8) %></td>
                        <td><%= rs.getString(12) %></td>
                        <td><%= rs.getString(13) %></td>
                        <td><%= donorIssues %></td>
                        <td><%= rs.getString(9) %></td>
                        <td><%= rs.getString(10) %></td>
                        <td><span class="status-accepted"><%= rs.getString(11) %></span></td>
                        <td>
                            <div class="action-buttons">
                                <a href="hospitalallocatedonor.jsp?
                                   bp=<%= rs.getString(9) %>
                                   &bg=<%= rs.getString(10) %>
                                   &dmail=<%= rs.getString(12) %>
                                   &pname=<%= rs.getString(2) %>
                                   &hname=<%= rs.getString(8) %>
                                   &gender=<%= rs.getString(6) %>"
                                   class="btn btn-allocate">
                                    <i class="fas fa-hand-holding-medical"></i> ALLOCATE
                                </a>
                                
                                <a href="rejectdonor.jsp?
                                   bp=<%= rs.getString(9) %>
                                   &bg=<%= rs.getString(10) %>
                                   &dmail=<%= rs.getString(12) %>
                                   &pname=<%= rs.getString(2) %>
                                   &hname=<%= rs.getString(8) %>
                                   &gender=<%= rs.getString(6) %>"
                                   class="btn btn-reject">
                                    <i class="fas fa-times-circle"></i> REJECT
                                </a>
                            </div>
                        </td>
                    </tr>
                <% } 
                   if (!rs.isBeforeFirst()) { // No records found
                %>
                    <tr class="no-results">
                        <td colspan="13">
                            <i class="fas fa-inbox"></i>
                            <h3>No Accepted Patients Found</h3>
                            <p>There are no patients with accepted status at the moment.</p>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        
        document.addEventListener('DOMContentLoaded', function() {
            const totalCount = <%= totalCount %>;
            document.getElementById('totalCount').textContent = totalCount;
            document.getElementById('visibleCount').textContent = totalCount;
            applyFilters();
        });

        
        function applyFilters() {
            const searchTerm = document.getElementById('global-search').value.toLowerCase();
            const bloodGroupFilter = document.getElementById('blood-group-filter').value;
            const componentFilter = document.getElementById('component-filter').value;
            const rows = document.querySelectorAll('#patients-tbody tr:not(.no-results)');
            
            let visibleCount = 0;
            
            rows.forEach(row => {
                const patientName = row.getAttribute('data-patient-name');
                const hospital = row.getAttribute('data-hospital');
                const location = row.getAttribute('data-location');
                const bloodGroup = row.getAttribute('data-blood-group');
                const component = row.getAttribute('data-component');
                
                
                const searchMatch = searchTerm === '' || 
                    patientName.includes(searchTerm) || 
                    hospital.includes(searchTerm) || 
                    location.includes(searchTerm);
                
                const bloodGroupMatch = bloodGroupFilter === 'all' || bloodGroup === bloodGroupFilter;
                const componentMatch = componentFilter === 'all' || component === componentFilter;
                
                if (searchMatch && bloodGroupMatch && componentMatch) {
                    row.style.display = '';
                    visibleCount++;
                } else {
                    row.style.display = 'none';
                }
            });
            
            
            document.getElementById('visibleCount').textContent = visibleCount;
            
           
            const tbody = document.getElementById('patients-tbody');
            let noResultsRow = tbody.querySelector('.no-results');
            const existingNoResults = tbody.querySelector('.no-results-row');
            
            if (existingNoResults) {
                existingNoResults.remove();
            }
            
            if (visibleCount === 0 && <%= totalCount %> > 0) {
                if (!noResultsRow) {
                    noResultsRow = document.createElement('tr');
                    noResultsRow.className = 'no-results no-results-row';
                    noResultsRow.innerHTML = `
                        <td colspan="13" style="text-align: center; padding: 30px; color: #666; background: var(--light-gray);">
                            <i class="fas fa-search" style="font-size: 48px; margin-bottom: 15px; color: #ddd;"></i>
                            <h3>No matching patients found</h3>
                            <p>Try adjusting your search criteria</p>
                        </td>
                    `;
                    tbody.appendChild(noResultsRow);
                } else {
                    noResultsRow.style.display = '';
                }
            } else if (noResultsRow) {
                noResultsRow.style.display = 'none';
            }
        }

        function clearFilters() {
            document.getElementById('global-search').value = '';
            document.getElementById('blood-group-filter').value = 'all';
            document.getElementById('component-filter').value = 'all';
            applyFilters();
        }

       
        document.getElementById('global-search').addEventListener('input', applyFilters);
        document.getElementById('blood-group-filter').addEventListener('change', applyFilters);
        document.getElementById('component-filter').addEventListener('change', applyFilters);
    </script>
</body>
</html>