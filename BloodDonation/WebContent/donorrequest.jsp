<%@page import="java.sql.*"%>
<%@page import="dbcon.Dbcon"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Raise Blood Request - LifeBlood Bank</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        :root {
            --primary-red: #c8102e;
            --dark-red: #a50e26;
            --light-red: #fde8ea;
            --secondary-color: #2c3e50;
            --light-gray: #f8f9fa;
            --medium-gray: #e9ecef;
            --dark-gray: #6c757d;
            --white: #ffffff;
            --glass-bg: rgba(255, 255, 255, 0.1);
            --glass-border: rgba(255, 255, 255, 0.2);
        }

        body {
            background: linear-gradient(
  135deg,
  rgba(255, 0, 0, 0.2) 0%,
  rgba(255, 0, 0, 0.2) 100%
);
	
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
        }

       
        .bg-elements {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            overflow: hidden;
        }

        .bg-circle {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            animation: float 6s ease-in-out infinite;
        }

        .circle-1 {
            width: 200px;
            height: 200px;
            top: 10%;
            left: 10%;
            animation-delay: 0s;
        }

        .circle-2 {
            width: 150px;
            height: 150px;
            top: 60%;
            right: 10%;
            animation-delay: 2s;
        }

        .circle-3 {
            width: 100px;
            height: 100px;
            bottom: 20%;
            left: 20%;
            animation-delay: 4s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        .container {
            width: 100%;
            max-width: 800px;
            margin: 0 auto;
        }

        .form-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            border: 1px solid var(--glass-border);
            position: relative;
            overflow: hidden;
        }

        .form-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--primary-red), var(--dark-red));
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
        }

        .logo {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
            margin-bottom: 15px;
        }

        .logo i {
            font-size: 3rem;
            color: var(--primary-red);
            filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.2));
        }

        .logo h1 {
            font-size: 2.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, var(--primary-red), var(--dark-red));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .tagline {
            color: var(--secondary-color);
            font-size: 1.1rem;
            font-weight: 300;
            opacity: 0.8;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--secondary-color);
            font-size: 0.95rem;
        }

        .input-group {
            position: relative;
        }

        input, select {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid var(--medium-gray);
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: var(--white);
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }

        input:focus, select:focus {
            border-color: var(--primary-red);
            outline: none;
            box-shadow: 0 0 0 3px rgba(200, 16, 46, 0.1);
            transform: translateY(-2px);
        }

        .input-icon {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--dark-gray);
        }

        .radio-group {
            display: flex;
            gap: 20px;
            margin-top: 5px;
        }

        .radio-option {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
        }

        .radio-option input[type="radio"] {
            width: auto;
            margin: 0;
        }

        .request-type-selector {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-top: 5px;
        }

        .type-option {
            position: relative;
            cursor: pointer;
        }

        .type-option input {
            display: none;
        }

        .type-card {
            background: var(--white);
            border: 2px solid var(--medium-gray);
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            transition: all 0.3s ease;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
        }

        .type-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .type-option input:checked + .type-card {
            border-color: var(--primary-red);
            background: var(--light-red);
            box-shadow: 0 5px 15px rgba(200, 16, 46, 0.2);
        }

        .type-icon {
            font-size: 2.5rem;
            margin-bottom: 10px;
            color: var(--primary-red);
        }

        .type-name {
            font-weight: 600;
            color: var(--secondary-color);
            margin-bottom: 5px;
        }

        .type-desc {
            font-size: 0.85rem;
            color: var(--dark-gray);
        }

        .btn-submit {
            width: 100%;
            padding: 18px;
            background: linear-gradient(135deg, var(--primary-red), var(--dark-red));
            color: var(--white);
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(200, 16, 46, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(200, 16, 46, 0.4);
            background: linear-gradient(135deg, var(--dark-red), #8a0b20);
        }

        .btn-submit:active {
            transform: translateY(-1px);
        }

        .emergency-notice {
            background: linear-gradient(135deg, #fff3cd, #ffeaa7);
            border: 1px solid #ffd43b;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 25px;
            text-align: center;
        }

        .emergency-notice i {
            color: #e74c3c;
            margin-right: 8px;
        }

        .footer-links {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--medium-gray);
        }

        .footer-links a {
            color: var(--primary-red);
            text-decoration: none;
            font-weight: 500;
            margin: 0 10px;
            transition: color 0.3s ease;
        }

        .footer-links a:hover {
            color: var(--dark-red);
            text-decoration: underline;
        }

        
        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .form-card {
                padding: 30px 25px;
            }

            .logo h1 {
                font-size: 2rem;
            }

            .request-type-selector {
                grid-template-columns: 1fr;
            }

            .radio-group {
                flex-direction: column;
                gap: 10px;
            }
        }

        @media (max-width: 480px) {
            body {
                padding: 10px;
            }

            .form-card {
                padding: 25px 20px;
            }

            .logo {
                flex-direction: column;
                gap: 10px;
            }

            .logo h1 {
                font-size: 1.8rem;
            }
        }

        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-group {
            animation: fadeInUp 0.6s ease-out;
        }

        .form-group:nth-child(1) { animation-delay: 0.1s; }
        .form-group:nth-child(2) { animation-delay: 0.2s; }
        .form-group:nth-child(3) { animation-delay: 0.3s; }
        .form-group:nth-child(4) { animation-delay: 0.4s; }
        .form-group:nth-child(5) { animation-delay: 0.5s; }
        .form-group:nth-child(6) { animation-delay: 0.6s; }
    </style>
</head>
<body>
    
    <div class="bg-elements">
        <div class="bg-circle circle-1"></div>
        <div class="bg-circle circle-2"></div>
        <div class="bg-circle circle-3"></div>
    </div>

    <div class="container">
        <div class="form-card">
            <div class="header">
                <div class="logo">
                    <i class="fas fa-tint"></i>
                    <h1>LifeStream Blood Bank</h1>
                </div>
                <p class="tagline">Raise Blood/Plasma Request - Save Lives</p>
            </div>

            <div class="emergency-notice">
                <i class="fas fa-exclamation-circle"></i>
                <strong>Emergency Request?</strong> Call our 24/7 helpline: <strong>+1-800-LIFEBLOOD</strong>
            </div>

            <form action="DonorBloodRequest" method="post" enctype="multipart/form-data">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="name"><i class="fas fa-user"></i> Patient Name</label>
                        <div class="input-group">
                            <input type="text" id="name" name="name" placeholder="Enter patient full name" required>
                            <i class="fas fa-user input-icon"></i>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email"><i class="fas fa-envelope"></i> Patient Email</label>
                        <div class="input-group">
                            <input type="email" id="email" name="email" placeholder="patient@example.com" required>
                            <i class="fas fa-envelope input-icon"></i>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="mobile"><i class="fas fa-phone"></i> Mobile Number</label>
                        <div class="input-group">
                            <input type="text" id="mobile" name="mobile" placeholder="+1 (555) 123-4567" required>
                            <i class="fas fa-phone input-icon"></i>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="age"><i class="fas fa-birthday-cake"></i> Age</label>
                        <div class="input-group">
                            <input type="number" id="age" name="age" placeholder="Enter age" min="1" max="120">
                            <i class="fas fa-birthday-cake input-icon"></i>
                        </div>
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-venus-mars"></i> Gender</label>
                        <div class="radio-group">
                            <label class="radio-option">
                                <input type="radio" name="gender" value="Male">
                                Male
                            </label>
                            <label class="radio-option">
                                <input type="radio" name="gender" value="Female">
                                Female
                            </label>
                            <label class="radio-option">
                                <input type="radio" name="gender" value="Other">
                                Other
                            </label>
                        </div>
                    </div>

                   

                    <div class="form-group">
                        <label for="bloodgroup"><i class="fas fa-tint"></i> Blood Group</label>
                        <div class="input-group">
                            <select id="bloodgroup" name="bloodgroup" required>
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
                            <i class="fas fa-tint input-icon"></i>
                        </div>
                        <div class="file-upload">
                        <label class="file-upload-label">
                            <span>Upload Medical Documents</span>
                            <i class="fas fa-cloud-upload-alt"></i>
                        </label>
                        <input type="file" name="file" class="file-input" required>
                    </div>
                    </div>

                    <div class="form-group full-width">
                        <label><i class="fas fa-hand-holding-medical"></i> Request Type</label>
                        <div class="request-type-selector">
                            <label class="type-option">
                                <input type="radio" name="type" value="Blood" checked>
                                <div class="type-card">
                                    <div class="type-icon">
                                        <i class="fas fa-tint"></i>
                                    </div>
                                    <div class="type-name">Whole Blood</div>
                                    <div class="type-desc">For surgeries, trauma, anemia</div>
                                </div>
                            </label>
                            <label class="type-option">
                                <input type="radio" name="type" value="Plasma">
                                <div class="type-card">
                                    <div class="type-icon">
                                        <i class="fas fa-vial"></i>
                                    </div>
                                    <div class="type-name">Blood Plasma</div>
                                    <div class="type-desc">For burns, liver disease, immunity</div>
                                </div>
                            </label>
                        </div>
                    </div>
                </div>

                <button type="submit" class="btn-submit">
                    <i class="fas fa-paper-plane"></i>
                    Submit Request
                </button>
            </form>

            <div class="footer-links">
                <a href="donorhome.jsp"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
                
            </div>
        </div>
    </div>

    <script>
        
        document.addEventListener('DOMContentLoaded', function() {
            
            const formGroups = document.querySelectorAll('.form-group');
            formGroups.forEach((group, index) => {
                group.style.animationDelay = `${index * 0.1}s`;
            });

            
            const inputs = document.querySelectorAll('input, select');
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.classList.add('focused');
                });
                
                input.addEventListener('blur', function() {
                    this.parentElement.classList.remove('focused');
                });
            });

            document.querySelector('.file-input').addEventListener('change', function(e) {
                const fileName = e.target.files[0] ? e.target.files[0].name : 'Upload Medical Documents';
                document.querySelector('.file-upload-label span').textContent = fileName;
            });
            
            const form = document.querySelector('form');
            form.addEventListener('submit', function(e) {
                let isValid = true;
                const requiredFields = form.querySelectorAll('[required]');
                
                requiredFields.forEach(field => {
                    if (!field.value.trim()) {
                        isValid = false;
                        field.style.borderColor = 'var(--danger)';
                    } else {
                        field.style.borderColor = '';
                    }
                });

                if (!isValid) {
                    e.preventDefault();
                    alert('Please fill in all required fields.');
                }
            });
        });
    </script>
</body>
</html>