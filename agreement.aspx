<%@ Page Language="C#" AutoEventWireup="true" CodeFile="agreement.aspx.cs" Inherits="agreement" %>

<%@ Register TagPrefix="ucx1" TagName="MyUserControl11" Src="~/sidenav2.ascx" %>
<%@ Register TagPrefix="ucx" TagName="MyUserControl1" Src="~/header.ascx" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <ucx:MyUserControl1 runat="server" />
    <title>Agreement</title>
    <style>
        body {
            background-color: white;
        }

        .form-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin: 2rem auto;
            margin-top: 86px;
        }

        .form-header {
            margin-top: 30px;
            font-size: 1.5rem;
            font-weight: bold;
            text-align: center;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

            .form-header h3 {
                background-color: #efefef;
                width: 60%;
                padding: 3px;
                border-radius: 7px;
                background-color: black;
                color: white;
            }

        .form-select {
            background-color: #efefef !important;
        }

        .btn-upload {
            font-size: 0.8rem;
            padding: 0.5rem;
        }

        .form-control {
            background-color: #efefef !important;
        }

        .form-control,
        .btn-upload,
        .form-check-input {
            border-radius: 5px;
        }

        .create-profile-btn {
            display: flex;
            justify-content: center;
            width: 200px;
            margin-left: 600px;
        }

        .btn-primary {
            background-color: #000428;
            border: none;
            width: 100%;
            padding: 0.8rem;
            border-radius: 5px;
        }

        .checkbox-wrapper-5 .check {
            --size: 30px;
            position: relative;
            background: linear-gradient(90deg, #9c88ed, #89deff);
            line-height: 0;
            perspective: 400px;
            font-size: var(--size);
        }

            .checkbox-wrapper-5 .check input[type="checkbox"],
            .checkbox-wrapper-5 .check label,
            .checkbox-wrapper-5 .check label::before,
            .checkbox-wrapper-5 .check label::after,
            .checkbox-wrapper-5 .check {
                appearance: none;
                display: inline-block;
                border-radius: var(--size);
                border: 0;
                transition: .35s ease-in-out;
                box-sizing: border-box;
                cursor: pointer;
            }

                .checkbox-wrapper-5 .check label {
                    width: calc(2.2 * var(--size));
                    height: var(--size);
                    background: #d7d7d7;
                    overflow: hidden;
                }

                .checkbox-wrapper-5 .check input[type="checkbox"] {
                    position: absolute;
                    z-index: 1;
                    width: calc(.8 * var(--size));
                    height: calc(.8 * var(--size));
                    top: calc(.1 * var(--size));
                    left: calc(.1 * var(--size));
                    background: linear-gradient(45deg, #dedede, #ffffff);
                    box-shadow: 0 6px 7px rgba(0,0,0,0.3);
                    outline: none;
                    margin: 0;
                }

                    .checkbox-wrapper-5 .check input[type="checkbox"]:checked {
                        left: calc(1.3 * var(--size));
                    }

                        .checkbox-wrapper-5 .check input[type="checkbox"]:checked + label {
                            background: transparent;
                        }

                .checkbox-wrapper-5 .check label::before,
                .checkbox-wrapper-5 .check label::after {
                    content: "· ·";
                    position: absolute;
                    overflow: hidden;
                    left: calc(.15 * var(--size));
                    top: calc(.5 * var(--size));
                    height: var(--size);
                    letter-spacing: calc(-0.04 * var(--size));
                    color: #9b9b9b;
                    font-family: "Times New Roman", serif;
                    z-index: 2;
                    font-size: calc(.6 * var(--size));
                    border-radius: 0;
                    transform-origin: 0 0 calc(-0.5 * var(--size));
                    backface-visibility: hidden;
                }

                .checkbox-wrapper-5 .check label::after {
                    content: "●";
                    top: calc(.65 * var(--size));
                    left: calc(.2 * var(--size));
                    height: calc(.1 * var(--size));
                    width: calc(.35 * var(--size));
                    font-size: calc(.2 * var(--size));
                    transform-origin: 0 0 calc(-0.4 * var(--size));
                }

                .checkbox-wrapper-5 .check input[type="checkbox"]:checked + label::before,
                .checkbox-wrapper-5 .check input[type="checkbox"]:checked + label::after {
                    left: calc(1.55 * var(--size));
                    top: calc(.4 * var(--size));
                    line-height: calc(.1 * var(--size));
                    transform: rotateY(360deg);
                }

                .checkbox-wrapper-5 .check input[type="checkbox"]:checked + label::after {
                    height: calc(.16 * var(--size));
                    top: calc(.55 * var(--size));
                    left: calc(1.6 * var(--size));
                    font-size: calc(.6 * var(--size));
                    line-height: 0;
                }

        #Agreement-document {
            height: 30px;
        }

        ##ReferBy {
            height: 30px;
        }

        .position-relative {
            position: relative;
        }

        .input-container {
            position: relative;
            display: flex;
            align-items: center;
        }

        .form-control {
            padding-right: 200px; /* Adjust to make space for buttons */
        }

        .button-group {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            display: flex;
            gap: 5px;
        }

        .btn {
            font-size: 12px;
            padding: 5px 10px;
            white-space: nowrap;
        }
    </style>

    <script>



        $(document).ready(function () {

            const clientData = JSON.parse(localStorage.getItem('clientData'));

            if (clientData) {
                // Auto-fill fields with data from localStorage
                $('#ClientID').val(clientData.ClientId); // Auto-fill Client ID
                $('#clientName').val(clientData.ClientName); // Auto-fill Client Name
                $('#TransactionAmount').val(clientData.Amount); // Auto-fill Transaction Amount
                $('#refer').val(clientData.ReferBy); // Auto-fill Refer By
                $('#ClientReceipt').val(clientData.MyDocPath); // Auto-fill Client Receipt Path
                $('#UploadId').val(clientData.UploadId); // Auto-fill Upload ID
            } else {
                console.error('No client data found in localStorage.');
            }




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
                        if (inputId === 'ClientReceiptx') {
                            $('#hiden').val(base64Data);   // base64 data for ClientReceipt
                            $('#hidden').val(fileName);    // file name for ClientReceipt

                        }
                    };
                    reader.readAsDataURL(file); // Read file as base64
                }
            });



            $("#TransactionAmount, #profitclient, #DaysInvestment, #CurrentTransaction").on("input", function () {
                // Get values from the inputs
                const transactionAmount = parseFloat($("#TransactionAmount").val()) || 0;
                const monthlyProfitPercentage = parseFloat($("#profitclient").val()) || 0; // Monthly percentage

                const daysInvestment = parseInt($("#DaysInvestment").val()) || 0;
                const currentTransactionDate = $("#CurrentTransaction").val();

                // Ensure valid date input
                if (currentTransactionDate) {
                    const currentDate = new Date(currentTransactionDate);

                    // Get the year and month from the current transaction date
                    const year = currentDate.getFullYear();
                    const month = currentDate.getMonth(); // 0-based month

                    // Calculate the total days in the current month
                    const daysInMonth = new Date(year, month + 1, 0).getDate(); // Last day of the month

                    // Calculate the daily profit rate
                    const dailyProfitRate = (transactionAmount * monthlyProfitPercentage) / (daysInMonth * 100);

                    let calculatedProfit;

                    if (daysInvestment >= daysInMonth) {
                        // If DaysInvestment equals or exceeds total days in the month, calculate full monthly profit
                        calculatedProfit = transactionAmount * (monthlyProfitPercentage / 100);
                    } else {
                        // Otherwise, calculate the proportional profit based on the daily rate
                        calculatedProfit = dailyProfitRate * daysInvestment;
                    }

                    // Display the calculated profit in the field
                    $("#calculatedProfit").val(calculatedProfit.toFixed(2)); // Round to 2 decimal places
                }
            });




            $("#approvebtn").on("click", function () {
                // Gather form data into a JSON object
                var formData = {
                    clientName: $("#clientName").val(),
                    ClientID: $("#ClientID").val(),
                    TransactionAmount: $("#TransactionAmount").val(),
                    ClientReceipt: $("#ClientReceipt").val(),

                    AgreementID: $("#AgreementID").val(),
                    Agreementdocument: $("#Agreementdocument").val(),
                    refer: $("#refer").val(),
                    percentage: $("#percentage").val(),
                    Priority: $("#Priority").val(),
                    TotalFund: $("#TotalFund").val(),
                    StartDate: $("#StartDate").val(),
                    Term: $("#Term").val(),
                    expireDate: $("#expireDate").val(),
                    profitclient: $("#profitclient").val(),
                    Accountlink: $("#Accountlink").val(),
                    CurrentTransaction: $("#CurrentTransaction").val(),
                    DaysInvestment: $("#DaysInvestment").val(),
                    pic: $("#hiden").val(),
                    path: $("#hidden").val(),
                    ifsc: $("#IFSC").val(),
                    calculatedProfit: $("#calculatedProfit").val(),
                    UploadId: $("#UploadId").val()
                };

                console.log(formData);

                // First AJAX request to save the main data
                $.ajax({
                    type: "POST",
                    url: "agreement.aspx/abcd",
                    data: JSON.stringify({ formData: formData }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        alert("Main data successfully registered.");
                        window.location.reload();
                        window.location.href = "alltransactions.aspx";
                    },
                    error: function (response) {
                        alert("Error saving main data: " + response.responseText);
                    }
                });
            });


            $("#btn1").click(function () {
                const clientID = $("#ClientID").val();
                // Check if AgreementID is already generated

                if ($("#AgreementID").val()) {
                    alert("AgreementID is already generated. Please proceed with the existing one.");
                    return; // Exit the function if AgreementID already exists
                }

                if (clientID.length >= 5) {
                    $.ajax({
                        type: "POST",
                        url: "agreement.aspx/GenerateNewAgreementID",
                        data: JSON.stringify({ clientID: clientID }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            $("#AgreementID").val(response.d);
                        },
                        error: function (error) {
                            alert("Error generating Agreement ID. Please try again.");
                        }
                    });
                } else {
                    alert("Invalid Client ID. It must be at least 5 characters long.");
                }
            });



            $("#btn2").click(function () {
                const clientID = $("#ClientID").val(); // Get the client ID from input field
                const currentTransection = $("#CurrentTransaction").val(); // Get the current transaction date
                const transactionAmount = parseFloat($("#TransactionAmount").val()) || 0; // Transaction amount


                // Input validation
                if (!clientID || !currentTransection) {
                    alert("Please provide both Client ID and Current Transaction date.");
                    return;
                }




                // First AJAX call to fetch AgreementID with validation
                $.ajax({
                    type: "POST",
                    url: "agreement.aspx/ExistingclientID", // Backend method URL
                    data: JSON.stringify({
                        clientID: clientID,
                        currentTransactionDate: currentTransection
                    }), // Send both ClientID and CurrentTransaction to the backend
                    contentType: "application/json; charset=utf-8", // Data type
                    dataType: "json", // Expecting a JSON response
                    success: function (response) {
                        if (response.d.startsWith("Error")) {
                            // Check if the response is an error message
                            alert(response.d); // Show the error message to the user
                        } else {
                            const agreementID = response.d; // Store the AgreementID
                            $("#AgreementID").val(agreementID); // Set the AgreementID to the input field

                            // Second AJAX call to fetch agreement details using the AgreementID
                            $.ajax({
                                type: "POST",
                                url: "agreement.aspx/FetchAgreementDetails", // The backend method URL to fetch agreement details
                                data: JSON.stringify({ agreementID: agreementID }), // Sending AgreementID to the backend
                                contentType: "application/json; charset=utf-8", // Data type
                                dataType: "json", // Expecting a JSON response
                                success: function (detailsResponse) {
                                    if (detailsResponse.d) {
                                        // If the response is valid
                                        var details = detailsResponse.d;

                                        // Update the UI with fetched details
                                        $("#StartDate").val(details.StartDate); // Set Start Date
                                        $("#Term").val(details.Term); // Set Term
                                        $("#expireDate").val(details.ExpireDate); // Set Expiry Date
                                        $("#Priority").val(details.Priority); // Set Priority
                                        var totalFund = parseFloat(details.TotalFund) || 0; // Ensure it's a number

                                        var combinedTotal = totalFund + transactionAmount; // Calculate combined total
                                        $("#TotalFund").val(combinedTotal); // Update Total Fund
                                    } else {
                                        alert("No details found for the selected Agreement ID.");
                                    }
                                },
                                error: function (xhr, status, error) {
                                    console.error("Error fetching agreement details:", error);
                                    alert("An error occurred while fetching agreement details. Please try again later.");
                                }
                            });
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("Error fetching AgreementID:", error);
                        alert("An error occurred while fetching the Agreement ID. Please try again later.");
                    }
                });
            });





            $("#StartDate, #Term").on("change", function () {
                // Get the start date value
                const startDateValue = $("#StartDate").val();
                const termValue = parseInt($("#Term").val(), 10);

                // Check if both start date and term are valid
                if (startDateValue && termValue > 0) {
                    // Parse the start date
                    const startDate = new Date(startDateValue);

                    // Add the term (in months) and one day
                    startDate.setMonth(startDate.getMonth() + termValue); // Add months
                    startDate.setDate(startDate.getDate() + 1); // Add one day

                    // Format the date as yyyy-MM-dd for input
                    const expiryDate = startDate.toISOString().split("T")[0];

                    // Set the expiry date input field
                    $("#expireDate").val(expiryDate);
                }
            });


            $("#btn5").on("click", function () {
                // Replace with the actual client ID value
                var clientId = $("#ClientID").val();

                if (clientId) {
                    $.ajax({
                        type: "POST",
                        url: "agreement.aspx/GetBankDetails",
                        data: JSON.stringify({ clientId: clientId }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            if (response.d) {
                                // Update the Bank Account and IFSC fields
                                $("#Accountlink").val(response.d.BankAccount);
                                $("#IFSC").val(response.d.IFSC);
                            } else {
                                alert("No bank details found for the provided Client ID.");
                            }
                        },
                        error: function () {
                            alert("An error occurred while fetching bank details.");
                        }
                    });
                } else {
                    alert("Please provide a valid Client ID.");
                }
            });



            $('#CurrentTransaction').on('change', function () {
                const selectedDate = $(this).val();

                if (selectedDate) {
                    const currentDate = new Date(selectedDate);
                    const year = currentDate.getFullYear();
                    const month = currentDate.getMonth(); // Months are 0-indexed
                    const dayOfMonth = currentDate.getDate(); // Selected day of the month

                    // Calculate the total days in the selected month
                    const daysInMonth = new Date(year, month + 1, 0).getDate();

                    // Calculate the remaining days in the month
                    const remainingDays = daysInMonth - dayOfMonth + 1; // Include the selected day

                    // Set the calculated remaining days in the Days For Investment field
                    $('#DaysInvestment').val(remainingDays);
                } else {
                    // Clear the Days For Investment field if no valid date is selected
                    $('#DaysInvestment').val('');
                }
            });





        });

    </script>



</head>
<body>
    <form id="form1" runat="server">
        <div>

            <ucx1:MyUserControl11 runat="server" />
            <div class="container">
                <div class="form-container">
                    <div class="form-header">
                        <h3>Create Agreement</h3>
                    </div>
                    <div>
                        <div class="row g-3">
                            <!-- Left Column -->
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Client Name:</label>
                                    <input type="text" class="form-control" id="clientName" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Client ID: </label>
                                    <input type="text" class="form-control" id="ClientID" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Transaction Amount:</label>
                                    <input type="number" class="form-control" id="TransactionAmount" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Receipt By Client:</label>
                                    <input type="text" class="form-control" id="ClientReceipt" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Payment Receipt:</label>


                                    <div class="input-group">
                                        <input type="file" class="form-control file-input" id="ClientReceiptx" required>
                                    </div>
                                </div>
                                  <div class="mb-3">
      <label class="form-label fw-bold">Current Transaction Start::</label>
      <input type="date" class="form-control" id="CurrentTransaction" required>
  </div>
                                <div class="mb-3 position-relative">
                                    <label class="form-label fw-bold" for="AgreementID">Agreement ID:</label>
                                    <div class="input-container position-relative">
                                        <input type="text" class="form-control" id="AgreementID" required readonly>
                                        <div class="button-group">
                                            <button type="button" class="btn new me-2" id="btn1">Create New</button>
                                            <button type="button" class="btn new" id="btn2">Link to Existing ID</button>
                                        </div>
                                    </div>
                                </div>


                                <div class="mb-3">
                                    <label class="form-label fw-bold">Agreement document:</label>
                                    <input value="Pending" readonly class="form-control" id="Agreementdocument"></input>


                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Refer By:</label>
                                    <input class="form-control" id="refer" required readonly>
                                      
                                    </input>
                                </div>

                                <div class="mb-3">
                                    <label for="percentage" class="form-label fw-bold">Percentage To My Team:</label>
                                    <input type="number" class="form-control" id="percentage" required>
                                </div>



                            </div>


                            <!-- Right Column -->
                            <div class="col-md-6">
                                                                <div class="mb-3">
                                    <label class="form-label fw-bold">Set Priority:</label>
                                    <select class="form-control" id="Priority" required>
                                        <option selected disabled>Choose From Option</option>
                                        <option value="P1">P1</option>
                                        <option value="P2">P2</option>
                                        <option value="P3">P3</option>
                                        <option value="P4">P4</option>
                                        <option value="P5">P5</option>
                                        <option value="P6">P6</option>
                                        <option value="P7">P7</option>

                                    </select>


                                </div>



                                <div class="mb-3">
                                    <label class="form-label fw-bold">Total Fund::</label>
                                    <input type="text" class="form-control" id="TotalFund" value="0" readonly>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Start Date::</label>
                                    <input type="date" class="form-control" id="StartDate">
                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Term:</label>
                                        <div class="input-group mb-2">
                                            <input type="number" class="form-control" id="Term" required>
                                        </div>
                                    </div>

                                    <label class="form-label fw-bold">Expire Date:</label>
                                    <div class="input-group mb-2">
                                        <input type="date" class="form-control" id="expireDate" readonly>
                                    </div>


                                    <input type="text" id="UploadId" style="display: none;" />




                                      
                                        <div class="mb-3">
                                            <label class="form-label fw-bold">Days For Investment:</label>
                                            <input type="number" class="form-control" id="DaysInvestment" required>
                                        </div>

                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Current Transaction Start::</label>
                                        <input type="date" class="form-control" id="CurrentTransaction" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Days For Investment:</label>
                                        <input type="number" class="form-control" id="DaysInvestment" required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Profit to client:</label>
                                        <div class="input-group mb-2 ">
                                            <input type="number" class="form-control" id="profitclient" required>
                                        </div>

                                        <div class="mb-3 d-flex align-items-center">
                                            <span class="fw-bold me-2">calculatedProfit:</span>
                                            <input type="number" class="form-control w-auto" id="calculatedProfit" required>
                                        </div>


                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Bank Account link:</label>
                                        <div class="input-group mb-2 ">
                                            <input type="text" class="form-control" id="Accountlink" required>
                                        </div>
                                        <span class="create-agreement-id mt-3">

                                            <button type="button" class="btn new" id="btn5">Primary Account</button>
                                        </span>

                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label fw-bold">IFSC Code</label>
                                        <input type="text" class="form-control" id="IFSC" required>
                                    </div>





                                </div>


                            </div>

                            <!-- Hidden fields -->

                            <input type="hidden" value="" id="hiden" runat="server" />
                            <input type="hidden" value="" id="hidden" runat="server" />


                        </div>
                    </div>
                    <div class="create-profile-btn mt-3">
                        <button type="button" class="btn btn-primary" id="approvebtn">Approve</button>
                    </div>
                </div>
            </div>
        </div>
        </div>

    </form>
</body>
</html>
