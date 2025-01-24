<%@ Page Language="C#" AutoEventWireup="true" CodeFile="agreementlist.aspx.cs" Inherits="agreementlist" %>


<%@ Register TagPrefix="ucx1" TagName="MyUserControl11" Src="~/sidenav2.ascx" %>
<%@ Register TagPrefix="ucx" TagName="MyUserControl1" Src="~/header.ascx" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" />
        <link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.dataTables.min.css" />
                <ucx:MyUserControl1 runat="server" />

        <style>
        /* General Reset */
			
		table.dataTable {
			width: 95% !important;
			margin: 0 auto;
			clear: both;
			border-collapse: separate;
			border-spacing: 0;
		}
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
    display: flex
;
    justify-content: space-around;
    margin-top: 85px;
    margin-left: 85px;
    margin-bottom: 0;
    background-color: #ffffff;
    padding: 10px;
    border-radius: 10px;
    gap: 15px;
}
.agreement-table{
        margin-left: 85px;
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
        .document-expiring { background-color: #a265dd !important; }


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
                table button{
            background-color: #28a745;
    color: #fff;
    border: 1px solid #fff;
    padding: 7px;
    border-radius: 11px;
        }
        table button:hover{
            background-color:#0a671f;
        }
    </style>


        <script>

            $(document).ready(function () {
                var table = $('#data-table').DataTable({
                    pageLength: 20,
                    responsive: true,
                    dom: 'Bfrtip'
                });

                $('#status-filter').on('change', function () {
                    const filterValue = $(this).val();
                    table.column(6).search(filterValue).draw();
                });



                $.ajax({
                    type: "POST",
                    url: "agreementlist.aspx/GetAgreementData",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var data = response.d; // Deserialize response data
                        var tableBody = $("#data-table tbody");
                        tableBody.empty(); // Clear existing rows

                        // Iterate through the data and append to the table
                        $.each(data, function (index, item) {
                            var row = `<tr>
                        <td>${index + 1}</td>
                        <td>${item.AgreementID}</td>
                        <td>${item.ClientName}</td>
                        <td>${item.TotalFund}</td>
                        <td>${item.Refer}</td>
                        <td>${item.Priority}</td>
                        <td>${(item.StartDate)}</td>
                        <td>${(item.ExpireDate)}</td>
                        <td>${item.ProfitClient}</td>
                    </tr>`;
                            tableBody.append(row);
                        });
                    },
                    error: function (error) {
                        console.error("Error fetching data:", error);
                    }
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
            <div class="card current-funds">50,000,000.00<br><span>Total Funds</span></div>
            <div class="card total-profit">76,000.00<br><span>Total Investors</span></div>
            <div class="card total-agreement">8,20,000<br><span>Profit Payment</span></div>
            <div class="card closed-agreement">02<br><span>Upcoming Expiring</span></div>
            <div class="card document-expiring">02<br><span>Documents Expiring</span></div>
        </div>

        <!-- Main Content: Left-Right Layout -->





<div class="agreement-table">
    <table id="data-table">
        <thead>
            <tr>
                <th>Sl No</th>
                <th>Agreement ID</th>
                <th>Client Name</th>
                <th>Funds</th>
                <th>Team</th>
                <th>Priority</th>
                <th>Start Date</th>
                <th>Expiry Date</th>
                <th>Status</th>
                <th>Total Profit</th>
                <th>Referred By</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
          
        </tbody>
    </table>
</div>
        </div>
    </form>


</body>
</html>


