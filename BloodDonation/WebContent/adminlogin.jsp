<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Blood Bank Admin Login</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    :root {
        --primary-red: #dc2626;
        --secondary-red: #ef4444;
        --light-red: #fecaca;
        --dark-red: #991b1b;
        --white: #ffffff;
        --light-bg: #f8fafc;
        --dark-gray: #1e293b;
        --text-gray: #64748b;
        --border-light: #e2e8f0;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
    background: linear-gradient(135deg, #8b0000 0%, #b22222 100%);
        min-height: 100vh;
        font-family: 'Inter', 'Segoe UI', system-ui, -apple-system, sans-serif;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
    }

   
    .blood-pattern {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-image: 
            radial-gradient(circle at 20% 30%, rgba(220, 38, 38, 0.05) 2px, transparent 0),
            radial-gradient(circle at 80% 70%, rgba(220, 38, 38, 0.05) 2px, transparent 0);
        background-size: 60px 60px;
        pointer-events: none;
        z-index: -1;
    }

    .login-container {
        background: var(--white);
        border-radius: 20px;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        width: 100%;
        max-width: 420px;
        border: 1px solid var(--border-light);
        position: relative;
    }

    
    .login-header {
        background: linear-gradient(135deg, var(--primary-red), var(--dark-red));
        color: var(--white);
        padding: 40px 30px;
        text-align: center;
        position: relative;
        overflow: hidden;
    }

    .login-header::before {
        content: '';
        position: absolute;
        top: -50%;
        left: -50%;
        width: 200%;
        height: 200%;
        background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
        background-size: 20px 20px;
        animation: pulse 4s ease-in-out infinite;
    }

    @keyframes pulse {
        0%, 100% { transform: scale(1); opacity: 0.3; }
        50% { transform: scale(1.1); opacity: 0.5; }
    }

    .logo {
        position: relative;
        z-index: 2;
    }

    .logo-icon {
        width: 80px;
        height: 80px;
        background: rgba(255, 255, 255, 0.2);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 20px;
        border: 2px solid rgba(255, 255, 255, 0.3);
        animation: heartbeat 2s ease-in-out infinite;
    }

    @keyframes heartbeat {
        0% { transform: scale(1); }
        50% { transform: scale(1.05); }
        100% { transform: scale(1); }
    }

    .logo-icon i {
        font-size: 2.5rem;
        color: var(--light-red);
    }

    .login-header h1 {
        font-size: 1.8rem;
        font-weight: 700;
        margin-bottom: 8px;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
    }

    .login-header p {
        font-size: 0.95rem;
        opacity: 0.9;
        font-weight: 400;
    }

    
    .login-form {
        padding: 40px 30px;
    }

    .form-group {
        margin-bottom: 25px;
    }

    .form-label {
        display: block;
        margin-bottom: 8px;
        color: var(--dark-gray);
        font-weight: 600;
        font-size: 0.9rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .input-with-icon {
        position: relative;
    }

    .form-input {
        width: 100%;
        padding: 15px 50px 15px 20px;
        border: 2px solid var(--border-light);
        border-radius: 12px;
        font-size: 1rem;
        background: var(--white);
        transition: all 0.3s ease;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    }

    .form-input:focus {
        outline: none;
        border-color: var(--primary-red);
        box-shadow: 0 4px 15px rgba(220, 38, 38, 0.15);
        transform: translateY(-2px);
    }

    .input-icon {
        position: absolute;
        right: 20px;
        top: 50%;
        transform: translateY(-50%);
        color: var(--text-gray);
        font-size: 1.1rem;
        transition: all 0.3s ease;
    }

    .form-input:focus + .input-icon {
        color: var(--primary-red);
    }

    .login-button {
        width: 100%;
        padding: 16px;
        background: linear-gradient(135deg, var(--primary-red), var(--secondary-red));
        color: var(--white);
        border: none;
        border-radius: 12px;
        font-size: 1.1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        box-shadow: 0 8px 25px rgba(220, 38, 38, 0.3);
        margin-top: 10px;
    }

    .login-button:hover {
        background: linear-gradient(135deg, var(--secondary-red), var(--primary-red));
        transform: translateY(-3px);
        box-shadow: 0 12px 30px rgba(220, 38, 38, 0.4);
    }

    .login-button:active {
        transform: translateY(-1px);
    }

   
    .security-features {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-top: 20px;
        padding: 15px;
        background: var(--light-bg);
        border-radius: 10px;
        border-left: 4px solid var(--primary-red);
    }

    .security-item {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 0.8rem;
        color: var(--text-gray);
    }

    .security-item i {
        color: var(--primary-red);
        font-size: 0.9rem;
    }

    
    .error-message {
        background: #fef2f2;
        color: #dc2626;
        padding: 12px 16px;
        border-radius: 8px;
        margin-bottom: 20px;
        border: 1px solid #fecaca;
        display: none;
        font-size: 0.9rem;
        align-items: center;
        gap: 8px;
    }

    .error-message.show {
        display: flex;
        animation: slideIn 0.3s ease;
    }

    @keyframes slideIn {
        from { opacity: 0; transform: translateY(-10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    
    .loading {
        display: none;
    }

    .loading.active {
        display: inline-block;
        animation: spin 1s linear infinite;
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }

    
    @media (max-width: 480px) {
        .login-container {
            margin: 10px;
        }
        
        .login-header {
            padding: 30px 20px;
        }
        
        .login-form {
            padding: 30px 20px;
        }
        
        .login-header h1 {
            font-size: 1.5rem;
        }
        
        .logo-icon {
            width: 60px;
            height: 60px;
        }
        
        .logo-icon i {
            font-size: 2rem;
        }
        
        .security-features {
            flex-direction: column;
            gap: 10px;
            align-items: flex-start;
        }
    }

    
    .password-toggle {
        position: absolute;
        right: 45px;
        top: 50%;
        transform: translateY(-50%);
        color: var(--text-gray);
        cursor: pointer;
        font-size: 1rem;
        transition: color 0.3s ease;
    }

    .password-toggle:hover {
        color: var(--primary-red);
    }
</style>
</head>
<body>
    
    <div class="blood-pattern"></div>

    <div class="login-container">
        
        <div class="login-header">
            <div class="logo">
                <div class="logo-icon">
                    <i class="fas fa-tint"></i>
                </div>
                <h1>LifeStream Blood Bank Admin</h1>
                <p>Secure Management System</p>
            </div>
        </div>

       
        <form action="Adminlog" method="post" id="loginForm">
            <div class="login-form">
               
                <div class="error-message" id="errorMessage">
                    <i class="fas fa-exclamation-circle"></i>
                    <span id="errorText">Please fill in all fields</span>
                </div>

               
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-user"></i> Username
                    </label>
                    <div class="input-with-icon">
                        <input type="text" class="form-input" name="mail" placeholder="Enter your username" required>
                        <i class="fas fa-user input-icon"></i>
                    </div>
                </div>

               
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-lock"></i> Password
                    </label>
                    <div class="input-with-icon">
                        <input type="password" class="form-input" id="password" name="password" placeholder="Enter your password" required>
                        <i class="fas fa-key input-icon"></i>
                        <span class="password-toggle" id="passwordToggle">
                            <i class="fas fa-eye"></i>
                        </span>
                    </div>
                </div>

               
                <button type="submit" class="login-button" id="loginBtn">
                    <span>Access System</span>
                    <i class="fas fa-arrow-right"></i>
                    <i class="fas fa-spinner loading" id="loadingIcon"></i>
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

                <div class="security-features">
                    
                    <div class="security-item">
                        <i class="fas fa-user-shield"></i>
                        <span>Admin Access Only</span>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const loginForm = document.getElementById('loginForm');
            const passwordInput = document.getElementById('password');
            const passwordToggle = document.getElementById('passwordToggle');
            const loginBtn = document.getElementById('loginBtn');
            const loadingIcon = document.getElementById('loadingIcon');
            const errorMessage = document.getElementById('errorMessage');
            const errorText = document.getElementById('errorText');

            
            passwordToggle.addEventListener('click', function() {
                const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordInput.setAttribute('type', type);
                this.innerHTML = type === 'password' ? '<i class="fas fa-eye"></i>' : '<i class="fas fa-eye-slash"></i>';
            });

            
            loginForm.addEventListener('submit', function(e) {
                const username = this.querySelector('input[name="mail"]').value.trim();
                const password = passwordInput.value.trim();
                
                if (!username || !password) {
                    e.preventDefault();
                    errorText.textContent = 'Please fill in all fields.';
                    errorMessage.classList.add('show');
                    return;
                }

                
                loginBtn.disabled = true;
                loadingIcon.classList.add('active');
                loginBtn.querySelector('span').textContent = 'Authenticating...';
            });

            
            const inputs = loginForm.querySelectorAll('input');
            inputs.forEach(input => {
                input.addEventListener('input', function() {
                    errorMessage.classList.remove('show');
                });
            });

            
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.querySelector('.input-icon').style.color = 'var(--primary-red)';
                });

                input.addEventListener('blur', function() {
                    this.parentElement.querySelector('.input-icon').style.color = 'var(--text-gray)';
                });
            });
        });
    </script>
</body>
</html>