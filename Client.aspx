<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Client.aspx.cs" Inherits="Client" %>


<%@ Register TagPrefix="ucx1" TagName="MyUserControl11" Src="~/sidenav.ascx" %>
<%@ Register TagPrefix="ucx" TagName="MyUserControl1" Src="~/header.ascx" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
       <ucx:MyUserControl1 runat="server" />


      <style>
        .metric-card {
            border-radius: 15px;
            padding: 20px;
            margin: 15px 0;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .metric-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: rgba(255, 255, 255, 0.1);
            transform: rotate(45deg);
            transition: all 0.5s ease;
        }
        
        .metric-card:hover::before {
            top: -30%;
            left: -30%;
        }
        
        .metric-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        
        .profit-card {
            background: linear-gradient(135deg, #ff9a9e, #fad0c4);
            color: #333;
        }
        
        .capital-card {
            background: linear-gradient(135deg, #84fab0, #8fd3f4);
            color: #333;
        }
        
        .metric-value {
            font-size: 32px;
            font-weight: 700;
            color: #2c3e50;
        }
        
        .metric-label {
            color: #4a4a4a;
            font-size: 16px;
            margin-top: 5px;
        }
        
        .view-all {
            color: #2c3e50;
            font-size: 14px;
            text-decoration: none;
            display: block;
            margin-top: 15px;
            padding-top: 10px;
            border-top: 1px solid rgba(44, 62, 80, 0.4);
            text-align: center;
        }
        
        .view-all:hover {
            color: #1a252f;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">

        <div>
             <ucx1:MyUserControl11 runat="server" />



             <div class="container py-4 ">
        <div class="row justify-content-center" style="margin-top: 100px;">
            <div class="col-md-6">
                <div class="metric-card profit-card">
                    <div class="text-center">
                        <div class="metric-value">$40,000.00</div>
                        <div class="metric-label">Total Profit</div>
                        <a href="#" class="view-all">View All</a>
                    </div>
                </div>
                
                <div class="metric-card capital-card">
                    <div class="text-center">
                        <div class="metric-value">$500,000.00</div>
                        <div class="metric-label">Current Capital</div>
                        <a href="#" class="view-all">View All</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
        </div>
    </form>
<h1>sourav</h1>
</body>
</html>
