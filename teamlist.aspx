<%@ Page Language="C#" AutoEventWireup="true" CodeFile="teamlist.aspx.cs" Inherits="teamlist" %>


<%@ Register TagPrefix="ucx1" TagName="MyUserControl11" Src="~/sidenav2.ascx" %>
<%@ Register TagPrefix="ucx" TagName="MyUserControl1" Src="~/header.ascx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

        <ucx:MyUserControl1 runat="server" />
    <title></title>
  <style>
        body {
  font-family: 'Arial', sans-serif;
  background-color: #f0f8ff;
  margin: 0;
  padding: 0;
}

.container {
  background: #fff;
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

h1 {
  font-size: 24px;
  color: #333;
  font-weight: bold;
  text-align: center;
}

.card {
  background-color: #fff;
  border: 1px solid #dcdcdc;
  border-radius: 10px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.card .card-body {
  text-align: center;
  padding: 10px;
}

.card-title {
  font-size: 18px;
  color: #333;
  margin-bottom: 5px;
}

.card-text {
  font-size: 20px;
  font-weight: bold;
  color: #007bff;
}

.btn-success {
  background-color: #28a745;
  border: none;
  color: #fff;
  padding: 10px 20px;
  font-size: 14px;
  border-radius: 5px;
  font-weight: bold;
}

.btn-success:hover {
  background-color: #218838;
}

.table {
  width: 100%;
  margin-top: 20px;
  border-collapse: collapse;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.table th {
  background-color: #007bff;
  color: #fff;
  font-size: 14px;
  text-align: center;
  padding: 10px;
}

.table td {
  text-align: center;
  padding: 10px;
  font-size: 14px;
  border: 1px solid #ddd;
}

.table tr:nth-child(even) {
  background-color: #f9f9f9;
}

.btn-primary {
  background-color: #007bff;
  border: none;
  color: #fff;
  padding: 5px 10px;
  font-size: 12px;
  border-radius: 3px;
}

.btn-primary:hover {
  background-color: #0056b3;
}

#team-list-table_wrapper {
  margin-top: 20px;
}

#team-list-table_filter input {
  border: 1px solid #ccc;
  border-radius: 4px;
  padding: 5px 10px;
}

#team-list-table_filter label {
  font-weight: bold;
}

#team-list-table_paginate .paginate_button {
  background-color: #007bff;
  color: #fff;
  border: none;
  margin: 0 5px;
  padding: 5px 10px;
  font-size: 12px;
  border-radius: 3px;
}

#team-list-table_paginate .paginate_button:hover {
  background-color: #0056b3;
}

#team-list-table_info {
  font-weight: bold;
  margin-top: 10px;
}

.float-right {
  float: right;
}

    </style>

<script>
    $(document).ready(function () {
        var table = $('#team-list-table').DataTable({
            pageLength: 20,
            responsive: true,
            dom: 'Bfrtip',
            ajax: {
                url: 'teamlist.aspx/GetTeamList',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                dataSrc: function (data) {
                    return data.d;
                }
            },
            columns: [
                { data: null, render: function (data, type, row, meta) { return meta.row + 1; } },
                { data: 'MemberID' },
                { data: 'MemberName' },
                { data: 'Joining' },
                { data: 'NoOfClients' },
                { data: 'Priority' },
                { data: 'ClientFunds', render: $.fn.dataTable.render.number(',', '.', 2) },
                { data: 'ClientProfits', render: $.fn.dataTable.render.number(',', '.', 2) },
                {
                    data: null,
                    render: function (data, type, row, meta) {
                        return '<a href="#" class="btn btn-primary btn-sm">View/Edit</a>';
                    }
                }
            ]
        });
		  $('.btn-success').click(function () {
      window.location.href = 'Newmember.aspx';
  });
    });
	</script>



</head>
<body>
    <form id="form1" runat="server">
        <div>
              <ucx1:MyUserControl11 runat="server" />

             <div class="container my-5">
    <h1 class="mb-4">Team List</h1>
    <div class="row mb-4">
      <div class="col-md-3">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Team Fund</h5>
            <p class="card-text">500000.00</p>
          </div>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Total Member</h5>
            <p class="card-text">15</p>
          </div>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Client Profit</h5>
            <p class="card-text">1608000.00</p>
          </div>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Active Documents</h5>
            <p class="card-text">375</p>
          </div>
        </div>
      </div>
    </div>
    <div class="row mb-4">
      <div class="col-md-3">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Expiring Capital</h5>
            <p class="card-text">350000.00</p>
          </div>
        </div>
      </div>
      <div class="col-md-9">
        <button type="button" class="btn btn-success float-right mb-3">+ Register New Member</button>
      </div>
    </div>
    <table class="table table-striped table-bordered" id="team-list-table">
      <thead>
        <tr>
          <th>Sl No</th>
          <th>Member ID</th>
          <th>Member Name</th>
          <th>Joining</th>
          <th>No Of Clients</th>
          <th>Priority</th>
          <th>Client Funds</th>
          <th>Client Profits</th>
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
