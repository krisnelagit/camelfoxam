<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : AddEnquiries
    Created on : 18-May-2015, 15:18:35
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Enquiries</title>
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />        
        <script src="js/jquery-ui.js"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery.datetimepicker.css"/>
        <script src="js/jquery.datetimepicker.js"></script>
        <script>
            $(document).ready(function () {
                $("#insurancetable").hide();
                $("#companyname").prop("required", false);
                for (var i = new Date().getFullYear(); i > 1946; i--) {
                    $('#yearMonthInput').append($('<option />').val(i).html(" " + i));
                }
                var currentDate = new Date();
                $(function () {
                    $(".datepicker").datepicker({dateFormat: 'yy-mm-dd'});
                    $(".datepicker").datepicker("option", "showAnim", 'drop');
                    $(".datepicker").datepicker("setDate", currentDate);
                });

                $(function () {
                    $("#fpdatepicker").datepicker({dateFormat: 'yy-mm-dd', maxDate: 0, setDate: currentDate});
                    $("#fpdatepicker").datepicker("option", "showAnim", 'drop');
//                    $("#fpdatepicker").datepicker("setDate", currentDate);
                });

                $(function () {
                    $("#fpdatepicker2").datepicker({dateFormat: 'yy-mm-dd', minDate: 0, setDate: currentDate});
                    $("#fpdatepicker2").datepicker("option", "showAnim", 'drop');
                });

                $('#apdatetimepicker').datetimepicker({
                    format: 'Y-m-d  H:i',
                    minDate:0
                });

                //setting current date time in appointment popup
                var monthNames = [
                    "01", "02", "03",
                    "04", "05", "06", "07",
                    "08", "09", "10",
                    "11", "12"];

                var date = new Date();
                var day = date.getDate();
                var monthIndex = date.getMonth();
                var year = date.getFullYear();
                var hours = date.getHours();
                var min = date.getMinutes();
                $('#apdatetimepicker').val(year+ "-" + monthNames[monthIndex] + "-" + day + "  " + hours + ":" + min);
                //end of setting date time for appointment

                getcarmodels();

            });

            function getcarmodels() {
                var brandid = $("#carbrand").val();
                $.ajax({
                    url: "getModelDetails",
                    dataType: 'json',
                    type: 'POST',
                    data: {
                        brandid: brandid
                    },
                    success: function (data) {
                        if (data) {

                            $('#carmodel option').remove();
                            for (var i = 0; i < data.length; i++) {
                                $("#carmodel").append('<option value="' + data[i].id + '">' + data[i].vehiclename + '</option>');
                            }
                        }
                    }, error: function () {
                    }
                });
            }

            function getFields(option) {
                var selectedStatus = $(option).val();
                if (selectedStatus == "Insurance") {
                    $("#insurancetable").show();
                    $("#companyname").prop("required", true);
                } else {
                    $("#insurancetable").hide();
                    $("#companyname").prop("required", false);
                }
            }
        </script>
        <script>
            var insuranceCompany;
            $(function () {
                insuranceCompany = [
            <c:forEach var="ob" items="${insuranceCompanyDetails}">
                    {value: "${ob.id}", label: "${ob.name}"},
            </c:forEach>
                ];

                var sourced = [];
                var mappingd = {};
                for (var i = 0; i < insuranceCompany.length; ++i) {
                    sourced.push(insuranceCompany[i].label);
                    mappingd[insuranceCompany[i].label] = insuranceCompany[i].value;
                }
                $("#companyname").autocomplete({
                    source: sourced,
                    select: function (event, ui) {
                        $("#companyid").val(mappingd[ui.item.value]);
                    },
                    change: function () {
                        var val = $(this).val();
                        var exists = $.inArray(val, sourced);
                        if (exists < 0) {
                            $(this).val("");
                            return false;
                        } else {

                        }
                    }
                });
            });
        </script>
        <style>
            /*@charset "utf-8";*/

            /* CSS Document */
            .cf:before, .cf:after {
                content:"";
                display:table;
            }
            .cf:after {
                clear:both;
            }
            /* Normal styles for the modal */
            #modal {
                left:70%;
                margin:-250px 0 0 -40%;
                opacity: 0;
                position:fixed;
                top:0%;
                visibility: hidden;
                width:40%;
                box-shadow:0 3px 7px rgba(0, 0, 0, .25);
                box-sizing:border-box;
                transition: all 0.4s ease-in-out;
                -moz-transition: all 0.4s ease-in-out;
                -webkit-transition: all 0.4s ease-in-out;
            }
            /* Make the modal appear when targeted */
            #modal:target {
                opacity: 1;
                top:60%;
                visibility: visible;
            }
            #modal .header, #modal .footer {
                border-bottom: 1px solid #e7e7e7;
                border-radius: 5px 5px 0 0;
            }
            #modal .footer {
                border:none;
                border-top: 1px solid #e7e7e7;
                border-radius: 0 0 5px 5px;
            }
            #modal h2 {
                margin:0;
            }
            #modal .btn {
                float:right;
            }
            #modal .copy, #modal .header, #modal .footer {
                padding:15px;
            }
            .modal-content {
                background: #f7f7f7;
                position: relative;
                z-index: 20;
                border-radius:5px;
            }
            #modal .copy {
                background: #fff;
            }
            #modal .overlay {
                background-color: #000;
                background: rgba(0, 0, 0, .5);
                height: 100%;
                left: 0;
                position: fixed;
                top: 0;
                width: 100%;
            }
            #modal1 {
                left:70%;
                margin:-250px 0 0 -40%;
                opacity: 0;
                position:fixed;
                top:0%;
                visibility: hidden;
                width:40%;
                box-shadow:0 3px 7px rgba(0, 0, 0, .25);
                box-sizing:border-box;
                transition: all 0.4s ease-in-out;
                -moz-transition: all 0.4s ease-in-out;
                -webkit-transition: all 0.4s ease-in-out;
            }
            /* Make the modal appear when targeted */
            #modal1:target {
                opacity: 1;
                top:60%;
                visibility: visible;
            }
            #modal1 .header, #modal .footer {
                border-bottom: 1px solid #e7e7e7;
                border-radius: 5px 5px 0 0;
            }
            #modal1 .footer {
                border:none;
                border-top: 1px solid #e7e7e7;
                border-radius: 0 0 5px 5px;
            }
            #modal1 h2 {
                margin:0;
            }
            #modal1 .btn {
                float:right;
            }
            #modal1 .copy, #modal1 .header, #modal1 .footer {
                padding:15px;
            }
            .modal1-content {
                background: #f7f7f7;
                position: relative;
                z-index: 20;
                border-radius:5px;
            }
            #modal1 .copy {
                background: #fff;
            }
            #modal1 .overlay {
                background-color: #000;
                background: rgba(0, 0, 0, .5);
                height: 100%;
                left: 0;
                position: fixed;
                top: 0;
                width: 100%;
            }

        </style>
    </head>
    <body>
        <a href="enquiriesgridlink" class="view">Back</a><a href="#modal" class="btn go view">Appointment</a><a href="#modal1" class="btn go view">Follow ups</a>
        <br/>

        <form action="insertLead" method="POST">

            <div id="modal">
                <div class="modal-content">
                    <div class="header">
                        <h2>Add appointment</h2>
                        <a href="#" class="btn"><img style="margin-top: -20px; width: 20px;height: 20px" src="images/cancel.png" ></a>

                    </div>
                    <div class="copy">
                        <table cellpadding="5" width="100%">
                            <tbody>
                                <tr>
                                    <td align="left" valign="top" width="13%">Date Time</td>
                                    <td align="left" valign="top" width="28%">
                                        <input name="datetime" id="apdatetimepicker" id="textfield2" type="text">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top" width="8%">Subject</td>
                                    <td align="left" valign="top" width="51%"><input name="subject" id="textfield9" type="text"></td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">Address</td>
                                    <td align="left" valign="top"><textarea name="address" id="address" rows="4" cols="20"></textarea></td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">Description</td>
                                    <td align="left" valign="top"><textarea name="apdescription" id="apdescription" rows="4" cols="20"></textarea></td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">Appointment owner</td>
                                    <td align="left" valign="top"><input name="appointmentowner" id="textfield3" type="text"></td>
                                </tr>
                            </tbody>
                        </table>

                    </div>
                    <div class="cf footer">	
                    </div>
                </div>
                <div class="overlay"></div>
            </div>



            <div id="modal1">
                <div class="modal-content">
                    <div class="header">
                        <h2>Add Followups</h2>
                        <a href="#" class="btn"><img style="margin-top: -20px; width: 20px;height: 20px" src="images/cancel.png" ></a>

                    </div>
                    <div class="copy">

                        <input name="type" type="hidden" value="lead">
                        <table cellpadding="5" width="100%">
                            <tbody>
                                <tr>
                                    <td align="left" valign="top" width="13%">Followed by</td>
                                    <td align="left" valign="top" width="28%">
                                        <input name="followedby" id="datepicker1" id="textfield2" type="text">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top" width="8%">Last Follow up</td>
                                    <td align="left" valign="top" width="51%"><input name="lastfollowup" id="fpdatepicker"  type="text"></td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">Next Follow up</td>
                                    <td align="left" valign="top"><input name="nextfollowup" id="fpdatepicker2"  type="text"></td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">Title</td>
                                    <td align="left" valign="top"><input name="title" id="textfield3" type="text"></td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">Description</td>
                                    <td align="left" valign="top"><input name="fpdescription" id="textfield3" type="text"></td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">Status</td>
                                    <td align="left" valign="top">
                                        <select name="fpstatus" class="select">
                                            <option>Incomplete</option>
                                            <option>complete</option>
                                            <option>In Progress</option>
                                        </select>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="cf footer">	
                    </div>
                </div>
                <div class="overlay"></div>
            </div>
            <h2>Lead Details</h2>
            <br>
            <br>
            <table cellpadding="5" width="100%">

                <tbody>
                    <tr>
                        <td align="left" valign="top" width="13%">Date</td>
                        <td align="left" valign="top" width="28%">
                            <input name="date" required="" class="datepicker" id="textfield2" type="text">
                        </td>
                        <td align="left" valign="top" width="8%">Name</td>
                        <td align="left" valign="top" width="51%"><input name="name" pattern=".{3,20}" required="" title="3 to 20 characters max name allowed" id="textfield9" type="text"></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Email</td>
                        <td align="left" valign="top"><input name="email" id="textfield" required="" pattern="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?" title="Please enter a valid email" type="text"></td>
                        <td align="left" valign="top">Mobile</td>
                        <td align="left" valign="top"><input name="mobile" required="" pattern="^[789]\d{9}$" title="Please enter a valid mobilenumber" id="textfield3" type="text"></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" width="13%">Car Brand</td>
                        <td align="left" valign="top" width="28%">
                            <select name="brandid" id="carbrand" onchange="getcarmodels()">
                                <option disabled="">--select--</option>
                                <c:forEach var="ob" items="${carbranddetails}">
                                    <option value="${ob.id}">${ob.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td align="left" valign="top" width="13%">Car model</td>
                        <td align="left" valign="top" width="28%">
                            <select name="branddetailid" id="carmodel">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Lead Source</td>
                        <td align="left" valign="top">
                            <select name="leadsource" required="" class="select">
                                <option>Just Dial</option>
                                <option>Sulekha</option>
                                <option>Self</option>
                                <option>Facebook</option>
                                <option>Other</option>
                            </select>
                        </td>
                        <td align="left" valign="top">Location</td>
                        <td align="left" valign="top"><input name="location" pattern=".{3,20}" required="" title="3 to 20 characters max name allowed" id="textfield5" type="text"></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Lead Owner</td>
                        <td align="left" valign="top"><input name="leadowner" pattern=".{3,20}" required="" title="3 to 20 characters max name allowed" id="textfield8" type="text"></td>
                        <td align="left" valign="top">Status</td>
                        <td align="left" valign="top">
                            <select name="status" onchange="getFields(this)" class="select">
                                <option>None</option>
                                <option>shopping for price</option>
                                <option>Attempted to Contact</option>
                                <option>Contacted</option>
                                <option>Contact in Future</option>
                                <option>Converted to Potential</option>
                                <option>Lost Lead</option>
                                <option>Fake Lead</option>
                                <option>Insurance</option>
                                <option>Preowned cars</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Requirement</td>
                        <td colspan="3" align="left" valign="top"><textarea name="requirement" required="" maxlength="600" cols="100" style="width: 717px;height: 295px" id="textfield6"></textarea></td>
                    </tr>
                </tbody>
            </table>

            <table cellpadding="5" id="insurancetable" width="100%">
                <tbody>
                    <tr>
                        <td align="left" valign="top" width="13%">Policy no.</td>
                        <td align="left" valign="top" width="28%">
                            <input type="text" name="policyno" id="textfield2" />
                        </td>
                        <td align="left" valign="top" width="8%">Current Ins Company</td>
                        <td align="left" valign="top" width="51%"><input type="text" name="insurancecompanyname" id="companyname" /><input type="hidden" name="insurancecompany" id="companyid" /></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" width="13%">Policy Type</td>
                        <td align="left" valign="top" width="28%">
                            <input type="text" name="type" id="textfield2" />
                        </td>
                        <td align="left" valign="top" width="8%">Expiry Date</td>
                        <td align="left" valign="top" width="51%"><input type="text" name="expirydate" class="datepicker"  /></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" width="13%">IDV of Vehicle</td>
                        <td align="left" valign="top" width="28%">
                            <input type="text" name="idv" id="textfield2" />
                        </td>
                        <td align="left" valign="top" width="8%">&nbsp;</td>
                        <td align="left" valign="top" width="51%">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" width="13%">Year of Manufacturer</td>
                        <td align="left" valign="top" width="28%">
                            <select name="yearofmanufacturer" id="yearMonthInput"></select>
                        </td>
                        <td align="left" valign="top" width="8%">Engine CC</td>
                        <td align="left" valign="top" width="51%"><input type="text" name="enginecc" id="textfield2" /></td>
                    </tr>
                </tbody>
            </table>

            <center>
                <input type="submit" class="view3" style="cursor: pointer" value="Save"  /> &nbsp;&nbsp;
            </center>
        </form>
    </body>
</html>
