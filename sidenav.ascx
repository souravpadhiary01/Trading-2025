<%@ Control Language="C#" AutoEventWireup="true" CodeFile="sidenav.ascx.cs" Inherits="sidenav" %>

<!-- Full-width Navbar -->
<div class="navbar">
    <img src="images/trading.jpg" alt="Logo" class="navbar-logo" />
    <a href="#logout" class="logout-btn">
        <img src="images/switch.png" alt="Logout" />
    </a>
</div>

<!-- External Toggle Button -->
<div class="toggle-btn" id="toggleBtn" onclick="toggleSidebar()">☰</div>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <!-- Close Button -->
    <div class="close-btn" id="closeBtn" onclick="toggleSidebar()">✖</div>

    <!-- Profile Section -->
    <div class="profile">
        <img src="images/profile.png" alt="Profile Photo" />
        <div class="profile-info">
            <h3>Johnny Cardoso</h3>
            <p>Client ID - 100025</p>
            <p>Joining Date - 08-04-2023</p>
        </div>
    </div>

    <!-- Sidebar Menu -->
    <ul class="sidebar-menu">
        <li><a href="#dashboard"><i class="icon">💻</i> Dashboard</a></li>
        <li><a href="#transactions"><i class="icon">💰</i> Transactions</a></li>
        <li><a href="#documents"><i class="icon">📄</i> My Documents</a></li>
        <li><a href="#profit-loss"><i class="icon">📊</i> Profit & Loss</a></li>
        <li><a href="#profile"><i class="icon">👤</i> Profile</a></li>
        <li><a href="#contact"><i class="icon">📞</i> Contact Us</a></li>
        <li><a href="#privacy"><i class="icon">🔒</i> Privacy Policy</a></li>
        <li><a href="#logout"><i class="fas fa-sign-out-alt"></i> Log Out</a></li>
    </ul>
</div>

<!-- Include Font Awesome (adjust the path if necessary) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />

<!-- Custom CSS Styling -->
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

  
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f0f0;
    }


    .navbar {
        width: 100%;
        padding: 10px;
        background-color: #46598d;
        display: flex;
        align-items: center;
        justify-content: center;
        position: fixed;
        top: 0;
        left: 0;
        color: #fff;
        z-index: 1;
        
    }

    .navbar-logo {
        width: 60px;
        height: 60px;
    }

    .logout-btn {
        position: absolute;
        right: 45px;
        top: 21px;
    }

    .logout-btn img {
        width: 35px;
        height: 35px;
        transition: transform 0.3s;
    }

  
    .logout-btn img:hover {
        transform: scale(1.1);
    }


.sidebar {
    position: fixed;
    width: 345px;
    height: 100%;
    background-color: #c8e3ff;
    color: #fff;
    transition: transform 0.3s ease;
    transform: translateX(-100%);
    display: flex;
    flex-direction: column;
    align-items: center;
    overflow-y: auto;
    padding-top: 0;
    z-index: 2;
    margin-top: 0px;
}

    .sidebar.active {
        transform: translateX(0);
    }

 
    .toggle-btn {
        position: fixed;
        top: 15px;
        left: 15px;
        font-size: 24px;
        cursor: pointer;
        color: #ffffff;
        z-index: 3;
    }

   
    .close-btn {
        position: absolute;
        top: 15px;
        right: 15px;
        font-size: 24px;
        cursor: pointer;
        color: #ffffff;
        display: none; / Initially hidden /
    }

   
    .profile {
        display: flex;
        align-items: center;
        text-align: left;
        padding: 15px;
        width: 100%;
        border-bottom: 1px solid #34495e;
        background-color: #46598d;
    }

    .profile img {
        width: 75px;
        height: 75px;
        border-radius: 50%;
        margin-right: 10px;
    }

    .profile-info h3, .profile-info p {
        margin: 5px 0;
    }
.profile-info h3 {
    font-size: 22px ;
    font-weight: 600;
}
.profile-info p {
    font-size: 16px;
    margin: 0;
    font-weight: 500;
}

    .sidebar-menu {
        list-style: none;
        padding: 0;
        width: 100%;
    }

    .sidebar-menu li {
        width: 100%;
        border-bottom: 2px solid #ffffff;
    }

    .sidebar-menu li a {
        display: flex;
        align-items: center;
        padding: 12px 8px 12px 25px;
        color: #000000;
        text-decoration: none;
        width: 100%;
    }

    .sidebar-menu li a:hover {
        background-color: #46598d;
        color: #ffffff;
    }

    / Menu Icons /
    .sidebar-menu li a i {
        font-size: 20px;
        margin-right: 15px;
    }


    @media (max-width: 768px) {
        .sidebar {
            width: 365px;
        }
    }
</style>

<script>
    function toggleSidebar() {
        const sidebar = document.getElementById("sidebar");
        const toggleBtn = document.getElementById("toggleBtn");
        const closeBtn = document.getElementById("closeBtn");

        sidebar.classList.toggle("active");
        toggleBtn.style.display = sidebar.classList.contains("active") ? 'none' : 'block';
        closeBtn.style.display = sidebar.classList.contains("active") ? 'block' : 'none';
    }
</script>