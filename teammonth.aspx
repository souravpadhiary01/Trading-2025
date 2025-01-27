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

        .container-fluid {
            width: 97% !important;
            margin-left: 45px !important;
        }
    </style>



    <script>
        $(document).ready(function () {


            // Initialize modal
            //const payModal = new bootstrap.Modal($('#payModal')[0]);

            // Open modal on "Pay" button click
            $('.abcd').on('click', function () {
                console.log("button clicked");

                // Get the row data of the clicked button
                var row = $(this).closest('tr');
                var memberName = row.find('td').eq(2).text();  // Assuming Member Name is in 3rd column
                var memberID = row.find('td').eq(1).text();    // Assuming Member ID is in 2nd column
                var clientPayments = row.find('td').eq(6).text(); // Assuming Client Payments is in 7th column
                var clientFund = row.find('td').eq(4).text();  // Assuming Client Fund is in 5th column

                // Set the data in the modal form
                $('#payMemberName').val(memberName);
                $('#payMemberID').val(memberID);
                $('#payClientPayments').val(clientPayments);
                $('#payClientFund').val(clientFund);

                // Show the modal
                $('#payModal').modal('show');
            });


            // File input change event
            $('.file-input').on('change', function () {
                const inputId = $(this).attr('id');
                const file = this.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        const base64Data = e.target.result; // Base64 encoded data
                        const fileName = file.name; // File name

                        if (inputId === 'payFileUpload') {
                            $('#hiddenFileData').val(base64Data); // Set Base64 data
                            $('#hiddenFileName').val(fileName); // Set file name
                            console.log('File loaded successfully:', fileName);
                        }
                    };
                    reader.readAsDataURL(file); // Read file as Base64
                } else {
                    alert('No file selected.');
                }
            });

            // Button click event
            $('#submitPay').on('click', function () {

                const formData = {
                    name: $('#payMemberName').val().trim(),
                    memberid: $('#payMemberID').val().trim(),
                    transctionamount: $('#payTransactionAmount').val().trim(),
                    transctiontype: $('#payTransactionType').val().trim(),
                    transctionby: $('#transctionby').val().trim(),
                    payClientPayments: $('#payClientPayments').val().trim(),
                    payClientFund: $('#payClientFund').val().trim(),
                    remark: $('#payRemark').val().trim(),
                    Uploadpicfile: $('#hiddenFileData').val(), // Hidden field for Base64 data
                    Uploadpathfile: $('#hiddenFileName').val(), // Hidden field for file name
                };

              
              

                console.log('Submitting data:', formData);

                $.ajax({
                    type: 'POST',
                    url: 'teammonth.aspx/InsertPaymodal',
                    data: JSON.stringify({ data: formData }),
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function (response) {
                        if (response.d.includes('successfully')) {
                            alert('Team payment successfully!');
                            location.reload(); // Reload page after success
                        } else {
                            alert(response.d);
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error('Error:', error);
                        alert('An error occurred while saving the data. Please try again.');
                    }
                });
            });
           




            // File input change event
            $('.file-input').on('change', function () {
                const inputId = $(this).attr('id');
                const file = this.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        const base64Data = e.target.result; // Base64 encoded data
                        const fileName = file.name; // File name

                        if (inputId === 'file') {
                            $('#hidenx').val(base64Data); // Set Base64 data
                            $('#hiddenx').val(fileName); // Set file name
                            console.log('File loaded successfully:', fileName);
                        }
                    };
                    reader.readAsDataURL(file); // Read file as Base64
                } else {
                    alert('No file selected.');
                }
            });

            // Button click event
            $('#btn1').on('click', function (event) {
                event.preventDefault(); // Prevent default form submission

                const formData = {
                    name: $('#name').val().trim(),
                    memberid: $('#memberid').val().trim(),
                    transctionamount: $('#amount').val().trim(),
                    transctiontype: $('#type').val().trim(),
                    transctionby: $('#transctionby').val().trim(),
                    remark: $('#remark').val().trim(),
                    picfile: $('#hidenx').val(), // Hidden field for Base64 data
                    pathfile: $('#hiddenx').val(), // Hidden field for file name
                };

                if (!formData.name || !formData.memberid || !formData.transctionamount || !formData.transctiontype) {
                    alert('Please fill in all required fields.');
                    return;
                }

                if (!formData.picfile || !formData.pathfile) {
                    alert('Please upload a valid file.');
                    return;
                }

                console.log('Submitting data:', formData);

                $.ajax({
                    type: 'POST',
                    url: 'teammonth.aspx/InsertInvestor',
                    data: JSON.stringify({ data: formData }),
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function (response) {
                        if (response.d.includes('successfully')) {
                            alert('Investor added successfully!');
                            location.reload(); // Reload page after success
                        } else {
                            alert(response.d);
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error('Error:', error);
                        alert('An error occurred while saving the data. Please try again.');
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
                    <div class="d-flex gap-3" id="transactionModal1">
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
                            <td>
                                <button type="button" class="btn btn-primary btn-sm abcd">Pay</button></td>
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
                            <td>
                                <button type="button" class="btn btn-primary btn-sm abcd">Pay</button></td>
                        </tr>
                        <!-- Add other rows similarly -->
                    </tbody>
                </table>
            </div>
              <input type="hidden" id="hiddenFileData" />
              <input type="hidden" id="hiddenFileName" />
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
                                            <input type="text" class="form-control" id="name" placeholder="Search Member Name">
                                        </div>
                                        <div class="form-group">
                                            <label>Member ID:</label>
                                            <input type="text" class="form-control" id="memberid" placeholder="Auto Fetch once select Name">
                                        </div>
                                        <div class="form-group">
                                            <label>Transaction Amount:</label>
                                            <input type="text" class="form-control" id="amount" placeholder="Enter Transaction Amount">
                                        </div>
                                        <div class="form-group">
                                            <label>Transaction Type:</label>
                                            <select class="form-control" id="type">
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
                                            <input type="text" class="form-control" id="transctionby" value="Admin">
                                        </div>
                                        <div class="form-group">
                                            <label>Upload File:</label>
                                            <div class="input-group">
                                                <input type="file" class="form-control file-input" id="file">
                                            </div>
                                        </div>
                                        <input type="hidden" id="hidenx" />
                                        <input type="hidden" id="hiddenx" />
                                        <div class="form-group">
                                            <label>Remark:</label>
                                            <textarea class="form-control" id="remark" placeholder="Remark to Member"></textarea>
                                        </div>
                                    </div>


                                    <input type="hidden" value="" id="hiden" runat="server" />
                                    <input type="hidden" value="" id="hidden" runat="server" />

                                </div>
                                <div class="text-center">
                                    <button type="button" id="btn1" class="pay-button">Pay</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
           
             
            <!-- Pay Modal -->
<!-- Button to Open Pay Modal -->
<%--<button type="button" class="btn btn-primary btn-sm abcd" data-bs-toggle="modal" data-bs-target="#payModal">Pay</button>--%>

<!-- Pay Modal -->
<!-- Button to Open Pay Modal -->
<%--<button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#payModal">Pay</button>--%>

<!-- Pay Modal -->
<div class="modal fade" id="payModal" tabindex="-1" aria-labelledby="payModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="payModalLabel">Pay Member</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Member Name:</label>
                                <input type="text" class="form-control" id="payMemberName" placeholder="Enter Member Name">
                            </div>
                            <div class="form-group">
                                <label>Member ID:</label>
                                <input type="text" class="form-control" id="payMemberID" placeholder="Enter Member ID">
                            </div>
                            <div class="form-group">
                                <label>Transaction Amount:</label>
                                <input type="text" class="form-control" id="payTransactionAmount" placeholder="Enter Transaction Amount">
                            </div>
                            <div class="form-group">
                                <label>Transaction Type:</label>
                                <select class="form-control" id="payTransactionType">
                                    <option>New Capital</option>
                                    <option>Profit</option>
                                    <option>Capital Return / Profit</option>
                                    <option>Capital Return</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Upload File:</label>
                                <div class="input-group">
                                    <input type="file" class="form-control file-input" id="payFileUpload">
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Client Payments:</label>
                                <input type="text" class="form-control" id="payClientPayments" placeholder="Enter Client Payments">
                            </div>
                            <div class="form-group">
                                <label>Client Fund:</label>
                                <input type="text" class="form-control" id="payClientFund" placeholder="Enter Client Fund">
                            </div>
                            <div class="form-group">
                                <label>Remark:</label>
                                <textarea class="form-control" id="payRemark" placeholder="Add any remarks..."></textarea>
                            </div>
                        </div>
                      
                    </div>
                    <div class="text-center">
                        <button type="button" id="submitPay" class="btn btn-success">SubmitPay</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</div>


         <div></div>
       
    </form>
</body>

</html>
