<%@ Page Language="C#" AutoEventWireup="true" CodeFile="profile2.aspx.cs" Inherits="profile2" %>
<%@ Register TagPrefix="ucx1" TagName="MyUserControl11" Src="~/sidenav2.ascx" %>
<%@ Register TagPrefix="ucx" TagName="MyUserControl1" Src="~/header.ascx" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" />
       <link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.dataTables.min.css" />

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
        }

        table a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <ucx1:MyUserControl11 runat="server" />

               <div calss="profile">
                                        <div class="profile-header">
            <div class="card current-funds">500,000.00<br><span>Current Funds</span></div>
            <div class="card total-profit">76,000.00<br><span>Total Profit</span></div>
            <div class="card total-agreement">08<br><span>Total Agreement</span></div>
            <div class="card closed-agreement">02<br><span>Closed Agreement</span></div>
        </div>

        <!-- Main Content: Left-Right Layout -->
        <div class="content">
            <!-- Left Section: Profile Details -->
            <div class="profile-details">
                <h2>Basic Details</h2>
                <p><strong>Client Name:</strong> ABC RKJ</p>
                <p><strong>Client ID:</strong> ABC7631</p>
                <p><strong>Joining Date:</strong> 01-05-2024 (6 Months)</p>
                <p><strong>Refer By:</strong> SK DANISH RAHIM</p>
                <p><strong>Mobile:</strong> 8249756314</p>
                <p><strong>Total Agreement:</strong> 08</p>
                <p><strong>Current Capital:</strong> 500,000.00</p>
                <p><strong>Total Profit:</strong> 76,000.00</p>
                <p><strong>Nominee:</strong> MKJ RKJ</p>
                <p><strong>District:</strong> Khordha</p>
                <button>Edit</button>
            </div>

            <!-- Right Section: Table and Tabs -->
            <div class="main-content">
                <!-- Tabs -->
                <div class="tabs">
					    <button type="button" class="tab-btn active"><a href="profile.aspx" style="text-decoration: none; color: #fff;">Documents</a></button>
					<button type="button" class="tab-btn"><a href="profile2.aspx" style="text-decoration: none; color: #fff;">Payment History</a></button>
                </div>

                <!-- Table -->
                <div class="table-container">
                    <div class="filters">
                        <select id="funds-filter">
                            <option value="">Choose status</option>
                            <option value="500,000.00">500,000.00</option>
                            <option value="200,000.00">200,000.00</option>
                        </select>
                    </div>

<table id="data-table">
    <thead>
        <tr>
            <th>Sl No</th>
            <th>Date</th>
            <th>Funds</th>
            <th>Profit</th>
            <th>Previous</th>
            <th>Balance</th>
            <th>Download</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>01</td>
            <td>04-02-2025</td>
            <td>500,000.00</td>
            <td>20,000.00</td>
            <td>56,000.00</td>
            <td>76,000.00</td>
            <td><a href="#">Download</a></td>
        </tr>
      
    </tbody>
</table>

            </div>
        </div>

               </div>

        </div>
    </form>

        <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <!-- DataTable JS -->
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js"></script>

    <script>
        $(document).ready(function () {
            var table = $('#data-table').DataTable({
                pageLength: 10, // Default page length
                responsive: true,
                dom: 'Bfrtip',
                lengthMenu: [10, 25, 50, 100] // Page length options
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

            const urlParams = new URLSearchParams(window.location.search);
            const clientId = urlParams.get('ClientId');

            if (clientId) {
                // Fetch client data from the server
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

                            // Populate the profile details
                            $(".profile-details").html(`
                    <h2>Client Details</h2>
                    <p><strong>Client Name:</strong> ${client.ClientName}</p>
                    <p><strong>Client ID:</strong> ${clientId}</p>
                    <p><strong>Joining Date:</strong> ${client.JoiningDate}</p>
                    <p><strong>Refer By:</strong> ${client.ReferBy}</p>
                    <p><strong>Mobile:</strong> ${client.MobileNo}</p>
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
            } else {

            }

            if (clientId) {

                $.ajax({
                    type: "POST",
                    url: "profile.aspx/GetAgreementsByClientId",
                    data: JSON.stringify({ clientId: clientId }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        const agreements = response.d;

                        let tableBody = "";


                        agreements.forEach((agreement, index) => {
                            tableBody += `
                            <tr>
                                <td>${index + 1}</td>
                                <td>${agreement.AgreementID}</td>
                                 <td>${agreement.TotalFund}</td> 
                                 <td>${agreement.Term}</td>
                                   <td>${agreement.StartDate}</td>
                                   <td>${agreement.ExpireDate}</td>
                                     <td>${agreement.Priority}</td>
                                      <td>${agreement.Status}</td>
                                      <td>${agreement.NoOfPayments}</td>
<td><button type="button" class="btn btn-primary btn-sm action-button" onclick="window.location.href='agreementDetails.aspx?AgreementID=${agreement.AgreementID}'">Action</button></td>


                            </tr>`
                        });

                        $("#data-table tbody").html(tableBody);
                    },
                    error: function (error) {
                        console.error("Error fetching data:", error.responseText);
                    }
                });
            } else {
                console.error("ClientId not found in the URL.");
            }

        });
    </script>
</body>
</html>
