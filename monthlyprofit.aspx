<%@ Page Language="C#" AutoEventWireup="true" CodeFile="monthlyprofit.aspx.cs" Inherits="monthlyprofit" %>
<%@ Register TagPrefix="ucx1" TagName="MyUserControl11" Src="~/sidenav2.ascx" %>
<%@ Register TagPrefix="ucx" TagName="MyUserControl1" Src="~/header.ascx" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <ucx:MyUserControl1 runat="server" />

    <title>Monthly Profits Table</title>
    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
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
.dashboard-header h2{
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
            text-align:left;
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
        #dheader{
            margin-left:100px;
        }      
        
        #data-table{
            margin-left:50px !important;
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
    </style>

    <script>

        $(document).ready(function () {
            // Fetch data when the page loads
            $.ajax({
                type: "POST",
                url: "monthlyprofit.aspx/Getmonthlyprofit",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ search: "" }),
                success: function (response) {
                    var data = response.d;
                    var tableBody = $("#data-table tbody");
                    tableBody.empty();

                    if (Array.isArray(data) && data.length > 0) {
                        $.each(data, function (index, item) {
                            var row = `
                        <tr>
                            <td>${index + 1}</td>
                            <td>${item.AgreementID}</td>
                            <td>${item.ClientName}</td>
                            <td>${item.Funds}</td>
                            <td>${item.Term}</td>
                            <td>${item.Priority}</td>
                            <td>${item.StartDate}</td>
                            <td>${item.ExpireDate}</td>
                            <td>${item.BankAccount}</td>
                            <td>${item.ReferBy}</td>
                            <td>
                                <button type="button" 
                                        class="expand-btn btn btn-sm btn-info" 
                                        data-term="${item.Term}"
                                        data-start-date="${item.StartDate}">
                                    <i class="fas fa-chevron-down"></i>
                                </button>
                            </td>
                        </tr>`;
                            tableBody.append(row);
                        });
                    } else {
                        tableBody.append('<tr><td colspan="11">No data available</td></tr>');
                    }
                },
                error: function (error) {
                    console.error("Error fetching data:", error);
                }
            });

            // Handle button clicks for dynamically added buttons
            $(document).on("click", ".expand-btn", function () {
                var $button = $(this);
                var $row = $button.closest("tr");
                var term = parseInt($button.data("term"));
                var startDate = new Date($button.data("start-date"));

                if ($row.next().hasClass("expandable-row")) {
                    $row.next().toggle();
                } else {
                    // Generate payment sections based on term
                    var payments = generatePaymentDates(startDate, term);
                    var paymentElements = payments.map(payment => `
                <div class="payment-status-container">
                    <div class="payment-date">${payment.date}</div>
                    <div class="payment-amount">₹ ${payment.amount}</div>
                    <button class="upload-file-btn">
                        <i class="fas fa-upload"></i> Upload File
                    </button>
                    <div class="status-indicator status-${payment.status.toLowerCase()}">
                        ${payment.status}
                    </div>
                    <button class="profile-btn">
                        Go To Profile
                    </button>
                </div>
            `).join('');

                    var expandableRow = `
                <tr class="expandable-row">
                    <td colspan="11">
                        <div class="expandable-content">
                            ${paymentElements}
                        </div>
                    </td>
                </tr>`;

                    $row.after(expandableRow);
                }

                // Toggle the arrow icon
                $button.find('i').toggleClass('fa-chevron-down fa-chevron-up');
            });
        });

        // Function to generate payment dates based on term
        function generatePaymentDates(startDate, term) {
            let payments = [];
            let currentDate = new Date(startDate);

            for (let i = 0; i < term; i++) {
                // Add one month to the date
                currentDate.setMonth(currentDate.getMonth() + 1);

                // Format the date
                let formattedDate = formatDate(currentDate);

                // Add payment object
                payments.push({
                    date: formattedDate,
                    amount: "12,000.00",
                    status: i === 0 ? "Paid" : "Pending" // First payment is Paid, rest are Pending
                });
            }

            return payments;
        }

        // Function to format date as "3rd Jan 2025"
        function formatDate(date) {
            const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
            const day = date.getDate();
            const month = months[date.getMonth()];
            const year = date.getFullYear();

            // Add ordinal suffix to day
            const suffix = getDaySuffix(day);

            return `${day}${suffix} ${month} ${year}`;
        }

        // Function to get day suffix (st, nd, rd, th)
        function getDaySuffix(day) {
            if (day > 3 && day < 21) return 'th';
            switch (day % 10) {
                case 1: return "st";
                case 2: return "nd";
                case 3: return "rd";
                default: return "th";
            }
        }
    </script>





</head>
<body>
 <ucx1:MyUserControl11 runat="server" />

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
        <input type="text" class="search-input" placeholder="Search....">
        <i class="fas fa-search search-icon"></i>
    </div>

    <div class="table-container p-3 bg-light rounded shadow">
    <table id="data-table" class="table table-striped table-bordered table-hover">
      
            <thead>
                <tr>
                    <th>Sl No</th>
                    <th>Agreement ID</th>
                    <th>Client Name</th>
                    <th>Funds</th>
                    <th>Term</th>
                    <th>Priority</th>
                    <th>Start Date</th>
                    <th>Expire Date</th>
                    <th>Bank Account / UPI</th>
                    <th>Refer By</th>
                    <th>Payments</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>

</body>
</html>       