<%@ Page Language="C#" AutoEventWireup="true" CodeFile="teammonth.aspx.cs" Inherits="teammonth" %>


<%@ Register TagPrefix="ucx1" TagName="MyUserControl11" Src="~/sidenav2.ascx" %>
<%@ Register TagPrefix="ucx" TagName="MyUserControl1" Src="~/header.ascx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

        <ucx:MyUserControl1 runat="server" />
    <title></title>

     <style>
        body {
            background-color: #f0f8ff;
            padding: 20px;
        }
        .summary-card {
            padding: 15px;
            color: white;
            border-radius: 8px;
            margin-bottom: 20px;
            display: inline-block;
        }
        .navy-card {
            background: #1a237e;
        }
        .red-card {
            background: #c62828;
        }
        .green-card {
            background: #1b5e20;
        }
        .capital-expiry {
            color: #ff0000;
        }
        .month-selector {
            background: #0d47a1;
            color: white;
            padding: 8px 15px;
            border-radius: 4px;
            border: none;
        }
        .team-transaction-btn {
            background: #00c853;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
        }
        .modal-header {
            background: #1a237e;
            color: white;
        }
        .form-group {
            margin-bottom: 1rem;
        }
        .pay-button {
            background: #1b5e20;
            color: white;
            border: none;
            padding: 8px 30px;
            border-radius: 4px;
        }
        .close-btn {
            background: none;
            border: none;
            color: white;
            font-size: 1.5rem;
        }
        .container-fluid{
                width: 97% !important;
margin-left: 45px !important;
        }
       


    </style>


      <script>
        $(document).ready(function() {
            $('#paymentsTable').DataTable({
                "order": [[0, "asc"]],
                "pageLength": 10,
                "dom": 'rt<"bottom"ip>',
                "language": {
                    "search": ""
                }
            });
        });
      </script>

 
</head>
<body>
    <form id="form1" runat="server">
        <div>
                <ucx1:MyUserControl11 runat="server" />

                <div class="container-fluid">
       <h2 class="mb-4">Team Monthly Payment</h2>
       
       <div class="d-flex gap-3 mb-4">
           <div class="summary-card navy-card">
               <h3>500000.00</h3>
               <div>Total Funds</div>
           </div>
           <div class="summary-card red-card">
               <h3>500,000.00</h3>
               <div>Client Payments</div>
           </div>
           <div class="summary-card green-card">
               <h3>250000.00</h3>
               <div>Team Payments</div>
           </div>
       </div>

       <div class="d-flex justify-content-between align-items-center mb-3">
           <select class="month-selector">
               <option>Choose Month: Oct</option>
               <option>Nov</option>
               <option>Dec</option>
           </select>
           <div class="d-flex gap-3">
               <button type="button" class="team-transaction-btn" data-bs-toggle="modal" data-bs-target="#transactionModal">
                   +Team Transaction
               </button>
               <input type="search" class="form-control" placeholder="Search....">
           </div>
       </div>

       <table id="paymentsTable" class="table table-bordered table-hover">
           <thead class="table-dark">
               <tr>
                   <th>Sl No</th>
                   <th>Member ID</th>
                   <th>Member Name</th>
                   <th>Member Priority</th>
                   <th>Client Fund</th>
                   <th>No Of Clients</th>
                   <th>Client Payments</th>
                   <th>Capital Expiry</th>
                   <th>Action</th>
               </tr>
           </thead>
           <tbody>
               <tr>
                   <td>1</td>
                   <td>DM8249002</td>
                   <td>SK Danish Rahim</td>
                   <td>25th</td>
                   <td>500,000.00</td>
                   <td>137</td>
                   <td>1500,000.00</td>
                   <td class="capital-expiry">3000,000.00</td>
                   <td><button class="btn btn-primary btn-sm">Pay</button></td>
               </tr>
               <tr>
                   <td>2</td>
                   <td>DM8249002</td>
                   <td>Sagar Maharana</td>
                   <td>24th</td>
                   <td>6000,000.00</td>
                   <td>65</td>
                   <td>300,000.00</td>
                   <td class="capital-expiry">2500,000.00</td>
                   <td><button class="btn btn-primary btn-sm">Pay</button></td>
               </tr>
               <!-- Add other rows similarly -->
           </tbody>
       </table>
   </div>

   <!-- Transaction Modal -->
               <div class="modal fade" id="transactionModal" tabindex="-1">
       <div class="modal-dialog modal-lg">
           <div class="modal-content">
               <div class="modal-header">
                   <h5 class="modal-title">Team Transaction</h5>
                   <button type="button" class="close-btn" data-bs-dismiss="modal">&times;</button>
               </div>
               <div class="modal-body">
                   <form>
                       <div class="row mb-3">
                           <div class="col-md-6">
                               <div class="form-group">
                                   <label>Member Name:</label>
                                   <input type="text" class="form-control" placeholder="Search Member Name">
                               </div>
                               <div class="form-group">
                                   <label>Member ID:</label>
                                   <input type="text" class="form-control" placeholder="Auto Fetch once select Name" readonly>
                               </div>
                               <div class="form-group">
                                   <label>Transaction Amount:</label>
                                   <input type="text" class="form-control" placeholder="Enter Transaction Amount">
                               </div>
                               <div class="form-group">
                                   <label>Transaction Type:</label>
                                   <select class="form-control">
                                       <option>New Capital</option>
                                       <option>Profit</option>
                                       <option>Capital Return / Profit</option>
                                       <option>Capital Return</option>
                                   </select>
                               </div>
                           </div>
                           <div class="col-md-6">
                               <div class="form-group">
                                   <label>Transaction By:</label>
                                   <input type="text" class="form-control" value="Admin" readonly>
                               </div>
                               <div class="form-group">
                                   <label>Upload File:</label>
                                   <div class="input-group">
                                       <input type="text" class="form-control" placeholder="Upload Payment File" readonly>
                                       <button class="btn btn-secondary">Upload File</button>
                                   </div>
                               </div>
                               <div class="form-group">
                                   <label>Remark:</label>
                                   <textarea class="form-control" placeholder="Remark to Member"></textarea>
                               </div>
                           </div>
                       </div>
                       <div class="text-center">
                           <button type="submit" class="pay-button">Pay</button>
                       </div>
                   </form>
               </div>
           </div>
       </div>
   </div>


        </div>
    </form>
</body>

</html>
