<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : AddCustomerAdvance
    Created on : 16-Jul-2015, 13:43:05
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Customer Advance</title>        
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
        <script>

            $(document).ready(function () {
                $("#brandid").change(function () {
                    var brandid = $(this).val();
                    $.ajax({
                        url: "getinsurancecarBrand",
                        dataType: 'json',
                        type: 'POST',
                        data: {
                            brandid: brandid
                        },
                        success: function (data) {
                            if (data) {
                                $('#relatedcars option').remove();
                                for (var i = 0; i < data.length; i++) {
                                    $("#relatedcars").append('<option value="' + data[i].id + '">' + data[i].vehiclename + '</option>');
                                }
                            }
                        }, error: function () {
                        }
                    });
                });
            });
        </script>
    </head>
    <body>
        <a href="customerAdvanceGridLink" class="view">Back</a>
        <h2>Advance Create</h2>
        <br />
        <form action="addCustomerAdvance" method="POST">
            <input type="hidden" name="customerid" id="customerid" value="" />
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Mobile no.</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="mobilenumber" id="tags" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Customer Name</td>
                    <td width="66%" align="left" valign="top"><input type="text" readonly="" name="customername" id="CustomerName" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Email id.</td>
                    <td width="66%" align="left" valign="top"><input type="text" readonly="" name="email" id="emailid" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Address</td>
                    <td width="66%" align="left" valign="top"><textarea name="address" readonly="" id="address"></textarea></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Vehicle Make</td>
                    <td width="66%" align="left" valign="top">
                        <select required name="brandid" id="brandid">
                            <option value="" disabled selected="">--select--</option>
                            <c:forEach var="obb" items="${branddt}">            
                                <option value="${obb.id}">${obb.name}</option>
                            </c:forEach>
                        </select> 
                    </td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Vehicle Model</td>
                    <td width="66%" align="left" valign="top">
                        <select required name="branddetailid" id="relatedcars">
                            <option value="" disabled>--select--</option>
                        </select> 
                    </td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Amount (Rs.)</td>
                    <td width="66%" align="left" valign="top">
                        <input type="number" step="0.01" name="advance_amount" value="" />
                    </td>
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
