<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ambulance Registration - Emergency Response System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #e3f2fd 0%, #f0f8ff 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            display: flex;
            width: 100%;
            max-width: 1000px;
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }

        .register-section {
            flex: 1;
            padding: 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .graphic-section {
            flex: 1;
            background: linear-gradient(135deg, #1976d2 0%, #0d47a1 100%);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: white;
            padding: 40px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .graphic-section::before {
            content: "";
            position: absolute;
            width: 200px;
            height: 200px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            top: -50px;
            right: -50px;
        }

        .graphic-section::after {
            content: "";
            position: absolute;
            width: 150px;
            height: 150px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            bottom: -50px;
            left: -50px;
        }

        .ambulance-icon {
            font-size: 80px;
            margin-bottom: 20px;
            z-index: 1;
        }

        .graphic-section h2 {
            font-size: 28px;
            margin-bottom: 15px;
            z-index: 1;
        }

        .graphic-section p {
            font-size: 16px;
            opacity: 0.9;
            max-width: 300px;
            z-index: 1;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 30px;
        }

        .logo i {
            font-size: 32px;
            color: #1976d2;
        }

        .logo h1 {
            font-size: 24px;
            color: #0d47a1;
            font-weight: 700;
        }

        .register-section h2 {
            color: #0d47a1;
            margin-bottom: 10px;
            font-size: 28px;
        }

        .subtitle {
            color: #546e7a;
            margin-bottom: 30px;
            font-size: 16px;
        }

        .form-row {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
            flex: 1;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #37474f;
        }

        .input-with-icon {
            position: relative;
        }

        .input-with-icon i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #78909c;
        }

        .input-with-icon input, .input-with-icon select {
            width: 100%;
            padding: 15px 15px 15px 45px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s;
            background: #fafafa;
        }

        .input-with-icon input:focus, .input-with-icon select:focus {
            outline: none;
            border-color: #1976d2;
            background: white;
            box-shadow: 0 0 0 3px rgba(25, 118, 210, 0.1);
        }

        .btn-register {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #1976d2 0%, #1565c0 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 10px;
            box-shadow: 0 4px 15px rgba(25, 118, 210, 0.3);
        }

        .btn-register:hover {
            background: linear-gradient(135deg, #1565c0 0%, #0d47a1 100%);
            box-shadow: 0 6px 20px rgba(25, 118, 210, 0.4);
            transform: translateY(-2px);
        }

        .login-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #e0e0e0;
        }

        .login-link a {
            color: #1976d2;
            text-decoration: none;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: color 0.3s;
        }

        .login-link a:hover {
            color: #0d47a1;
            text-decoration: underline;
        }

        .pulse {
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
            100% {
                transform: scale(1);
            }
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }
            
            .graphic-section {
                padding: 30px;
            }
            
            .register-section {
                padding: 40px 30px;
            }
            
            .form-row {
                flex-direction: column;
                gap: 0;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="register-section">
            <div class="logo">
                <i class="fas fa-ambulance"></i>
                <h1>LifeStream Blood Bank</h1>
            </div>
            
            <h2>Ambulance Registration</h2>
            <p class="subtitle">Join our emergency response network</p>
            
            <form action="Ambulancereg" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label for="drivername">Driver Name</label>
                        <div class="input-with-icon">
                            <i class="fas fa-user"></i>
                            <input type="text" id="drivername" name="drivername" placeholder="Enter driver's full name" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="ambulanceno">Ambulance Number</label>
                        <div class="input-with-icon">
                            <i class="fas fa-ambulance"></i>
                            <input type="text" id="ambulanceno" name="ambulanceno" placeholder="TN-01-AB-1234" required>
                        </div>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="phone">Driver Phone</label>
                        <div class="input-with-icon">
                            <i class="fas fa-phone"></i>
                            <input type="text" id="phone" name="phone" placeholder="Enter phone number" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="location">Location</label>
                        <div class="input-with-icon">
                            <i class="fas fa-map-marker-alt"></i>
                            <input type="text" id="location" name="location" placeholder="Enter your service area" required>
                        </div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="email">Email (Login ID)</label>
                    <div class="input-with-icon">
                        <i class="fas fa-envelope"></i>
                        <input type="email" id="email" name="email" placeholder="Enter email address" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-with-icon">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="password" name="password" placeholder="Create a secure password" required>
                    </div>
                </div>
                
                <button type="submit" class="btn-register">
                    <i class="fas fa-user-plus"></i> Register Ambulance
                </button>
            </form>
            
            <div class="login-link">
                <a href="ambulancelog.jsp">
                    <i class="fas fa-sign-in-alt"></i> Already have an account? Login here
                </a>
            </div>
        </div>
        
        <div class="graphic-section">
            <i class="fas fa-ambulance ambulance-icon pulse"></i>
            <h2>Join Our Emergency Team</h2>
            <p>Register your ambulance to become part of our life-saving emergency response network and help communities in need.</p>
        </div>
    </div>

    <script>
       
        document.addEventListener('DOMContentLoaded', function() {
            const inputs = document.querySelectorAll('input, select');
            
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.classList.add('focused');
                });
                
                input.addEventListener('blur', function() {
                    this.parentElement.classList.remove('focused');
                });
            });
            
            
            const form = document.querySelector('form');
            form.addEventListener('submit', function(e) {
                let isValid = true;
                const requiredFields = form.querySelectorAll('[required]');
                
                requiredFields.forEach(field => {
                    if (!field.value.trim()) {
                        isValid = false;
                        field.style.borderColor = '#dc2626';
                    } else {
                        field.style.borderColor = '#1976d2';
                    }
                });
                
                if (!isValid) {
                    e.preventDefault();
                    alert('Please fill in all required fields');
                }
            });
        });
    </script>
</body>
</html>