<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : EditEnquiryDetails
    Created on : 19-May-2015, 16:31:29
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Enquiry Details</title>       
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        <script>
            $(document).ready(function () {
                $("#enquirystatus").change();

                $(function () {
                    $(".datepicker").datepicker({dateFormat: 'yy-mm-dd'});
                    $(".datepicker").datepicker("option", "showAnim", 'drop');
                });
//                getcarmodels();
                for (var i = new Date().getFullYear(); i > 1946; i--) {
                    $('#oldyear').val();
                    if ($('#oldyear').val() == i) {
                        $('#yearMonthInput').append($('<option selected="" />').val(i).html(" " + i));
                    } else {
                        $('#yearMonthInput').append($('<option />').val(i).html(" " + i));
                    }
                }
                
                var selection=$(".statustypes").val();
                if (selection == "Insurance") {
                    $("#insurancetable").show();
                } else {
                    $("#insurancetable").hide();
                }

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
                } else {
                    $("#insurancetable").hide();
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
    </head>
    <body>
        <a href="enquiriesgridlink" class="view">Back</a>
        <br/>

        <form action="updateLead" method="POST">   
            <input type="hidden" name="id" value="${param.enquiryid}" />
            <h2>Lead Details</h2>
            <br>
            <br>
            <table cellpadding="5" width="100%">

                <tbody>
                    <tr>
                        <td align="left" valign="top" width="13%">Date</td>
                        <td align="left" valign="top" width="28%">
                            <input name="date" value="${enquirydtl.date}" class="datepicker" id="textfield2" type="text">
                        </td>
                        <td align="left" valign="top" width="8%">Name</td>
                        <td align="left" valign="top" width="51%"><input value="${enquirydtl.custname}" name="name" id="textfield9" type="text"></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Email</td>
                        <td align="left" valign="top"><input name="email" value="${enquirydtl.email}" id="textfield" type="text"></td>
                        <td align="left" valign="top">Mobile</td>
                        <td align="left" valign="top"><input name="mobile" value="${enquirydtl.mobile}" id="textfield3" type="text"></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Car Brand</td>
                        <td align="left" valign="top">
                            <select name="brandid" id="carbrand" onchange="getcarmodels()">
                                <c:forEach var="ob" items="${carbranddetails}">
                                    <c:choose>
                                        <c:when test="${ob.id==enquirydtl.brandid}">
                                            <option value="${ob.id}" selected="">${ob.name}</option>
                                        </c:when>
                                        <c:otherwise>                                        
                                            <option value="${ob.id}">${ob.name}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </select>
                        </td>
                        <td align="left" valign="top">Car model</td>
                        <td align="left" valign="top">
                            <select name="branddetailid" id="carmodel">
                                <c:forEach var="ob" items="${modelforselected}">
                                    <c:choose>
                                        <c:when test="${ob.id==enquirydtl.branddetailid}">
                                            <option value="${ob.id}" selected="">${ob.vehiclename}</option>
                                        </c:when>
                                        <c:otherwise>                                        
                                            <option value="${ob.id}">${ob.vehiclename}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Lead Source</td>
                        <td align="left" valign="top">
                            <select name="leadsource" class="select">
                                <c:choose>
                                    <c:when test="${enquirydtl.leadsource=='Just Dial'}">
                                        <option selected="">Just Dial</option>
                                        <option>Sulekha</option>
                                        <option>Self</option>
                                        <option>Facebook</option>
                                        <option>Other</option>
                                    </c:when>
                                    <c:when test="${enquirydtl.leadsource=='Sulekha'}">
                                        <option>Just Dial</option>
                                        <option selected="">Sulekha</option>
                                        <option>Self</option>
                                        <option>Facebook</option>
                                        <option>Other</option>
                                    </c:when>
                                    <c:when test="${enquirydtl.leadsource=='Sulekha'}">
                                        <option>Just Dial</option>
                                        <option selected="">Sulekha</option>
                                        <option>Self</option>
                                        <option>Facebook</option>
                                        <option>Other</option>
                                    </c:when>
                                    <c:when test="${enquirydtl.leadsource=='Self'}">
                                        <option>Just Dial</option>
                                        <option>Sulekha</option>
                                        <option selected="">Self</option>
                                        <option>Facebook</option>
                                        <option>Other</option>
                                    </c:when>
                                    <c:when test="${enquirydtl.leadsource=='Facebook'}">
                                        <option>Just Dial</option>
                                        <option>Sulekha</option>
                                        <option>Self</option>
                                        <option selected="">Facebook</option>
                                        <option>Other</option>
                                    </c:when>
                                    <c:when test="${enquirydtl.leadsource=='Other'}">
                                        <option>Just Dial</option>
                                        <option>Sulekha</option>
                                        <option>Self</option>
                                        <option>Facebook</option>
                                        <option selected="">Other</option>
                                    </c:when>
                                </c:choose>
                            </select>
                        </td>
                        <td align="left" valign="top">Location</td>
                        <td align="left" valign="top"><input name="location" value="${enquirydtl.location}" id="textfield5" type="text"></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Lead Owner</td>
                        <td align="left" valign="top"><input name="leadowner" value="${enquirydtl.leadowner}" id="textfield8" type="text"></td>
                        <td align="left" valign="top">Status</td>
                        <td align="left" valign="top">
                            <select name="status" onchange="getFields(this)" id="enquirystatus" class="select">
                                <c:choose>
                                    <c:when test="${enquirydtl.status=='None'}">
                                        <option selected="">None</option>
                                        <option>Attempted to Contact</option>
                                        <option>Contacted</option>
                                        <option>Contact in Future</option>
                                        <option>Converted to Potential</option>
                                        <option>Lost Lead</option>
                                        <option>Fake Lead</option>
                                        <option>Insurance</option>
                                        <option>Preowned cars</option>
                                    </c:when>
                                    <c:when test="${enquirydtl.status=='shopping for price'}">
                                        <option>None</option>
                                        <option selected="">shopping for price</option>
                                        <option>Attempted to Contact</option>
                                        <option>Contacted</option>
                                        <option>Contact in Future</option>
                                        <option>Converted to Potential</option>
                                        <option>Lost Lead</option>
                                        <option>Fake Lead</option>
                                        <option>Insurance</option>
                                        <option>Preowned cars</option>
                                    </c:when>
                                    <c:when test="${enquirydtl.status=='Attempted to Contact'}">
                                        <option>None</option>
                                        <option selected="">Attempted to Contact</option>
                                        <option>Contacted</option>
                                        <option>Contact in Future</option>
                                        <option>Converted to Potential</option>
                                        <option>Lost Lead</option>
                                        <option>Fake Lead</option>
                                        <option>Insurance</option>
                                        <option>Preowned cars</option>
                                    </c:when>
                                    <c:when test="${enquirydtl.status=='Contacted'}">
                                        <option>None</option>
                                        <option>Attempted to Contact</option>
                                        <option selected="">Contacted</option>
                                        <option>Contact in Future</option>
                                        <option>Converted to Potential</option>
                                        <option>Lost Lead</option>
                                        <option>Fake Lead</option>
                                        <option>Insurance</option>
                                        <option>Preowned cars</option>
                                    </c:when>
                                    <c:when test="${enquirydtl.status=='Contact in Future'}">
                                        <option>None</option>
                                        <option>Attempted to Contact</option>
                                        <option>Contacted</option>
                                        <option selected="">Contact in Future</option>
                                        <option>Converted to Potential</option>
                                        <option>Lost Lead</option>
                                        <option>Fake Lead</option>
                                        <option>Insurance</option>
                                        <option>Preowned cars</option>
                                    </c:when>
                                    <c:when test="${enquirydtl.status=='Lost Lead'}">
                                        <option>None</option>
                                        <option>Attempted to Contact</option>
                                        <option>Contacted</option>
                                        <option>Contact in Future</option>
                                        <option>Converted to Potential</option>
                                        <option selected="">Lost Lead</option>
                                        <option>Fake Lead</option>
                                        <option>Insurance</option>
                                        <option>Preowned cars</option>
                                    </c:when>
                                    <c:when test="${enquirydtl.status=='Fake Lead'}">
                                        <option>None</option>
                                        <option>Attempted to Contact</option>
                                        <option>Contacted</option>
                                        <option>Contact in Future</option>
                                        <option>Converted to Potential</option>
                                        <option>Lost Lead</option>
                                        <option selected="">Fake Lead</option>
                                        <option>Insurance</option>
                                        <option>Preowned cars</option>
                                    </c:when>
                                    <c:when test="${enquirydtl.status=='Insurance'}">
                                        <option>None</option>
                                        <option>Attempted to Contact</option>
                                        <option>Contacted</option>
                                        <option>Contact in Future</option>
                                        <option>Converted to Potential</option>
                                        <option>Lost Lead</option>
                                        <option>Fake Lead</option>
                                        <option selected="">Insurance</option>
                                        <option>Preowned cars</option>
                                    </c:when>
                                    <c:when test="${enquirydtl.status=='Preowned cars'}">
                                        <option>None</option>
                                        <option>Attempted to Contact</option>
                                        <option>Contacted</option>
                                        <option>Contact in Future</option>
                                        <option>Converted to Potential</option>
                                        <option>Lost Lead</option>
                                        <option>Fake Lead</option>
                                        <option>Insurance</option>
                                        <option selected="">Preowned cars</option>
                                    </c:when>
                                </c:choose>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Requirement</td>
                        <td colspan="3" align="left" valign="top"><textarea name="requirement"  cols="100" id="textfield6">${enquirydtl.requirement}</textarea></td>
                    </tr>
                </tbody>
            </table>
                    
                    <table cellpadding="5" id="insurancetable" width="100%">
                        <tbody>
                            <tr>
                                <td align="left" valign="top" width="13%">Policy no.</td>
                                <td align="left" valign="top" width="28%">
                                    <input type="text" name="policyno" value="${enquirydtl.policyno}" id="textfield2" />                                    
                                </td>
                                <td align="left" valign="top" width="8%">Current Ins Company</td>
                                <td align="left" valign="top" width="51%"><input type="text" name="insurancecompanyname" id="companyname" value="${enquirydtl.insurancecompanyname}" /><input type="hidden" name="insurancecompany" value="${enquirydtl.insurancecompany}" id="companyid" /></td></td>
                            </tr>
                            <tr>
                                <td align="left" valign="top" width="13%">Policy Type</td>
                                <td align="left" valign="top" width="28%">
                                    <input type="text" name="type" value="${enquirydtl.type}" id="textfield2" />
                                    
                                </td>
                                <td align="left" valign="top" width="8%">Expiry Date</td>
                                <td align="left" valign="top" width="51%"><input type="text" name="expirydate" value="${enquirydtl.expirydate}" class="datepicker"  /></td>
                            </tr>
                            <tr>
                                <td align="left" valign="top" width="13%">IDV of Vehicle</td>
                                <td align="left" valign="top" width="28%">
                                    <input type="text" name="idv" value="${enquirydtl.idv}" id="textfield2" />                                    
                                </td>
                                <td align="left" valign="top" width="8%">&nbsp;</td>
                                <td align="left" valign="top" width="51%">&nbsp;</td>
                            </tr>
                            <tr>
                                <td align="left" valign="top" width="13%">Year of Manufacturer</td>
                                <td align="left" valign="top" width="28%">
                                    <select name="yearofmanufacturer" id="yearMonthInput"></select><input type="hidden" name="prevyear" id="oldyear" value="${insurancedetailsdt.yearofmanufacturer}" />
                                </td>
                                <td align="left" valign="top" width="8%">Engine CC</td>
                                <td align="left" valign="top" width="51%"><input type="text" name="enginecc" value="${enquirydtl.enginecc}" id="textfield2" /></td>
                            </tr>
                        </tbody>
                    </table>                            

            <center>
                <input type="submit" class="view3" style="cursor: pointer" value="Update" /> &nbsp;&nbsp;
            </center>
        </form>
    </body>
</html>
