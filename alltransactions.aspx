<%@ Page Language="C#" AutoEventWireup="true" CodeFile="alltransactions.aspx.cs" Inherits="alltransactions" %>

<%@ Register TagPrefix="ucx1" TagName="MyUserControl11" Src="~/sidenav2.ascx" %>
<%@ Register TagPrefix="ucx" TagName="MyUserControl1" Src="~/header.ascx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>Investor lists</title>
    <ucx:MyUserControl1 runat="server" />


      <script>

          $(document).ready(function () {

              $('#status-filter').on('change', function () {
                  const filterValue = $(this).val();
                  table.column(6).search(filterValue).draw();
              });


              const table = $('#data-table').DataTable({
                  pageLength: 5,
                  responsive: true,
                  dom: 'Bfrtip',
                  buttons: [
                      'copy', 'csv', 'excel', 'pdf', 'print'
                  ],
                  columnDefs: [
                      {
                          targets: [8], // Index of the 'Upload ID' column
                          visible: false, // Hide the column from user view
                          searchable: false // Prevent search in hidden column
                      }
                  ]
              });

              // AJAX call to fetch data and populate the DataTable
              $.ajax({
                  type: "POST",
                  url: "alltransactions.aspx/GetAllTransactions",
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  success: function (response) {
                      // Clear the existing rows
                      table.clear();

                      // Process the response data
                      const transactions = response.d;

                      // Loop through the data and add rows to the DataTable
                      transactions.forEach((transaction, index) => {
                          console.log("Upload ID for this transaction: ", transaction.uploadId);

                          table.row.add([
                              index + 1, // Sl No
                              transaction.ClientId, // Client ID
                              transaction.ClientName, // Client Name
                              transaction.Amount.toFixed(2), // Transaction Amount
                              transaction.ReferBy, // Referred By
                              transaction.CreatedDate, // Date and Time
                              `<a href="${transaction.MyDocPath}" target="_blank">View Receipt</a>`, // Receipt by Client
                              `<button class="btn-action" 
                    data-id="${transaction.ClientId}" 
                    data-name="${transaction.ClientName}" 
                    data-amount="${transaction.Amount}" 
                    data-path="${transaction.MyDocPath}" 
                    data-referby="${transaction.ReferBy}"
                    data-uploadid="${transaction.uploadId}">Create Agreement</button>`, // Action column with uploadId
                              transaction.uploadId // Hidden Upload ID (will not be visible)
                          ]);
                      });

                      // Redraw the table to display the new data
                      table.draw();
                  },
                  error: function (error) {
                      console.error("Error fetching transactions:", error);
                  }
              });


        // Add event listeners for dynamic actions (optional)
              $('#data-table').on('click', '.btn-action', function () {
                  const clientId = $(this).data('id');
                  const clientName = $(this).data('name');
                  const amount = $(this).data('amount');
                  const myDocPath = $(this).data('path');
                  const referBy = $(this).data('referby');
                  const uploadId = $(this).data('uploadid');  // Add uploadId from the data attribute

                  // Store data in localStorage
                  const clientData = {
                      ClientId: clientId,
                      ClientName: clientName,
                      Amount: amount,
                      MyDocPath: myDocPath,
                      ReferBy: referBy,
                      UploadId: uploadId  // Add uploadId to the clientData object
                  };

                  localStorage.setItem('clientData', JSON.stringify(clientData));

                  // Redirect to the other page
                  window.location.href = 'agreement.aspx';
              });




              $("#clientIdx").on("input", function () {
                  const clientId = $(this).val();
                  if (clientId) {
                      $.ajax({
                          type: "POST",
                          url: "alltransactions.aspx/GetClientName", // Update with your page name
                          contentType: "application/json; charset=utf-8",
                          data: JSON.stringify({ clientId: clientId }),
                          dataType: "json",
                          success: function (response) {
                              if (response.d) {
                                  $("#clientName").val(response.d);
                              } else {
                                  $("#clientName").val("Client not found");
                              }
                          },
                          error: function () {
                              alert("Error fetching client name.");
                          }
                      });
                  } else {
                      $("#clientName").val("");
                  }
              });

              $('#receiptFile').on('change', function () {
                  const file = this.files[0];
                  if (file) {
                      const reader = new FileReader();
                      reader.onload = function (e) {
                          const base64Data = e.target.result;
                          const fileName = file.name;

                          // Store base64 data and file name in hidden fields
                          $('#hiden').val(base64Data);   // Base64 data
                          $('#hidden').val(fileName);    // File name
                      };
                      reader.readAsDataURL(file); // Read file as base64
                  }
              });




              // Form submission inside the modal
              $("#btn").on("click", function () {
                  $.ajax({
                      type: "POST",
                      url: "upload.aspx/Insert",
                      data: JSON.stringify({
                          ClientId: $("#clientIdx").val(), // Send the ClientId to the server
                          Amount: $("#transactionAmount").val(),
                          pic: $("#hiden").val(),
                          path: $("#hidden").val()
                      }),
                      contentType: "application/json; charset=utf-8",
                      dataType: "json",
                      success: OnSuccessrrd,
                      failure: function (response) {
                          alert(response.d);
                      }
                  });

                  function OnSuccessrrd(response) {
                      alert("You have Successfully Registered, Thank You");
                      window.location.reload();
                  }
              });
          });
      </script>

  
    }
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f8fc;
        }

.investors-list-container {
    padding: 10px;
    max-width: 90%;
    margin: 0 auto;
    background-color: #d1e4ff;
    border-radius: 8px;
    box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.1);
    margin-top: 85px;
    margin-left: 111px;
}
.investors-list-container h2{
    display: flex;
    font-size: 25px;
    font-weight: 600;
    padding: 12px 5px;

}
        h2 {
            font-size: 1.8em;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }

.summary-cards {
    display: flex;
    justify-content: center;
    gap: 20px;
    width: 48%;
    background-color: #ffffff;
    padding: 10px;
    border-radius: 10px;
}
.summary-cards p {
    margin-top: 0;
    margin-bottom: 1rem;
    color: #fff;
}
.summary-cards h3 {

    color: #fff;
}

.card {
    flex: 1;
    padding: 8px;
    text-align: center;
    border-radius: 8px;
    color: white;
    font-weight: 500;
    font-size: 18px;
}

        .total-investors {
            background-color: #087a9f !important;
        }

        .inactive-investors {
            background-color: #830000 !important;
        }

.actions {
    display: flex
;
    justify-content: right;
    align-items: center;
    margin-bottom: 15px;
    gap: 20px;
}

        .filter-dropdown {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
        }

        .register-btn {
            padding: 10px 15px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        .investors-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            background-color: white;
            box-shadow: 0px 1px 5px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            overflow: hidden;
        }

        .investors-table th,
        .investors-table td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
            font-size: 0.9em;
        }

        .investors-table th {
            background-color: #087a9f;
            color: white;
            font-weight: bold;
        }

        .status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.9em;
            color: white;
        }

        .status.active {
            background-color: #28a745;
        }

        .status.inactive {
            background-color: #6c757d;
        }

        .profile-link {
            color: #087a9f;
            text-decoration: none;
            font-weight: bold;
        }

        .profile-link:hover {
            text-decoration: underline;
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
             .modal-content {
            background: linear-gradient(to bottom right, #ffffff, #e9f5ff);
            border-radius: 15px;
            box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.2);
        }

        .modal-header {
            background-color: #087a9f;
            color: white;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }

        .modal-title {
            font-size: 1.5rem;
            font-weight: bold;
        }

        .btn-close {
            background-color: white;
            border: none;
        }

        .btn-close:hover {
            background-color: #ccc;
        }

        .modal-body {
            padding: 20px;
            font-family: 'Arial', sans-serif;
            color: #333;
        }

        .modal-footer {
            background-color: #f1f5f9;
            border-bottom-left-radius: 15px;
            border-bottom-right-radius: 15px;
        }

        .modal-footer .btn {
            font-weight: bold;
            border-radius: 8px;
        }

        .modal-footer .btn-primary {
            background-color: #087a9f;
            border: none;
        }

        .modal-footer .btn-primary:hover {
            background-color: #065e7d;
        }

        .modal-footer .btn-secondary {
            background-color: #6c757d;
            border: none;
        }

        .modal-footer .btn-secondary:hover {
            background-color: #545b62;
        }

        /* Input fields */
        .form-control {
            border: 1px solid #087a9f;
            border-radius: 8px;
            box-shadow: inset 0px 2px 4px rgba(0, 0, 0, 0.1);
        }

        .form-control:focus {
            border-color: #065e7d;
            box-shadow: 0px 0px 6px rgba(8, 122, 159, 0.5);
        }

        .form-label {
            font-weight: bold;
            color: #087a9f;
        }

        /* File input */
        #receiptFile {
            padding: 5px;
        }

        /* Submit button hover effect */
        #submitTransaction {
            transition: all 0.3s ease-in-out;
        }

        #submitTransaction:hover {
            transform: translateY(-2px);
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <ucx1:MyUserControl11 runat="server" />

            <div class="investors-list-container">
                <h2>All Transactions</h2>
                <div class="summary-cards">
                    <div class="card total-investors">
                        <h3>25,70,000</h3>
                        <p>Transaction amounts</p>
                    </div>
                    <div class="card inactive-investors">
                        <h3>3</h3>
                        <p>Pending Items</p>
                    </div>
                </div>
   <div class="actions">
                    <!-- Button to open the modal -->
                    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#newTransactionModal">
                        New Transactions
                    </button>
                </div>
                <table id="data-table" class="investors-table display responsive nowrap">
                    <thead>
                        <tr>
                            <th>Sl No</th>
                            <th>Client ID</th>
                            <th>Client Name</th>
                            <th>Transaction Amount</th>
                            <th>Referred By</th>
                            <th>Date and Time</th>
                            <th>Receipt by Client</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
        
        <!-- New Transaction Modal -->
         <div class="modal fade" id="newTransactionModal" tabindex="-1" aria-labelledby="newTransactionModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="newTransactionModalLabel">New Transaction</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="newTransactionForm">
                            <div class="mb-3">
                                <label for="clientId" class="form-label">Client ID</label>
                                <input type="text" class="form-control" id="clientIdx" name="clientIdx" placeholder="Enter Client ID" required>
                            </div>
                            <div class="mb-3">
                                <label for="clientName" class="form-label">Client Name</label>
                                <input type="text" class="form-control" id="clientName" placeholder="Auto-fetch once ID is entered" disabled>
                            </div>
                            <div class="mb-3">
                                <label for="transactionAmount" class="form-label">Transaction Amount</label>
                              <input type="number" class="form-control" id="transactionAmount" name="transactionAmount" placeholder="Enter Transaction Amount" required>
                            </div>
                            <div class="mb-3">
                                 <label for="receiptFile" class="form-label">Receipt by Client</label>
                                      <input type="file" class="form-control" id="receiptFile" name="receiptFile" required/>  
                                          <input type="hidden" value="" id="hiden" runat="server" /> <input type="hidden" value="" runat="server" id="hidden"  />

                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary" id="btn">Submit</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>