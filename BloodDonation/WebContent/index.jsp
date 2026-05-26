<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LifeStream Blood Bank</title>
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
            --card-bg: rgba(255, 255, 255, 0.9);
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
            flex-direction: column;
        }

        header {
            background-color: var(--primary);
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .logo i {
            font-size: 2rem;
        }

        .logo h1 {
            font-size: 1.8rem;
            font-weight: 600;
        }

        nav ul {
            display: flex;
            list-style: none;
            gap: 1.5rem;
        }

        nav a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            transition: all 0.3s ease;
        }

        nav a:hover {
            background-color: var(--primary-dark);
        }

        .hero {
            text-align: center;
            padding: 4rem 2rem;
            color: white;
            max-width: 800px;
            margin: 0 auto;
        }

        .hero h2 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }

        .hero p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        .cta-button {
            display: inline-block;
            background-color: var(--primary);
            color: white;
            padding: 0.8rem 2rem;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        .cta-button:hover {
            background-color: var(--primary-dark);
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
        }

        .dashboard {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }

        .card {
            background-color: var(--card-bg);
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card i {
            font-size: 3rem;
            color: var(--primary);
            margin-bottom: 1rem;
        }

        .card h3 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: var(--primary);
        }

        .card p {
            color: var(--text-light);
            margin-bottom: 1.5rem;
            line-height: 1.5;
        }

        .card-button {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 0.7rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 80%;
        }

        .card-button:hover {
            background-color: var(--primary-dark);
        }

        footer {
            background-color: rgba(33, 33, 33, 0.9);
            color: white;
            text-align: center;
            padding: 2rem;
            margin-top: auto;
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 2rem;
        }

        .footer-section {
            flex: 1;
            min-width: 250px;
        }

        .footer-section h3 {
            margin-bottom: 1rem;
            color: var(--accent);
        }

        .footer-section p {
            line-height: 1.6;
        }

        .social-icons {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 1rem;
        }

        .social-icons a {
            color: white;
            font-size: 1.5rem;
            transition: color 0.3s ease;
        }

        .social-icons a:hover {
            color: var(--accent);
        }

        .copyright {
            margin-top: 2rem;
            padding-top: 1rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        @media (max-width: 768px) {
            header {
                flex-direction: column;
                gap: 1rem;
            }
            
            nav ul {
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .hero h2 {
                font-size: 2rem;
            }
            
            .dashboard {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="logo">
            <i class="fas fa-tint"></i>
            <h1>LifeStream Blood Bank</h1>
        </div>
        <nav>
            <ul>
                <li><a href="donorlogin.jsp">Donor Portal</a></li>
                <li><a href="doctorlogin.jsp">Hospital Portal</a></li>
                <li><a href="ambulancelog.jsp">Ambulance Portal</a></li>
                <li><a href="adminlogin.jsp">Admin Portal</a></li>
                <li><a href="bloodbanklogin.jsp">Blood Bank</a></li>
               
            </ul>
        </nav>
    </header>

    <section class="hero">
        <h2>Donate Blood, Save Lives</h2>
        <p>Join our mission to ensure a stable blood supply for patients in need. Every donation can save up to three lives. Become a hero today!</p>
        <a href="donorlogin.jsp" class="cta-button">Become a Donor</a>
    </section>

    <main class="dashboard">
        <div class="card">
            <i class="fas fa-user-plus"></i>
            <h3>For Donors</h3>
            <p>Register as a blood donor, schedule appointments, and track your donation history. Your contribution makes a difference.</p>
            <a href="donorlogin.jsp" class="card-button">Donor Login</a>
        </div> 
        <div class="card">
            <i class="fas fa-hospital"></i>
            <h3>For Hospitals</h3>
            <p>Access our blood inventory, request blood units, and manage patient blood requirements efficiently.</p>
            <a href="doctorlogin.jsp" class="card-button">Hospital Login</a>
        </div>
        
        <div class="card">
            <i class="fas fa-ambulance"></i>
            <h3>Ambulance Services</h3>
            <p>Coordinate emergency blood transport, manage ambulance requests, and ensure timely delivery to hospitals.</p>
            <a href="ambulancelog.jsp" class="card-button">Ambulance Login</a>
        </div>
        
        <div class="card">
            <i class="fas fa-cogs"></i>
            <h3>Administration</h3>
            <p>Manage blood inventory, donor records, and coordinate with hospitals to ensure seamless operations.</p>
            <a href="adminlogin.jsp" class="card-button">Admin Login</a>
        </div>
    </main>

    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3>About LifeStream</h3>
                <p>We are a non-profit organization dedicated to maintaining a safe and adequate blood supply for our community through voluntary donations.</p>
            </div>
            
           
        </div>
       
    </footer>
</body>
</html>