<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Arrange Blood Donation Camp</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
    :root {
        --primary-red: #c8102e;
        --dark-red: #9c0d24;
        --light-red: #f8d7da;
        --light-pink: #ffe6e6;
        --white: #ffffff;
        --dark-gray: #333;
        --light-gray: #f8f9fa;
    }

    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
        background: linear-gradient(135deg, #ffe6e6 0%, #ffcccc 50%, #ffb3b3 100%);
        font-size: 16px;
        min-height: 100vh;
        padding: 20px;
        position: relative;
        overflow-x: hidden;
    }

   
    .back-button {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        background: var(--primary-red);
        color: white;
        padding: 12px 20px;
        border-radius: 8px;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s ease;
        margin-bottom: 20px;
        box-shadow: 0 4px 12px rgba(200, 16, 46, 0.3);
    }

    .back-button:hover {
        background: var(--dark-red);
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(200, 16, 46, 0.4);
    }

    .back-button:active {
        transform: translateY(0);
    }

  
    .medical-background {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        pointer-events: none;
        z-index: -1;
        opacity: 0.1;
    }

    .medical-background i {
        position: absolute;
        font-size: 2rem;
        color: var(--primary-red);
    }

    .medical-background i:nth-child(1) { top: 10%; left: 5%; }
    .medical-background i:nth-child(2) { top: 20%; right: 10%; }
    .medical-background i:nth-child(3) { bottom: 30%; left: 15%; }
    .medical-background i:nth-child(4) { bottom: 15%; right: 5%; }
    .medical-background i:nth-child(5) { top: 50%; left: 8%; }
    .medical-background i:nth-child(6) { top: 60%; right: 15%; }

    .container {
        max-width: 1000px;
        margin: 20px auto;
        background-color: var(--white);
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0 15px 40px rgba(200, 16, 46, 0.2);
        border-left: 5px solid var(--primary-red);
        position: relative;
        overflow: hidden;
    }

    .container::before {
        content: "";
        position: absolute;
        top: 0;
        right: 0;
        width: 100px;
        height: 100px;
        background: var(--primary-red);
        border-radius: 50%;
        transform: translate(30px, -30px);
        opacity: 0.1;
    }

    .container::after {
        content: "";
        position: absolute;
        bottom: 0;
        left: 0;
        width: 150px;
        height: 150px;
        background: var(--primary-red);
        border-radius: 50%;
        transform: translate(-50px, 50px);
        opacity: 0.1;
    }

    .header {
        text-align: center;
        margin-bottom: 30px;
        padding-bottom: 20px;
        border-bottom: 2px solid var(--light-red);
        position: relative;
    }

    .header::after {
        content: "";
        position: absolute;
        bottom: -2px;
        left: 50%;
        transform: translateX(-50%);
        width: 100px;
        height: 3px;
        background: var(--primary-red);
    }

    .logo {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 15px;
        margin-bottom: 15px;
    }

    .logo-icon {
        font-size: 2.5rem;
        color: var(--primary-red);
    }

    .logo-text {
        font-size: 2rem;
        font-weight: 700;
        color: var(--primary-red);
    }

    .contact-heading {
        font-size: 1.8rem;
        color: var(--dark-gray);
        margin-bottom: 10px;
    }

    .subtitle {
        color: #666;
        font-size: 1.1rem;
    }

    .info-cards {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 15px;
        margin-bottom: 25px;
    }

    .info-card {
        background: var(--light-pink);
        padding: 15px;
        border-radius: 10px;
        border-left: 4px solid var(--primary-red);
    }

    .info-card h3 {
        color: var(--dark-red);
        margin-bottom: 8px;
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 1.1rem;
    }

    .info-card ul {
        list-style: none;
        padding-left: 0;
    }

    .info-card li {
        margin-bottom: 5px;
        font-size: 0.9rem;
        display: flex;
        align-items: flex-start;
        gap: 8px;
    }

    .info-card li i {
        color: var(--primary-red);
        margin-top: 2px;
        flex-shrink: 0;
    }

    form {
        position: relative;
        z-index: 1;
    }

    fieldset {
        margin: 20px 0;
        border: 2px solid var(--light-red);
        border-radius: 10px;
        padding: 25px;
        background: var(--light-gray);
        position: relative;
    }

    legend {
        font-size: 1.4rem;
        font-weight: 600;
        color: var(--primary-red);
        padding: 0 15px;
        background: var(--white);
        border-radius: 5px;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .form-group {
        margin-bottom: 20px;
        position: relative;
    }

    .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        color: var(--dark-gray);
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .form-group label i {
        color: var(--primary-red);
        width: 20px;
    }

    input[type="text"],
    input[type="email"],
    input[type="number"],
    input[type="date"],
    textarea,
    select {
        width: 100%;
        padding: 14px 16px;
        border: 2px solid #e1e1e1;
        border-radius: 8px;
        font-size: 16px;
        transition: all 0.3s ease;
        background: var(--white);
    }

    input[type="text"]:focus,
    input[type="email"]:focus,
    input[type="number"]:focus,
    input[type="date"]:focus,
    textarea:focus,
    select:focus {
        outline: none;
        border-color: var(--primary-red);
        box-shadow: 0 0 0 3px rgba(200, 16, 46, 0.1);
    }

    textarea {
        resize: vertical;
        min-height: 120px;
        font-family: inherit;
    }

    .input-with-icon {
        position: relative;
    }

    .input-with-icon i {
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        color: #999;
    }

    .submit-btn {
        width: 100%;
        padding: 18px;
        background: linear-gradient(135deg, var(--primary-red), var(--dark-red));
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 1.1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        margin-top: 10px;
        box-shadow: 0 5px 15px rgba(200, 16, 46, 0.3);
    }

    .submit-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(200, 16, 46, 0.4);
        background: linear-gradient(135deg, var(--dark-red), var(--primary-red));
    }

    .submit-btn:active {
        transform: translateY(0);
    }

    .hospital-id-note {
        background: var(--light-pink);
        padding: 10px 15px;
        border-radius: 6px;
        margin-top: 5px;
        font-size: 0.9rem;
        color: var(--dark-red);
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .required {
        color: var(--primary-red);
    }

  
    @media (max-width: 768px) {
        .container {
            padding: 20px;
            margin: 10px;
        }
        
        .logo-text {
            font-size: 1.6rem;
        }
        
        .contact-heading {
            font-size: 1.5rem;
        }
        
        .info-cards {
            grid-template-columns: 1fr;
        }
        
        fieldset {
            padding: 15px;
        }
    }

    @media (max-width: 480px) {
        body {
            padding: 10px;
        }
        
        .container {
            padding: 15px;
        }
        
        .logo {
            flex-direction: column;
            gap: 8px;
        }
        
        .form-group label {
            flex-direction: column;
            align-items: flex-start;
            gap: 5px;
        }
    }
    </style>
</head>
<body>
   
    <div class="medical-background">
        <i class="fas fa-heartbeat"></i>
        <i class="fas fa-tint"></i>
        <i class="fas fa-stethoscope"></i>
        <i class="fas fa-ambulance"></i>
        <i class="fas fa-hospital"></i>
        <i class="fas fa-user-md"></i>
    </div>

<%

String hmail = session.getAttribute("doctoremail").toString();
%>
    
    <div class="container">
        
        <a href="doctorhome.jsp" class="back-button">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
        
        <div class="header">
            <div class="logo">
                <i class="fas fa-tint logo-icon"></i>
                <div class="logo-text">LifeStream Blood Bank</div>
            </div>
            <h1 class="contact-heading">Arrange Blood Donation Camp</h1>
            <p class="subtitle">Schedule a camp to help save lives in your community</p>
        </div>

        <div class="info-cards">
            <div class="info-card">
                <h3><i class="fas fa-info-circle"></i> Camp Benefits</h3>
                <ul>
                    <li><i class="fas fa-check"></i> Increase blood supply</li>
                    <li><i class="fas fa-check"></i> Community engagement</li>
                    <li><i class="fas fa-check"></i> Emergency preparedness</li>
                </ul>
            </div>
            <div class="info-card">
                <h3><i class="fas fa-requirements"></i> Requirements</h3>
                <ul>
                    <li><i class="fas fa-check"></i> Adequate space</li>
                    <li><i class="fas fa-check"></i> Medical staff</li>
                    <li><i class="fas fa-check"></i> Proper equipment</li>
                </ul>
            </div>
            <div class="info-card">
                <h3><i class="fas fa-tips"></i> Tips</h3>
                <ul>
                    <li><i class="fas fa-check"></i> Plan 4-6 weeks ahead</li>
                    <li><i class="fas fa-check"></i> Promote in local media</li>
                    <li><i class="fas fa-check"></i> Provide donor incentives</li>
                </ul>
            </div>
        </div>

        <form action="campdetails" method="post">
            <fieldset>
                <legend><i class="fas fa-clinic-medical"></i> Camp Details</legend>
                
                <div class="form-group">
                    <label for="hname"><i class="fas fa-hospital"></i> Hospital Name <span class="required">*</span></label>
                    <input type="text" name="hname" id="hname" placeholder="Enter hospital name" required>
                </div>

                

                <div class="form-group">
                    <label for="email"><i class="fas fa-envelope"></i> E-mail <span class="required">*</span></label>
                    <input type="email" name="email" id="email"  value="<%=hmail%>" readonly >
                </div>

                <div class="form-group">
                    <label for="number"><i class="fas fa-phone"></i> Contact No <span class="required">*</span></label>
                    <input type="number" name="number" id="number" placeholder="Enter contact number" required>
                </div>

                <div class="form-group">
                    <label for="address"><i class="fas fa-map-marker-alt"></i> Address <span class="required">*</span></label>
                    <textarea name="address" id="address" placeholder="Enter complete address" required></textarea>
                </div>

                <div class="form-group">
                    <label for="city"><i class="fas fa-city"></i> City <span class="required">*</span></label>
                    <input type="text" name="city" id="city" placeholder="Enter city name" required>
                </div>

                <div class="form-group">
                    <label for="state"><i class="fas fa-map"></i> State <span class="required">*</span></label>
                    <input type="text" name="state" id="state" placeholder="Enter state name" required>
                </div>

                <div class="form-group">
                    <label for="zip"><i class="fas fa-mail-bulk"></i> Zip Code <span class="required">*</span></label>
                    <input type="number" name="zip" id="zip" placeholder="Enter ZIP or postal code" required>
                </div>

                <div class="form-group">
                    <label for="date"><i class="fas fa-calendar-alt"></i> Camp Date <span class="required">*</span></label>
                    <input type="date" name="date" id="date" required>
                </div>

                <button type="submit" class="submit-btn">
                    <i class="fas fa-paper-plane"></i> Schedule Blood Donation Camp
                </button>
            </fieldset>
        </form>
    </div>

    <script>
       
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('date').min = today;
            
          
            const formGroups = document.querySelectorAll('.form-group');
            formGroups.forEach((group, index) => {
                group.style.opacity = '0';
                group.style.transform = 'translateY(20px)';
                group.style.animation = `fadeInUp 0.5s ease ${index * 0.1}s forwards`;
            });
        });

       
        const style = document.createElement('style');
        style.textContent = `
            @keyframes fadeInUp {
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>