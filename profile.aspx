<%@ Page Language="C#" AutoEventWireup="true" CodeFile="profile.aspx.cs" Inherits="profile" %>
<%@ Register TagPrefix="ucx1" TagName="MyUserControl11" Src="~/sidenav2.ascx" %>
<%@ Register TagPrefix="ucx" TagName="MyUserControl1" Src="~/header.ascx" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
       <ucx:MyUserControl1 runat="server" />
    <title></title>
 <style>
        /* General Reset */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f7fa;
        }


        .profile{
            margin:0 auto;
        }
        /* Header Cards (Top Section) */
.profile-header {
    display: flex;
    justify-content: space-around;
    margin-top: 85px;
    margin-left: 85px;
    margin-bottom: 0;
    background-color: #ffffff;
    padding: 10px;
    border-radius: 10px;
}

.card {
    width: 23%;
    text-align: center;
    padding: 15px 10px;
    border-radius: 10px;
    color: #fff !important;
    font-size: 1.3em;
    font-weight: bold;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

        .card span {
            display: block;
            margin-top: 5px;
            font-size: 0.9em;
            font-weight: normal;
        }

        .current-funds { background-color: #234168 !important; }
        .total-profit { background-color: #4caf50 !important; }
        .total-agreement { background-color: #fbc02d !important; }
        .closed-agreement { background-color: #e53935 !important; }

        /* Main Content (Left-Right Layout) */
        .content {
            display: flex;
            gap: 20px;
            margin-top:10px !important; 
        }

        /* Left Section (Profile Details) */
.profile-details {
    width: 25%;
    background-color: #234168;
    color: #fff;
    padding: 20px;
    border-radius: 10px;
    border: 2px solid #fff;
    box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
}

.profile-details h2 {
    font-size: 21px;
    font-weight: 600;
    border-bottom: 2px solid #3b7be6;
    padding-bottom: 5px;
    margin-bottom: 15px;
}

        .profile-details p {
            margin: 10px 0;
            font-size: 0.9em;
        }

.profile-details button {
    margin-top: 10px;
    padding: 5px 15px;
    border: none;
    background-color: #f9a825;
    color: #fff;
    border-radius: 5px;
    cursor: pointer;
    font-size: 17px;
    width: 100%;
}
        .profile-details button:hover {
            background-color: #bb6f00;
        }

        /* Right Section (Table and Tabs) */
        .main-content {
            width: 75%;
        }

        /* Tabs */
.tabs {
    display: flex;
    justify-content: flex-start;
    margin-bottom: 15px;
    width: 25%;
    position: absolute;
    padding: 5px;
    border-radius: 10px;
}

.tab-btn {
    padding: 10px 20px;
    font-size: 0.9em;
    cursor: pointer;
    background-color: #1e3d5b;
    color: #fff;
    border: 1px solid #ddd;
    border-radius: 5px;
    margin-right: 5px;
    text-align: center;
    border: 2px solid #fff;
    box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
}

        .tab-btn.active {
            background-color: #4caf50;
        }

        /* Filters */
        .filters {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    margin-bottom: 10px;
    gap: 15px;
}

        .filters select {
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ddd;
            font-size: 0.9em;
        }

        /* Table Section */
        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            background-color: white;
            box-shadow: 0px 1px 5px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            overflow: hidden;
        }

        table th,
        table td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
            font-size: 0.9em;
        }

        table th {
            background-color: #087a9f;
            color: white;
            font-weight: bold;
        }

table a {
    color: #3b7be6;
    text-decoration: none;
    font-size: 12px !important;
    white-space: nowrap;
}

        table a:hover {
            text-decoration: underline;
        }
        .badge{
            padding:9px !important;
        }
        .table-container{
            margin-top: 66px !important;
        }
    </style>

      
    <script>
        $(document).ready(function () {
            var table = $('#data-table').DataTable({
                pageLength: 10,
                responsive: true,
                dom: 'Bfrtip',
                lengthMenu: [10, 25, 50, 100]
            });

            $('.tab-btn').click(function () {
                $('.tab-btn').removeClass('active');
                $(this).addClass('active');
                $('.table-container table').hide();
                $($(this).data('target')).show();
            });

            $('#status-filter').on('change', function () {
                const filterValue = $(this).val();
                table.column(6).search(filterValue).draw();
            });

            var clientId = sessionStorage.getItem("ClientId");

            if (!clientId) {
                console.error("ClientId not found in the URL.");
            } else {
                console.log("Client ID found:", clientId);

                // ✅ Fetch Client Details
                $.ajax({
                    type: "POST",
                    url: "profile.aspx/GetClientDetails",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ clientId: clientId }),
                    dataType: "json",
                    success: function (response) {
                        const data = response.d;
                        if (data && data.length > 0) {
                            const client = data[0];
                            $(".profile-details").html(`
                        <h2>Client Details</h2>
                        <p><strong>Client Name:</strong> ${client.ClientName}</p>
                        <p><strong>Client ID:</strong> ${clientId}</p>
                        <p><strong>Joining Date:</strong> ${client.JoiningDate}</p>
                        <p><strong>Refer By:</strong> ${client.ReferBy}</p>
                        <p><strong>Mobile:</strong> ${client.MobileNo}</p>
                        <p><strong>Total Agreement:</strong> ${client.TotalAgreements}</p>
                        <p><strong>Current Capital:</strong> ${client.CurrentCapital}</p>
                        <p><strong>Total Profit:</strong> ${client.TotalProfit}</p>
                        <p><strong>Nominee:</strong> ${client.NomineeName}</p>
                        <p><strong>District:</strong> ${client.District}</p>
                        <button>Edit</button>
                    `);
                        } else {
                            alert("No data found for the provided Client ID.");
                        }
                    },
                    error: function (err) {
                        console.error("Error fetching client details:", err);
                    }
                });

                // ✅ Fetch Agreement Details
                $.ajax({
                    type: "POST",
                    url: "profile.aspx/GetAgreementsByClientId",
                    data: JSON.stringify({ clientId: clientId }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        const agreements = response.d;
                        let tableContent = "";
                        if (agreements.length > 0) {
                            agreements.forEach((agreement, index) => {
                                tableContent += `
                            <tr>
                                <td>${index + 1}</td>
                                <td>${agreement.AgreementID}</td>
                                <td>${agreement.TotalFund}</td>
                                <td>${agreement.Term}</td>
                                <td>${agreement.StartDate}</td>
                                <td>${agreement.ExpireDate}</td>
                                <td>${agreement.Priority}</td>
                                <td class="${agreement.Status === 'Running' ? 'text-success' : 'text-danger'}">
                                    ${agreement.Status}
                                </td>
                                <td>${agreement.NoOfPayments}</td>
                                <td>
                                    <button type="button" class="btn btn-primary btn-sm action-button"
                                        onclick="window.location.href='agreementDetails.aspx?AgreementID=${agreement.AgreementID}'">
                                        View
                                    </button>
                                </td>
                            </tr>`;
                            });
                        } else {
                            tableContent = `<tr><td colspan="10" class="text-center">No agreements found.</td></tr>`;
                        }
                        $("#document-table").html(`
                    <thead class="table-dark">
                        <tr>
                            <th>Sl No</th>
                            <th>Agreement Id</th>
                            <th>Funds</th>
                            <th>Term</th>
                            <th>Start Date</th>
                            <th>Expiry Date</th>
                            <th>Priority</th>
                            <th>Status</th>
                            <th>No of Payment</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>${tableContent}</tbody>
                `);
                    },
                    error: function (error) {
                        console.error("Error fetching agreement data:", error.responseText);
                    }
                });
            }

            // ✅ FIX: Ensure Button Exists Before Binding
            $(document).on("click", "#transaction", function () {
                console.log("Current clientId:", clientId); // Added logging

                if (!clientId) {
                    alert("Client ID is missing!");
                    return;
                }

                console.log("Fetching transactions for Client ID:", clientId);
                $.ajax({
                    type: "POST",
                    url: "profile.aspx/GetTransactionHistory",
                    data: JSON.stringify({ clientId: clientId }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        console.log("Full response:", response);

                        // Parse the nested response
                        const responseData = response.d;

                        console.log("Response success:", responseData.success);
                        console.log("Response data:", responseData.data);

                        if (!responseData.success) {
                            alert(responseData.message);
                            return;
                        }

                        const transactions = responseData.data; // Note the change here
                        console.log("Transactions:", transactions);

                        let tableContent = "";
                        if (transactions && transactions.length > 0) {
                            transactions.forEach((transaction, index) => {
                                tableContent += `
                    <tr>
                        <td>${index + 1}</td>
                        <td>${transaction.AgreementId}</td>
                        <td>${transaction.DepositAmount}</td>
                        <td>${transaction.DepositDate}</td>
                        <td>${transaction.WithdrawalAmount}</td>
                        <td>${transaction.WithdrawalDate}</td>
                        <td>${transaction.ActiveFund}</td>
                        <td>${transaction.Profit}</td>
                    </tr>`;
                            });

                            console.log("Generated table content:", tableContent);
                            $("#transactionx tbody").html(tableContent);
                            $("#transactionx").show();
                        } else {
                            console.warn("No transactions found");
                            alert("No transaction history found.");
                            $("#transactionx").hide();
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("AJAX Error:", {
                            status: status,
                            error: error,
                            responseText: xhr.responseText
                        });
                        alert("An error occurred while fetching data.");
                    }
                });
            });
        });
           
    </script>



</head>
<body>
    <form id="form1" runat="server">
        <div>
             <ucx1:MyUserControl11 runat="server" />

               <div calss="profile">
                                        <div class="profile-header">
            <div class="card current-funds">500,000.00<br><span>Current Funds</span></div>
            <div class="card total-profit">76,000.00<br><span>No. of Payments</span></div>
            <div class="card total-agreement">08<br><span>Total Agreement</span></div>
            <div class="card closed-agreement">02<br><span>Closed Agreement</span></div>
        </div>

        <!-- Main Content: Left-Right Layout -->
        <div class="content">
            <!-- Left Section: Profile Details -->
            <div class="profile-details">
                <h2>Client Details</h2>
                <p><strong>Client Name:</strong></p>
                <p><strong>Client ID:</strong></p>
                <p><strong>Joining Date:</strong></p>
                <p><strong>Refer By:</strong></p>
                <p><strong>Mobile:</strong> </p>
                <p><strong>Total Agreement:</strong> </p>
                <p><strong>Current Capital:</strong> </p>
                <p><strong>Total Profit:</strong> </p>
                <p><strong>Nominee:</strong> </p>
                <p><strong>District:</strong></p>
                <button>Edit</button>
            </div>

            <!-- Right Section: Table and Tabs -->
            <div class="main-content">
                <!-- Tabs -->
             
        <div class="tabs">
            <button type="button" class="tab-btn active" id="document" data-target="#document-table">Document</button>
            <button type="button" class="tab-btn" id="transaction" data-target="#transaction-history-table">Transaction History</button>
        </div>

        <div class="table-container">
            <!-- Document Table -->
            <table id="document-table" class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>Sl No</th>
                        <th>Aggrement Id</th>
                        <th>Funds</th>
                        <th>Term</th>
                        <th>Start Date</th>
                        <th>Expairy Date</th>
                        <th>Priority</th>
                        <th>Status</th>
                        <th>No of payment</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                   
                </tbody>
            </table>

            <!-- Profit History Table -->

            <!-- Transaction History Table -->
<table id="transactionx" class="table table-bordered table-striped" style="display: none;">
    <thead class="table-dark">
        <tr>
            <th>Sl No</th>
            <th>AgreementId</th>
            <th>DepositAmount</th>
            <th>DepositDate</th>
            <th>WithdrawalAmount</th>
            <th>WithdrawalDate</th>
            <th>ActiveFund</th>
            <th>Profit</th>
        </tr>
    </thead>
    <tbody>
    </tbody>
</table>
        </div>
    </div>



            </div>
        </div>

               </div>

        
    </form>

 
</body>
</html>

