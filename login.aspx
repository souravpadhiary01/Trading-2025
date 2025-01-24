<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<%@ Register TagPrefix="ucx" TagName="MyUserControl1" Src="~/header.ascx" %>



<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <ucx:MyUserControl1 ID="MyUserControl1" runat="server" />


    <title>Login</title>
 
<script>

    function getCookie(cookieName) {
        let cookies = document.cookie.split("; ");
        for (let i = 0; i < cookies.length; i++) {
            let cookiePair = cookies[i].split("=");
            if (cookiePair[0] === cookieName) {
                return decodeURIComponent(cookiePair[1]);
            }
        }
        return null; // Return null if cookie not found
    }


    $(document).ready(function () {


        $('#btn').on('click', function (e) {
            e.preventDefault();

            // Capture input values
            var userId = $('#UserId').val();
            var password = $('#password').val();

            // Validate input (optional)
            if (!userId || !password) {
                alert('Please fill in both fields!');
                return;
            }

            // Create data object
            var data = {
                UserID: userId,
                Password: password
            };

            // Send AJAX request
            $.ajax({
                url: 'login.aspx/user', // Change this to your backend API endpoint
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ data: data }),
                success: function (response) {
                    alert(response.d);

                        let myCookie = getCookie("usrid"); // Replace "TestCookie" with your cookie name
                        if (myCookie) {
                            console.log("Cookie Value: ", myCookie);
                        } else {
                            console.log("Cookie not found.");
                        }
                        window.location.href = "fund.aspx";
                   
                },
                error: function (xhr, status, error) {
                    alert('Error: ' + xhr.responseText);
                }
            });
        });
    });
</script>
    



    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #1e3a5f, #2874a6);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.2);
            padding: 2.5rem 2rem;
            width: 100%;
            max-width: 400px;
        }

        .login-header {
            font-size: 1.8rem;
            font-weight: bold;
            text-align: center;
            margin-bottom: 1.5rem;
            color: #1e3a5f;
        }

        .form-label {
            font-size: 0.9rem;
            color: #2c3e50;
            font-weight: 600;
        }

        .form-control {
            border-radius: 10px;
            border: 1px solid #1e3a5f;
            box-shadow: inset 0px 2px 4px rgba(0, 0, 0, 0.1);
        }

        .form-control:focus {
            border-color: #2874a6;
            box-shadow: 0px 0px 8px rgba(40, 116, 166, 0.6);
        }

        .login-btn {
            background: linear-gradient(90deg, #1e3a5f, #2874a6);
            border: none;
            padding: 0.8rem;
            width: 100%;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: bold;
            color: white;
            transition: all 0.3s ease-in-out;
        }

        .login-btn:hover {
            background: linear-gradient(90deg, #0d2235, #18527a);
            transform: translateY(-3px);
            box-shadow: 0px 5px 10px rgba(0, 0, 0, 0.2);
        }

        .forgot-password {
            text-align: center;
            font-size: 0.9rem;
            margin-top: 1.5rem;
            color: #666;
        }

        .forgot-password a {
            color: #2874a6;
            text-decoration: none;
        }

        .forgot-password a:hover {
            text-decoration: underline;
        }

        /* Add subtle animation */
        .login-container {
            animation: fadeIn 1.2s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <h2 class="login-header">Welcome, D Market Analyst</h2>
            
            <div class="mb-4">
                <label for="UserId" class="form-label">User ID</label>
                <input type="text" class="form-control" id="UserId" placeholder="Enter User ID" runat="server" />
            </div>
            
            <div class="mb-4">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" placeholder="Enter Password" runat="server" />
            </div>
            
            <button type="submit" class="btn login-btn" id="btn">LOGIN</button>
            
            <div class="forgot-password">
                <span>Forgot Password?</span><br>
                <small>Please <a href="#">contact your team member</a>.</small>
            </div>
        </div>
    </form>
</body>
</html>
