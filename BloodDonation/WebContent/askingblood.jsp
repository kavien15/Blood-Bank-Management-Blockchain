<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Blood Request Form - Blood Bank</title>
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
        font-family: 'Inter', 'Segoe UI', system-ui, -apple-system, sans-serif;
    }

    body {
        background: linear-gradient(135deg, #fef2f2 0%, #f8fafc 100%);
        min-height: 100vh;
        padding: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
    }

    
    .back-button {
        position: absolute;
        top: 30px;
        left: 30px;
        background: var(--white);
        color: var(--primary-red);
        border: 2px solid var(--primary-red);
        padding: 12px 25px;
        border-radius: 10px;
        font-size: 0.9rem;
        font-weight: 600;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 8px;
        text-decoration: none;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        z-index: 100;
    }

    .back-button:hover {
        background: var(--primary-red);
        color: var(--white);
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(220, 38, 38, 0.3);
        text-decoration: none;
    }

    
    .blood-pattern {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-image: 
            radial-gradient(circle at 20% 30%, rgba(220, 38, 38, 0.03) 2px, transparent 0),
            radial-gradient(circle at 80% 70%, rgba(220, 38, 38, 0.03) 2px, transparent 0);
        background-size: 60px 60px;
        pointer-events: none;
        z-index: -1;
    }

    .form-container {
        background: var(--white);
        border-radius: 20px;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        width: 100%;
        max-width: 800px;
        border: 1px solid var(--border-light);
        margin-top: 20px;
    }

   
    .form-header {
        background: linear-gradient(135deg, var(--primary-red), var(--dark-red));
        color: var(--white);
        padding: 40px;
        text-align: center;
        position: relative;
        overflow: hidden;
    }

    .form-header::before {
        content: '';
        position: absolute;
        top: -50%;
        left: -50%;
        width: 200%;
        height: 200%;
        background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
        background-size: 20px 20px;
    }

    .header-icon {
        width: 80px;
        height: 80px;
        background: rgba(255, 255, 255, 0.2);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 20px;
        border: 2px solid rgba(255, 255, 255, 0.3);
    }

    .header-icon i {
        font-size: 2.5rem;
        color: var(--light-red);
    }

    .form-header h1 {
        font-size: 2.2rem;
        font-weight: 700;
        margin-bottom: 10px;
    }

    .form-header p {
        font-size: 1.1rem;
        opacity: 0.9;
    }

    
    .form-content {
        padding: 40px;
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

    .form-label {
        display: block;
        margin-bottom: 8px;
        color: var(--dark-gray);
        font-weight: 600;
        font-size: 0.9rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .form-label i {
        color: var(--primary-red);
        margin-right: 8px;
        width: 16px;
    }

    .form-input, .form-select {
        width: 100%;
        padding: 14px 16px;
        border: 2px solid var(--border-light);
        border-radius: 10px;
        font-size: 1rem;
        background: var(--white);
        transition: all 0.3s ease;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    }

    .form-input:focus, .form-select:focus {
        outline: none;
        border-color: var(--primary-red);
        box-shadow: 0 4px 15px rgba(220, 38, 38, 0.15);
        transform: translateY(-2px);
    }

    .form-select {
        appearance: none;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%23dc2626'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'%3E%3C/path%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: right 16px center;
        background-size: 16px;
    }

    .full-width {
        grid-column: 1 / -1;
    }

    .form-section {
        background: var(--light-bg);
        border-radius: 12px;
        padding: 25px;
        margin-bottom: 25px;
        border-left: 4px solid var(--primary-red);
    }

    .section-title {
        font-size: 1.2rem;
        font-weight: 600;
        color: var(--dark-gray);
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .section-title i {
        color: var(--primary-red);
    }

    
    .submit-section {
        text-align: center;
        margin-top: 30px;
        display: flex;
        gap: 15px;
        justify-content: center;
        flex-wrap: wrap;
    }

    .submit-button {
        background: linear-gradient(135deg, var(--primary-red), var(--secondary-red));
        color: var(--white);
        border: none;
        padding: 16px 40px;
        border-radius: 12px;
        font-size: 1.1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 12px;
        box-shadow: 0 8px 25px rgba(220, 38, 38, 0.3);
    }

    .submit-button:hover {
        background: linear-gradient(135deg, var(--secondary-red), var(--primary-red));
        transform: translateY(-3px);
        box-shadow: 0 12px 30px rgba(220, 38, 38, 0.4);
    }

    .cancel-button {
        background: transparent;
        color: var(--text-gray);
        border: 2px solid var(--border-light);
        padding: 16px 40px;
        border-radius: 12px;
        font-size: 1.1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 12px;
        text-decoration: none;
    }

    .cancel-button:hover {
        background: var(--light-bg);
        color: var(--dark-gray);
        transform: translateY(-3px);
        text-decoration: none;
    }

   
    .emergency-notice {
        background: #fef2f2;
        border: 1px solid var(--light-red);
        border-radius: 10px;
        padding: 20px;
        margin-bottom: 25px;
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .emergency-icon {
        width: 50px;
        height: 50px;
        background: var(--primary-red);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--white);
        font-size: 1.2rem;
        flex-shrink: 0;
    }

    .emergency-text h3 {
        color: var(--dark-red);
        font-size: 1rem;
        margin-bottom: 5px;
    }

    .emergency-text p {
        color: var(--text-gray);
        font-size: 0.9rem;
    }

   
    @media (max-width: 768px) {
        .back-button {
            top: 15px;
            left: 15px;
            padding: 10px 20px;
            font-size: 0.8rem;
        }

        .form-grid {
            grid-template-columns: 1fr;
            gap: 20px;
        }

        .form-header {
            padding: 30px 20px;
        }

        .form-content {
            padding: 30px 20px;
        }

        .form-header h1 {
            font-size: 1.8rem;
        }

        .header-icon {
            width: 60px;
            height: 60px;
        }

        .header-icon i {
            font-size: 2rem;
        }

        .submit-section {
            flex-direction: column;
            align-items: center;
        }

        .submit-button, .cancel-button {
            width: 100%;
            max-width: 300px;
            justify-content: center;
        }
    }

    @media (max-width: 480px) {
        body {
            padding: 10px;
        }

        .form-header h1 {
            font-size: 1.5rem;
        }

        .emergency-notice {
            flex-direction: column;
            text-align: center;
        }

        .back-button {
            top: 10px;
            left: 10px;
            padding: 8px 15px;
        }
    }

   
    .form-input:invalid:not(:focus):not(:placeholder-shown) {
        border-color: #f87171;
    }

    .form-input:valid:not(:focus):not(:placeholder-shown) {
        border-color: #4ade80;
    }
</style>
</head>
<body>
   
    <a href="doctorhome.jsp" class="back-button">
        <i class="fas fa-arrow-left"></i>
        Back to Dashboard
    </a>

   
    <div class="blood-pattern"></div>

    <div class="form-container">
        
        <div class="form-header">
            <div class="header-icon">
                <i class="fas fa-hand-holding-medical"></i>
            </div>
            <h1>Blood Request Form</h1>
            <p>Life-Saving Blood Donation Request</p>
        </div>

       
        <div class="emergency-notice">
            <div class="emergency-icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            <div class="emergency-text">
                <h3>Emergency Blood Request</h3>
                <p>This form will notify available donors immediately. Please ensure all information is accurate.</p>
            </div>
        </div>

       
        <div class="form-content">
            <form id="bloodRequestForm" action="Askblood" method="post" enctype="multipart/form-data">
                <!-- Hospital Information -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-hospital"></i> Hospital Information
                    </h3>
                    <div class="form-grid">
                       
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-hospital"></i> Hospital Name
                            </label>
                            <input type="text" class="form-input" name="hospital" placeholder="Enter hospital name" required>
                        </div>
                    </div>
                </div>

               
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-user-injured"></i> Patient Information
                    </h3>
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-user"></i> Patient Name
                            </label>
                            <input type="text" class="form-input" name="name" placeholder="Enter patient full name" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-venus-mars"></i> Gender
                            </label>
                            <select class="form-select" name="gender" required>
                                <option value="">Select Gender</option>
                                <option value="male">Male</option>
                                <option value="female">Female</option>
                                <option value="other">Other</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-birthday-cake"></i> Age
                            </label>
                            <input type="number" class="form-input" name="age" placeholder="Enter age" min="1" max="120" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-tint"></i> Blood Group
                            </label>
                            <select class="form-select" name="bloodgroup" required>
                                <option value="">Select Blood Group</option>
                                <option value="O+">O+</option>
                                <option value="O-">O-</option>
                                <option value="A+">A+</option>
                                <option value="A-">A-</option>
                                <option value="B+">B+</option>
                                <option value="B-">B-</option>
                                <option value="AB+">AB+</option>
                                <option value="AB-">AB-</option>
                            </select>
                        </div>
                         <div class="file-upload">
                        <label class="file-upload-label">
                            <span>Upload Medical Documents</span>
                            <i class="fas fa-cloud-upload-alt"></i>
                        </label>
                        <input type="file" name="file" class="file-input" required>
                    </div>
                    </div>
                </div>

               
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-map-marker-alt"></i> Contact & Location
                    </h3>
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-envelope"></i> Email Address
                            </label>
                            <input type="email" class="form-input" name="email" placeholder="Enter email address" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-phone"></i> Mobile Number
                            </label>
                            <input type="tel" class="form-input" name="number" placeholder="Enter mobile number" required>
                        </div>
                        <div class="form-group full-width">
                            <label class="form-label">
                                <i class="fas fa-location-dot"></i> Full Address
                            </label>
                            <input type="text" class="form-input" name="address" placeholder="Enter complete address" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-city"></i> Location
                            </label>
                            <input type="text" class="form-input" name="location" placeholder="Enter city/location" required>
                        </div>
                    </div>
                </div>

              
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-hand-holding-heart"></i> Blood Requirements
                    </h3>
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-flask"></i> Required Component
                            </label>
                            <select class="form-select" name="bp" required>
                                <option value="">Select Component</option>
                                <option value="blood">Whole Blood</option>
                                <option value="plasma">Plasma</option>
                                <option value="platelets">Platelets</option>
                                <option value="redcells">Red Blood Cells</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-bell"></i> Notification Type
                            </label>
                            <select class="form-select" name="gmail" required>
                                <option value="">Select Recipients</option>
                                <option value="allusers">Emergency Alert (All)</option>
                                <option value="donors">Matched Donors</option>
                               
                            </select>
                        </div>
                    </div>
                </div>

               
                <div class="submit-section">
                    <button type="submit" class="submit-button">
                        <i class="fas fa-paper-plane"></i>
                        Submit Blood Request
                    </button>
                    <a href="doctormainpage.jsp" class="cancel-button">
                        <i class="fas fa-times"></i>
                        Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('bloodRequestForm');
            
            
            form.addEventListener('submit', function(e) {
                let isValid = true;
                const requiredFields = form.querySelectorAll('[required]');
                
                requiredFields.forEach(field => {
                    if (!field.value.trim()) {
                        isValid = false;
                        field.style.borderColor = '#f87171';
                    } else {
                        field.style.borderColor = '#4ade80';
                    }
                });

                if (!isValid) {
                    e.preventDefault();
                    alert('Please fill in all required fields.');
                }
            });

           
            const inputs = form.querySelectorAll('input, select');
            inputs.forEach(input => {
                input.addEventListener('input', function() {
                    if (this.value.trim()) {
                        this.style.borderColor = '#4ade80';
                    } else {
                        this.style.borderColor = '#e2e8f0';
                    }
                });
            });
            document.querySelector('.file-input').addEventListener('change', function(e) {
                const fileName = e.target.files[0] ? e.target.files[0].name : 'Upload Medical Documents';
                document.querySelector('.file-upload-label span').textContent = fileName;
            });
           
            const ageInput = form.querySelector('input[name="age"]');
            ageInput.addEventListener('blur', function() {
                const age = parseInt(this.value);
                if (age < 1 || age > 120) {
                    this.style.borderColor = '#f87171';
                    alert('Please enter a valid age between 1 and 120.');
                }
            });
        });
    </script>
</body>
</html>