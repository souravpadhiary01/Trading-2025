<%@ Page Language="C#" AutoEventWireup="true" CodeFile="upload.aspx.cs" Inherits="upload" %>

<%@ Register TagPrefix="ucx1" TagName="MyUserControl11" Src="~/sidenav.ascx" %>
<%@ Register TagPrefix="ucx" TagName="MyUserControl1" Src="~/header.ascx" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register New Investor</title>
    <!-- Bootstrap CSS -->
   <%-- <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" />
    <ucx:MyUserControl1 runat="server" />--%>

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
            height: 79px;
        }
        
      
        .sidebar + .main-section {
            padding-top: 70px;
        }

        .main-section {
            padding: 20px;
            width: calc(100% - 360px);
            margin: auto;
        }

      
        .capital-section {
            width: 100%;
            max-width: 730px;
            margin: auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top: 100px;
        }

       
        .capital-summary {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .capital-box {
            width: 48%;
            text-align: center;
            padding: 10px;
            background-color: #e7eef8;
            border-radius: 8px;
        }

       
        .upload-section {
            flex-direction: column;
            align-items: start;
            margin-bottom: 20px;
            background-color: #dfdfdf;
            padding: 10px;
        }

      
        .upload-section button,
        .submit-btn-container button {
            background-color: #336699;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .upload-section button:hover,
        .submit-btn-container button:hover {
            background-color: #295a85;
        }

       
        .file-upload {
            display: none;
        }

       
        .transaction-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .transaction-table th,
        .transaction-table td {
            border: 1px solid #ffffff;
            padding: 10px;
            text-align: center;
        }

        .transaction-table th {
            background-color: #336699;
            color: white;
        }

        .transaction-table td {
            background-color: #f9f9f9;
        }

        / Row Styling /
        .transaction-table tr:nth-child(even) td {
            background-color: #f7f2f2;
        }

        .transaction-table tr:nth-child(odd) td {
            background-color: #dfdfdf;
        }

       
        @media (max-width: 768px) {
            .main-section {
                width: 100%;
                padding: 10px;
            }
            .capital-summary {
                flex-direction: column;
                gap: 10px;
            }
            .capital-box {
                width: 100%;
            }
            .transaction-table,
            .transaction-table th,
            .transaction-table td {
                font-size: 0.9em;
            }
        }

        @media (max-width: 576px) {
            .navbar {
                font-size: 0.9em;
                padding: 8px;
            }
            .upload-section input,
            .upload-section button,
            .submit-btn-container button {
                width: 100%;
            }
            .transaction-table {
                font-size: 0.8em;
            }
            .transaction-table th, 
            .transaction-table td {
                padding: 6px;
            }
        }
        .table-responsive {
    overflow-x: auto; 
    -webkit-overflow-scrolling: touch;
}

.transaction-table {
    width: 100%;
    border-collapse: collapse; 
}




    </style>




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

        $(document).ready(function (){


            let myCookie = getCookie("usrid"); // Replace "TestCookie" with your cookie name
            if (myCookie) {
                console.log("Cookie Value: ", myCookie);
            } else {
                console.log("Cookie not found.");
            }

            $('#receipt').on('change', function () {
                const file = this.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        const base64Data = e.target.result;
                        const fileName = file.name;

                        // Store base64 data and file name in hidden fields
                        $('#hiden').val(base64Data);   // Base64 data
                        $('#hidden').val(fileName);    // File name
                    };
                    reader.readAsDataURL(file); // Read file as base64
                }
            });

            $("#btn").on("click", function () {
                $.ajax({
                    type: "POST",
                    url: "upload.aspx/Insert",
                    data: JSON.stringify({
                        ClientId: myCookie, // Send the ClientId to the server
                        Amount: $("#amount").val(),
                        pic: $("#hiden").val(),
                        path: $("#hidden").val()
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccessrrd,
                    failure: function (response) {
                        alert(response.d);
                    }
                });

                function OnSuccessrrd(response) {
                    alert("You have Successfully Registered, Thank You");
                    window.location.reload();
                }
            });


        })
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <ucx1:MyUserControl11 runat="server" />
        </div>

        <!-- Capital Section -->
        <div class="main-section">
            <div class="capital-section">
                <div class="capital-summary">
                    <div class="capital-box">
                        <p>200,000.00</p>
                        <span>Total Capital</span>
                    </div>
                    <div class="capital-box">
                        <p>0.00</p>
                        <span>Capital Withdraw</span>
                    </div>
                </div>

                <div class="upload-section">
                    <div class="form-group d-flex align-items-center">
                        <label for="amount" class="mr-2 mb-0" style="white-space: nowrap;">Enter Your Amount</label>
                        <input type="number" id="amount" class="form-control" placeholder="100,000.00" style="max-width: 200px;">
                    </div>
                    
                    <div class="form-group">
                        <label for="receipt">Upload Receipt</label>
                        <input type="file" id="receipt" accept=".jpg, .png, .pdf" class="form-control-file">
                        <input type="hidden" value="" id="hiden" runat="server" /> <input type="hidden" value="" runat="server" id="hidden"  />
                    </div>
                    
                    <div class="submit-btn-container">
                        <button id="btn" type="button">Submit</button>
                    </div>
                </div>

<div class="table-responsive">
    <table class="transaction-table">
        <thead>
            <tr>
                <th>Sl No</th>
                <th>Amount</th>
                <th>Sent File</th>
                <th>Approved File</th>
                <th>Transaction Date</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>200000.00</td>
                <td><img src="receipt.jpg" alt="Uploaded Receipt" /></td>
                <td></td>
                <td>Based on Client upload</td>
                <td>Pending</td>
            </tr>
            <tr><td>2</td><td></td><td></td><td></td><td></td><td></td></tr>
            <tr><td>3</td><td></td><td></td><td></td><td></td><td></td></tr>
            <tr><td>4</td><td></td><td></td><td></td><td></td><td></td></tr>
            <tr><td>5</td><td></td><td></td><td></td><td></td><td></td></tr>
        </tbody>
    </table>
</div>
            </div>
        </div>
    </form>
</body>
</html>


