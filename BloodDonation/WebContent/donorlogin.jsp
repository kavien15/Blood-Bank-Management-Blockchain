<!DOCTYPE html>
<html lang="en">


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Donor Login - LifeStream Blood Bank</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        :root {
            --primary: #c62828;
            --primary-dark: #8e0000;
            --primary-light: #ff5f52;
            --secondary: #fafafa;
            --accent: #ffab91;
            --text: #212121;
            --text-light: #757575;
            --card-bg: rgba(255, 255, 255, 0.95);
        }

        body {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), 
                        url('https://images.unsplash.com/photo-1579154204601-01588f351e67?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: var(--text);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem;
        }

        .container {
            display: flex;
            max-width: 1000px;
            width: 100%;
            background-color: var(--card-bg);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .info-section {
            flex: 1;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        .info-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('https://images.unsplash.com/photo-1582719188393-bb71ca45dbb9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80');
            background-size: cover;
            background-position: center;
            opacity: 0.2;
            z-index: 0;
        }

        .info-content {
            position: relative;
            z-index: 1;
        }

        .info-section h1 {
            font-size: 2.2rem;
            margin-bottom: 1.5rem;
            position: relative;
        }

        .info-section h1:after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 60px;
            height: 4px;
            background-color: var(--accent);
        }

        .info-section p {
            margin-bottom: 1.5rem;
            line-height: 1.6;
            font-size: 1rem;
        }

        .features-list {
            margin: 1.5rem 0;
        }

        .features-list li {
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
        }

        .features-list i {
            margin-right: 10px;
            color: var(--accent);
            font-size: 1.2rem;
        }

        .stats {
            display: flex;
            margin-top: 2rem;
            gap: 1.5rem;
        }

        .stat-item {
            text-align: center;
            flex: 1;
        }

        .stat-number {
            font-size: 1.8rem;
            font-weight: bold;
            display: block;
        }

        .stat-label {
            font-size: 0.8rem;
        }

        .form-section {
            flex: 1;
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .form-header h2 {
            font-size: 2rem;
            color: var(--primary);
            margin-bottom: 0.5rem;
        }

        .form-header p {
            color: var(--text-light);
        }

        .logo {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }

        .logo i {
            font-size: 2.5rem;
            color: var(--primary);
            margin-right: 10px;
        }

        .logo-text {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--primary);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--text);
        }

        .input-with-icon {
            position: relative;
        }

        .input-with-icon i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-light);
        }

        .form-control {
            width: 100%;
            padding: 12px 15px 12px 45px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(198, 40, 40, 0.2);
            outline: none;
        }

        .btn {
            display: block;
            width: 100%;
            padding: 14px;
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 1rem;
        }
        .btn a{
        text-decoration: none;
        color: white;
        }

        .btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .links {
            display: flex;
            justify-content: space-between;
            margin-top: 1.5rem;
        }

        .links a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.9rem;
        }

        .links a:hover {
            text-decoration: underline;
        }

        .register-link {
            text-align: center;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid #eee;
            color: var(--text-light);
        }

        .register-link a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }
            
            .info-section, .form-section {
                padding: 2rem;
            }
            
            .stats {
                flex-direction: column;
                gap: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="info-section">
            <div class="info-content">
                <h1>Welcome Back, Lifesaver!</h1>
                <p>Thank you for being part of our mission to save lives through blood donation. Your continued support makes a real difference.</p>
                
                <ul class="features-list">
                    <li><i class="fas fa-trophy"></i> Track your donation milestones</li>
                    <li><i class="fas fa-calendar-check"></i> Schedule your next appointment</li>
                    <li><i class="fas fa-heartbeat"></i> View your health screening results</li>
                    <li><i class="fas fa-award"></i> Earn recognition for your contributions</li>
                </ul>
                
                <div class="stats">
                    <div class="stat-item">
                        <span class="stat-number" id="lives-saved">0</span>
                        <span class="stat-label">Lives Saved</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number" id="donations-today">0</span>
                        <span class="stat-label">Donations Today</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number" id="urgent-needs">12</span>
                        <span class="stat-label">Urgent Needs</span>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="form-section">
            <div class="form-header">
                <div class="logo">
                    <i class="fas fa-tint"></i>
                    <span class="logo-text">LifeStream</span>
                </div>
                <h2>Donor Login</h2>
                <p>Access your donor account</p>
            </div>
            
            <form action="Donorlog" method="post" class="login-form">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <div class="input-with-icon">
                        <i class="fas fa-envelope"></i>
                        <input type="email" id="email" name="email" class="form-control" placeholder="Enter your email address" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-with-icon">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" required>
                    </div>
                </div>
                <button type="submit" class="btn">
    Login to Your Account
</button>

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
            
            <div class="register-link">
                <p>Don't have an account? <a href="donorregister.jsp">Register as a Donor</a></p>
            </div>
        </div>
        
        
    </div>
    

    <script>
       
        function animateCounter(elementId, targetValue, duration) {
            let element = document.getElementById(elementId);
            let startValue = 0;
            let increment = targetValue / (duration / 10);
            let currentValue = startValue;
            
            let timer = setInterval(() => {
                currentValue += increment;
                if (currentValue >= targetValue) {
                    currentValue = targetValue;
                    clearInterval(timer);
                }
                element.textContent = Math.floor(currentValue).toLocaleString();
            }, 10);
        }
        
        
        window.onload = function() {
            animateCounter("lives-saved", 12475, 1500);
            animateCounter("donations-today", 342, 1200);
        };
    </script>
</body>
</html>