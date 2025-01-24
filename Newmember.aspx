<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Newmember.aspx.cs" Inherits="Newmember" %>

<%@ Register TagPrefix="ucx1" TagName="MyUserControl11" Src="~/sidenav2.ascx" %>
<%@ Register TagPrefix="ucx" TagName="MyUserControl1" Src="~/header.ascx" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <ucx:MyUserControl1 runat="server" />

    <title></title>
</head>

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

        // Fetch client name based on client ID
        // Trigger AJAX request when clientId changes
        $('#clientId').on('change', function () {
            const clientId = $(this).val().trim(); // Get the entered Client ID

            if (!clientId) {
                $('#clientname').val(''); // Clear client name if clientId is empty
                return;
            }

            // Make an AJAX request to fetch client name
            $.ajax({
                type: 'POST',
                url: 'Newmember.aspx/GetClientName', // Replace with your backend method URL
                data: JSON.stringify({ clientId: clientId }), // Pass clientId to the backend
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (response) {
                    if (response.d) { // Assuming the response contains the client name
                        $('#clientname').val(response.d); // Set the fetched client name
                    } else {
                        $('#clientname').val(''); // Clear if no client name found
                        alert('No client found for the entered Client ID.');
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                    alert('An error occurred while fetching the client name. Please try again.');
                }
            });
        });

        function generateMemberId() {
            const clientId = $('#clientId').val().trim(); // Get the client name

            if (clientId) {
                const firstName = clientId.split(' ')[0]; // Get the first word of the name
                const memberId = 'M' + firstName; // Generate Member ID with "M" prefix
                $('#memberid').val(memberId); // Set the Member ID
            } else {
                $('#memberid').val(''); // Clear the Member ID if input is invalid
            }
        }

        // Trigger `generateMemberId` when client name changes
        $('#clientId').on('input', function () {
            generateMemberId();
        });



        // Handle file input changes to capture Base64 data
        $('.file-input').on('change', function () {
            const inputId = $(this).attr('id');
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    const base64Data = e.target.result;
                    const fileName = file.name;

                    // Map Base64 data and file name to hidden fields based on input ID
                    if (inputId === 'fileInputAdhaar') {
                        $('#hidenx').val(base64Data);
                        $('#hiddenx').val(fileName);
                    } else if (inputId === 'fileInputPhoto') {
                        $('#hidenz').val(base64Data);
                        $('#hiddenz').val(fileName);
                    }
                    else if (inputId === 'fileInputBank') {
                        $("#hideny").val(base64Data);
                        $("#hiddeny").val(fileName);
                    }
                };
                reader.readAsDataURL(file); // Read file as Base64
            }
        });

        // Handle form submission on button click
        $('#btn').on('click', function () {
            // Collect all form data
            const formData = {
                clientId: $('#clientId').val().trim(),
                clientname: $('#clientname').val().trim(),
                mobileNo: $('#mobileNo').val().trim(),
                joiningDate: $('#joiningDate').val().trim(),
                whatsappNo: $('#whatsappNo').val().trim(),
                emailId: $('#emailId').val().trim(),
                priority: $('#priority').val(),
                address: $('#address').val().trim(),
                memberId: $('#memberid').val().trim(),
                password: $('#password').val().trim(),
                bankAccount: $('#bankAccount').val().trim(),
                IFSC: $('#IFSC').val().trim(),
                adhaarNumber: $('#adhaarNumber').val().trim(),
                nomineeName: $('#nomineeName').val().trim(),
                place: $('#place').val().trim(),
                whatsappNotification: $('#whatsappNotification').is(':checked'),
                msgNotification: $('#msgNotification').is(':checked'),
                emailNotification: $('#emailNotification').is(':checked'),
                picAdhaar: $('#hidenx').val(),
                pathAdhaar: $('#hiddenx').val(),
                picPhoto: $('#hidenz').val(),
                pathPhoto: $('#hiddenz').val(),
                picBank: $('#hideny').val(),
                pathBank: $('#hiddeny').val()
            };

            // Validate form data
            if (!formData.clientId || !formData.mobileNo || !formData.joiningDate || !formData.password) {
                alert('Please fill out all required fields.');
                return;
            }

            // Send data to the backend
            $.ajax({
                type: 'POST',
                url: 'Newmember.aspx/InsertInvestor', // Replace with your backend method URL
                data: JSON.stringify({ data: formData }),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (response) {
                    alert('Investor added successfully!');
                    // Optionally reset the form
                    $('input').val('');
                    $('textarea').val('');
                    $('select').prop('selectedIndex', 0);
                    $('input[type=checkbox]').prop('checked', false);
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                    alert('An error occurred while saving the data. Please try again.');
                }
            });
        });
    });

</script>



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
                                    <label class="form-label fw-bold">Client id:</label>
                                    <input type="text" class="form-control" id="clientId" placeholder="Please Enter id" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Client name:</label>
                                    <input type="text" class="form-control" id="clientname" placeholder="Please Enter Name" required>
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

                            </div>

                            <!-- Right Column -->
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Member ID:</label>
                                    <input type="text" class="form-control" id="memberid" placeholder="Auto Generate">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Password:</label>
                                    <input type="password" class="form-control" id="password" placeholder="Enter Password" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Bank Account:</label>
                                    <div class="input-group mb-2">
                                        <input type="text" class="form-control" id="bankAccount" placeholder="Enter Account Number" required>
                                    </div>
                                    <div class="input-group">
                                        <input type="file" class="form-control file-input" id="fileInputBank" required>
                                    </div>

                                    <label class="form-label fw-bold">IFSC Code</label>
                                    <div class="input-group mb-2">
                                        <input type="text" class="form-control" id="IFSC" placeholder="Enter IFSC Code" required>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Adhaar Number:</label>
                                    <div class="input-group mb-2">
                                        <input type="text" class="form-control" id="adhaarNumber" placeholder="Enter Adhaar Number" required>
                                    </div>
                                    <div class="input-group">
                                        <input type="file" class="form-control file-input" id="fileInputAdhaar" required>
                                    </div>
                                </div>


                                <div class="mb-3">
                                    <label class="form-label fw-bold">Photo:</label>
                                    <div class="input-group">
                                        <input type="file" class="form-control file-input" id="fileInputPhoto" required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Nominee:</label>
                                        <div class="input-group mb-2">
                                            <input type="text" class="form-control" id="nomineeName" placeholder="Enter Nominee Name" required>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Place:</label>
                                        <div class="input-group mb-2">
                                            <input type="text" class="form-control" id="place" placeholder="Enter place" required>
                                        </div>
                                    </div>



                                </div>

                                <!-- Hidden fields -->


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
                                            <input id="whatsappNotification" type="checkbox">
                                            <label for="check-5"></label>
                                        </div>
                                    </div>
                                    <%--<input type="checkbox" class="form-check-input" id="whatsappNotification" checked>--%>
                                </div>
                                <div class="mb-3 d-flex align-items-center">
                                    <label class="form-label fw-bold me-auto">MSG Notification:</label>

                                    <%--<input type="checkbox" class="form-check-input" id="msgNotification" checked>--%>

                                    <div class="checkbox-wrapper-5">
                                        <div class="check">
                                            <input id="whatsappNotification" type="checkbox">
                                            <label for="check-5"></label>
                                        </div>
                                    </div>

                                </div>
                                <div class="mb-3 d-flex align-items-center">
                                    <label class="form-label fw-bold me-auto">Email Notifications:</label>
                                    <%--<input type="checkbox" class="form-check-input" id="emailNotification">--%>

                                    <div class="checkbox-wrapper-5">
                                        <div class="check">
                                            <input id="whatsappNotification" type="checkbox">
                                            <label for="check-5"></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="create-profile-btn mt-3">
                            <button type="button" class="btn btn-primary" id="btn">+Add Newmember</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
