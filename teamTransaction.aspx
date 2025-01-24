<%@ Page Language="C#" AutoEventWireup="true" CodeFile="teamTransaction.aspx.cs" Inherits="teammonth" %>


<%@ Register TagPrefix="ucx1" TagName="MyUserControl11" Src="~/sidenav2.ascx" %>
<%@ Register TagPrefix="ucx" TagName="MyUserControl1" Src="~/header.ascx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

        <ucx:MyUserControl1 runat="server" />

    <title></title>


       <style>
        .card {
            background: white;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            display: inline-block;
        }
        .navy-card {
            background: #1a237e;
            color: white;
        }
        .red-card {
            background: #c62828;
            color: white;
        }
        .status-pending {
            color: #f44336;
        }
        .status-acknowledged {
            color: #2e7d32;
        }
        body {
            background-color: #f0f8ff;
            padding: 20px;
        }

        .container-fluid{
            margin-left: 80px !important;
        }
        .dataTables_wrapper{
            width:98%;
        }

    </style>

    <script>
        $(document).ready(function() {
            $('#transactionsTable').DataTable({
                "order": [[0, "desc"]],
                "pageLength": 10,
                "lengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]],
                "responsive": true
            });
        });
    </script>



</head>
<body>
    <form id="form1" runat="server">
        <div>
                        <ucx1:MyUserControl11 runat="server" />

               <div class="container-fluid">
        <h2 class="mb-4">Team Transactions</h2>
        
        <div class="d-flex gap-3 mb-4">
            <div class="card navy-card">
                <h3>15,50,000.00</h3>
                <div>Transaction Amount</div>
            </div>
            <div class="card red-card">
                <h3>05</h3>
                <div>Pending Items</div>
            </div>
        </div>

        <table id="transactionsTable" class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>Sl No</th>
                    <th>Member ID</th>
                    <th>Member Name</th>
                    <th>Date & Time</th>
                    <th>Transaction Amount</th>
                    <th>Transaction Type</th>
                    <th>Transaction By</th>
                    <th>Download</th>
                    <th>Remark</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>DM567769</td>
                    <td>Sagar Maharana</td>
                    <td>05-10-2024 06:45PM</td>
                    <td>500,000.00</td>
                    <td>Profit</td>
                    <td>Admin</td>
                    <td><a href="#" class="text-primary">Download</a></td>
                    <td>Read</td>
                    <td class="status-pending">Pending</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>DM567502</td>
                    <td>Mirza Talif</td>
                    <td>02-10-2024 09:05AM</td>
                    <td>200,000.00</td>
                    <td>New Capital</td>
                    <td>Team</td>
                    <td><a href="#" class="text-primary">Download</a></td>
                    <td>Read</td>
                    <td class="status-acknowledged">Acknowledged</td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>DM567502</td>
                    <td>Mirza Talif</td>
                    <td>30-09-2024 09:05AM</td>
                    <td>575,000.00</td>
                    <td>Capital Return/Profit</td>
                    <td>Admin</td>
                    <td><a href="#" class="text-primary">Download</a></td>
                    <td>Read</td>
                    <td class="status-acknowledged">Acknowledged</td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>DM593207</td>
                    <td>Preeti Krushna</td>
                    <td>03-09-2024 09:05AM</td>
                    <td>300,250.00</td>
                    <td>Profit</td>
                    <td>Admin</td>
                    <td><a href="#" class="text-primary">Download</a></td>
                    <td>Read</td>
                    <td class="status-acknowledged">Acknowledged</td>
                </tr>
                <tr>
                    <td>4</td>
                    <td>DM593207</td>
                    <td>Preeti Krushna</td>
                    <td>01-09-2024 09:05AM</td>
                    <td>325,000.00</td>
                    <td>New Capital</td>
                    <td>Team</td>
                    <td><a href="#" class="text-primary">Download</a></td>
                    <td>Read</td>
                    <td class="status-acknowledged">Acknowledged</td>
                </tr>
            </tbody>
        </table>
    </div>
        </div>
    </form>
</body>
</html>
