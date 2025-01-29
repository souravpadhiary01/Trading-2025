<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PNL.aspx.cs" Inherits="PNL" %>

<%@ Register TagPrefix="ucx1" TagName="MyUserControl11" Src="~/sidenav2.ascx" %>
<%@ Register TagPrefix="ucx" TagName="MyUserControl1" Src="~/header.ascx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <ucx:MyUserControl1 runat="server" />

    <title>PNL Table</title>

    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }

        h1 {
            text-align: center;
            margin: 20px 0;
            font-size: 2.5rem;
            color: #343a40;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .table-container {
            margin-top: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        table {
            width: 100%;
            text-align: center;
        }

        thead {
            background: linear-gradient(90deg, #007bff, #6610f2);
            color: white;
        }

        th, td {
            padding: 15px;
        }

        tbody tr:hover {
            background-color: #f1f3f5;
        }

        .btn-pnl {
            width: 80px;
            margin: 2px;
            font-weight: bold;
            background-color: #007bff;
            border: none;
            color: white;
            transition: all 0.3s ease;
        }

            .btn-pnl:hover {
                background-color: #0056b3;
                transform: scale(1.1);
            }

        .table-bordered th {
            background-color: lightblue !important;
        }
        /* Modal Custom Styling */
        .modal-content {
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            animation: fadeIn 0.4s ease-in-out;
        }

        /* Header with Gradient */
        .modal-header {
            background: linear-gradient(135deg, #007bff, #6610f2);
            color: white;
            padding: 16px;
        }

            /* Close Button Styling */
            .modal-header .btn-close {
                filter: brightness(0) invert(1);
            }

        /* Modal Body Styling */
        .modal-body {
            background-color: #f8f9fa;
            padding: 20px;
        }

            /* Input Fields */
            .modal-body .form-control {
                border-radius: 8px;
                border: 1px solid #ccc;
                padding: 12px;
                transition: 0.3s ease;
            }

                .modal-body .form-control:focus {
                    border-color: #007bff;
                    box-shadow: 0 0 8px rgba(0, 123, 255, 0.5);
                }

            /* File Input */
            .modal-body input[type="file"] {
                background-color: white;
                border: 1px solid #ccc;
                padding: 10px;
                border-radius: 8px;
            }

        /* Switch Styling */
        .form-switch .form-check-input {
            width: 50px;
            height: 25px;
            cursor: pointer;
        }

            .form-switch .form-check-input:checked {
                background-color: #007bff;
                border-color: #007bff;
            }

        /* Modal Footer Buttons */
        .modal-footer {
            background-color: #f1f3f5;
            border-top: 1px solid #ddd;
            padding: 12px;
        }

            /* Save Button */
            .modal-footer .btn-primary {
                background: linear-gradient(135deg, #007bff, #6610f2);
                border: none;
                border-radius: 8px;
                padding: 10px 20px;
                font-weight: bold;
                transition: 0.3s ease;
            }

                .modal-footer .btn-primary:hover {
                    background: linear-gradient(135deg, #0056b3, #520dc2);
                    transform: scale(1.05);
                }

            /* Close Button */
            .modal-footer .btn-secondary {
                border-radius: 8px;
            }

        /* Modal Animation */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: scale(0.9);
            }

            to {
                opacity: 1;
                transform: scale(1);
            }
        }
        #uploadPnlBtn{
            float:right;
            margin-top:10px;
            margin-right:30px;
        }
    </style>

    <script>
        $(document).ready(function () {
            $(document).on("change", ".pnlFiles", function () {
                let lastInputGroup = $(".file-input-group").last();
                let hasPlusButton = lastInputGroup.find(".add-file-input").length > 0;

                if (hasPlusButton) {
                    let newInput = `
                <div class="input-group mb-2 file-input-group">
                    <input type="file" class="form-control pnlFiles" name="pnlFiles[]" multiple>
                    <button type="button" class="btn btn-success add-file-input">+</button>
                </div>`;
                    $("#fileInputsContainer").append(newInput);
                    $(this).siblings(".add-file-input").remove();
                }

                $(".file-input-group").each(function () {
                    let input = $(this).find(".pnlFiles");
                    let removeBtn = '<button type="button" class="btn btn-danger remove-file-input">-</button>';

                    if (input.val()) {
                        if (!$(this).find(".remove-file-input").length) {
                            $(this).append(removeBtn);
                        }
                    }
                });
            });

            $(document).on("click", ".remove-file-input", function () {
                $(this).closest(".file-input-group").remove();
                if ($(".file-input-group").length === 1) {
                    $(".file-input-group").first().append('<button type="button" class="btn btn-success add-file-input">+</button>');
                }
            });
        });





    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <ucx1:MyUserControl11 runat="server" />

            <h1>Profit and Loss Table</h1>
            <button type="button" class="btn btn-success" id="uploadPnlBtn" data-bs-toggle="modal" data-bs-target="#uploadPnlModal">
                Upload PNL
            </button>



            <div class="container table-container">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Sl No</th>
                            <th>Date</th>
                            <th>PNL</th>
                            <th>Profit</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>01-04-2023</td>
                            <td>
                                <button class="btn btn-primary btn-pnl" data-link="https://example.com/1">PNL</button>
                                <button class="btn btn-primary btn-pnl" data-link="https://example.com/2">PNL</button>
                                <button class="btn btn-primary btn-pnl" data-link="https://example.com/3">PNL</button>
                                <button class="btn btn-primary btn-pnl" data-link="https://example.com/4">PNL</button>
                            </td>
                            <td>600,000.00</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>01-04-2023</td>
                            <td>
                                <button class="btn btn-primary btn-pnl" data-link="https://example.com/5">PNL</button>
                            </td>
                            <td>3,000.00</td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>01-04-2023</td>
                            <td>
                                <button class="btn btn-primary btn-pnl" data-link="https://example.com/6">PNL</button>
                            </td>
                            <td>50,000.00</td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td>01-04-2023</td>
                            <td>
                                <button class="btn btn-primary btn-pnl" data-link="https://example.com/7">PNL</button>
                                <button class="btn btn-primary btn-pnl" data-link="https://example.com/8">PNL</button>
                                <button class="btn btn-primary btn-pnl" data-link="https://example.com/9">PNL</button>
                                <button class="btn btn-primary btn-pnl" data-link="https://example.com/10">PNL</button>
                                <button class="btn btn-primary btn-pnl" data-link="https://example.com/11">PNL</button>
                            </td>
                            <td>70,000.00</td>
                        </tr>
                    </tbody>
                </table>
            </div>
    <%--modal--%>
<div class="modal fade" id="uploadPnlModal" tabindex="-1" aria-labelledby="uploadPnlLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="uploadPnlLabel">PNL Upload Form</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="pnlUploadForm">
                    <div class="mb-3">
                        <label for="pnlDate" class="form-label">Date</label>
                        <input type="text" class="form-control" id="pnlDate" value="Auto Generate" disabled>
                    </div>
                    <div class="mb-3">
                        <label for="pnlAmount" class="form-label">Amount</label>
                        <input type="text" class="form-control" id="pnlAmount" placeholder="Enter Profit or Loss Amount">
                    </div>
                    <div class="mb-3">
                        <label for="pnlNote" class="form-label">Note*</label>
                        <input type="text" class="form-control" id="pnlNote" placeholder="Add Details">
                    </div>
<div class="mb-3" id="fileInputsContainer">
    <label class="form-label">Upload Files</label>
    <div class="input-group mb-2 file-input-group">
        <input type="file" class="form-control pnlFiles" name="pnlFiles[]" multiple>
        <button type="button" class="btn btn-success add-file-input">+</button>
    </div>
</div>                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" id="publishPnl">
                        <label class="form-check-label" for="publishPnl">Publish PNL</label>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="savePnl">Save</button>
            </div>
        </div>
    </div>
</div>


        </div>
    </form>
</body>
</html>
