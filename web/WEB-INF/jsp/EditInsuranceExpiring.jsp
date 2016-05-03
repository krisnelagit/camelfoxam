<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : EditInsuranceExpiring
    Created on : 26-May-2015, 10:54:00
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Insurance Expiring</title>        
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        <script>
            $(function () {
                var availabletags = [
            <c:forEach var="oba" items="${customerdt}">
                    "${oba.mobilenumber}",
            </c:forEach>];
                $("#tags").autocomplete({
                    source: availabletags
                });
            });

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
        <script>

            $(document).ready(function () {

                $(function () {
                    $(".datepicker").datepicker({dateFormat: 'yy-mm-dd'});
                    $(".datepicker").datepicker("option", "showAnim", 'drop');
                });



                $("#tags").change(function () {
                    var customerMobileNo = $(this).val();
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
                });

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


                for (var i = new Date().getFullYear(); i > 1946; i--) {
                    $('#oldyear').val();
                    if ($('#oldyear').val() == i) {
                        $('#yearMonthInput').append($('<option selected="" />').val(i).html(" " + i));
                    } else {
                        $('#yearMonthInput').append($('<option />').val(i).html(" " + i));
                    }
                }
            });
        </script>
    </head>
    <body>
        <h2>Insurance Expiring Details</h2>
        <br>
        <br>
        <form method="POST" action="updateInsuranceExpiring">
            <input type="hidden" name="customerid" id="customerid" value="${insurancedetailsdt.customerid}" />
            <table cellpadding="5" width="100%">
                <input type="hidden" name="id" value="${insurancedetailsdt.id}" />
                <tbody>
                    <tr>
                        <td width="34%" align="left" valign="top">Mobile no.</td>
                        <td width="66%" align="left" valign="top"><input type="text" name="mobilenumber" value="${insurancedetailsdt.mobilenumber}" id="tags" /></td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Customer Name</td>
                        <td width="66%" align="left" valign="top"><input type="text" readonly="" name="customername" id="CustomerName" value="${insurancedetailsdt.custname}" /></td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Email id.</td>
                        <td width="66%" align="left" valign="top"><input type="text" readonly="" name="email" value="${insurancedetailsdt.email}" id="emailid" /></td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Address</td>
                        <td width="66%" align="left" valign="top"><textarea name="address" readonly="" id="address">${insurancedetailsdt.address}</textarea></td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Policy no.</td>
                        <td width="66%" align="left" valign="top"><input type="text" name="policyno" id="textfield2" value="${insurancedetailsdt.policyno}" /></td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Current Ins Company</td>
                        <td width="66%" align="left" valign="top">
                            <input type="text" required name="insurancecompanyname" id="companyname" value="${insurancedetailsdt.insurancecompanyname}" /><input type="hidden" value="${insurancedetailsdt.insurancecompany}" name="insurancecompany" id="companyid" />
                            </td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Policy Type</td>
                        <td width="66%" align="left" valign="top"><input type="text" name="type" id="textfield2" value="${insurancedetailsdt.type}" /></td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Expiry Date</td>
                        <td width="66%" align="left" valign="top"><input type="text" name="expirydate" required="" value="${insurancedetailsdt.expirydate}" class="datepicker"  /></td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">IDV of Vehicle</td>
                        <td width="66%" align="left" valign="top"><input type="text" name="idv" value="${insurancedetailsdt.idv}" id="textfield2" /></td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Vehicle Make</td>
                        <td width="66%" align="left" valign="top">
                            <select required name="brandid" id="brandid">
                                <c:forEach var="obb" items="${branddt}">
                                    <c:choose>
                                        <c:when test="${obb.id==insurancedetailsdt.brandid}">
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
                                        <c:when test="${obc.id==insurancedetailsdt.branddetailid}">
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
                        <td width="34%" align="left" valign="top">Year of Manufacturer</td>
                        <td width="66%" align="left" valign="top"><select name="yearofmanufacturer" id="yearMonthInput"></select><input type="hidden" name="prevyear" id="oldyear" value="${insurancedetailsdt.yearofmanufacturer}" /></td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Engine CC</td>
                        <td width="66%" align="left" valign="top"><input type="text" name="enginecc" value="${insurancedetailsdt.enginecc}" id="textfield2" /></td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">&nbsp;</td>
                        <td width="66%" align="left" valign="top"><input type="submit" value="Update" /></td>
                    </tr>
                </tbody>
            </table>
        </form>
    </body>
</html>