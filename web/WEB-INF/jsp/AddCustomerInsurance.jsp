<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : AddCustomerInsurance
    Created on : 25-May-2015, 11:06:26
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Customer Insurance</title>        
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
                
                var person = [
            <c:forEach var="occ" items="${customerdt}">
                    {custname: "${occ.name}", custid: "${occ.id}", custMobile: "${occ.mobilenumber}", custEmail: "${occ.email}", custAddress: "${occ.address}"},
            </c:forEach>
                ];

                var source = [];
                var mapping = {};
                //mapping customer mobile number to id and customer id to name
                for (var i = 0; i < person.length; ++i) {
                    source.push(person[i].custname);
                    mapping[person[i].custname] = person[i].custid + ',' + person[i].custMobile + ',' + person[i].custEmail + ',' + person[i].custAddress;
                }

                $("input:text[id^='CustomerName']").on("focus.autocomplete", null, function () {
                    $(this).autocomplete({
                        source: source,
                        select: function (event, ui) {
                            var data = mapping[ui.item.value];
                            var splitvar = data.split(',');
                            $("#customerid").val(splitvar[0]);
                            $("#tags").val(splitvar[1]);
                            $("#emailid").val(splitvar[2]);
                            $("#address").val(splitvar[3]);
                        }
                    });
                });
            });
        </script>
        <!--mobile number autocomplete that fetch user data end here-->
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

                //popup for Edit Appointment details start here
                $("#dialogCustomer").hide();
                //on click of edit
                $(".customer_link3").click(function (e) {
                    e.preventDefault();
                    $("#dialogCustomer").dialog({
                        modal: true,
                        effect: 'drop',
                        show: {
                            effect: "drop"
                        },
                        hide: {
                            effect: "drop"
                        }
                    });
                });
                //popup for Edit Appointment details end here

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
                    $('#yearMonthInput').append($('<option />').val(i).html(" " + i));
                }
            });
        </script>
    </head>
    <body>
        <a href="viewInsuranceExpiringGridLink" class="view">Back</a>&nbsp;&nbsp;<a href="customerMasterCreateLink" title="Add new Customer" class="view customer_link3">Add Customer</a>
        <h2>Customer Insurance</h2>
        <br />
        <form action="addInsurance" method="POST">
            <input type="hidden" name="customerid" id="customerid" value="" />
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Mobile no.</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="mobilenumber" id="tags" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Customer Name</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="customername" id="CustomerName" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Email id.</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="email" id="emailid" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Address</td>
                    <td width="66%" align="left" valign="top"><textarea name="address" id="address"></textarea></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Policy no.</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="policyno" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Current Ins Company</td>
                    <td width="66%" align="left" valign="top"><input type="text" required name="insurancecompanyname" id="companyname" /><input type="hidden" name="insurancecompany" id="companyid" />
                    </td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Policy Type</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="type" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Expiry Date</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="expirydate" required="" class="datepicker"  /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">IDV of Vehicle</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="idv" id="textfield2" /></td>
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
                    <td width="34%" align="left" valign="top">Year of Manufacturer</td>
                    <td width="66%" align="left" valign="top"><select name="yearofmanufacturer" id="yearMonthInput"></select></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Engine CC</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="enginecc" id="textfield2" /></td>
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

        <!--modal popup to add customer begin here-->        
        <div id="dialogCustomer" title="Add Customer">
            <form action="addCustomerInsuranceExpiring" method="POST" onsubmit="var text = document.getElementById('address').value;
                    if (text.length > 100) {
                        alert('only 100 characters allowed for address');
                        return false;
                    }
                    return true;">        
                <table width="100%" cellpadding="5">
                    <tr>
                        <td width="34%" align="left" valign="top">Customer Name</td>
                        <td width="66%" align="left" valign="top"><input type="text" pattern=".{3,20}" required="" title="3 to 20 characters max name allowed" name="name" id="textfield2" /></td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Address</td>
                        <td width="66%" align="left" valign="top"><textarea name="address" id="address" maxlength="120" rows="4" cols="20"></textarea></td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Mobile Number</td>
                        <td width="66%" align="left" valign="top"><input type="text" required="" pattern="^[789]\d{9}$" title="Please enter a valid mobilenumber" name="mobilenumber" id="textfield2" /></td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Email</td>
                        <td width="66%" align="left" valign="top"><input type="text" required="" pattern="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?" title="Please enter a valid email" name="email" id="textfield2" /></td>
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
        </div>
        <!--customer add modal end here-->
    </body>
</html>
