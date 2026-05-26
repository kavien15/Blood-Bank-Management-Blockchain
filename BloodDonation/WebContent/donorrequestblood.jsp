<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
String bid = request.getParameter("bid");
String email = request.getParameter("email");
%>

<!DOCTYPE html>
<html>
<head>
<title>Request Blood</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    :root {
        --primary: #c62828;
        --primary-dark: #8e0000;
        --primary-light: #ff5f52;
        --secondary: #2c3e50;
        --light: #f8f9fa;
        --gray: #e9ecef;
        --dark-gray: #6c757d;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        color: var(--secondary);
        line-height: 1.6;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        padding: 2rem;
        position: relative;
    }

    
    .btn-back {
        background: var(--secondary);
        color: var(--light);
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
        margin-bottom: 2rem;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        position: absolute;
        top: 20px;
        left: 20px;
        z-index: 10;
    }

    .btn-back:hover {
        background: #1a252f;
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(0,0,0,0.15);
    }

    
    .container {
        width: 100%;
        max-width: 480px;
        background: white;
        padding: 2.5rem;
        border-radius: 16px;
        box-shadow: 
            0 10px 30px rgba(0,0,0,0.1),
            0 0 0 1px rgba(255,255,255,0.8);
        position: relative;
        overflow: hidden;
    }

    .container::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: linear-gradient(90deg, var(--primary), var(--primary-dark));
    }

    
    .header {
        text-align: center;
        margin-bottom: 2rem;
        position: relative;
    }

    .header-icon {
        font-size: 3rem;
        color: var(--primary);
        margin-bottom: 1rem;
        animation: pulse 2s infinite;
    }

    @keyframes pulse {
        0% { transform: scale(1); }
        50% { transform: scale(1.05); }
        100% { transform: scale(1); }
    }

    .page-title {
        font-size: 1.8rem;
        color: var(--primary);
        margin-bottom: 0.5rem;
        font-weight: 700;
    }

    .page-subtitle {
        font-size: 1rem;
        color: var(--dark-gray);
        margin-bottom: 1rem;
    }

    .bloodbank-info {
        background: linear-gradient(135deg, rgba(198, 40, 40, 0.05), rgba(255, 95, 82, 0.05));
        padding: 1rem;
        border-radius: 8px;
        border-left: 4px solid var(--primary);
        margin-bottom: 1.5rem;
    }

    .bloodbank-info strong {
        color: var(--primary);
    }

    
    .form-group {
        margin-bottom: 1.5rem;
        position: relative;
    }

    label {
        font-weight: 600;
        color: var(--secondary);
        display: block;
        margin-bottom: 0.5rem;
        font-size: 0.95rem;
    }

    .required::after {
        content: ' *';
        color: var(--primary);
    }

    select, input[type="text"], input[type="number"], input[type="file"] {
        width: 100%;
        padding: 12px 16px;
        border: 2px solid var(--gray);
        border-radius: 8px;
        font-size: 1rem;
        transition: all 0.3s ease;
        background: white;
    }

    select:focus, input[type="text"]:focus, input[type="number"]:focus {
        outline: none;
        border-color: var(--primary);
        box-shadow: 0 0 0 3px rgba(198, 40, 40, 0.1);
    }

    select {
        appearance: none;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='%236c757d' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: right 16px center;
        background-size: 12px;
    }

    .input-with-icon {
        position: relative;
    }

    .input-with-icon i {
        position: absolute;
        left: 16px;
        top: 50%;
        transform: translateY(-50%);
        color: var(--dark-gray);
    }

    .input-with-icon input {
        padding-left: 45px;
    }

    
    .file-input-wrapper {
        position: relative;
        overflow: hidden;
        display: inline-block;
        width: 100%;
    }

    .file-input-wrapper input[type=file] {
        position: absolute;
        left: 0;
        top: 0;
        opacity: 0;
        width: 100%;
        height: 100%;
        cursor: pointer;
    }

    .file-input-custom {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 12px 16px;
        border: 2px dashed var(--gray);
        border-radius: 8px;
        background: var(--light);
        transition: all 0.3s ease;
        cursor: pointer;
    }

    .file-input-custom:hover {
        border-color: var(--primary);
        background: rgba(198, 40, 40, 0.05);
    }

    .file-input-custom i {
        color: var(--primary);
        font-size: 1.2rem;
    }

    .file-input-text {
        flex: 1;
        color: var(--dark-gray);
    }

   
    .note {
        font-size: 0.85rem;
        color: var(--dark-gray);
        margin-top: 0.5rem;
        font-style: italic;
    }

  
    .btn-submit {
        width: 100%;
        padding: 14px;
        border: none;
        background: linear-gradient(135deg, var(--primary), var(--primary-dark));
        color: white;
        font-size: 1.1rem;
        font-weight: 600;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        margin-top: 1rem;
        box-shadow: 0 4px 15px rgba(198, 40, 40, 0.3);
    }

    .btn-submit:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(198, 40, 40, 0.4);
    }

    .btn-submit:active {
        transform: translateY(0);
    }

    
    .form-divider {
        height: 1px;
        background: linear-gradient(90deg, transparent, var(--gray), transparent);
        margin: 1.5rem 0;
    }

    
    .emergency-notice {
        background: linear-gradient(135deg, rgba(255, 193, 7, 0.1), rgba(255, 193, 7, 0.05));
        border: 1px solid rgba(255, 193, 7, 0.3);
        padding: 1rem;
        border-radius: 8px;
        margin-top: 1.5rem;
        text-align: center;
    }

    .emergency-notice i {
        color: #ffc107;
        margin-right: 8px;
    }

    .emergency-notice strong {
        color: #856404;
    }

    
    @media (max-width: 768px) {
        body {
            padding: 1rem;
        }
        
        .container {
            padding: 2rem 1.5rem;
            margin: 1rem auto;
        }
        
        .btn-back {
            position: relative;
            top: 0;
            left: 0;
            margin-bottom: 1rem;
            width: 100%;
            justify-content: center;
        }
        
        .page-title {
            font-size: 1.6rem;
        }
    }

    @media (max-width: 480px) {
        .container {
            padding: 1.5rem 1rem;
        }
        
        .header-icon {
            font-size: 2.5rem;
        }
    }
</style>
</head>
<body>

    
    <a href="donorviewbloodbank.jsp" class="btn-back">
        <i class="fas fa-arrow-left"></i> Back to Blood Banks
    </a>

    <div class="container">
       
        <div class="header">
            <i class="fas fa-tint header-icon"></i>
            <h1 class="page-title">Blood Request Form</h1>
            <p class="page-subtitle">Submit your blood requirement details</p>
            
            <div class="bloodbank-info">
                <strong>Blood Bank:</strong> <%= email %>
            </div>
        </div>

        <form action="SendBloodRequest" method="post" enctype="multipart/form-data">
            <input type="hidden" name="bid" value="<%= bid %>">

            
            <div class="form-group">
                <label class="required">Patient Name</label>
                <div class="input-with-icon">
                    <i class="fas fa-user"></i>
                    <input type="text" name="patientname" required placeholder="Enter patient full name">
                </div>
            </div>

            
            <div class="form-group">
                <label class="required">Patient Age</label>
                <div class="input-with-icon">
                    <i class="fas fa-calendar-alt"></i>
                    <input type="number" name="age" min="1" max="120" required placeholder="Enter patient age">
                </div>
            </div>

            
            <div class="form-group">
                <label class="required">Hospital Name</label>
                <div class="input-with-icon">
                    <i class="fas fa-hospital"></i>
                    <input type="text" name="hospital" required placeholder="Enter hospital name">
                </div>
            </div>

           
            <div class="form-group">
                <label class="required">Blood Group</label>
                <select name="bloodgroup" required>
                    <option value="">-- Select Blood Group --</option>
                    <option value="A+">A+</option>
                    <option value="A-">A-</option>
                    <option value="B+">B+</option>
                    <option value="B-">B-</option>
                    <option value="O+">O+</option>
                    <option value="O-">O-</option>
                    <option value="AB+">AB+</option>
                    <option value="AB-">AB-</option>
                </select>
            </div>

            
            <div class="form-group">
                <label class="required">Units Required (ML)</label>
                <div class="input-with-icon">
                    <i class="fas fa-flask"></i>
                    <input type="number" name="qty" min="1" required placeholder="Enter ML needed">
                </div>
            </div>

           
            <div class="form-group">
                <label class="required">Reason for Blood Requirement</label>
                <div class="input-with-icon">
                    <i class="fas fa-stethoscope"></i>
                    <input type="text" name="reason" required placeholder="Accident, Surgery, Emergency etc.">
                </div>
            </div>

            
            <div class="form-group">
                <label class="required">Upload Medical Document</label>
                <div class="file-input-wrapper">
                    <div class="file-input-custom">
                        <i class="fas fa-file-upload"></i>
                        <span class="file-input-text">Click to upload prescription or hospital letter</span>
                    </div>
                    <input type="file" name="file" accept=".pdf,.jpg,.jpeg,.png" required>
                </div>
                <div class="note">Supported formats: PDF, JPG, PNG (Max: 5MB)</div>
            </div>

           
            <div class="form-divider"></div>

            
            <button type="submit" class="btn-submit">
                <i class="fas fa-paper-plane"></i> Submit Blood Request
            </button>

           
            <div class="emergency-notice">
                <i class="fas fa-exclamation-triangle"></i>
                <strong>Emergency?</strong> For urgent requirements, please call the blood bank directly.
            </div>
        </form>
    </div>

    <script>
        
        document.querySelector('input[type="file"]').addEventListener('change', function(e) {
            const fileName = e.target.files[0] ? e.target.files[0].name : 'Click to upload prescription or hospital letter';
            document.querySelector('.file-input-text').textContent = fileName;
        });

       
        document.querySelector('form').addEventListener('submit', function(e) {
            const fileInput = document.querySelector('input[type="file"]');
            if (fileInput.files.length > 0) {
                const file = fileInput.files[0];
                const fileSize = file.size / 1024 / 1024; // MB
                if (fileSize > 5) {
                    e.preventDefault();
                    alert('File size must be less than 5MB');
                    return false;
                }
            }
        });
    </script>
</body>
</html>