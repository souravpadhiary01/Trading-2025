<%@ Page Language="C#" AutoEventWireup="true" CodeFile="adminlogin.aspx.cs" Inherits="adminlogin" %>

<%@ Register TagPrefix="ucx" TagName="MyUserControl1" Src="~/header.ascx" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <ucx:MyUserControl1 runat="server" />
    <title>Admin Login</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>



<script>
    $(document).ready(function () {
        $('#loginButton').click(function () {
            // Get the values from the input fields
            const loginId = $('#loginId').val().trim();
            const password = $('#password').val().trim();

            // Check for correct credentials
            if (loginId === 'admin' && password === 'admin213') {
                // Redirect to fund.aspx
                window.location.href = 'fund.aspx';
            } else {
                // Show an alert for incorrect credentials
                alert('Invalid Login ID or Password. Please try again.');
            }
        });
    });
</script>
<style>

body {
background: linear-gradient(45deg, 
    #8b0000, #a52a2a, #800000, #8b4513, #5f9ea0, #4682b4, #4169e1, #000080, #00008b, #191970,
    #4b0082, #6a5acd, #8a2be2, #9400d3, #9932cc, #8b008b, #800080, #4b0082, #483d8b, #6c3483,
    #2c3e50, #1a5276, #2874a6, #5499c7, #154360, #1b2631, #2e4053, #212f3d, #283747, #34495e,
    #2c3e50, #16a085, #138d75, #117864, #0e6251, #145a32, #186a3b, #239b56, #1d8348, #145a32,
    #9a7d0a, #7e5109, #6e2c00, #784212, #935116, #d68910, #c0392b, #b03a2e, #943126, #78281f,
    #641e16, #512e5f, #4a235a, #6c3483, #922b21, #a93226, #c0392b, #d35400, #e67e22, #dc7633,
    #e74c3c, #cb4335, #922b21, #641e16, #512e5f, #4a235a, #6c3483, #922b21, #a93226, #c0392b,
    #2980b9, #3498db, #1abc9c, #16a085, #27ae60, #2ecc71, #d4ac0d, #d68910, #ca6f1e, #ba4a00,
    #784212, #6e2c00, #7e5109, #9a7d0a, #a04000, #8e44ad, #9b59b6, #76448a, #5b2c6f, #512e5f,
    #4a235a, #641e16, #78281f, #943126, #b03a2e, #c0392b, #d35400, #dc7633, #e74c3c, #cb4335,
    #6b4226, #8b572a, #3e2723, #5d4037, #795548, #9e9d24, #827717, #4a6572, #455a64, #37474f,
    #263238, #1c313a, #102027, #004d40, #00695c, #00796b, #00897b, #009688, #80cbc4, #26a69a,
    #004d40, #00695c, #00796b, #00897b, #26a69a, #4caf50, #43a047, #388e3c, #2e7d32, #1b5e20,
    #cddc39, #afb42b, #9e9d24, #827717, #fbc02d, #ffa000, #ff8f00, #ff6f00, #f57c00, #e65100,
    #bf360c, #d84315, #e64a19, #f4511e, #ff5722, #ff3d00, #dd2c00, #ff6d00, #ff8f00, #ffa000,
    #ffab00, #ffd600, #ffea00, #ffff00, #fdd835, #fbc02d, #f9a825, #f57f17, #ff6d00, #e65100,
    #bf360c, #d84315, #e64a19, #f4511e, #ff5722, #ff3d00, #dd2c00, #ff6d00, #ff8f00, #ffa000,
    #9e9d24, #827717, #6b4226, #8b572a, #3e2723, #5d4037, #795548, #8d6e63, #6d4c41, #5d4037
);



    background-size: 400% 400%;
    animation: gradientBackground 100s ease infinite;
    font-family: 'Poppins', sans-serif;
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0;
    overflow: hidden;
    color: #fff;
}

@keyframes gradientBackground {
    0% {
        background-position: 0% 50%;
    }
    50% {
        background-position: 100% 50%;
    }
    100% {
        background-position: 0% 50%;
    }
}

.login-container {
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(15px);
    border: 1px solid rgba(255, 255, 255, 0.3);
    border-radius: 15px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.37);
    width: 400px;
    max-width: 90%;
    padding: 2rem;
    text-align: center;
    color: white;
    position: relative;
}


.login-container::before,
.login-container::after {
    content: '';
    position: absolute;
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.15);
    filter: blur(50px);
    z-index: -1;
}

.login-container::before {
    width: 200px;
    height: 200px;
    top: -60px;
    left: -80px;
}

.login-container::after {
    width: 300px;
    height: 300px;
    bottom: -100px;
    right: -120px;
}


.login-header {
    font-size: 2rem;
    margin-bottom: 1.5rem;
    font-weight: bold;
    letter-spacing: 1.5px;
    text-transform: uppercase;
    text-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
}


.form-label {
    font-size: 0.9rem;
    font-weight: 500;
    color: rgba(255, 255, 255, 0.8);
    margin-bottom: 0.5rem;
    display: block;
    text-align: left;
}

input[type="text"], input[type="password"] {
    width: 100%;
    padding: 0.8rem;
    margin-bottom: 1.2rem;
    border: none;
    border-radius: 8px;
    background: rgba(255, 255, 255, 0.2);
    color: #fff;
    font-size: 1rem;
    outline: none;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

input[type="text"]:focus, input[type="password"]:focus {
    transform: scale(1.05);
    box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
}

.login-btn {
    background: linear-gradient(to right, #6a11cb, #2575fc);
    color: white;
    font-size: 1rem;
    font-weight: bold;
    padding: 0.8rem;
    border: none;
    border-radius: 10px;
    width: 100%;
    cursor: pointer;
    transition: background 0.3s ease, transform 0.3s ease;
}

.login-btn:hover {
    background: linear-gradient(to right, #8e2de2, #4a00e0);
    transform: translateY(-3px);
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
}

.forgot-password {
    font-size: 0.9rem;
    color: rgba(255, 255, 255, 0.8);
    margin-top: 1rem;
}

.forgot-password a {
    color: #ffd700;
    text-decoration: none;
    font-weight: bold;
    transition: color 0.3s ease;
}

.forgot-password a:hover {
    color: #ff9f43;
    text-decoration: underline;
}

@media (max-width: 576px) {
    .login-container {
        padding: 1.5rem;
    }

    .login-header {
        font-size: 1.8rem;
    }

    input[type="text"], input[type="password"] {
        font-size: 0.9rem;
    }

    .login-btn {
        font-size: 0.9rem;
    }
}

</style>

</head>
<body>
    <form id="form1" runat="server">
     

        
             
                <div class="login-container">
                    <h2 class="login-header">Welcome Admin</h2>
                    <div class="mb-3">
                        <label for="loginId" class="form-label">Login ID</label>
                        <input type="text" class="form-control" id="loginId" placeholder="Enter Login ID" runat="server" />
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" placeholder="Enter Password" runat="server" />
                    </div>
                    <button type="button" class="btn btn-primary login-btn" id="loginButton">LOGIN</button>
                    <div class="forgot-password">
                        <span>Forgot Password?</span><br>
                        <small class="text-muted">please <a href="#">Send Link</a> Check your Email.</small>
                    </div>
                </div>
                   

    </form>
</body>
</html>
