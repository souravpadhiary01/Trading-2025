<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Adminapprove.aspx.cs" Inherits="Adminapprove" %>
<%@ Register TagPrefix="ucx1" TagName="MyUserControl11" Src="~/sidenav2.ascx" %>
<%@ Register TagPrefix="ucx" TagName="MyUserControl1" Src="~/header.ascx" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <ucx:MyUserControl1 runat="server" />
    <style>
        .card {
            background-color: #0a1425;
            color: white;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
        }
        .action-btn {
            min-width: 140px;
        }
        .table-dark {
            --bs-table-bg: #0a1425;
        }
        .header-stats {
            background-color: #0a1425;
            color: white;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
    </style>


</head>
<body>
    <form id="form1" runat="server">
         <div>
            <ucx1:MyUserControl11 runat="server" />
       

        <div class="container-fluid py-4">
        <h4 class="mb-4">All Transactions</h4>
        
        <!-- Stats Cards -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="header-stats">
                    <h6>Transaction Amount</h6>
                    <h4 id="transactionAmount">Loading...</h4>
                </div>
            </div>
            <div class="col-md-3">
                <div class="header-stats">
                    <h6>Pending Tasks</h6>
                    <h4 id="pendingTasks">Loading...</h4>
                </div>
            </div>
        </div>

        <!-- Filter Controls -->
        <div class="row mb-4">
            <div class="col-md-3">
                <select class="form-select" id="clientFilter">
                    <option value="">Choose Client: All</option>
                </select>
            </div>
            <div class="col-md-3">
                <select class="form-select" id="filterBy">
                    <option value="">Choose Filter By: All</option>
                </select>
            </div>
            <div class="col-md-6 text-end">
                <button class="btn btn-success">+ New Transaction</button>
            </div>
        </div>

        <!-- DataTable -->
        <div class="card">
            <table id="transactionTable" class="table table-dark table-hover">
                <thead>
                    <tr>
                        <th>Sl No</th>
                        <th>Client Id</th>
                        <th>Client Name</th>
                        <th>Transaction Amount</th>
                        <th>Referred By</th>
                        <th>Date & Time Action</th>
                        <th>Receipt By Client</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Data will be populated by DataTables -->
                </tbody>
            </table>
        </div>
    </div>
              </div>
    </form>
</body>
</html>
