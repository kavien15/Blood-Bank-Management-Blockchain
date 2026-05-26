<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Blood Bank Login</title>
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
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
        background: linear-gradient(135deg, #ffe6e6 0%, #ffcccc 50%, #ffb3b3 100%);
        color: #333;
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
        position: relative;
        overflow-x: hidden;
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

    .container {
        max-width: 450px;
        width: 100%;
    }

    .header {
        background: linear-gradient(135deg, var(--primary-red), var(--dark-red));
        color: white;
        padding: 2rem;
        border-radius: 15px 15px 0 0;
        text-align: center;
        position: relative;
        overflow: hidden;
    }

    .logo {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 15px;
        margin-bottom: 1rem;
    }

    .logo-icon {
        font-size: 2.5rem;
        color: white;
        animation: pulse 2s infinite;
    }

    @keyframes pulse {
        0% { transform: scale(1); }
        50% { transform: scale(1.1); }
        100% { transform: scale(1); }
    }

    .logo-text {
        font-size: 2rem;
        font-weight: 700;
    }

    .page-title {
        font-size: 1.5rem;
        margin-bottom: 0.5rem;
    }

    .page-subtitle {
        font-size: 1rem;
        opacity: 0.9;
    }

    .form-container {
        background: white;
        padding: 2rem;
        border-radius: 0 0 15px 15px;
        box-shadow: 0 15px 40px rgba(200, 16, 46, 0.2);
        position: relative;
    }

    .form-container::before {
        content: "";
        position: absolute;
        top: -10px;
        left: 50%;
        transform: translateX(-50%);
        width: 20px;
        height: 20px;
        background: var(--primary-red);
        border-radius: 50%;
    }

    .form-group {
        margin-bottom: 1.5rem;
        position: relative;
    }

    .form-group label {
        display: block;
        margin-bottom: 0.5rem;
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

    .input-with-icon {
        position: relative;
    }

    .input-with-icon i {
        position: absolute;
        left: 15px;
        top: 50%;
        transform: translateY(-50%);
        color: #999;
    }

    input[type="text"],
    input[type="email"],
    input[type="password"] {
        width: 100%;
        padding: 14px 14px 14px 45px;
        border: 2px solid #e1e1e1;
        border-radius: 8px;
        font-size: 16px;
        transition: all 0.3s ease;
        background: var(--white);
    }

    input[type="text"]:focus,
    input[type="email"]:focus,
    input[type="password"]:focus {
        outline: none;
        border-color: var(--primary-red);
        box-shadow: 0 0 0 3px rgba(200, 16, 46, 0.1);
    }

    .submit-btn {
        width: 100%;
        padding: 16px;
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
        margin-top: 1rem;
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

    .form-links {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 1.5rem;
        padding-top: 1.5rem;
        border-top: 1px solid #eee;
        flex-wrap: wrap;
        gap: 1rem;
    }

    .form-links a {
        color: var(--primary-red);
        text-decoration: none;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 8px;
        transition: color 0.3s;
        font-size: 0.9rem;
    }

    .form-links a:hover {
        color: var(--dark-red);
    }

    .required {
        color: var(--primary-red);
    }

    .form-note {
        background: var(--light-pink);
        padding: 12px 15px;
        border-radius: 6px;
        margin-bottom: 1.5rem;
        font-size: 0.9rem;
        color: var(--dark-red);
        display: flex;
        align-items: flex-start;
        gap: 8px;
        border-left: 4px solid var(--primary-red);
    }

    .form-note i {
        margin-top: 2px;
        flex-shrink: 0;
    }

    
    .error-message {
        background: #f8d7da;
        color: #721c24;
        padding: 12px;
        border-radius: 6px;
        margin-bottom: 1rem;
        border: 1px solid #f5c6cb;
        display: none;
        align-items: center;
        gap: 10px;
    }

    
    .success-message {
        background: #d4edda;
        color: #155724;
        padding: 12px;
        border-radius: 6px;
        margin-bottom: 1rem;
        border: 1px solid #c3e6cb;
        display: none;
        align-items: center;
        gap: 10px;
    }

    .password-toggle {
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        background: none;
        border: none;
        color: #999;
        cursor: pointer;
        font-size: 1rem;
        transition: color 0.3s;
    }

    .password-toggle:hover {
        color: var(--primary-red);
    }

    
    .remember-me {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-top: 1rem;
    }

    .remember-me input[type="checkbox"] {
        width: 16px;
        height: 16px;
        accent-color: var(--primary-red);
    }

    .remember-me label {
        font-size: 0.9rem;
        color: #666;
        cursor: pointer;
    }

   
    @media (max-width: 768px) {
        .container {
            max-width: 100%;
        }
        
        .header {
            padding: 1.5rem;
        }
        
        .logo-text {
            font-size: 1.6rem;
        }
        
        .form-container {
            padding: 1.5rem;
        }
        
        .form-links {
            flex-direction: column;
            align-items: flex-start;
            gap: 0.5rem;
        }
    }

    @media (max-width: 480px) {
        body {
            padding: 10px;
        }
        
        .header {
            padding: 1rem;
        }
        
        .logo {
            flex-direction: column;
            gap: 8px;
        }
        
        .form-container {
            padding: 1rem;
        }
        
        input[type="text"],
        input[type="email"],
        input[type="password"] {
            padding: 12px 12px 12px 40px;
        }
        
        .form-links {
            text-align: center;
        }
        
        .form-links a {
            justify-content: center;
            width: 100%;
        }
    }
</style>
</head>
<body>
   
    <div class="medical-background">
        <i class="fas fa-heartbeat"></i>
        <i class="fas fa-tint"></i>
        <i class="fas fa-stethoscope"></i>
        <i class="fas fa-hospital"></i>
    </div>

    <div class="container">
        <div class="header">
            <div class="logo">
                <i class="fas fa-tint logo-icon"></i>
                <div class="logo-text">LifeStream Blood Bank</div>
            </div>
            <h1 class="page-title">Blood Bank Login</h1>
            <p class="page-subtitle">Access your blood bank management system</p>
        </div>

        <div class="form-container">
            
            <div class="error-message" id="errorMessage">
                <i class="fas fa-exclamation-triangle"></i>
                <span id="errorText">Invalid credentials. Please try again.</span>
            </div>

            
            <div class="success-message" id="successMessage">
                <i class="fas fa-check-circle"></i>
                <span id="successText">Login successful! Redirecting...</span>
            </div>

            <form action="BloodBankLogin" method="post" id="loginForm">
                <div class="form-note">
                    <i class="fas fa-info-circle"></i>
                    Please enter your Blood Bank ID, Email, and Password to access the system.
                </div>

                <div class="form-group">
                    <label for="bloodbankId">
                        <i class="fas fa-id-card"></i> Blood Bank ID <span class="required">*</span>
                    </label>
                    <div class="input-with-icon">
                        <i class="fas fa-hashtag"></i>
                        <input type="text" name="bloodbankId" id="bloodbankId" placeholder="Enter your blood bank ID" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="email">
                        <i class="fas fa-envelope"></i> Email Address <span class="required">*</span>
                    </label>
                    <div class="input-with-icon">
                        <i class="fas fa-at"></i>
                        <input type="email" name="email" id="email" placeholder="Enter your email address" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="password">
                        <i class="fas fa-lock"></i> Password <span class="required">*</span>
                    </label>
                    <div class="input-with-icon">
                        <i class="fas fa-key"></i>
                        <input type="password" name="password" id="password" placeholder="Enter your password" required>
                        <button type="button" class="password-toggle" id="passwordToggle">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>

                

                <button type="submit" class="submit-btn">
                    <i class="fas fa-sign-in-alt"></i> Login to Dashboard
                </button><br>
                
                              <%
    String error = (String) request.getAttribute("errorMsg");
    if (error != null) {
%>
    <div style="
        background:#ffebee;
        color:#c62828;
        padding:12px;
        border-radius:6px;
        margin-bottom:15px;
        text-align:center;
        font-weight:500;">
        <i class="fas fa-exclamation-circle"></i> <%= error %>
    </div>
<%
    }
%>
         
                
            </form>

            <div class="form-links">
                <a href="bloodbankreg.jsp">
                    <i class="fas fa-user-plus"></i> Create New Account
                </a>
               
            </div>
        </div>
    </div>

    
</body>
</html>