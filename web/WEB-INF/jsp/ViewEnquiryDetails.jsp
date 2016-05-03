<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewEnquiryDetails
    Created on : 19-May-2015, 13:11:27
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Enquiry Details</title>
        <link rel="stylesheet" type="text/css" href="css/jquery.datetimepicker.css"/>
        <script src="js/jquery.datetimepicker.js"></script>
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />        
        <script src="js/jquery-ui.js"></script>
        <script>
            $(document).ready(function () {
                var currentDate = new Date();
                $(function () {
                    $(".datepicker").datepicker({dateFormat: 'yy-mm-dd'});
                    $(".datepicker").datepicker("option", "showAnim", 'drop');
                    $(".datepicker").datepicker("setDate", currentDate);
                });

                $(function () {
                    $("#fpdatepicker").datepicker({dateFormat: 'yy-mm-dd', maxDate: 0, setDate: currentDate});
//                    $("#fpdatepicker").datepicker({dateFormat: 'yy-mm-dd'});
                    $("#fpdatepicker").datepicker("option", "showAnim", 'drop');
//                    $("#fpdatepicker").datepicker("setDate", currentDate);
                });

                $(function () {
                    $("#fpdatepicker2").datepicker({dateFormat: 'yy-mm-dd', minDate: 0, setDate: currentDate});
                    $("#fpdatepicker2").datepicker("option", "showAnim", 'drop');
//                    $("#fpdatepicker2").datepicker("setDate", currentDate);
                });

                $('#apdatetimepicker').datetimepicker({
                    format: 'Y-m-d  H:i'
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

                $("#hide").click(function () {
                    $(".target").hide("drop", {direction: "up"}, 1000);
                });


            });
        </script>
        <script>
            $(function () {
                //popup for Edit followup details
                $("#dialogfollowups").hide();
                //on click of edit
                $(".followup_link3").click(function (e) {

                    $("#apdatetimepicker").prop("required", false);
                    $("#appsubject").prop("required", false);
                    $("#appaddress").prop("required", false);
                    $("#appdescription").prop("required", false);
                    $("#appointmentowner").prop("required", false);
                    e.preventDefault();
                    $("#dialogfollowups").dialog({
                        modal: true,
                        effect: 'drop',
                        width: 600,
                        height: 450,
                        show: {
                            effect: "drop"
                        },
                        hide: {
                            effect: "drop"
                        }
                    });
                    $("#datepicker1").prop("required", true);
                    $("#fpdatepicker").prop("required", true);
                    $("#fpdatepicker2").prop("required", true);
                    $("#fptitle").prop("required", true);
                    $("#fpdescription").prop("required", true);
                    $("#fpstatus").prop("required", true);
                });
            });//END FUNCTION
        </script>
        <script>
            $(function () {
                //popup for Edit Appointment details
                $("#dialogappointment").hide();
                //on click of edit
                $(".appointment_link3").click(function (e) {
                    e.preventDefault();

                    $("#datepicker1").prop("required", false);
                    $("#fpdatepicker").prop("required", false);
                    $("#fpdatepicker2").prop("required", false);
                    $("#fptitle").prop("required", false);
                    $("#fpdescription").prop("required", false);
                    $("#fpstatus").prop("required", false);
                    $("#dialogappointment").dialog({
                        modal: true,
                        effect: 'drop',
                        width: 600,
                        height: 450,
                        show: {
                            effect: "drop"
                        },
                        hide: {
                            effect: "drop"
                        }
                    });
                    $("#apdatetimepicker").prop("required", true);
                    $("#appsubject").prop("required", true);
                    $("#appaddress").prop("required", true);
                    $("#appdescription").prop("required", true);
                    $("#appointmentowner").prop("required", true);
                });
            });//END FUNCTION
        </script>
    </head>
    <body>
        <a href="enquiriesgridlink" class="view">Back</a><a href="" class="view appointment_link3">Appointment</a><a href="" class="view followup_link3">Follow ups</a>


        <div id="dialogappointment" title="Appointment">
            <form method="POST" action="insertAppointment">
                <input type="hidden" name="enquirieid" value="${enquirydtl.enquiryid}" />
                <table cellpadding="5" width="100%">
                    <tbody>
                        <tr>
                            <td align="left" valign="top" width="20%">Date Time</td>
                            <td align="left" valign="top" width="28%">
                                <input name="datetime" id="apdatetimepicker" id="appointmentdatetime" type="text">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="8%">Subject</td>
                            <td align="left" valign="top" width="51%"><input name="subject" id="appsubject" type="text"></td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">Address</td>
                            <td align="left" valign="top"><textarea name="address" id="appaddress" rows="4" cols="35"></textarea></td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">Description</td>
                            <td align="left" valign="top"><textarea name="apdescription" id="appdescription" rows="4" cols="35"></textarea></td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">Appointment owner</td>
                            <td align="left" valign="top"><input name="appointmentowner" id="appointmentowner" type="text"></td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">Pickup</td>
                            <td align="left" valign="top"><input type="radio" name="pickup" value="Yes" />Yes &nbsp;&nbsp;<input type="radio" name="pickup" value="No" />No</td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">&nbsp;</td>
                            <td align="left" valign="top"><input type="submit" class="view3" value="Save" style="cursor: pointer" /></td>
                        </tr>
                    </tbody>
                </table>
                <br>
                <br>

            </form>
        </div>

        <div id="dialogfollowups" title="New Followup">
            <form method="POST" action="insertFollowups">
                <input type="hidden" name="enquirieid" value="${param.enquiryid}" />
                <table cellpadding="5" width="100%">
                    <tbody>
                        <tr>
                            <td align="left" valign="top" width="13%">Followed by</td>
                            <td align="left" valign="top" width="28%">
                                <input name="followedby" id="datepicker1" type="text"><input name="type" type="hidden" value="lead">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="8%">Last Follow up</td>
                            <td align="left" valign="top" width="51%"><input name="lastfollowup" id="fpdatepicker" width="20%"  type="text"></td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">Next Follow up</td>
                            <td align="left" valign="top"><input name="nextfollowup"  width="20%" id="fpdatepicker2"  type="text"></td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">Title</td>
                            <td align="left" valign="top"><input name="title" id="fptitle" type="text"></td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">Description</td>
                            <td align="left" valign="top"><textarea name="fpdescription" id="fpdescription" rows="4" cols="35"></textarea></td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">Status</td>
                            <td align="left" valign="top">
                                <select name="fpstatus" id="fpstatus" class="select">
                                    <option>Incomplete</option>
                                    <option>complete</option>
                                    <option>In Progress</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">&nbsp;</td>
                            <td align="left" valign="top"><input type="submit" class="view3" style="cursor: pointer" value="Save" /></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
        <h2>Lead Details</h2>
        <br>
        <br>
        <table cellpadding="5" width="100%">
            <tbody>
                <tr>
                    <td align="left" valign="top" width="13%">Date</td>
                    <td align="left" valign="top" width="28%">
                        ${enquirydtl.date}
                    </td>
                    <td align="left" valign="top" width="8%">Name</td>
                    <td align="left" valign="top" width="51%">${enquirydtl.custname}</td>
                </tr>
                <tr>
                    <td align="left" valign="top">Email</td>
                    <td align="left" valign="top">${enquirydtl.email}</td>
                    <td align="left" valign="top">Mobile</td>
                    <td align="left" valign="top">${enquirydtl.mobile}</td>
                </tr>
                <tr>
                    <td align="left" valign="top">Car brand</td>
                    <td align="left" valign="top">${enquirydtl.name}</td>
                    <td align="left" valign="top">Car model</td>
                    <td align="left" valign="top">${enquirydtl.vehiclename}</td>
                </tr>
                <tr>
                    <td align="left" valign="top">Lead Source</td>
                    <td align="left" valign="top">
                        ${enquirydtl.leadsource}
                    </td>
                    <td align="left" valign="top">Location</td>
                    <td align="left" valign="top">${enquirydtl.location}</td>
                </tr>
                <tr>
                    <td align="left" valign="top">Lead Owner</td>
                    <td align="left" valign="top">${enquirydtl.leadowner}</td>
                    <td align="left" valign="top">Status</td>
                    <td align="left" valign="top">
                        ${enquirydtl.status}
                    </td>
                </tr>
                <tr>
                    <td align="left" valign="top">Requirement</td>
                    <td colspan="3" align="left" valign="top">${enquirydtl.requirement}</td>
                </tr>
            </tbody>
        </table>
        <c:choose>
            <c:when test="${enquirydtl.status=='Insurance'}">
                <table cellpadding="5" id="insurancetable" width="100%">
                    <tbody>
                        <tr>
                            <td align="left" valign="top" width="13%">Policy no.</td>
                            <td align="left" valign="top" width="28%">
                                ${enquirydtl.policyno}
                            </td>
                            <td align="left" valign="top" width="8%">Current Ins Company</td>
                            <td align="left" valign="top" width="51%">${enquirydtl.insurancecompanyname}</td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="13%">Policy Type</td>
                            <td align="left" valign="top" width="28%">
                                ${enquirydtl.type}
                            </td>
                            <td align="left" valign="top" width="8%">Expiry Date</td>
                            <td align="left" valign="top" width="51%">${enquirydtl.expirydate}</td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="13%">IDV of Vehicle</td>
                            <td align="left" valign="top" width="28%">
                                ${enquirydtl.idv}
                            </td>
                            <td align="left" valign="top" width="8%">&nbsp;</td>
                            <td align="left" valign="top" width="51%">&nbsp;</td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="13%">Year of Manufacturer</td>
                            <td align="left" valign="top" width="28%">
                                ${enquirydtl.yearofmanufacturer}
                            </td>
                            <td align="left" valign="top" width="8%">Engine CC</td>
                            <td align="left" valign="top" width="51%">${enquirydtl.enginecc}</td>
                        </tr>
                    </tbody>
                </table>
            </c:when>
        </c:choose>
    <center>
        <a href="editLeadDetailsLink?enquiryid=${param.enquiryid}" class="view">Edit</a> &nbsp;&nbsp;
    </center>
</body>
</html>
