<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Document.aspx.cs" Inherits="Document" %>
<%@ Register TagPrefix="ucx1" TagName="MyUserControl11" Src="~/sidenav.ascx" %>
<%@ Register TagPrefix="ucx" TagName="MyUserControl1" Src="~/header.ascx" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register New Investor</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" />
    <ucx:MyUserControl1 runat="server" />

    <style>
     
.section-container {
    font-family: Arial, sans-serif;
    max-width: 600px;
    margin: 10px auto;
    padding: 15px;
    background-color: #e7eef8;
    border-radius: 10px;
    box-shadow: 0 2px 3px rgba(0, 0, 0, 0.1);
}

     
.section-title {
    font-weight: bold;
    color: #365293;
    margin-bottom: 10px;
}

      
        .content-row {
            display: flex;
            justify-content: space-between;
            margin: 5px 0;
        }

.content-row label {
    color: #373f60;
    margin-bottom: 0;
}

.content-row span {
    font-weight: bold;
    color: #283e60;
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
    margin-top: -21px;
}

        .icon {
            display: inline-flex;
            align-items: center;
            font-size: 1.2em;
            cursor: pointer;
            color: #333;
        }

        .icon + .icon {
            margin-left: 10px;
        }

      
        .main-content {
            margin-top: 20px; / Apply top margin /
            overflow: auto;   / Prevent margin from affecting sidebar /
        }
    .section{
        margin-top:100px;
    }

      
        @media (max-width: 600px) {
    .content-row {
        align-items: flex-start;
        display: flex;
    }
            .content-row label,
            .content-row span {
                margin: 2px 0;
            }
        }
    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <ucx1:MyUserControl11 runat="server" />

            <!-- Main Content -->
            <div class="main-content">
                <!-- Capital Section -->
                <div class="section">
                <div class="section-container">
                    <div class="section-title">Capital</div>
                    <div class="content-row">
                        <label>Capital:</label> <span>700,000.00</span>
                    </div>
                    <div class="content-row">
                        <label>Start Date:</label> <span>01-01-2024</span>
                    </div>
                    <div class="content-row">
                        <label>Expiry Date:</label> <span>01-04-2024</span>
                    </div>
                    <div class="content-row">
                        <label>Profit %:</label> <span>4%</span>
                    </div>
                </div>

                <!-- Transactions Section -->
                <div class="section-container">
                    <div class="section-title">Transactions</div>
                    <div class="content-row">
                        <label>Investor Receipt:</label>
                        <div>
                            <span class="icon">👁️</span>
                            <span class="icon">⬇️</span>
                        </div>
                    </div>
                    <div class="content-row">
                        <label>Approve Receipt:</label>
                        <div>
                            <span class="icon">👁️</span>
                            <span class="icon">⬇️</span>
                        </div>
                    </div>
                </div>

                <!-- Withdraw Section -->
                <div class="section-container">
                    <div class="section-title">Withdraw</div>
                    <div class="content-row">
                        <label>Capital Withdraw:</label> <span>100,000.00</span>
                    </div>
                    <div class="content-row">
                        <label>On Date:</label> <span>20-01-2024</span>
                    </div>
                    <div class="content-row">
                        <label>Active Capital:</label> <span>600,000.00</span>
                    </div>
                </div>
                    <!-- Capital return Section -->
                <div class="section-container">
                    <div class="section-title">Capital return</div>
                    <div class="content-row">
                        <label>Capital return:</label> <span>0.00</span>
                    </div>
                    <div class="content-row">
                        <label>Date:</label> <span>20-01-2024</span>
                    </div>
                    <div class="content-row">
                        <label>Status:</label> <span>Reinvested</span>
                    </div>
                </div>
                     <!-- BAnk account Section -->
                <div class="section-container">
                    <div class="section-title">Bank Account</div>
                    <div class="content-row">
                        <label>Bank Account No:</label> <span>451256234512</span>
                    </div>
                    <div class="content-row">
                        <label>Bank:</label> <span>20-01-2024</span>
                    </div>
                </div>
                </div>

            </div>
        </div>
    </form>
</body>
</html>