<%@ Page Language="C#" AutoEventWireup="true" CodeFile="agreementDetails.aspx.cs" Inherits="agreementDetails" %>
<%@ Register TagPrefix="ucx1" TagName="MyUserControl11" Src="~/sidenav2.ascx" %>
<%@ Register TagPrefix="ucx" TagName="MyUserControl1" Src="~/header.ascx" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <ucx:MyUserControl1 runat="server" />
    <title></title>

    <style>
        .agreement-container {
            max-width: 1200px;
            margin: auto;
            padding: 20px;
            border-radius: 8px;
            margin-top: 45px;
        }
        .profile-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .profile-header h2 {
            color: #1a2947;
            font-size: 28px;
            font-weight: 600;
        }
        .profile-header h3 {
            color: #1a2947;
            font-size: 28px;
            font-weight: 600;
        }
        .basic-details {
            display: flex;
            justify-content: space-around;
            background-color: #1a2947;
            color: #fff;
            padding: 10px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            width: 70%;
        }
        .bd {
            margin: 0 0 10px 0;
            font-size: 22px;
            font-weight: 600;
            padding-left: 16px;
        }
        .basic-details .details-left p, 
        .basic-details .details-right p {
            margin: 9px 0;
            letter-spacing: .7px;
            font-size: 17px;
        }
        .download-btn {
            background-color: #087a9f;
            color: #fff;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
        }
        .download-btn:hover {
            background-color: #065f7d;
        }
        .transaction-details h3 {
            margin-bottom: 10px;
            color: #000000;
            margin: 0 0 10px 0;
            font-size: 22px;
            font-weight: 600;
            padding-left: 16px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        table th, table td {
            border: 1px solid #ddd;
            text-align: center;
            padding: 10px;
            font-size: 15px;
        }
        table th {
            background-color: #1a2947;
            color: #fff;
            font-size: 15px;
            font-weight: 500;
        }
        table tbody tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        table tbody tr:hover {
            background-color: #eaf4f8;
        }
        .profit-details {
            margin-top: 30px;
            padding: 20px;
        }
        .status-paid {
            color: green;
        }
        .status-pending {
            color: orange;
        }
        .download-link {
            color: blue;
            text-decoration: underline;
            cursor: pointer;
        }
        .upload-btn {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 14px;
        }

         .emergency-withdraw {
            margin-top: 30px;
            padding: 20px;
        }
        .withdraw-btn {
            background-color: #1a2947;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            float: right;
            margin-bottom: 10px;
        }
        .modal-header {
            background-color: #1a2947;
            color: white;
        }
        .modal-title {
            color: white;
        }
        .withdraw-submit-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 4px;
        }
        .read-link {
            color: #ffc107;
            text-decoration: none;
        }

          .capital-header {
            background: linear-gradient(to bottom, #f8f9fa, #e9ecef);
            padding: 15px;
            border-radius: 5px 5px 0 0;
            border: 1px solid #dee2e6;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .table-container {
            border: 1px solid #dee2e6;
            border-radius: 0 0 5px 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .table > :not(caption) > * > * {
            padding: 12px 15px;
        }
        .table > thead {
            background-color: #212529;
            color: white;
        }
        .download-link {
            color: #0d6efd;
            text-decoration: underline;
            cursor: pointer;
        }
        .status-link {
            color: #dc3545;
            text-decoration: underline;
            cursor: pointer;
        }
        .note-link {
            color: #ffc107;
            text-decoration: underline;
            cursor: pointer;
        }

          .withdrawal-header {
            background: linear-gradient(to bottom, #f8f9fa, #e9ecef);
            padding: 15px;
            border-radius: 5px;
            border: 1px solid #dee2e6;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .withdrawal-header h3 {
            margin-bottom: 0;
            font-size: 1.25rem;
        }
    </style>

      <script>
          $(document).ready(function () {
              let activefund = 0;
              const urlParams = new URLSearchParams(window.location.search);
              const agreementId = urlParams.get('AgreementID'); // Ensure AgreementID exists in the URL
              if (!agreementId) {
                  console.error("AgreementID is missing in the URL.");
                  alert("Agreement ID is required.");
                  return;
              }

              $.ajax({
                  url: 'agreementDetails.aspx/GetActiveFund',
                  method: 'POST',
                  contentType: 'application/json; charset=utf-8',
                  data: JSON.stringify({ agreementId: agreementId }),
                  success: function (response) {
                      console.log("Full Response:", response); // Log the entire response
                       activefund = response.d;
                      if (activefund !== undefined && activefund !== null) {
                          console.log("Active Fund Value:", activefund);
                      } else {
                          console.error("Active fund value is missing in the response.");
                      }
                  },
                  error: function (xhr, status, error) {
                      console.error('Error:', error);
                      alert('Failed to save data.');
                  }
              });


              $("#withdrawbtn").click(function () {
                  console.log("Withdraw button clicked");
                  $("#withdrawModal").modal('show'); // Ensure modal opens
              });


              $("#Returnbtn").click(function () {
                  console.log("Withdraw button clicked");
                  $("#capitalReturnModal").modal('show'); // Ensure modal opens
              });




              $("#Reinvestbtn").click(function () {
                  console.log("Reinvest button clicked");

                  $("#capitalReinvestModal").modal('show');

                  // AJAX request to send reinvest data to the server

              });

              $('.btn-upload').on('click', function () {
                  $(this).next('.file-input').trigger('click'); // Opens the file input dialog
              });
              $('.file-input').on('change', function () {
                  const inputId = $(this).attr('id');
                  const file = this.files[0];
                  if (file) {
                      const reader = new FileReader();
                      reader.onload = function (e) {
                          const base64Data = e.target.result;
                          const fileName = file.name;

                          // Map each file input to its respective hidden fields for base64 data and file name
                          if (inputId === 'reinvestmodalx') {
                              $('#hidden1').val(base64Data);   // base64 data for ClientReceipt
                              $('#hidden2').val(fileName);    // file name for ClientReceipt

                          }
                      };
                      reader.readAsDataURL(file); // Read file as base64
                  }
              });


              $("#Reinvestmodal").click(function () {

                  $.ajax({
                      type: "POST",
                      url: "upload.aspx/Insert", // Backend method URL
                      data: JSON.stringify({
                          ClientId: $("#clientId").val(), // Use ClientId from the client object
                          Amount: $("#amount").val(),
                          pic: $("#hidden1").val(),
                          path: $("#hidden2").val(),
                          message: $("#message").val(),
                      }),
                      contentType: "application/json; charset=utf-8",
                      dataType: "json",
                      success: function (response) {
                          // On success handler
                          alert("You have successfully registered, Thank you.");
                          window.location.reload(); // Reload the page
                      },
                      error: function (xhr, status, error) {
                          // On error handler
                          console.error("Error during reinvestment:", error);
                          alert("An error occurred while processing your request. Please try again later.");
                      }
                  });


              });
              $('.btn-download').on('click', function () {
                  alert('Download functionality coming soon!');
              });

             

              $("#Agreement").text(`Agreement ID: ${agreementId}`);


              if (agreementId) {
                  $.ajax({
                      type: "POST",
                      url: "agreementDetails.aspx/GetAgreementData",
                      data: JSON.stringify({ agreementId: agreementId }),
                      contentType: "application/json; charset=utf-8",
                      dataType: "json",
                      success: function (response) {
                          console.log(response.d); // Log the response to check if it's correct

                          const client = response.d[0]; // Access the first object in the array

                          if (client) {
                              $("#clientName").val(client.ClientName || "N/A");
                              $("#clientId").val(client.ClientId || "N/A");
                              // Ensure startDate and expireDate are defined
                              const startDate = client.StartDate || "N/A";
                              const expireDate = client.ExpireDate || "N/A";

                              const htmlContent = `
                    <div class="basic-details">
                        <div class="details-left">
                            <p><strong>Client Name:</strong> ${client.ClientName || "N/A"}</p>
                            <p><strong>Client ID:</strong> ${client.ClientId || "N/A"}</p>
                            <p><strong>Nominee:</strong> ${client.Nominee || "N/A"}</p>
                            <p><strong>Refer By:</strong> ${client.Refer || "N/A"}</p>
                            <p><strong>Account Link:</strong> ${client.Accountlink || "N/A"}</p>
                            <p><strong>Contact Number:</strong> ${client.Contact || "N/A"}</p>
                        </div>
                        <div class="details-right">
                            <p><strong>Agreement ID:</strong> ${client.AgreementID || "N/A"}</p>
                            <p><strong>Capital:</strong> ${client.Capital || "N/A"}</p>
                            <p><strong>Start Date:</strong> ${startDate}</p>
                            <p><strong>Expire Date:</strong> ${expireDate}</p>
                            <p><strong>Term:</strong> ${client.Term || "N/A"}</p>
                         
                            <p><strong>Agreement Status:</strong> ${client.Status || "Active"}</p>
                            <button class="download-btn">Download</button>
                        </div>
                    </div>
                `;

                              // Insert the content into the container
                              $("#detailsContainer").html(htmlContent);
                          } else {
                              alert("No data found for the provided Agreement ID.");
                          }
                      },
                      error: function (error) {
                          console.error("Error fetching data:", error.responseText);
                          alert("An error occurred while fetching agreement details. Please try again.");
                      }
                  });
              } else {
                  console.error("AgreementID not found in the URL.");
                  alert("Agreement ID is missing from the URL.");
              }






              if (agreementId) {
                  console.log("Agreement ID found:", agreementId);  // Log the Agreement ID to confirm it's set

                  $.ajax({
                      type: "POST",
                      url: "agreementDetails.aspx/GetAgreementDatax",
                      data: JSON.stringify({ agreementId: agreementId }),
                      contentType: "application/json; charset=utf-8",
                      dataType: "json",
                      success: function (response) {
                          console.log("AJAX success response:", response);  // Log the entire response to check if it contains the expected data

                          if (response.d && response.d.length > 0) {
                              let tableContent = '';
                              response.d.forEach((agreement, index) => {
                                  console.log(`Processing agreement ${index + 1}:`, agreement);  // Log each agreement object

                                  let transactionDate = agreement.CurrentTransaction;
                                  let investmentStartDate = agreement.StartDate;
                                  let currentDate = new Date();

                                  // Calculate Days in Current Month
                                  let daysInCurrentMonth = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0).getDate();

                                  // Calculate Days Invested
                                  let daysInvested = agreement.DaysInvestment || "N/A";

                                  // Calculate Profits
                                  let firstMonthTotalProfit = parseFloat(agreement.Profit) || 0;
                                  let dailyProfit = parseFloat(firstMonthTotalProfit / daysInvested);
                                  let monthlyProfit = parseFloat(dailyProfit * daysInCurrentMonth);

                                  // Log calculated values


                                  tableContent += `
                        <tr>
                            <td>${index + 1}</td>
                            <td>${transactionDate}</td>
                            <td>${daysInCurrentMonth}</td>
                            <td>${agreement.TransactionAmount || "N/A"}</td>
                            <td><a href="${agreement.ClientReceipt || "#"}" target="_blank">View</a></td>
                            <td><a href="${agreement.ClientReceiptPath || "#"}" target="_blank">View</a></td>
                            <td>${agreement.StartDate}</td>
                            <td>${daysInvested}</td>
                            <td>${monthlyProfit.toFixed(0) || "N/A"}</td>
                            <td>${dailyProfit.toFixed(2) || "N/A"}</td>
                            <td>${firstMonthTotalProfit || "N/A"}</td>
                        </tr>
                    `;
                              });

                              $("#transactionTableBody").html(tableContent);
                              console.log("Table content inserted successfully.");  // Log when the table content is inserted
                          } else {
                              console.log("No data found for the provided Agreement ID.");  // Log if no data was returned
                              alert("No data found for the provided Agreement ID.");
                          }
                      },
                      error: function (error) {
                          console.error("AJAX error:", error);  // Log the entire error response to troubleshoot
                          alert("Error fetching data: " + error.responseText);  // Display error message
                      }
                  });
              } else {
                  console.error("AgreementID not found in the URL.");  // Log if Agreement ID is missing
              }


              $('.btn-upload').on('click', function () {
                  $(this).next('.file-input').trigger('click'); // Opens the file input dialog
              });
              $('.file-input').on('change', function () {
                  const file = this.files[0];
                  if (file) {
                      const reader = new FileReader();
                      reader.onload = function (e) {
                          $('#hiden').val(e.target.result); // Store Base64 data
                          $('#hidden').val(file.name); // Store file name
                      };
                      reader.readAsDataURL(file); // Read the file
                  } else {
                      console.error("No file selected.");
                  }
              });

              // Handle form submission on button click
              $(document).ready(function () {
                  let activefund = 0; // Initialize active fund variable

                  // Fetch Active Fund on Page Load
                  $.ajax({
                      url: 'agreementDetails.aspx/GetActiveFund',
                      method: 'POST',
                      contentType: 'application/json; charset=utf-8',
                      data: JSON.stringify({ agreementId: agreementId }),
                      success: function (response) {
                          console.log("Full Response:", response); // Log the entire response
                          activefund = response.d; // Assign the fetched active fund
                          if (activefund !== undefined && activefund !== null) {
                              console.log("Active Fund Value:", activefund);
                              $('#activeFund').val(activefund); // Display the initial active fund in the input field
                          } else {
                              console.error("Active fund value is missing in the response.");
                              alert("Failed to retrieve active fund.");
                          }
                      },
                      error: function (xhr, status, error) {
                          console.error('Error fetching active fund:', error);
                          alert('Failed to fetch active fund.');
                      }
                  });

                  // Dynamically Calculate Remaining Active Fund on Input
                  $('#enterAmount').on('input', function () {
                      let withdrawAmount = parseFloat($(this).val()) || 0; // Ensure a valid number
                      let realactive = activefund - withdrawAmount; // Calculate remaining active fund

                      if (realactive < 0) {
                          realactive = 0; // Prevent negative values
                      }

                      $('#activeFund').val(realactive); // Update the #activeFund field
                      console.log("Calculated Real Active Fund:", realactive); // Log the value for debugging
                  });

                  // Handle Form Submission on Button Click
                  $('#withdrawSubmit').on('click', function () {
                      // Fetch the latest withdrawal amount and remaining active fund
                      let withdrawAmount = parseFloat($('#enterAmount').val()) || 0;
                      let realactive = activefund - withdrawAmount;

                      // Collect form data
                      const modalData = {
                          WithdrawalDate: $('#enterDate').val(),
                          WithdrawalAmount: withdrawAmount, // Use the numeric value
                          activeFund: realactive, // Use the calculated active fund
                          note: $('#note').val(),
                          fileData: $('#hiden').val(), // Base64 file data
                          fileName: $('#hidden').val(), // File name
                          agreementId: agreementId
                      };

                      console.log("Form Data to Submit:", modalData); // Debug log

                      // Validate form data
                      if (!modalData.WithdrawalDate || withdrawAmount <= 0) {
                          alert('Please enter a valid withdrawal date and amount.');
                          return;
                      }

                      // Send data to the backend
                      $.ajax({
                          url: 'agreementDetails.aspx/SaveModalData',
                          method: 'POST',
                          contentType: 'application/json; charset=utf-8',
                          data: JSON.stringify({ data: modalData }),
                          success: function (response) {
                              alert(response.d); // Show backend response
                              // Optionally, reset the form or close the modal
                              $('#enterDate').val('');
                              $('#enterAmount').val('');
                              $('#activeFund').val('');
                              $('#note').val('');
                              $('#uploadFilex').val('');
                              $('#hiden').val('');
                              $('#hidden').val('');
                          },
                          error: function (xhr, status, error) {
                              console.error('Error:', error);
                              alert('Failed to save data.');
                          }
                      });
                  });
              });


             
              // Handle status filter dropdown
              $('#status-filter').on('change', function () {
                  const filterValue = $(this).val();
                  table.column(6).search(filterValue).draw(); // Apply search to the "Status" column
              });

              $.ajax({
                  type: "POST",
                  url: "investorlist.aspx/GetClientData",
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  success: function (response) {
                      var data = response.d.data;

                      // Clear existing rows in DataTable
                      table.clear();

                      // Add rows dynamically to DataTable using its API
                      $.each(data, function (index, item) {
                          table.row.add([
                              index + 1,
                              item.Sl.No,
                              item.TransactionDate,
                              item.Withdraw Amount || "-",
                              item.Active Fund,
                              item.File,
                              item.Note,



                          ]);
                      });

                      // Redraw DataTable to update the UI
                      table.draw();
                  },
                  error: function (err) {
                      console.error("Error fetching data:", err);
                  }
              });
            




          });
      </script>

</head>
    <body>
 <form id="form1">
        <div>
             <ucx1:MyUserControl11 runat="server" />
            <div class="agreement-container">
                <div class="profile-header">
                    <h2>Agreement Profile</h2>
                    <h3 id="Agreement"></h3>
                </div>
          <input type="hidden" value="" id="hiden" runat="server" />
          <input type="hidden" value="" runat="server" id="hidden"  />
                  <input type="hidden" value="" id="hidden1" runat="server" />
                    <input type="hidden" value="" runat="server" id="hidden2"  />
 
 
                <h2 class="bd">Basic Details</h2>
                <div class="basic-details" id="detailsContainer">
                    <div class="details-left">
                        <p><strong>Client Name:</strong> </p>
                        <p><strong>Client ID:</strong> </p>
                        <p><strong>Nominee:</strong></p>
                        <p><strong>Refer By:</strong></p>
                        <p><strong>Account Link:</strong> </p>
                        <p><strong>Bank Name:</strong> </p>
                        <p><strong>Contact Number:</strong> </p>
                    </div>
                    <div class="details-right">
                        <p><strong>Agreement ID:</strong> </p>
                        <p><strong>Capital:</strong></p>
                        <p><strong>Start Date:</strong></p>
                        <p><strong>Expire Date:</strong></p>
                        <p><strong>Term:</strong> </p>
                        <p><strong>Agreement Status:</strong> </p>
                        <button class="download-btn">Download</button>
                    </div>
                </div>

                <div class="transaction-details">
                    <h3>Transaction Details</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Sl No</th>
                                <th>Transaction Date</th>
                                <th>Days in Current Month</th>
                                <th>Transaction Amount</th>
                                <th>Client File</th>
                                <th>Manager File</th>
                                <th>Investment Start Date</th>
                                <th>Days Invested</th>
                                <th>Monthly Profit</th>
                                <th>Daily Profit</th>
                                <th>1st Month Total Profit</th>
                            </tr>
                        </thead>
                        <tbody id="transactionTableBody">
                        </tbody>
                    </table>
                </div>

                <div class="profit-details">
                    <h3>Profit Details</h3>
                    <table class="table table-bordered profit-table">
                        <thead>
                            <tr>
                                <th>Sl.No</th>
                                <th>Profit Name</th>
                                <th>Months</th>
                                <th>Transaction Date</th>
                                <th>Funds</th>
                                <th>Points</th>
                                <th>Profit Amount</th>
                                <th>File</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody id="profitTableBody">
                        </tbody>
                    </table>
                </div>





                <div class="Withdrawl-details">
                  <div class="withdrawal-header">
            <h3>Withdrawal Details</h3>
            <div>
                <button type="button" class="btn btn-success" id="withdrawbtn" data-bs-toggle="modal" data-bs-target="#withdrawModal">
                    Withdraw Capital
                </button>
            </div>
        </div>
                    <table id="datatable" class="table table-bordered withdraw-table">
                        <thead>
                            <tr>
                                <th>Sl.No</th>
                                <th>Transaction Date</th>
                                <th>Withdraw Amount</th>
                                <th>Active Fund</th>
                                <th>File</th>
                                <th>Note</th>

                            </tr>
                        </thead>
                        <tbody id="withdrawlTableBody">
                        </tbody>
                    </table>
                </div>



<div class="modal fade" id="withdrawModal" tabindex="-1" aria-labelledby="withdrawModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header">
                <h5 class="modal-title" id="withdrawModalLabel">Withdraw Capital</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <!-- Modal Body -->
            <div class="modal-body">
                <form>
                    <div class="mb-3">
                        <label for="enterDate" class="form-label">Enter Date:</label>
                        <input type="date" class="form-control" id="enterDate">
                    </div>
                    <div class="mb-3">
                        <label for="enterAmount" class="form-label">Enter Amount:</label>
                        <input type="number" class="form-control" id="enterAmount">
                    </div>
                    <div class="mb-3">
                        <label for="activeFund" class="form-label">Active Fund:</label>
                        <input type="text" class="form-control" id="activeFund" placeholder="Auto calculate from capital" >
                    </div>
                    <div class="mb-3">
                        <label for="uploadFile" class="form-label">Upload File:</label>
                        <input type="file" class="form-control" id="uploadFilex">
                    </div>
                    <div class="mb-3">
                        <label for="note" class="form-label">Note:</label>
                        <textarea class="form-control" id="note" placeholder="Please enter description"></textarea>
                    </div>
                </form>
            </div>
            <!-- Modal Footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button> <!-- Cancel Button -->
                <button type="button" class="btn btn-danger" id="withdrawSubmit">Withdraw</button>
            </div>
        </div>
    </div>
</div>





                <div class="container mt-4">
        <div class="capital-header">
            <h5 class="mb-0">Capital Return</h5>
            <div>
<button class="btn btn-success me-2" type="button" id="Reinvestbtn" data-bs-toggle="modal" data-bs-target="#capitalReinvestModal">
    Reinvest
</button>
                <button type="button" id="Returnbtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#capitalReturnModal">Capital Return</button>
            </div>
        </div>
        
        <div class="table-container">
            <table class="table table-hover mb-0">
                <thead>
                    <tr>
                        <th>Sl No</th>
                        <th>Transaction Date</th>
                        <th>Amount</th>
                        <th>File</th>
                        <th>Status</th>
                        <th>Note</th>
                    </tr>
                </thead>
                <tbody>
                   
                </tbody>
            </table>
        </div>
    </div>


                
<!-- Modal Structure -->
<div class="modal fade" id="capitalReturnModal" tabindex="-1" aria-labelledby="capitalReturnModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h5 class="modal-title" id="capitalReturnModalLabel">Capital Return</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <!-- Modal Body -->
      <div class="modal-body">
        <!-- Expire Field -->
        <div class="mb-3">
          <label for="expireField" class="form-label">Expire:</label>
          <input type="text" id="expireField" class="form-control" placeholder="Auto Fetch From Form" readonly>
        </div>

        <!-- Active Amount Field -->
        <div class="mb-3">
          <label for="activeAmountField" class="form-label">Active Amount:</label>
          <input type="text" id="activeAmountField" class="form-control" placeholder="Enter Amount">
        </div>

        <!-- File Upload -->
        <div class="mb-3">
          <label for="uploadFile" class="form-label">Upload File:</label>
          <input type="file" id="uploadFile" class="form-control">
          <button class="btn btn-dark mt-2">Upload Amount</button>
        </div>

        <!-- Message -->
        <div class="mb-3">
          <label for="messageField" class="form-label">Message*:</label>
          <textarea id="messageField" class="form-control" rows="4" readonly>Dear Client, today one of our agreements is expired.
          
Thank you,
D Market Analyst
8247653214</textarea>
        </div>
      </div>

      <!-- Modal Footer -->
      <div class="modal-footer">
        <button class="btn btn-danger w-100">Close Agreement</button>
      </div>
    </div>
  </div>
</div>


                <div class="modal fade" id="capitalReinvestModal" tabindex="-1" aria-labelledby="capitalReinvestModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="capitalReinvestModalLabel">Capital Reinvest</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="mb-3">
                        <label for="clientName" class="form-label">Client Name</label>
                        <input type="text" id="clientName" class="form-control" placeholder="Auto Fetch" disabled>
                    </div>
                    <div class="mb-3">
                        <label for="clientId" class="form-label">Client ID</label>
                        <input type="text" id="clientId" class="form-control" placeholder="Auto Fetch" disabled>
                    </div>
                    <div class="mb-3">
                        <label for="transactionDate" class="form-label">Transaction Date</label>
                        <input type="date" id="transactionDate" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label for="enterAmount" class="form-label">Enter Amount</label>
                        <input type="number" id="enterAmountx" class="form-control" placeholder="Enter Amount">
                    </div>
                    <div class="mb-3">
                        <label for="uploadFile" class="form-label">Upload File</label>
                        <input type="file" id="uploadFiley" class="form-control">
                    </div>
                    <p class="text-danger">* Upload capital receipt from previous agreement</p>
                    <div class="mb-3">
                        <label for="message" class="form-label">Message</label>
                        <textarea id="message" class="form-control" rows="4">
Dear Client, today one of our agreements is expired. However, due to our conversation on call, we mutually agreed that I will not send the investment amount; it will be reinvested.

Thank you,
D Market Analyst
8247653214
                        </textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" id="reinvestmodalx" class="btn btn-success">Reinvest</button>
            </div>
        </div>
    </div>
</div>

            </div>
        </div>
    </form>
        </body>
</html>
