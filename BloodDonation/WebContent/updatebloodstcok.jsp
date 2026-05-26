<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Bank Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Roboto', sans-serif;
        }
        
        body {
            background-color: #f9f9f9;
            color: #333;
            line-height: 1.6;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        header {
            background: linear-gradient(to right, #c8102e, #e53935);
            color: white;
            padding: 1rem 0;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .logo i {
            font-size: 2.5rem;
        }
        
        .logo h1 {
            font-size: 1.8rem;
            font-weight: 700;
        }
        
        .tagline {
            font-size: 1rem;
            font-weight: 300;
            opacity: 0.9;
        }
        
        .main-content {
            display: flex;
            min-height: calc(100vh - 140px);
        }
        
        .sidebar {
            width: 250px;
            background-color: white;
            padding: 2rem 1rem;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.05);
        }
        
        .sidebar ul {
            list-style: none;
        }
        
        .sidebar li {
            margin-bottom: 10px;
        }
        
        .sidebar a {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 15px;
            color: #555;
            text-decoration: none;
            border-radius: 5px;
            transition: all 0.3s ease;
        }
        
        .sidebar a:hover, .sidebar a.active {
            background-color: #ffeaea;
            color: #c8102e;
        }
        
        .content {
            flex: 1;
            padding: 2rem;
        }
        
        .card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 2rem;
            margin-bottom: 2rem;
        }
        
        .card-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #eee;
        }
        
        .card-header i {
            color: #c8102e;
            font-size: 1.5rem;
        }
        
        .card-header h2 {
            color: #c8102e;
            font-size: 1.5rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #555;
        }
        
        input, select {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            transition: border 0.3s ease;
        }
        
        input:focus, select:focus {
            border-color: #c8102e;
            outline: none;
            box-shadow: 0 0 0 2px rgba(200, 16, 46, 0.2);
        }
        
        .form-row {
            display: flex;
            gap: 20px;
        }
        
        .form-row .form-group {
            flex: 1;
        }
        
        .btn {
            display: inline-block;
            background: linear-gradient(to right, #c8102e, #e53935);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
        }
        
        .btn:hover {
            background: linear-gradient(to right, #b00e28, #d32f2f);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(200, 16, 46, 0.3);
        }
        
        .btn i {
            margin-right: 8px;
        }
        
        footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 1.5rem 0;
            margin-top: 2rem;
        }
        
        .footer-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .social-links {
            display: flex;
            gap: 15px;
        }
        
        .social-links a {
            color: white;
            font-size: 1.2rem;
            transition: color 0.3s ease;
        }
        
        .social-links a:hover {
            color: #c8102e;
        }
        
        @media (max-width: 768px) {
            .main-content {
                flex-direction: column;
            }
            
            .sidebar {
                width: 100%;
            }
            
            .form-row {
                flex-direction: column;
                gap: 0;
            }
            
            .footer-content {
                flex-direction: column;
                gap: 15px;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <div class="header-content">
                <div class="logo">
                    <i class="fas fa-tint"></i>
                    <div>
                        <h1>LifeStream Blood Bank</h1>
                        <div class="tagline">Donate Blood, Save Lives</div>
                    </div>
                </div>
                <div class="header-actions">
                 <a href="bloodbankdashboard.jsp"> <button class="btn">	<i class="fas fa-arrow-left"></i> Go Back</button></a> 
                </div>
            </div>
        </div>
    </header>
    
    <div class="container">
        <div class="main-content">
        <main class="content">
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-tint"></i>
                        <h2>Blood Donation Entry</h2>
                    </div>
                    
                    <form action="BloodDetails" method="post">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="donorname"><i class="fas fa-user"></i> Donor Name</label>
                                <input type="text" id="donorname" name="donorname" placeholder="Enter donor name" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="bloodgroup"><i class="fas fa-tint"></i> Blood Group</label>
                                <select id="bloodgroup" name="bloodgroup" required>
                                    <option value="">-- Select Blood Group --</option>
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
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="quantity"><i class="fas fa-weight"></i> Quantity (ml)</label>
                                <input type="number" id="quantity" name="quantity" placeholder="Enter quantity in ml" min="1" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="date"><i class="fas fa-calendar-alt"></i> Donation Date</label>
                                <input type="date" id="date" name="date" required>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="location"><i class="fas fa-map-marker-alt"></i> Location</label>
                            <input type="text" id="location" name="location" placeholder="Enter donation location" required>
                        </div>
                        
                        <button type="submit" class="btn"><i class="fas fa-save"></i> Submit Donation</button>
                    </form>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-info-circle"></i>
                        <h2>Blood Donation Guidelines</h2>
                    </div>
                    <ul style="padding-left: 20px; margin-top: 10px;">
                        <li>Donors must be at least 17 years old and weigh at least 110 pounds.</li>
                        <li>Bring a valid ID with photo and proof of age.</li>
                        <li>Eat a healthy meal and drink plenty of fluids before donating.</li>
                        <li>Avoid fatty foods before donation as they can affect blood tests.</li>
                        <li>Get a good night's sleep before your donation.</li>
                    </ul>
                </div>
            </main>
        </div>
    </div>
    
   

    <script>
       
        document.getElementById('date').valueAsDate = new Date();
        
        
        document.querySelector('form').addEventListener('submit', function(e) {
            const donorName = document.getElementById('donorname').value;
            const bloodGroup = document.getElementById('bloodgroup').value;
            const quantity = document.getElementById('quantity').value;
            const date = document.getElementById('date').value;
            const location = document.getElementById('location').value;
            
            if (!donorName || !bloodGroup || !quantity || !date || !location) {
                e.preventDefault();
                alert('Please fill in all required fields.');
                return false;
            }
            
            if (quantity < 1) {
                e.preventDefault();
                alert('Quantity must be at least 1 ml.');
                return false;
            }
            
           
            return true;
        });
    </script>
</body>
</html>