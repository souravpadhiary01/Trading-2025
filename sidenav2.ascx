<%@ Control Language="C#" AutoEventWireup="true" CodeFile="sidenav2.ascx.cs" Inherits="sidenav2" %>


<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>


<style>
  body {
    margin: 0;
    font-family: 'Arial', sans-serif;
    height: 100vh;
    background-color: #e8f0f2;
  }

  .sidebar {
    width: 60px;
    background: #234168;
    color: white;
    transition: width 0.3s;
    overflow-x: hidden;
    display: flex;
    flex-direction: column;
    align-items: center;
    box-shadow: 2px 0 10px rgba(0, 0, 0, 0.2);
    position: relative;
  }

  .sidebar.open {
    width: 260px;
  }

  .sidebar-header {
    font-size: 18px;
    text-align: left;
    padding: 15px;
    background-color: rgb(35, 65, 104);
    font-weight: bold;
    color: #fff;
    width: 100%;
    position: relative;
    height: 52px;
    margin-top: 1px;
    margin-left: 35px;
  }

  .sidebar-header span {
    background-color: #25273a;
    padding: 10px;
    border: 1px solid #afafaf;
    border-radius: 7px;
  }

  .sidebar:not(.open) .company-name {
    display: none;
  }

  .toggle-btn {
    background-color: transparent;
    border: none;
    color: white;
    font-size: 20px;
    cursor: pointer;
    position: absolute;
    right: 35px !important;
    top: 13px;
    transition: transform 0.3s;
  }

  .menu-item {
    padding: 15px;
    display: flex;
    align-items: center;
    cursor: pointer;
    color: white;
    transition: background 0.3s, color 0.3s;
    text-decoration: none;
    font-size: 16px;
    width: 100%;
    position: relative;
  }

  .menu-item:hover {
    background-color: rgba(255, 255, 255, 0.1);
    color: #e0e0e0;
    transform: scale(1.05);
  }

  .menu-icon {
    font-size: 18px;
    transition: color 0.3s;
  }

  .menu-item:nth-child(2) .menu-icon { color: #f29b34; }
  .menu-item:nth-child(3) .menu-icon { color: #5fd1e5; }
  .menu-item:nth-child(4) .menu-icon { color: #fd5e53; }
  .menu-item:nth-child(5) .menu-icon { color: #62c370; }
  .menu-item:nth-child(6) .menu-icon { color: #fcaf58; }
  .menu-item:nth-child(7) .menu-icon { color: #ad5fd5; }

  .menu-text {
    opacity: 0;
    max-width: 0;
    overflow: hidden;
    white-space: nowrap;
    transition: opacity 0.3s, max-width 0.3s;
  }

  .sidebar.open .menu-text {
    opacity: 1;
    max-width: 150px;
    margin-left: 10px;
  }

  .submenu {
    display: none;
    flex-direction: column;
    padding-left: 20px;
    width: 100%;
  }

  .submenu-item {
    padding: 8px 20px;
    color: #c0c0c0;
    text-decoration: none;
    font-size: 14px;
    display: block;
  }

  .submenu-item:hover {
    background-color: rgba(255, 255, 255, 0.1);
    color: #e0e0e0;
  }

.navbar {
    position: fixed;
    top: 0;
    left: 60px;
    height: 60px;
    background-color: #234168;
    display: flex;
    align-items: center;
    padding: 0 20px;
    width: calc(100% - 60px);
    transition: left 0.3s, width 0.3s;
    z-index: 1;
}

  .search-box {
    flex-grow: 1;
    display: flex;
    justify-content: left;
    align-items: center;
  }

  .search-input {
    width: 300px;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 12px;
    outline: none;
  }

  .profile-photo {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    margin-left: 20px;
  }

  .content {
    flex-grow: 1;
    padding: 20px;
    transition: margin-left 0.3s;
    margin-top: 60px;
    overflow-y: auto;
  }

  .sidebar.open ~ .navbar {
    left: 260px;
    width: calc(100% - 260px);
  }

  ::-webkit-scrollbar {
    width: 10px;
  }

  ::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 10px;
  }

  ::-webkit-scrollbar-thumb {
    background-color: #234168;
    border-radius: 10px;
    border: 2px solid #f1f1f1;
  }

  ::-webkit-scrollbar-thumb:hover {
    background-color: #1a3050;
  }



    body {
    margin: 0;
    font-family: 'Arial', sans-serif;
    background-color: #e8f0f2;
    overflow-x: hidden;
  }

.sidebar {
    position: fixed;
    top: 0;
    left: 0;
    height: 100vh;
    width: 60px;
    background: #234168;
    color: white;
    transition: width 0.3s;
    overflow-x: hidden;
    display: flex;
    flex-direction: column;
    align-items: center;
    box-shadow: 2px 0 10px rgba(0, 0, 0, 0.2);
    z-index: 1;
}

  .sidebar.open {
    width: 260px;
  }

  .sidebar-header {
    font-size: 18px;
    text-align: left;
    padding: 15px;
    background-color: rgb(35, 65, 104);
    font-weight: bold;
    color: #fff;
    width: 100%;
    position: relative;
  }

  .toggle-btn {
    background-color: transparent;
    border: none;
    color: white;
    font-size: 20px;
    cursor: pointer;
    position: absolute;
    right: 10px;
    top: 15px;
  }

  .menu-item {
    padding: 15px;
    display: flex;
    align-items: center;
    color: white;
    text-decoration: none;
    font-size: 16px;
    width: 100%;
    transition: background 0.3s;
  }

  .menu-item:hover {
    background-color: rgba(255, 255, 255, 0.1);
  }

  .menu-icon {
    font-size: 18px;
  }

  .menu-text {
    opacity: 0;
    max-width: 0;
    overflow: hidden;
    white-space: nowrap;
    transition: opacity 0.3s, max-width 0.3s;
    margin-left: 10px;
  }

  .sidebar.open .menu-text {
    opacity: 1;
    max-width: 150px;
  }

  .submenu {
    display: none;
    flex-direction: column;
    padding-left: 20px;
    width: 100%;
  }

  .submenu-item {
    padding: 8px 20px;
    color: #c0c0c0;
    font-size: 14px;
  }


  .navbar {
    position: fixed;
    top: 0;
    left: 60px;
    height: 60px;
    background-color: #234168;
    display: flex;
    align-items: center;
    padding: 0 20px;
    width: calc(100% - 60px);
    transition: left 0.3s, width 0.3s;
  }

  .sidebar.open ~ .navbar {
    left: 260px;
    width: calc(100% - 260px);
  }

  .content {
    margin-left: 60px;
    margin-top: 60px;
    padding: 20px;
    transition: margin-left 0.3s;
  }

  .sidebar.open ~ .content {
    margin-left: 260px;
  }

</style>

<div class="sidebar" id="sidebar">
  <div class="sidebar-header">
    <span class="company-name">D-Market Analyst</span>
    <button type="button" class="toggle-btn" id="toggleBtn">
      <i class="fas fa-bars"></i>
    </button>
  </div>
  <a href="fund.aspx" class="menu-item">
    <i class="fas fa-tachometer-alt menu-icon"></i>
    <span class="menu-text">Dashboard</span>
  </a>
  <a href="#" class="menu-item" id="investorsMenu">
    <i class="fas fa-user-friends menu-icon"></i>
    <span class="menu-text">Investors</span>
    <i class="fas fa-caret-down" style="margin-left: auto;"></i>
  </a>
  <div class="submenu" id="submenu">
       <a href="agreementlist.aspx" class="submenu-item">Agreements List</a>
            <a href="alltransactions.aspx" class="submenu-item">Transactions</a>
      <a href="#" class="submenu-item">Profits</a>
    <a href="investorlist.aspx" class="submenu-item">Investors List</a>
    <a href="#" class="submenu-item">Expire Agreement</a>
    
  </div>
  <a href="#" class="menu-item" id="teammenu">
    <i class="fas fa-users menu-icon"></i>
    <span class="menu-text">My Team</span>
        <i class="fas fa-caret-down" style="margin-left: auto;"></i>
  </a>
    <div class="submenu" id="submenux">
       <a href="teamlist.aspx" class="submenu-item">Team List</a>
       <a href="teamTransaction.aspx" class="submenu-item">Team Transactions</a>
      <a href="teammonth.aspx" class="submenu-item">Team Monthly Profits</a>
  
    
  </div>
  <a href="#" class="menu-item">
    <i class="fas fa-bell menu-icon"></i>
    <span class="menu-text">Notification</span>
  </a>
  <a href="#" class="menu-item">
    <i class="fas fa-chart-line menu-icon"></i>
    <span class="menu-text">PNL</span>
  </a>
  <a href="#" class="menu-item">
    <i class="fas fa-seedling menu-icon"></i>
    <span class="menu-text">Growth</span>
  </a>
  <a href="#" class="menu-item">
    <i class="fas fa-user menu-icon"></i>
    <span class="menu-text">Profile</span>
  </a>
  <a href="agreement.aspx" class="menu-item">
    <i class="fas fa-sliders-h menu-icon"></i>
    <span class="menu-text">Control</span>
  </a>
  <a href="#" class="menu-item">
    <i class="fas fa-cog menu-icon"></i>
    <span class="menu-text">Settings</span>
  </a>
</div>

<div class="navbar">
  <div class="search-box">
    <input type="text" class="search-input" placeholder="Search investor, years, months, team" />
  </div>
  <img src="profile.png" alt="Profile Photo" class="profile-photo" />
</div>


  <script>
      document.getElementById('toggleBtn').addEventListener('click', function () {
          const sidebar = document.getElementById('sidebar');
          const submenu = document.getElementById('submenu');
          const submenux = document.getElementById('submenux');

          sidebar.classList.toggle('open');

          // Ensure both submenus are inactive when sidebar is toggled
          submenu.style.display = 'none';
          submenux.style.display = 'none';
      });

      document.getElementById('investorsMenu').addEventListener('click', function () {
          const submenu = document.getElementById('submenu');

          // Toggle submenu display
          submenu.style.display = submenu.style.display === 'flex' ? 'none' : 'flex';
      });

      document.getElementById('teammenu').addEventListener('click', function () {
          const submenux = document.getElementById('submenux');

          // Toggle submenux display
          submenux.style.display = submenux.style.display === 'flex' ? 'none' : 'flex';
      });

  </script>