<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Monthlypayment.aspx.cs" Inherits="Monthlypayment" %>

<%@ Register TagPrefix="ucx1" TagName="MyUserControl11" Src="~/sidenav2.ascx" %>
<%@ Register TagPrefix="ucx" TagName="MyUserControl1" Src="~/header.ascx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

        <ucx:MyUserControl1 runat="server" />

</head>

<style>
    / Previous styles remain the same until expand-btn /
    body {
        font-family: Arial, sans-serif;
        background-color: #e8f1f5;
        padding: 20px;
        margin: 0;
    }

    .dashboard-header {
        background-color: white;
        border-radius: 8px;
        padding: 20px;
        margin-bottom: 20px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        width: 50%;
    }

        .dashboard-header h2 {
            margin: 0 0 20px 0;
        }

    .stats-container {
        display: flex;
        gap: 20px;
    }

    .stat-card {
        padding: 15px;
        border-radius: 8px;
        color: white;
        flex: 1;
    }

        .stat-card.total {
            background-color: #0a2647;
        }

        .stat-card.client {
            background-color: #b22222;
        }

        .stat-card.team {
            background-color: #228b22;
        }

    .stat-amount {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 5px;
    }

    .stat-label {
        font-size: 14px;
    }

    .search-container {
        text-align: right;
        margin: 20px 0;
        position: relative;
    }

    .search-input {
        padding: 8px 32px 8px 12px;
        border: 1px solid #ccc;
        border-radius: 4px;
        width: 200px;
    }

    .search-icon {
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        color: #666;
    }

    .table-container {
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        overflow: hidden;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th {
        background-color: #0a2647;
        color: white;
        padding: 12px;
        text-align: center;
        font-weight: normal;
    }

    td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    .expand-btn {
        background: none;
        color: #0a2647;
        cursor: pointer;
        font-size: 14px;
        padding: 5px;
        border: 1px solid #bfbfbf;
        background-color: #d8e7ff;
    }

    .expandable-row {
        display: none;
        background-color: #f0f6ff;
    }

    .expandable-content {
        display: flex;
        justify-content: space-around;
        align-items: center;
        padding: 15px 20px;
    }

    .installment-box {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .date-amount {
        text-align: left;
    }

    .installment-date {
        font-size: 14px;
        color: #333;
        margin-bottom: 4px;
    }

    .installment-amount {
        font-size: 18px;
        font-weight: bold;
        color: #000;
    }

    .upload-file-btn {
        padding: 6px 12px;
        background-color: #e0e0e0;
        border: none;
        border-radius: 4px;
        color: #333;
        cursor: pointer;
        font-size: 13px;
        display: flex;
        align-items: center;
        gap: 5px;
    }

    .status-btn {
        padding: 6px 16px;
        border: none;
        border-radius: 4px;
        color: white;
        cursor: pointer;
        font-size: 13px;
        min-width: 80px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 5px;
    }

    .status-paid {
        background-color: #006400;
    }

    .status-pending {
        background-color: #cc0000;
    }

    .profile-btn {
        background-color: #1a4157;
        color: white;
        padding: 8px 16px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 13px;
        display: flex;
        align-items: center;
        gap: 5px;
    }

    .pagination {
        margin-top: 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 10px;
    }

    .pagination-info {
        color: #666;
    }

    .pagination-controls button {
        padding: 8px 12px;
        margin: 0 4px;
        border: 1px solid #ddd;
        background-color: white;
        cursor: pointer;
        border-radius: 4px;
    }

        .pagination-controls button:hover {
            background-color: #f0f0f0;
        }

    #dheader {
        margin-left: 100px;
    }

    #data-table {
        margin-left: 50px !important;
    }


    text-align: center;
    min-width: 100px;
    }

    .status-paid {
        background-color: #198754;
    }

    .status-pending {
        background-color: #dc3545;
    }

    .profile-btn {
        background-color: #0a2647;
        color: white;
        border: none;
        padding: 8px 15px;
        border-radius: 4px;
        cursor: pointer;
        margin-left: auto;
    }
/* Modal Overlay */
.modal.fade {
    background-color: rgba(0, 0, 0, 0.7); /* Dim background */
}

/* Modal Content */
.modal-content {
    border-radius: 15px; /* Rounded corners */
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5); /* Add shadow */
    animation: fadeIn 0.4s ease-out;
}

/* Modal Header */
.modal-header {
    background: linear-gradient(to right, #007bff, #00d4ff); /* Gradient header */
    color: white;
    border-bottom: 2px solid #ddd;
}

.modal-title {
    font-weight: bold;
    font-size: 1.8rem;
}

/* Close Button Styling */
.btn-close {
    filter: brightness(0) invert(1); /* White close button */
}

/* Modal Body */
.modal-body {
    background-color: #f9f9f9;
    padding: 1.5rem;
}

/* Form Labels */
.modal-body .form-label {
    font-weight: 600;
    color: #333;
}

/* Input Fields */
.modal-body .form-control {
    border: 1px solid #ccc;
    border-radius: 8px;
    padding: 0.8rem;
    transition: border-color 0.3s ease, box-shadow 0.3s ease;
}

.modal-body .form-control:focus {
    border-color: #007bff;
    box-shadow: 0 0 8px rgba(0, 123, 255, 0.5);
    outline: none;
}

/* File Input */
.modal-body input[type="file"] {
    border: 1px solid #ccc;
    border-radius: 8px;
    padding: 0.6rem;
    cursor: pointer;
}

/* Select Dropdown */
.modal-body select {
    border: 1px solid #ccc;
    border-radius: 8px;
    padding: 0.8rem;
    font-size: 1rem;
}

/* Modal Footer */
.modal-footer {
    background-color: #f1f1f1;
    padding: 1rem;
    display: flex;
    justify-content: flex-end;
    gap: 1rem;
}

/* Footer Buttons */
.modal-footer .btn {
    padding: 0.8rem 1.5rem;
    font-size: 1rem;
    border-radius: 8px;
    transition: all 0.3s ease;
}

.modal-footer .btn-secondary {
    background-color: #d6d6d6;
    color: #333;
}

.modal-footer .btn-secondary:hover {
    background-color: #bbb;
    color: white;
}

.modal-footer .btn-primary {
    background-color: #007bff;
    color: white;
    border: none;
}

.modal-footer .btn-primary:hover {
    background-color: #0056b3;
}

/* Fade In Animation */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: scale(0.95);
    }
    to {
        opacity: 1;
        transform: scale(1);
    }
}
</style>



        <script>
            $(document).ready(function () {
                // When the Member ID input loses focus
                $('#memberID').on('change', function () {
                    let memberID = $(this).val(); // Get the Member ID value

                    if (memberID) {
                        $.ajax({
                            url: 'alltransactions.aspx/GetClientName', // The WebMethod endpoint
                            type: 'POST',
                            contentType: 'application/json; charset=utf-8', // Required for WebMethod
                            dataType: 'json', // The response is JSON
                            data: JSON.stringify({ clientId: memberID }), // Pass the Member ID as JSON
                            success: function (response) {
                                let clientName = response.d; // The WebMethod returns the data under "d"
                                if (clientName) {
                                    $('#memberName').val(clientName); // Set the Member Name
                                } else {
                                    alert('No data found for the provided Member ID');
                                }
                            },
                            error: function (error) {
                                console.error('Error fetching client details:', error);
                                alert('An error occurred while fetching client details.');
                            }
                        });
                    }
                });
    });
    </script>

    


<body>
    <ucx1:MyUserControl11 runat="server" />


    <form id="form1" runat="server">

        <div class="dashboard-header" id="dheader">
            <h2>Monthly Profits</h2>
            <div class="stats-container">
                <div class="stat-card total">
                    <div class="stat-amount">500000.00</div>
                    <div class="stat-label">Total Funds</div>
                </div>
                <div class="stat-card client">
                    <div class="stat-amount">500,000.00</div>
                    <div class="stat-label">Client Payments</div>
                </div>
                <div class="stat-card team">
                    <div class="stat-amount">250000.00</div>
                    <div class="stat-label">Team Payments</div>
                </div>
            </div>
        </div>
        <div class="search-container">
           <%-- btn to open modal--%>
            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#TeamTransactionModal">
                   +Team Transaction
              </button>
            
        </div>



        <div class="table-container p-3 bg-light rounded shadow">
            <table id="data-table" class="table table-striped table-bordered table-hover">

                <thead>
                    <tr>
                        <th>Sl No</th>
                        <th>Member ID</th>
                        <th>Member Name</th>
                        <th>Member Priority</th>
                        <th>Client Fund</th>
                        <th>Priority</th>
                        <th>No Of Clints</th>
                        <th>Client Payments </th>
                        <th>Capital Expiry</th>
                        <th>Action Status</th>

                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>

<div class="modal fade" id="TeamTransactionModal" tabindex="-1" aria-labelledby="TeamTransactionLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="TeamTransactionLabel">Team Transaction</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="TeamTransactionForm">
                    <div class="mb-3">
                        <label for="memberID" class="form-label">Member ID:</label>
                        <input type="text" class="form-control" id="memberID" name="memberID" placeholder="Enter Member ID:" required>
                    </div>
                       <div class="mb-3">
                        <label for="memberName" class="form-label">Member Name:</label>
                        <input type="text" class="form-control" id="memberName" name="memberName" placeholder="Enter Member Name:" required>
                    </div>

                    <div class="mb-3">
                        <label for="transactionAmount" class="form-label">Transaction Amount:</label>
                        <input type="text" class="form-control" id="transactionAmount" name="transactionAmount" placeholder="Enter Transaction Amount:" required>
                    </div>
                    <div class="mb-3">
                        <label for="transactionBy" class="form-label">Transaction By:</label>
                        <input type="text" class="form-control" id="transactionBy" name="transactionBy" placeholder="Enter Transaction By:">
                    </div>
                    <div class="mb-3">
                        <label for="uploadFile" class="form-label">Upload File:</label>
                        <input type="file" class="form-control" id="uploadFile" name="uploadFile" required>
                    </div>
                    <div class="mb-3">
                        <label for="priority" class="form-label">Priority:</label>
                        <select class="form-control" id="priority" name="priority" required>
                            <option selected disabled>Choose From Option</option>
                            <option value="P1">New Capital</option>
                            <option value="P2">Profit</option>
                            <option value="P3">Capital Return / Profit</option>
                            <option value="P4">Capital Return</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" id="payButton">Pay</button>
            </div>
        </div>
    </div>
</div>

    </form>
</body>
</html>
