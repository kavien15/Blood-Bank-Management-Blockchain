<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BloodCare - Doctor Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #8a0303 0%, #5c0101 100%);
            padding: 20px;
            position: relative;
            overflow: hidden;
        }

        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 80%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 40% 40%, rgba(255, 0, 0, 0.1) 0%, transparent 50%);
            z-index: -1;
        }

        .container {
            display: flex;
            width: 900px;
            height: 550px;
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            position: relative;
        }

        .left-panel {
            flex: 1;
            background: linear-gradient(135deg, #8a0303 0%, #5c0101 100%);
            color: white;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        .left-panel::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100" height="100" opacity="0.1"><path fill="white" d="M50,15 C60,5 80,5 90,15 C100,25 100,45 90,55 C80,65 60,65 50,55 C40,65 20,65 10,55 C0,45 0,25 10,15 C20,5 40,5 50,15 Z M40,35 L40,55 L30,55 L30,35 L40,35 Z M70,35 L70,55 L60,55 L60,35 L70,35 Z"/></svg>');
            background-size: 200px;
            opacity: 0.1;
        }

        .left-panel h1 {
            font-size: 2.5rem;
            margin-bottom: 15px;
            font-weight: 600;
            position: relative;
        }

        .left-panel h1::after {
            content: "";
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 60px;
            height: 4px;
            background: #ff6b6b;
            border-radius: 2px;
        }

        .left-panel p {
            font-size: 1.1rem;
            line-height: 1.6;
            margin-bottom: 30px;
            opacity: 0.9;
        }

        .features {
            list-style: none;
        }

        .features li {
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }

        .features i {
            margin-right: 10px;
            color: #8a0303;
            background: white;
            border-radius: 50%;
            padding: 5px;
            font-size: 0.9rem;
        }

        .right-panel {
            flex: 1;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background: #fff;
        }

        .logo {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
        }

        .logo i {
            font-size: 2rem;
            color: #8a0303;
            margin-right: 10px;
        }

        .logo h2 {
            color: #8a0303;
            font-size: 1.8rem;
            font-weight: 700;
        }

        .form-container h3 {
            color: #333;
            margin-bottom: 25px;
            font-size: 1.8rem;
            font-weight: 600;
        }

        .input-group {
            position: relative;
            margin-bottom: 25px;
        }

        .input-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #8a0303;
        }

        .input-group input {
            width: 100%;
            padding: 15px 15px 15px 45px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s;
        }

        .input-group input:focus {
            border-color: #8a0303;
            box-shadow: 0 0 0 2px rgba(138, 3, 3, 0.2);
            outline: none;
        }

        .options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            font-size: 0.9rem;
        }

        .remember {
            display: flex;
            align-items: center;
        }

        .remember input {
            margin-right: 8px;
            accent-color: #8a0303;
        }

        .forgot {
            color: #8a0303;
            text-decoration: none;
            transition: color 0.3s;
            font-weight: 500;
        }

        .forgot:hover {
            color: #5c0101;
            text-decoration: underline;
        }

        .login-btn {
            width: 100%;
            padding: 15px;
            background: #8a0303;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s;
            margin-bottom: 20px;
            position: relative;
            overflow: hidden;
        }

        .login-btn:hover {
            background: #5c0101;
        }

        .login-btn::after {
            content: "";
            position: absolute;
            top: 50%;
            left: 50%;
            width: 5px;
            height: 5px;
            background: rgba(255, 255, 255, 0.5);
            opacity: 0;
            border-radius: 100%;
            transform: scale(1, 1) translate(-50%);
            transform-origin: 50% 50%;
        }

        .login-btn:focus:not(:active)::after {
            animation: ripple 1s ease-out;
        }

        @keyframes ripple {
            0% {
                transform: scale(0, 0);
                opacity: 0.5;
            }
            100% {
                transform: scale(20, 20);
                opacity: 0;
            }
        }

        .register {
            text-align: center;
            font-size: 0.9rem;
            color: #666;
        }

        .register a {
            color: #8a0303;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
        }

        .register a:hover {
            color: #5c0101;
            text-decoration: underline;
        }

        .blood-drop {
            position: absolute;
            width: 80px;
            height: 100px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50% 50% 50% 50% / 60% 60% 40% 40%;
            transform: rotate(-15deg);
            z-index: 0;
        }

        .drop-1 {
            top: 10%;
            left: 10%;
            width: 60px;
            height: 80px;
        }

        .drop-2 {
            bottom: 15%;
            right: 10%;
            width: 70px;
            height: 90px;
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                height: auto;
                width: 100%;
            }
            
            .left-panel {
                padding: 30px;
            }
            
            .blood-drop {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="left-panel">
            <div class="blood-drop drop-1"></div>
            <div class="blood-drop drop-2"></div>
            <h1>
LifeStream Portal</h1>
            <p>Access the blood bank management system to track donations, inventory, and patient transfusions securely.</p>
            <ul class="features">
                <li><i class="fas fa-check"></i> Real-time blood inventory tracking</li>
                <li><i class="fas fa-check"></i> Donor management and screening</li>
                <li><i class="fas fa-check"></i> Cross-matching and compatibility testing</li>
                <li><i class="fas fa-check"></i> Transfusion history and records</li>
            </ul>
        </div>
        <div class="right-panel">
            <div class="logo">
                <i class="fas fa-tint"></i>
                <h2>
LifeStream</h2>
            </div>
            <div class="form-container">
                <h3>Hospital Login</h3>
                <form action="Doctorlog" method="post">
                    <div class="input-group">
                        <i class="fas fa-envelope"></i>
                        <input type="email" name="email" placeholder="Email Address" required>
                    </div>
                    <div class="input-group">
                        <i class="fas fa-lock"></i>
                        <input type="password" name="password" placeholder="Password" required>
                    </div>
                    
                    
                    <button type="submit" class="login-btn">LOGIN</button><br>
                    
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
                <div class="register">
                    <p>Don't have an account? <a href="doctorregister.jsp">Register here</a></p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>