<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="dbcon.Dbcon"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.util.Calendar"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Blood Donation Confirmation</title>
<style>
:root {
    --primary-red: #c8102e;
    --dark-red: #9c0d24;
    --light-red: #f8d7da;
    --light-gray: #f8f9fa;
    --dark-gray: #343a40;
    --white: #ffffff;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
    background: linear-gradient(135deg, var(--light-gray) 0%, #e9ecef 100%);
    color: var(--dark-gray);
    line-height: 1.6;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    flex: 1;
}

.header {
    background: linear-gradient(135deg, var(--primary-red) 0%, var(--dark-red) 100%);
    color: var(--white);
    padding: 25px 0;
    border-radius: 15px;
    margin-bottom: 30px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
    text-align: center;
    position: relative;
    overflow: hidden;
}

.header::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
    background-size: 20px 20px;
    animation: float 20s linear infinite;
}

@keyframes float {
    0% { transform: translate(0, 0) rotate(0deg); }
    100% { transform: translate(-20px, -20px) rotate(360deg); }
}

.header-content {
    position: relative;
    z-index: 2;
}

.logo {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 15px;
    margin-bottom: 10px;
}

.logo i {
    font-size: 36px;
    animation: pulse 2s infinite;
}

@keyframes pulse {
    0%, 100% { transform: scale(1); }
    50% { transform: scale(1.1); }
}

.logo h1 {
    font-size: 28px;
    font-weight: 700;
}

.header p {
    font-size: 16px;
    opacity: 0.9;
}

.btn-back {
    background: var(--dark-gray);
    color: var(--white);
    border: none;
    padding: 12px 25px;
    border-radius: 8px;
    cursor: pointer;
    font-weight: 600;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 10px;
    transition: all 0.3s ease;
    margin-bottom: 30px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

.btn-back:hover {
    background: #495057;
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(0,0,0,0.15);
}

.donation-card {
    background: var(--white);
    border-radius: 20px;
    padding: 40px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
    margin-bottom: 30px;
    border: 1px solid rgba(0,0,0,0.05);
    position: relative;
    overflow: hidden;
}

.donation-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: linear-gradient(90deg, var(--primary-red), var(--dark-red));
}

.card-header {
    text-align: center;
    margin-bottom: 30px;
}

.card-header h2 {
    color: var(--primary-red);
    font-size: 28px;
    margin-bottom: 10px;
    font-weight: 700;
}

.card-header p {
    color: #666;
    font-size: 16px;
}

.patient-info {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 25px;
    margin-bottom: 30px;
}

.info-group {
    background: var(--light-gray);
    padding: 20px;
    border-radius: 12px;
    border-left: 4px solid var(--primary-red);
}

.info-group h3 {
    color: var(--dark-red);
    margin-bottom: 15px;
    font-size: 18px;
    font-weight: 600;
}

.info-item {
    display: flex;
    justify-content: space-between;
    padding: 8px 0;
    border-bottom: 1px solid rgba(0,0,0,0.05);
}

.info-item:last-child {
    border-bottom: none;
}

.info-label {
    font-weight: 600;
    color: #555;
}

.info-value {
    color: var(--dark-gray);
    font-weight: 500;
}

.blood-image {
    text-align: center;
    margin: 30px 0;
}

.blood-image img {
    max-width: 100%;
    height: auto;
    border-radius: 15px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.1);
    transition: transform 0.3s ease;
}

.blood-image img:hover {
    transform: scale(1.02);
}

.donation-section {
    text-align: center;
    background: linear-gradient(135deg, #fff5f5 0%, var(--light-red) 100%);
    padding: 30px;
    border-radius: 15px;
    margin: 30px 0;
    border: 2px dashed var(--primary-red);
}

.donation-section h3 {
    color: var(--dark-red);
    margin-bottom: 20px;
    font-size: 24px;
    font-weight: 700;
}

.btn-donate {
    background: linear-gradient(135deg, var(--primary-red) 0%, var(--dark-red) 100%);
    color: var(--white);
    border: none;
    padding: 15px 40px;
    border-radius: 50px;
    font-size: 18px;
    font-weight: 700;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 6px 20px rgba(200, 16, 46, 0.3);
    text-transform: uppercase;
    letter-spacing: 1px;
    position: relative;
    overflow: hidden;
}

.btn-donate:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 30px rgba(200, 16, 46, 0.4);
}

.btn-donate:active {
    transform: translateY(-1px);
}

.btn-donate::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
    transition: left 0.5s;
}

.btn-donate:hover::before {
    left: 100%;
}

.date-info {
    background: var(--light-gray);
    padding: 25px;
    border-radius: 12px;
    margin-top: 20px;
    border: 1px solid rgba(0,0,0,0.1);
}

.date-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
    border-bottom: 1px solid rgba(0,0,0,0.05);
}

.date-item:last-child {
    border-bottom: none;
}

.date-label {
    font-weight: 600;
    color: #555;
}

.date-value {
    background: var(--primary-red);
    color: var(--white);
    padding: 6px 15px;
    border-radius: 20px;
    font-weight: 600;
    font-size: 14px;
}

.footer {
    text-align: center;
    padding: 20px;
    color: #666;
    font-size: 14px;
    margin-top: 30px;
    border-top: 1px solid rgba(0,0,0,0.1);
}


.blood-svg {
	width: 40vmax;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	opacity: 0;
	z-index: 1000;
	pointer-events: none;
}

.blood-splash-2 {
	width: 70vmax;
}

.blood-splash-3 {
	width: 60vmax;
}


@media (max-width: 768px) {
    .container {
        padding: 15px;
    }
    
    .donation-card {
        padding: 25px;
    }
    
    .patient-info {
        grid-template-columns: 1fr;
        gap: 15px;
    }
    
    .logo h1 {
        font-size: 24px;
    }
    
    .btn-donate {
        padding: 12px 30px;
        font-size: 16px;
    }
}

@media (max-width: 480px) {
    .header {
        padding: 20px 0;
    }
    
    .donation-card {
        padding: 20px;
    }
    
    .info-group {
        padding: 15px;
    }
    
    .date-item {
        flex-direction: column;
        align-items: flex-start;
        gap: 5px;
    }
    
    .date-value {
        align-self: flex-start;
    }
}
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    
    <div class="container">
        <a href="donorhome.jsp" class="btn-back">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>

   
    <div class="header">
        <div class="header-content">
            <div class="logo">
                <i class="fas fa-tint"></i>
                <h1>LifeStream Blood Bank Management System</h1>
            </div>
            <p>Life Saver Portal - Donation Confirmation</p>
        </div>
    </div>

    <div class="container">
        <form action="updatedonordetails.jsp" method="post">
            <% 
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd-MM-yyyy");  
            LocalDateTime now = LocalDateTime.now();  
            System.out.println(dtf.format(now));  

            String pname="" , hname="" , bg="" , bp="" , email="" , number="", ambulanceno="" , drivername="" , ambcontact="";
            String status="donated";

            Connection con;
            con=Dbcon.create();
            PreparedStatement ps=con.prepareStatement("SELECT * FROM `blood`.`patient` where status='allocate' ");
            ResultSet rs=ps.executeQuery();

            while(rs.next()) {
                pname=rs.getString(2);
                hname=rs.getString(8);
                bg=rs.getString(10);
                bp=rs.getString(9);
                email=rs.getString(12);
                
                ambulanceno=rs.getString(17);
                drivername=rs.getString(18);
                ambcontact=rs.getString(19);
                
                
            } 
            %>
            
            <% 
            String type="blood";
            if(type.equals(bp)) {
            %>
                <% 
                String dateBefore = dtf.format(now);    
                System.out.println(dateBefore+" is the date before adding days");  
                
                SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");  
                Calendar cal = Calendar.getInstance();  
                try{  
                   cal.setTime(sdf.parse(dateBefore));  
                }catch(ParseException e){  
                    e.printStackTrace();  
                 }  
                
                cal.add(Calendar.DAY_OF_MONTH, 90);  
                String dateAfter = sdf.format(cal.getTime());  
                System.out.println(dateAfter+" is the date after adding 3 days.");  
                %>

                <div class="donation-card">
                    <div class="card-header">
                        <h2><i class="fas fa-hand-holding-heart"></i> Blood Donation Request</h2>
                        <p>Your donation can save lives. Please confirm the details below.</p>
                    </div>

                    <div class="blood-image">
                        <img src="image/blood1.jpg" alt="Blood Donation" width="400" height="300">
                    </div>

                    <div class="patient-info">
                        <div class="info-group">
                            <h3><i class="fas fa-user-injured"></i> Patient Information</h3>
                            <div class="info-item">
                                <span class="info-label">Patient Name:</span>
                                <span class="info-value"><%=pname %></span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Hospital Name:</span>
                                <span class="info-value"><%=hname %></span>
                            </div>
                        </div>

                        <div class="info-group">
                            <h3><i class="fas fa-tint"></i> Blood Details</h3>
                            <div class="info-item">
                                <span class="info-label">Blood Group:</span>
                                <span class="info-value" style="color: var(--primary-red); font-weight: bold;"><%=bg %></span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Component:</span>
                                <span class="info-value"><%=bp %></span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Donor Email:</span>
                                <span class="info-value"><%=email %></span>
                            </div>
                        </div>
                        
                        
                         <div class="info-group">
                            <h3><i class="fas fa-ambulance"></i> Ambulance Details</h3>
                            <div class="info-item">
                                <span class="info-label">Ambulance NO:</span>
                                <span class="info-value" style="color: var(--primary-red); font-weight: bold;"><%=ambulanceno %></span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Driver Name:</span>
                                <span class="info-value"><%=drivername %></span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Contact:</span>
                                <span class="info-value"><%=ambcontact %></span>
                            </div>
                        </div>
                    </div>

                    <div class="donation-section">
                        <h3><i class="fas fa-heartbeat"></i> Ready to Save a Life?</h3>
                        <p style="margin-bottom: 20px; color: #666;">Click the button below to confirm your blood donation.</p>
                        
                        <% 
                        Connection con1;
                        con1=Dbcon.create();
                        PreparedStatement ps1=con1.prepareStatement("SELECT * FROM `blood`.`donorlist` where donor_email='"+email+"'  ");
                        ResultSet rs1=ps1.executeQuery();

                        while(rs1.next()) {
                            number=rs1.getString(4);
                        %>
                            <input type="hidden" value="<%=pname %>" name="pname">
                            <input type="hidden" value="<%=hname %>" name="hname">
                            <input type="hidden" value="<%=bg %>" name="bg">
                            <input type="hidden" value="<%=bp %>" name="bp">
                            <input type="hidden" value="<%=email %>" name="email">
                            <input type="hidden" value="<%=number %>" name="number">
                            <input type="hidden" value="<%=dateBefore %>" name="bdate">
                            <input type="hidden" value="<%=dateAfter %>" name="adate">
                            <input type="hidden" value="<%=status %>" name="status">
                        <%} %>

                        <button type="submit" class="btn-donate bloody-click">
                            <i class="fas fa-heart"></i> Confirm Blood Donation
                        </button>
                    </div>

                    <div class="date-info">
                        <h3 style="color: var(--dark-red); margin-bottom: 15px;"><i class="fas fa-calendar-alt"></i> Important Dates</h3>
                        <div class="date-item">
                            <span class="date-label">Donation Date:</span>
                            <span class="date-value"><%=dateBefore %></span>
                        </div>
                        <div class="date-item">
                            <span class="date-label">Next Eligible Date:</span>
                            <span class="date-value"><%=dateAfter %></span>
                        </div>
                    </div>
                </div>

            <%} else { %>
                
                <% 
                String dateBefore = dtf.format(now);    
                System.out.println(dateBefore+" is the date before adding days");  

                SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");  
                Calendar cal = Calendar.getInstance();  
                try{  
                cal.setTime(sdf.parse(dateBefore));  
                }catch(ParseException e){  
                e.printStackTrace();  
                }  

                cal.add(Calendar.DAY_OF_MONTH, 14);  
                String dateAfter = sdf.format(cal.getTime());  
                System.out.println(dateAfter+" is the date after adding 3 days.");  
                %>

                <div class="donation-card">
                    <div class="card-header">
                        <h2><i class="fas fa-hand-holding-medical"></i> Plasma Donation Request</h2>
                        <p>Your plasma donation is crucial for patient recovery.</p>
                    </div>

                    <div class="blood-image">
                        <img src="image/blood1.jpg" alt="Plasma Donation" width="400" height="300">
                    </div>

                    <div class="patient-info">
                        <div class="info-group">
                            <h3><i class="fas fa-user-injured"></i> Patient Information</h3>
                            <div class="info-item">
                                <span class="info-label">Patient Name:</span>
                                <span class="info-value"><%=pname %></span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Hospital Name:</span>
                                <span class="info-value"><%=hname %></span>
                            </div>
                        </div>

                        <div class="info-group">
                            <h3><i class="fas fa-vial"></i> Plasma Details</h3>
                            <div class="info-item">
                                <span class="info-label">Blood Group:</span>
                                <span class="info-value" style="color: var(--primary-red); font-weight: bold;"><%=bg %></span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Component:</span>
                                <span class="info-value"><%=bp %></span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Donor Email:</span>
                                <span class="info-value"><%=email %></span>
                            </div>
                        </div>
                    </div>

                    <div class="donation-section">
                        <h3><i class="fas fa-hand-holding-water"></i> Ready to Donate Plasma?</h3>
                        <p style="margin-bottom: 20px; color: #666;">Click the button below to confirm your plasma donation.</p>
                        
                        <% 
                        Connection con1;
                        con1=Dbcon.create();
                        PreparedStatement ps1=con1.prepareStatement("SELECT * FROM `blood`.`donorlist` where donor_email='"+email+"'  ");
                        ResultSet rs1=ps1.executeQuery();

                        while(rs1.next()) {
                            number=rs1.getString(4);
                        %>
                            <input type="hidden" value="<%=pname %>" name="pname">
                            <input type="hidden" value="<%=hname %>" name="hname">
                            <input type="hidden" value="<%=bg %>" name="bg">
                            <input type="hidden" value="<%=bp %>" name="bp">
                            <input type="hidden" value="<%=email %>" name="email">
                            <input type="hidden" value="<%=number %>" name="number">
                            <input type="hidden" value="<%=dateBefore %>" name="bdate">
                            <input type="hidden" value="<%=dateAfter %>" name="adate">
                            <input type="hidden" value="<%=status %>" name="status">
                        <%} %>
                        
                        <button type="submit" class="btn-donate bloody-click">
                            <i class="fas fa-hand-holding-medical"></i> Confirm Plasma Donation
                        </button>
                    </div>

                    <div class="date-info">
                        <h3 style="color: var(--dark-red); margin-bottom: 15px;"><i class="fas fa-calendar-alt"></i> Important Dates</h3>
                        <div class="date-item">
                            <span class="date-label">Donation Date:</span>
                            <span class="date-value"><%=dateBefore %></span>
                        </div>
                        <div class="date-item">
                            <span class="date-label">Next Eligible Date:</span>
                            <span class="date-value"><%=dateAfter %></span>
                        </div>
                    </div>
                </div>
                
            <%} %>
        </form>
    </div>

   
    <div class="footer">
        <p>Blood Bank Management System &copy; 2025 | Saving Lives Through Donation</p>
    </div>

    
    <svg class="blood-svg blood-splash-1" viewBox="0 0 764 713" xmlns="http://www.w3.org/2000/svg">
       
        <animate id="splash-1-fade" attributeName="opacity" attributeType="XML" dur="2.5s" begin="indefinite" from="1" to="0" />
        
    </svg>

    <svg class="blood-svg blood-splash-2" viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg">
        <animate id="splash-2-fade" attributeName="opacity" attributeType="XML" dur="2.5s" begin="indefinite" from="1" to="0" />
       
    </svg>

    <svg class="blood-svg blood-splash-3" viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg">
        <animate id="splash-3-fade" attributeName="opacity" attributeType="XML" dur="2.5s" begin="indefinite" from="1" to="0" />
        
    </svg>

    
    <script>
        
        document.querySelector(".bloody-click").addEventListener('click', getBlood);

       
        let splashesUsed = [];

       
        function getBlood() {
            if (splashesUsed.length == 3) {
                splashesUsed.shift();
                splashesUsed.shift();
            }

            let randomNumber = Math.floor(Math.random() * 3);

            while (splashesUsed.includes(randomNumber)) {
                randomNumber = Math.floor(Math.random() * 3);
            }

            let chosenNumber = randomNumber;

            if (chosenNumber === 0) {
                Blood1();
            } else if (chosenNumber === 1) {
                Blood2();
            } else if (chosenNumber === 2) {
                Blood3();
            }

            splashesUsed.push(chosenNumber);
            console.log(splashesUsed);
        }

        
        function Blood1() {
            document.getElementById("splash-1-fade").beginElement();
            document.getElementById("splash-1a-drip").beginElement();
            document.getElementById("splash-1b-drip").beginElement();
        }

        
        function Blood2() {
            document.getElementById("splash-2-fade").beginElement();
            document.getElementById("splash-2-drip").beginElement();
        }

       
        function Blood3() {
            document.getElementById("splash-3-fade").beginElement();
            document.getElementById("splash-3-drip").beginElement();
        }
    </script>
</body>
</html>