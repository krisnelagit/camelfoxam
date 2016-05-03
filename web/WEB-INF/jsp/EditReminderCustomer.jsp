<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : AddReminderCustomer
    Created on : 13-Aug-2015, 13:25:10
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Reminder Customer</title>        
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        <!--mobile number autocomplete that fetch user data begin here-->
        <script>
            $(function () {
                var availabletags = [
            <c:forEach var="oba" items="${customerdt}">
                    "${oba.mobilenumber}",
            </c:forEach>];
                $("#tags").autocomplete({
                    source: availabletags,
                    select: function (event, ui) {
                        var customerMobileNo = ui.item.value;
                        $.ajax({
                            url: "getCustomerDetailsurl",
                            dataType: 'json',
                            type: 'POST',
                            data: {
                                custmobile: customerMobileNo
                            },
                            success: function (data) {
                                if (data) {
                                    $("#CustomerName").val(data[0].name);
                                    $("#emailid").val(data[0].email);
                                    $("#address").val(data[0].address);
                                    $("#customerid").val(data[0].id);
                                }
                            }, error: function () {
                            }
                        });

                        $.ajax({
                            url: "getCustomerBrandDetailsurl",
                            dataType: 'json',
                            type: 'POST',
                            data: {
                                custmobile: customerMobileNo
                            },
                            success: function (data) {
                                if (data) {
                                    $('#relatedcars option').remove();

                                    for (var i = 0; i < data.length; i++) {
                                        $("#relatedcars").append('<option value="' + data[i].vehicleid + '">' + data[i].vehiclename + '</option>');
                                    }
                                }
                            }, error: function () {
                            }
                        });
                    },
                    change: function () {

                        var val = $(this).val();
                        var exists = $.inArray(val, availabletags);
                        if (exists < 0) {
                            $(this).val("");
                            $("#CustomerName").val("");
                            $("#emailid").val("");
                            $("#address").val("");
                            $("#customerid").val("");
                            return false;
                        } else {

                        }
                    }
                });
            });
        </script>
        <!--mobile number autocomplete that fetch user data end here-->
        <link rel="stylesheet" type="text/css" href="css/jquery.datetimepicker.css"/>
        <script src="js/jquery.datetimepicker.js"></script>
        <script>
            $(document).ready(function () {
                $('#apdatetimepicker').datetimepicker({
                    format: 'd/m/Y  H:i'
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
                $('#apdatetimepicker').val(day + "/" + monthNames[monthIndex] + "/" + year + "  " + hours + ":" + min);
                //end of setting date time for appointment
            });
        </script>
    </head>
    <body>
        <a href="reminderCustomerLink" class="view">Back</a>
        <h2>Reminder Create</h2>
        <br />
        <form action="updateReminderCustomer" method="POST">        
            <input type="hidden" name="customerid" id="customerid" value="${rccustomerdt.cuid}" />
            <input type="hidden" name="id" id="oldrcid" value="${rccustomerdt.rcid}" />
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Mobile no.</td>
                    <td width="66%" align="left" valign="top"><input type="text" value="${rccustomerdt.mobilenumber}" name="mobilenumber" id="tags" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Customer Name</td>
                    <td width="66%" align="left" valign="top"><input type="text" value="${rccustomerdt.name}" readonly="" name="customername" id="CustomerName" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Email id.</td>
                    <td width="66%" align="left" valign="top"><input type="text" value="${rccustomerdt.email}" readonly="" name="email" id="emailid" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Address</td>
                    <td width="66%" align="left" valign="top"><textarea name="address" readonly="" id="address"> ${rccustomerdt.address}</textarea></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Vehicle Model</td>
                    <td width="66%" align="left" valign="top">
                        <select required name="branddetailid" id="relatedcars">
                            <c:forEach var="ob" items="${custvehiclesdt}">   
                                <c:choose>
                                    <c:when test="${ob.vehicleid==branddetailid}">
                                        <option value="${ob.vehicleid}" selected="">${ob.vehiclename}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${ob.vehicleid}">${ob.vehiclename}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select> 
                    </td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Message</td>
                    <td width="66%" align="left" valign="top"><textarea name="message" id="message">${rccustomerdt.message}</textarea></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Date & time</td>
                    <td width="66%" align="left" valign="top"><input name="date_time" id="apdatetimepicker" value="${rccustomerdt.date_time}" id="textfield2" type="text"></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td><input type="submit" value="Save" class="view3" style="cursor: pointer" />&nbsp;&nbsp;&nbsp;</td>
                </tr>
                <tr>    
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
            <br>
        </form>
    </body>
</html>
