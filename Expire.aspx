<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Expire.aspx.cs" Inherits="Expire" %>
<%@ Register TagPrefix="ucx1" TagName="MyUserControl11" Src="~/sidenav2.ascx" %>
<%@ Register TagPrefix="ucx" TagName="MyUserControl1" Src="~/header.ascx" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

          <ucx:MyUserControl1 runat="server" />

    <title></title>
</head>
<body class="bg-light">
                 <ucx1:MyUserControl11 runat="server" />

    <div class="container mt-4">
        <h2 class="mb-4">Expires Agreement</h2>
        
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card bg-danger text-white">
                    <div class="card-body text-center">
                        <h3>25000.00</h3>
                        <p class="mb-0">Capital Expire</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-danger text-white">
                    <div class="card-body text-center">
                        <h3>05</h3>
                        <p class="mb-0">Documents Expiring</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-body">
                <table id="agreementTable" class="table table-striped table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th>Sl No</th>
                            <th>Agreement ID</th>
                            <th>Client Name</th>
                            <th>Funds</th>
                            <th>Term</th>
                            <th>Priority</th>
                            <th>Start Date</th>
                            <th>Expire Date</th>
                            <th>Status</th>
                            <th>Refer By</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>AG2589047</td>
                            <td>MGJ POD</td>
                            <td>200,000.00</td>
                            <td>3</td>
                            <td>P2</td>
                            <td>07-10-2024</td>
                            <td>07-01-2025</td>
                            <td>Active</td>
                            <td>Danish</td>
                            <td><button class="btn btn-sm btn-primary">More</button></td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>AG2589047</td>
                            <td>MGJ POD</td>
                            <td>700,000.00</td>
                            <td>6</td>
                            <td>P5</td>
                            <td>01-03-2024</td>
                            <td>02-10-2025</td>
                            <td>Active</td>
                            <td>Danish</td>
                            <td><button class="btn btn-sm btn-primary">More</button></td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>AG3457826</td>
                            <td>OLA ELE</td>
                            <td>225,000.00</td>
                            <td>3</td>
                            <td>P1</td>
                            <td>02-10-2024</td>
                            <td>03-01-2025</td>
                            <td>Active</td>
                            <td>Danish</td>
                            <td><button class="btn btn-sm btn-primary">More</button></td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td>AG7586214</td>
                            <td>KPS GHF</td>
                            <td>100,000.00</td>
                            <td>3</td>
                            <td>P5</td>
                            <td>02-10-2024</td>
                            <td>03-01-2025</td>
                            <td>Active</td>
                            <td>Sagar</td>
                            <td><button class="btn btn-sm btn-primary">More</button></td>
                        </tr>
                        <tr>
                            <td>5</td>
                            <td>AG6317201</td>
                            <td>ABC RKJ</td>
                            <td>900,000.00</td>
                            <td>6</td>
                            <td>P3</td>
                            <td>02-08-2024</td>
                            <td>03-01-2025</td>
                            <td>Active</td>
                            <td>Mirza</td>
                            <td><button class="btn btn-sm btn-primary">More</button></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

 
    <script>
        $(document).ready(function() {
            $('#agreementTable').DataTable({
                "pageLength": 10,
                "searching": true,
                "ordering": true,
                "responsive": true,
                "language": {
                    "paginate": {
                        "next": "→",
                        "previous": "←"
                    }
                }
            });
        });
    </script>
</body>
</html>