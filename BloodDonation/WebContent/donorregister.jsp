<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Donor Registration - LifeStream Blood Bank</title>
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
            --success: #4caf50;
            --warning: #ff9800;
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
            max-width: 1200px;
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
            top: -50%;
            right: -50%;
            width: 100%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
            background-size: 20px 20px;
            transform: rotate(30deg);
            z-index: 0;
        }

        .info-content {
            position: relative;
            z-index: 1;
        }

        .info-section h1 {
            font-size: 2.5rem;
            margin-bottom: 1.5rem;
            position: relative;
        }

        .info-section h1:after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 80px;
            height: 4px;
            background-color: var(--accent);
        }

        .info-section p {
            margin-bottom: 1.5rem;
            line-height: 1.6;
            font-size: 1.1rem;
        }

        .benefits-list {
            margin: 1.5rem 0;
        }

        .benefits-list li {
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
        }

        .benefits-list i {
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
            font-size: 2rem;
            font-weight: bold;
            display: block;
        }

        .stat-label {
            font-size: 0.9rem;
        }

        .form-section {
            flex: 1;
            padding: 3rem;
            overflow-y: auto;
            max-height: 90vh;
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

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--text);
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
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

        .form-row {
            display: flex;
            gap: 1rem;
        }

        .form-row .form-group {
            flex: 1;
        }

        .password-strength {
            height: 5px;
            background-color: #eee;
            border-radius: 5px;
            margin-top: 5px;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0%;
            transition: width 0.3s ease, background-color 0.3s ease;
        }

        .password-match {
            margin-top: 5px;
            font-size: 0.9rem;
            display: none;
        }

        .password-match.valid {
            color: var(--success);
            display: block;
        }

        .password-match.invalid {
            color: var(--primary);
            display: block;
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

        .btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .login-link {
            text-align: center;
            margin-top: 1.5rem;
            color: var(--text-light);
        }

        .login-link a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .form-footer {
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid #eee;
            text-align: center;
            color: var(--text-light);
            font-size: 0.9rem;
        }

        .requirement-list {
            margin-top: 1rem;
            padding: 1rem;
            background-color: rgba(198, 40, 40, 0.05);
            border-radius: 8px;
            border-left: 4px solid var(--primary);
        }

        .requirement-list h4 {
            color: var(--primary);
            margin-bottom: 0.5rem;
        }

        .requirement-list ul {
            padding-left: 1.5rem;
        }

        .requirement-list li {
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }

        @media (max-width: 900px) {
            .container {
                flex-direction: column;
            }
            
            .info-section, .form-section {
                padding: 2rem;
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
        <div class="info-section">
            <div class="info-content">
                <h1>Become a Lifesaver</h1>
                <p>Join our community of heroes who donate blood to save lives. Your single donation can help up to three people in need.</p>
                
                <ul class="benefits-list">
                    <li><i class="fas fa-check-circle"></i> Free health screening with every donation</li>
                    <li><i class="fas fa-check-circle"></i> Refreshments and post-donation care</li>
                    <li><i class="fas fa-check-circle"></i> Blood type testing and donor card</li>
                    <li><i class="fas fa-check-circle"></i> Track your donation history and impact</li>
                    <li><i class="fas fa-check-circle"></i> Join a community that saves lives</li>
                </ul>
                
                <div class="stats">
                    <div class="stat-item">
                        <span class="stat-number">1M+</span>
                        <span class="stat-label">Lives Saved</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">50K+</span>
                        <span class="stat-label">Active Donors</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">100+</span>
                        <span class="stat-label">Partner Hospitals</span>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="form-section">
            <div class="form-header">
                <h2>Donor Registration</h2>	
                <p>Create your account to start saving lives</p>
            </div>
            
            <form action="Donorreg" method="post" class="register-form" id="donorForm">
                <div class="form-row">
                    <div class="form-group">
                        <label for="name">Full Name</label>
                        <input type="text" id="name" name="name" class="form-control" placeholder="Enter your full name" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" name="email" class="form-control" placeholder="Enter your email address" required>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="age">Age</label>
                        <input type="number" id="age" name="age" class="form-control" placeholder="Your age" min="18" max="65" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="bloodGroup">Blood Group</label>
                        <select id="bloodGroup" name="bloodGroup" class="form-control" required>
                            <option value="">Select Blood Group</option>
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
                </div>
                
                <div class="form-group">
                    <label for="medicalHistory">Past Medical Issues</label>
                    <textarea id="medicalHistory" name="medicalHistory" class="form-control" placeholder="Please mention any past medical conditions, surgeries, or current medications" rows="3"></textarea>
                    <small style="color: var(--text-light);">This information helps us ensure your safety as a donor.</small>
                </div>
                
                 <div class="form-group">
                    <label for="location">Mobile Number</label>
                    <input type="text" id="location" name="mobile" class="form-control" placeholder="Enter Mobile Number" required>
                </div>
                
                <div class="form-group">
                    <label for="location">Address</label>
                    <input type="text" id="location" name="address" class="form-control" placeholder="Enter Detailed Address" required>
                </div>
                
                <div class="form-group">
                    <label for="location">Location</label>
                    <input type="text" id="location" name="location" class="form-control" placeholder="City, State" required>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" class="form-control" placeholder="Create a secure password" required>
                        <div class="password-strength">
                            <div class="password-strength-bar" id="passwordStrengthBar"></div>
                        </div>
                    </div>

                </div>
                
                <div class="requirement-list">
                    <h4>Donor Eligibility Requirements</h4>
                    <ul>
                        <li>Must be between 18 and 65 years old</li>
                        <li>Must weigh at least 50 kg (110 lbs)</li>
                        <li>Should be in good general health</li>
                        <li>Should not have donated blood in the last 3 months</li>
                    </ul>
                </div>
                
                <button type="submit" class="btn">Register as Donor</button>
            </form>
            
            <div class="login-link">
                Already have an account? <a href="donorlogin.jsp">Sign In</a>
            </div>
            
           
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const passwordInput = document.getElementById('password');
            const passwordStrengthBar = document.getElementById('passwordStrengthBar');
            const passwordMatchMessage = document.getElementById('passwordMatchMessage');
            const donorForm = document.getElementById('donorForm');
            
           
            passwordInput.addEventListener('input', function() {
                const password = this.value;
                let strength = 0;
                
                
                if (password.length >= 8) strength += 25;
                
                
                if (/[a-z]/.test(password)) strength += 25;
                
                
                if (/[A-Z]/.test(password)) strength += 25;
                
               
                if (/[0-9]/.test(password) || /[^A-Za-z0-9]/.test(password)) strength += 25;
                
              
                passwordStrengthBar.style.width = strength + '%';
                
               
                if (strength < 50) {
                    passwordStrengthBar.style.backgroundColor = '#f44336'; 
                } else if (strength < 75) {
                    passwordStrengthBar.style.backgroundColor = '#ff9800'; 
                } else {
                    passwordStrengthBar.style.backgroundColor = '#4caf50'; 
                }
            });
            
     
           
            donorForm.addEventListener('submit', function(e) {
                const password = passwordInput.value;
                const confirmPassword = confirmPasswordInput.value;
                const age = document.getElementById('age').value;
                
                
                if (password !== confirmPassword) {
                    e.preventDefault();
                    alert('Passwords do not match. Please check and try again.');
                    return;
                }
                
                
                if (age < 18 || age > 65) {
                    e.preventDefault();
                    alert('You must be between 18 and 65 years old to donate blood.');
                    return;
                }
                
               
            });
        });
    </script>
</body>
</html>