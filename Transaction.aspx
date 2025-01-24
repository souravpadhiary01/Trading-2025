<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Transaction.aspx.cs" Inherits="Transaction" %>

<%@ Register TagPrefix="ucx1" TagName="MyUserControl11" Src="~/sidenav2.ascx" %>
<%@ Register TagPrefix="ucx" TagName="MyUserControl1" Src="~/header.ascx" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <ucx:MyUserControl1 runat="server" />
    <title>Register New Investor</title>
    <!-- Bootstrap CSS -->
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

        #btn {
            width: 180px;
        }
    </style>


    <script>
        $(document).ready(function () {



            function generateClientId() {
                  const clientName = $('#clientName').val().trim().toUpperCase();
                const mobileNo = $('#mobileNo').val().trim();

                if (clientName && mobileNo.length >= 5) {
                    const firstName = clientName.split(' ')[0]; // Get the first word of the name
                    const lastFiveDigits = mobileNo.slice(-5); // Get the last 5 digits of the mobile number
                    const clientId = firstName + lastFiveDigits;
                    $('#clientId').val(clientId); // Set the Client ID
                } else {
                    $('#clientId').val(''); // Clear the Client ID if input is invalid
                }
            }

            // Attach event handlers to the input fields
            $('#clientName, #mobileNo').on('input', function () {
                generateClientId();
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
                        if (inputId === 'fileInputBankAccount') {
                            $('#hiden').val(base64Data);   // base64 data for Bank Account
                            $('#hidden').val(fileName);    // file name for Bank Account
                        } else if (inputId === 'fileInputAdhaar') {
                            $('#hidenx').val(base64Data);  // base64 data for Adhaar
                            $('#hiddenx').val(fileName);   // file name for Adhaar
                        } else if (inputId === 'fileInputNominee') {
                            $('#hideny').val(base64Data);  // base64 data for Nominee
                            $('#hiddeny').val(fileName);   // file name for Nominee
                        } else if (inputId === 'fileInputPhoto') {
                            $('#hidenz').val(base64Data);  // base64 data for Photo
                            $('#hiddenz').val(fileName);   // file name for Photo
                        }
                    };
                    reader.readAsDataURL(file); // Read file as base64
                }
            });


            $("#btn").on("click", function () {

  // Collect all required fields
        const clientName = $('#clientName').val().trim();
        const mobileNo = $('#mobileNo').val().trim();
        const joiningDate = $('#joiningDate').val().trim();
        const referBy = $('#referBy').val();
        const priority = $('#priority').val();
        const address = $('#address').val().trim();
        const status = $('#Status').val().trim();
        const clientId = $('#clientId').val().trim();
        const password = $('#password').val().trim();
        const bankAccount = $('#bankAccount').val().trim();
        const IFSC = $('#IFSC').val().trim();
        const adhaarNumber = $('#adhaarNumber').val().trim();
                const nomineeName = $('#nomineeName').val().trim();
                const place = $('#place').val().trim();

        // Validation
        let isValid = true;

        // Helper function to show error
        const showError = (field, message) => {
            alert(message); // Alert for simplicity; replace with custom error UI if needed
            field.focus();
            isValid = false;
        };

        if (!clientName) return showError($('#clientName'), 'Client Name is required.');
        if (!mobileNo) return showError($('#mobileNo'), 'Mobile Number is required.');
        if (!joiningDate) return showError($('#joiningDate'), 'Joining Date is required.');
        if (!referBy || referBy === 'Choose From Option') return showError($('#referBy'), 'Please select a Refer By option.');
        if (!priority || priority === 'Choose From Option') return showError($('#priority'), 'Please select a Priority option.');
        if (!address) return showError($('#address'), 'Address is required.');
        if (!status) return showError($('#Status'), 'Status is required.');
        if (!clientId) return showError($('#clientId'), 'Client ID is required.');
        if (!password) return showError($('#password'), 'Password is required.');
        if (!bankAccount) return showError($('#bankAccount'), 'Bank Account Number is required.');
        if (!IFSC) return showError($('#IFSC'), 'IFSC Code is required.');
        if (!adhaarNumber) return showError($('#adhaarNumber'), 'Adhaar Number is required.');
                if (!nomineeName) return showError($('#nomineeName'), 'Nominee Name is required.');
                if (!place) return showError($('#place'), 'place is required.');

        // If all fields are valid
        if (isValid) {
            alert('Form is valid. Proceed with submission.');
            // Add form submission or AJAX code here
        }

                $.ajax({
                    type: "POST",
                    url: "Transaction.aspx/Insert",
                    data: '{' +
                        'clientName:"' + $("#clientName").val() + '", ' +
                        'mobileNo:"' + $("#mobileNo").val() + '", ' +
                        'joiningDate:"' + $("#joiningDate").val() + '", ' +
                        'whatsappNo:"' + $("#whatsappNo").val() + '", ' +
                        'emailId:"' + $("#emailId").val() + '", ' +
                        'referBy:"' + $("#referBy").val() + '", ' +
                        'priority:"' + $("#priority").val() + '", ' +
                        'address:"' + $("#address").val() + '", ' +
                        'Status:"' + $("#Status").val() + '", ' +
                        'clientId:"' + $("#clientId").val() + '", ' +
                        'passwordx:"' + $("#password").val() + '", ' +
                        'bankAccount:"' + $("#bankAccount").val() + '", ' +
                        'IFSC:"' + $("#IFSC").val() + '", ' +
                        'adhaarNumber:"' + $("#adhaarNumber").val() + '", ' +
                        'nomineeName:"' + $("#nomineeName").val() + '", ' +
                        'whatsappNotification:"' + ($("#whatsappNotification").is(":checked") ? 'true' : 'false') + '", ' +
                        'msgNotification:"' + ($("#msgNotification").is(":checked") ? 'true' : 'false') + '", ' +
                        'emailNotification:"' + ($("#emailNotification").is(":checked") ? 'true' : 'false') + '", ' +
                        'pic:"' + $("#hiden").val() + '", ' +
                        'path:"' + $("#hidden").val() + '", ' +
                        'picx:"' + $("#hidenx").val() + '", ' +
                        'pathx:"' + $("#hiddenx").val() + '", ' +
                        'picy:"' + $("#hideny").val() + '", ' +
                        'pathy:"' + $("#hiddeny").val() + '", ' +
                        'picz:"' + $("#hidenz").val() + '", ' +
                        'pathz:"' + $("#hiddenz").val() + '"' +
                        'place:"' + $("#place").val() + '"' +
                        '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccessrrd,
                    failure: function (response) {
                        alert(response.d);
                    }
                });

                function OnSuccessrrd(response) {

                    alert("You have Successfully Registered,Thank You");

                    window.location.reload();
                }
            });



        });</script>

</head>
<body>
    <form id="form1" runat="server">



        <div>

            <ucx1:MyUserControl11 runat="server" />
            <div class="container">
                <div class="form-container">
                    <div class="form-header">
                        <h3>Register New Investor</h3>
                    </div>
                    <div>
                        <div class="row g-3">
                            <!-- Left Column -->
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Client Name:</label>
                                    <input type="text" class="form-control" id="clientName" placeholder="Please Enter Name" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Mobile No:</label>
                                    <input type="number" class="form-control" id="mobileNo" placeholder="Enter Mobile Number" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Joining Date:</label>
                                    <input type="date" class="form-control" id="joiningDate" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">What's App:</label>
                                    <input type="number" class="form-control" id="whatsappNo" placeholder="Enter What's App Number" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Email ID:</label>
                                    <input type="email" class="form-control" id="emailId" placeholder="Enter your Email" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Refer By:</label>
                                    <select class="form-select" id="referBy" required>
                                        <option selected disabled>Choose From Option</option>
                                        <option>SK Danish Rahim</option>
                                        <option>Sagar Maharana</option>
                                        <option>Mirza Talif Baig</option>
                                        <option>Preeti Krushna Behera</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Set Priority:</label>
                                    <select class="form-select" id="priority" required>
                                        <option selected disabled>Choose From Option</option>
                                        <option>High</option>
                                        <option>Medium</option>
                                        <option>Low</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Address:</label>
                                    <textarea class="form-control" id="address" placeholder="Enter Address" required></textarea>
                                </div>
                                 <div class="mb-3">
     <label class="form-label fw-bold">Place:</label>
     <input type="text" class="form-control" id="place" >
 </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Status:</label>
                                    <input type="text" class="form-control" id="Status" placeholder=" Status" value ="Active" readonly></input>
                                </div>

                            </div>

                            <!-- Right Column -->
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Client ID:</label>
                                    <input type="text" class="form-control" id="clientId" placeholder="Auto Generate"/>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Password:</label>
                                    <input type="password" class="form-control" id="password" placeholder="Enter Password" required/>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Bank Account:</label>
                                    <div class="input-group mb-2">
                                        <input type="text" class="form-control" id="bankAccount" placeholder="Enter Account Number" required/>
                                    </div>
                                    <label class="form-label fw-bold">IFSC Code</label>
                                    <div class="input-group mb-2">
                                        <input type="text" class="form-control" id="IFSC" placeholder="Enter IFSC Code" required/>
                                    </div>
                                    <div class="input-group">
                                        <input type="file" class="form-control file-input" id="fileInputBankAccount" required/>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Adhaar Number:</label>
                                    <div class="input-group mb-2">
                                        <input type="text" class="form-control" id="adhaarNumber" placeholder="Enter Adhaar Number" required/>
                                    </div>
                                    <div class="input-group">
                                        <input type="file" class="form-control file-input" id="fileInputAdhaar" required/>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Nominee:</label>
                                    <div class="input-group mb-2">
                                        <input type="text" class="form-control" id="nomineeName" placeholder="Enter Nominee Name" required/>
                                    </div>
                                    <div class="input-group">
                                        <input type="file" class="form-control file-input" id="fileInputNominee" required/>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Photo:</label>
                                    <div class="input-group">
                                        <input type="file" class="form-control file-input" id="fileInputPhoto" required/>
                                    </div>
                                </div>

                                <!-- Hidden fields -->

                                <input type="hidden" value="" id="hiden" runat="server" />
                                <input type="hidden" value="" runat="server" id="hidden" />
                                <input type="hidden" value="" id="hidenx" runat="server" />
                                <input type="hidden" value="" runat="server" id="hiddenx" />
                                <input type="hidden" value="" id="hideny" runat="server" />
                                <input type="hidden" value="" runat="server" id="hiddeny" />
                                <input type="hidden" value="" id="hidenz" runat="server" />
                                <input type="hidden" value="" runat="server" id="hiddenz" />


                                <div class="mb-3 d-flex align-items-center">
                                    <label class="form-label fw-bold me-auto">What's App Notification:</label>
                                    <div class="checkbox-wrapper-5">
                                        <div class="check">
                                            <input id="whatsappNotification" type="checkbox"/>
                                            <label for="check-5"></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="mb-3 d-flex align-items-center">
                                    <label class="form-label fw-bold me-auto">MSG Notification:</label>


                                    <div class="checkbox-wrapper-5">
                                        <div class="check">
                                            <input id="msgNotification" type="checkbox">
                                            <label for="check-5"></label>
                                        </div>
                                    </div>

                                </div>
                                <div class="mb-3 d-flex align-items-center">
                                    <label class="form-label fw-bold me-auto">Email Notifications:</label>

                                    <div class="checkbox-wrapper-5">
                                        <div class="check">
                                            <input id="emailNotification" type="checkbox">
                                            <label for="check-5"></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="create-profile-btn mt-3">
                            <button type="button" class="btn btn-primary" id="btn">+Add Investor</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
