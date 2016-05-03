<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : EditCustomerAdvance
    Created on : 16-Jul-2015, 18:57:38
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Customer Advance</title>        
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
                function getcustomerdetail(){
                    var mobno="${editadvanceDetails.mobilenumber}";
                    $.ajax({
                            url: "getCustomerDetailsurl",
                            dataType: 'json',
                            type: 'POST',
                            data: {
                                custmobile: mobno
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
                }

            $(document).ready(function () {
                getcustomerdetail();
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
        <h2>Edit Advance</h2>
        <br />
        <form action="updateCustomerAdvance" method="POST">
            <input type="hidden" name="id" value="${editadvanceDetails.caid}" />
            <input type="hidden" name="customerid" id="customerid" value="${editadvanceDetails.customerid}" />
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Mobile no.</td>
                    <td width="66%" align="left" valign="top"><input type="text" value="${editadvanceDetails.mobilenumber}" name="mobilenumber" id="tags" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Customer Name</td>
                    <td width="66%" align="left" valign="top"><input type="text" readonly="" value="${editadvanceDetails.custname}" name="customername" id="CustomerName" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Email id.</td>
                    <td width="66%" align="left" valign="top"><input type="text" readonly="" value="${editadvanceDetails.email}" name="email" id="emailid" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Address</td>
                    <td width="66%" align="left" valign="top"><textarea name="address" value="${editadvanceDetails.cuaddress}" readonly="" id="address"></textarea></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Vehicle Make</td>
                    <td width="66%" align="left" valign="top">
                        <select required name="brandid" id="brandid">
                            <c:forEach var="obb" items="${branddt}"> 
                                <c:choose>
                                    <c:when test="${obb.id==editadvanceDetails.brandid}">
                                        <option value="${obb.id}" selected="">${obb.name}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${obb.id}">${obb.name}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select> 
                    </td>
                </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Vehicle Model</td>
                        <td width="66%" align="left" valign="top">
                            <select required name="branddetailid" id="relatedcars">
                                <c:forEach var="obc" items="${branddetailsdt}">
                                    <c:choose>
                                        <c:when test="${obc.id==editadvanceDetails.branddetailid}">
                                            <option value="${obc.id}" selected="">${obc.vehiclename}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${obc.id}">${obc.vehiclename}</option>
                                        </c:otherwise>
                                    </c:choose>                                
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Amount (Rs.)</td>
                    <td width="66%" align="left" valign="top">
                        <input type="number" step="0.01" name="advance_amount" value="${editadvanceDetails.advance_amount}" />
                        <input type="hidden" name="old_advance_amount" value="${editadvanceDetails.advance_amount}" />
                        
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
