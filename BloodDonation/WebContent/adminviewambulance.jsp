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
</style>
</head>
<body>


<a href="Aadminhomepage.jsp" class="back-button">
    <i class="fas fa-arrow-left"></i> Back to Dashboard
</a>

<div class="header">
    <h1><i class="fas fa-hospital"></i> Ambulance Network</h1>
   
    <div class="hospital-count">
        <i class="fas fa-hospital-alt"></i> Registered Ambulances
    </div>
</div>


<div class="search-section">
    <div class="search-container">
        <div class="search-box">
            <i class="fas fa-search"></i>
            <input type="text" id="searchInput" placeholder="Search by name, location, email, contact...">
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
PreparedStatement ps = con.prepareStatement("SELECT * FROM `blood`.`ambulance`");
ResultSet rs = ps.executeQuery();

boolean hasData = false;
int totalCount = 0;

while(rs.next()) {
    hasData = true;
    totalCount++;
%>

<div class="hospital-card"
     data-name="<%= rs.getString(2).toLowerCase() %>"
     data-location="<%= rs.getString(7).toLowerCase() %>"
     data-contact="<%= rs.getString(5) %>"
     data-email="<%= rs.getString(4).toLowerCase() %>">

    <div class="card-header">
        <div class="hospital-title">
            <div class="hospital-icon">
                <i class="fas fa-hospital-alt"></i>
            </div>
            <div class="hospital-name"><%=rs.getString(3) %></div>
        </div>
    </div>

    <div class="card-body">
        <div class="info-item">
            <div class="info-icon"><i class="fas fa-person"></i></div>
            <div class="info-content">
                <div class="info-label">Name</div>
                <div class="info-value"><%=rs.getString(2) %></div>
            </div>
        </div>

        <div class="info-item">
            <div class="info-icon"><i class="fas fa-envelope"></i></div>
            <div class="info-content">
                <div class="info-label">Email</div>
                <div class="info-value"><%=rs.getString(5) %></div>
            </div>
        </div>

        <div class="info-item">
            <div class="info-icon"><i class="fas fa-phone-alt"></i></div>
            <div class="info-content">
                <div class="info-label">Contact</div>
                <div class="info-value"><%=rs.getString(4) %></div>
            </div>
        </div>

        <div class="info-item">
            <div class="info-icon"><i class="fas fa-map-marker-alt"></i></div>
            <div class="info-content">
                <div class="info-label">Location</div>
                <div class="info-value"><%=rs.getString(7) %></div>
            </div>
        </div>
    </div>
</div>

<%
}  
%>

</div>

<script>
document.addEventListener('DOMContentLoaded', function() {

    const totalCount = <%= totalCount %>;
    document.getElementById('totalCount').textContent = totalCount;
    document.getElementById('visibleCount').textContent = totalCount;

    const searchInput = document.getElementById('searchInput');
    const hospitalCards = document.querySelectorAll('.hospital-card');

    function performSearch() {
        const term = searchInput.value.toLowerCase();
        let visible = 0;

        hospitalCards.forEach(card => {
            const name = card.dataset.name;
            const location = card.dataset.location;
            const contact = card.dataset.contact;
            const email = card.dataset.email;

            const match =
                name.includes(term) ||
                location.includes(term) ||
                contact.includes(term) ||
                email.includes(term);

            if (match) {
                card.style.display = "block";
                visible++;
            } else {
                card.style.display = "none";
            }
        });

        document.getElementById('visibleCount').textContent = visible;
    }

    searchInput.addEventListener("input", performSearch);
});
</script>

</body>
</html>
