<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 
    Document   : EditInvoice
    Created on : 27-Mar-2015, 13:56:45
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="css/csstable.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="css/jquery-ui.css" />
        <script src="js/jquery-1.8.3.js" type="text/javascript"></script>
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Invoice</title>

        <SCRIPT language="javascript">
            //make insurance 100% code begins here
            function makefull(a) {
                var insurancetype = $(a).val();
                if (insurancetype === 'Full Payment') {
                    $(".insurancepercent").val("100");
                    $("#dataTable .insurancepercent").trigger("change");
                    $("#dataTable1 .insurancepercent").trigger("change");
                } else {

                }
            }
            //make insurance 100% code ends! here

            //add rows
            function addRow(tableID) {
                max = "100";
                var insurance_percent;
                var type_insurance = document.getElementById("typeofinsurance").value;
                if (type_insurance === "Full Payment") {
                    insurance_percent = "100";
                } else {
                    insurance_percent = "0";
                }
                var boolinsurance = document.getElementById("selectinsurance").value;
                if (tableID === "dataTable") {
                    $('#' + tableID + '').append('<tr><td align="left" valign="top"><INPUT type="checkbox" name="chk" value="0"/><input type="hidden" name="newpartid" value="" id="prdid"/></td><td align="left" valign="top"><input name="newcarparts" type="text" id="carparts" /></td><td align="left" valign="top"><select name="newmanufacturerid" class="manufacturer" style="width: 100px" onchange="iambatman(this)"></select></td><td align="left" valign="top"><input name="newpartQuantity" type="text" class="quantity" style="width: 45px" onchange="calculatebalance(this)" /></td><td align="left" valign="top"><input name="newsellingprice"  onchange="calculateselling(this)" type="text" class="sellingprice" style="width: 50px"/></td><td align="left" valign="top" class="inventoryinsurance"><input name="newinsurancepercent" min="0" max="100" step="0.01" value="' + insurance_percent + '" type="number" class="insurancepercent" onchange="calculateinsurance(this)" style="width: 100px" /></td><td align="left" valign="top" class="inventorycompanyinsurance"><input name="newinsurancecompanyamount" readonly="" type="text" value="0" class="insurancers" style="width: 100px"/></td><td align="left" valign="top" class="inventorycustinsurance"><input name="newinsurancecustomeramount" readonly="" type="text" value="0" class="custinsurance" style="width: 100px"/></td><td align="left" valign="top"><input name="newitemtotal" readonly="" type="text" value="0" class="itemtotal" style="width: 100px"/></td></tr>');
                } else {
                    $('#' + tableID + '').append('<tr><td align="left" valign="top"><INPUT type="checkbox" name="chk" value="0"/><input type="hidden" name="newserviceid" value="" id="serviceid"/></td><td align="left" valign="top"><input name="newservicename" type="text" id="labour" /></td><td align="left" valign="top"><input name="newdescription" type="text" class="description" /></td><td align="left" valign="top" class="labourinsurance"><input name="newserviceinsurancepercent" value="' + insurance_percent + '" type="text" class="insurancepercent" onchange="calculateInsurancebalance(this)" style="width: 100px"/></td><td align="left" valign="top" class="labourcompanyinsurance"><input name="newcompanyinsuranceservice" type="text" readonly="" value="0" class="insuranceServicers" style="width: 100px"/></td><td align="left" valign="top" class="labourcustinsurance"><input name="newcustinsuranceservice" type="text" readonly="" value="0" class="insuranceServicerscustomer" style="width: 100px"/></td><td align="left" valign="top"><input name="newservicetotal" onchange="calservicetotal();" type="text" class="charges" /></td></tr>');
                }

                if (boolinsurance === 'Yes') {
                    $('#insurancecompany').show();
                    $('#insurancetype').show();
                    $('#claimnumber').show();
                    $('.inventoryinsurance').show();
                    $('.inventorycompanyinsurance').show();
                    $('.inventorycustinsurance').show();
                    $('.labourinsurance').show();
                    $('.labourcompanyinsurance').show();
                    $('.labourcustinsurance').show();
                    $('#claimss').show();

                    $('#companyname').prop('required', true);
                    $('#typeofinsurance').prop('required', true);
                    $('#claimno').prop('required', true);
                    $('.insurancepercent').prop('required', true);


                } else {


                    $('#insurancecompany').hide();
                    $('#insurancecompany').hide();
                    $('#insurancetype').hide();
                    $('#claimnumber').hide();
                    $('.inventoryinsurance').hide();
                    $('.inventorycompanyinsurance').hide();
                    $('.inventorycustinsurance').hide();
                    $('.labourinsurance').hide();
                    $('.labourcompanyinsurance').hide();
                    $('.labourcustinsurance').hide();
                    $('#claimss').hide();

                    $('#companyname').prop('required', false);
                    $('#typeofinsurance').prop('required', false);
                    $('#claimno').prop('required', false);
                    $('.insurancepercent').prop('required', false);
                }
            }

            //permanent delete
            function deleteInventoryRow() {
                var result = confirm("Are You Sure To Delete?");
                if (result === true)
                {
                    var chkvalue = "";
                    var checkValues = $('input[name=chk]:checked').map(function ()
                    {
                        var b = $(this).val();
                        if ($(this).val() !== '0')
                        {
                            chkvalue = chkvalue + $(this).val() + ",";
                        }
                        var itm = Number($(b).closest('tr').find('.itemtotal').val());
                        var sparesfin = Number($(b).closest('tr').find('#sparepartsfinal').val());
                        var result = sparesfin - itm;
                        $(b).closest('tr').find('#sparepartsfinal').val(result);
                        $(this).closest('tr').remove();
                    }).get();
                    $.ajax({
                        url: "deletePartData",
                        data: {
                            inventoryid: chkvalue},
                        cache: false,
                        success: function (data) {
                            if (data === "Success") {
                                deletedlabourinsurance();
                            }
                        }, error: function () {
                        }
                    });
                }
            }

            //permanent delete
            function deleteLabourServiceRow() {

                var result = confirm("Are You Sure To Delete?");
                if (result === true)
                {

                    var chkvalue = "";
                    var checkValues = $('input[name=chk]:checked').map(function ()
                    {
                        if ($(this).val() !== '0')
                        {
                            chkvalue = chkvalue + $(this).val() + ",";
                        }
                        $(this).closest('tr').remove();
                    }).get();
                    $.ajax({
                        url: "deleteLabourData",
                        data: {
                            labourinventoryid: chkvalue
                        },
                        cache: false,
                        success: function (data) {
                            if (data === "Success") {
                                deletedlabourinsurance();
                            }
                        }, error: function () {
                        }
                    });
                }
            }


            //customer mobile number auto complete
            var mobilenumber;
            $(function () {

                mobilenumber = [
            <c:forEach var="obj" items="${customers}">
                    {mobnumber: "${obj.mobilenumber}", customername: "${obj.name}", customerid: "${obj.id}"},
            </c:forEach>
                ];
                var availableTags = []; // to show the user auto complete data
                var mapping = {}; // to assigm the value against the auto complete data

                for (var i = 0; i < mobilenumber.length; ++i)
                {
                    availableTags.push(mobilenumber[i].mobnumber);
                    mapping[mobilenumber[i].mobnumber] = mobilenumber[i].customername + ',' + mobilenumber[i].customerid;
                }

                $("input:text[id^='mobilenumber']").live("focus.autocomplete", null, function () {
                    $(this).autocomplete({
                        source: availableTags,
                        select: function (event, ui) {
                            var data = mapping[ui.item.value];
                            var splitcustomer = data.split(',');
                            $("#customer_name").val(splitcustomer[0]);
                        },
                        change: function () {
                            var val = $(this).val();
                            var exists = $.inArray(val, availableTags);
                            if (exists < 0) {
                                $(this).val("");
                                return false;
                            }
                        }
                    });
                });
            });
            //customer mobile number autocomplete end here

            //insurance company autcomplete begin here
            var insuranceCompany;
            $(function () {
                insuranceCompany = [
            <c:forEach var="ob" items="${insuranceCompanyDetails}">
                    {value: "${ob.id}", label: "${ob.name}"},
            </c:forEach>
                ];

                $("input:text[id^='companyname']").live("focus.autocomplete", null, function () {
                    var sourced = [];
                    var mappingd = {};
                    for (var i = 0; i < insuranceCompany.length; ++i) {
                        sourced.push(insuranceCompany[i].label);
                        mappingd[insuranceCompany[i].label] = insuranceCompany[i].value;
                    }
                    $(this).autocomplete({
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
            });
            //insurance autcomplete end!! here

            //car parts item name auto complete will come based on model
            var carparts = [
            <c:forEach var="ob" items="${carparts}">
                {value: "${ob.id}", label: "${ob.partname}"},
            </c:forEach>
            ];

            $(function () {

                $("input:text[id^='carparts']").live("focus.autocomplete", null, function () {
                    var source = [];
                    var mapping = {};
                    for (var i = 0; i < carparts.length; ++i) {
                        source.push(carparts[i].label);
                        mapping[carparts[i].label] = carparts[i].value;
                    }
                    var a = $(this);
                    $(this).autocomplete({
                        source: source,
                        select: function (event, ui) {
                            a.closest('tr').find('#prdid').val(mapping[ui.item.value]);
//                            $("#prdid").val(mapping[ui.item.value]); // display the selected text
//                                        $("#txtAllowSearchID").val(ui.item.value); // save selected id to hidden input
                        },
                        change: function () {

                            var currentelement = $(this);
                            var val = $(this).val();
                            var exists = $.inArray(val, source);
                            if (exists < 0) {
                                currentelement.val("");
                                return false;
                            } else {
                                currentelement.closest('tr').find('option').remove();
//                                var amount = a.closest('tr').find('#prdid').val();
                                var partid = a.closest('tr').find("#prdid").val();

                                $.ajax({
                                    url: "getinventorydata",
                                    dataType: 'json',
                                    type: 'POST',
                                    data: {
                                        id: partid
                                    },
                                    success: function (data) {
                                        if (data)
                                        {
                                            currentelement.closest('tr').find('.manufacturer').append('<option value="" selected>--select--</option>');
                                            for (var i = 0; i < data.length; i++)
                                            {
                                                currentelement.closest('tr').find('.manufacturer').append('<option value="' + data[i].id + '">' + data[i].mfgname + '</option>');
                                            }
                                        }
                                    }, error: function () {
                                    }
                                });
                            }
                        }
                    });
                });
            });
            //customer vehicle model auto complete
            var vehicle;
            $(function () {
                vehicle = [
            <c:forEach items="${vehicles}" var="ob">
                    {value: "${ob.id}", label: "${ob.vehiclename}"},
            </c:forEach>
                ];
                var source = [];
                var mapping = {};
                for (var i = 0; i < vehicle.length; ++i) {
                    source.push(vehicle[i].label);
                    mapping[vehicle[i].label] = vehicle[i].value;
                }

                $("input:text[id^='vehicle']").live("focus.autocomplete", null, function () {

                    $(this).autocomplete({
                        source: source,
                        select: function (event, ui) {
                            $('#vehicleid').val(mapping[ui.item.value]);
                        },
                        change: function () {
//                            var currentelement = $(this);
                            var val = $(this).val();
                            var exists = $.inArray(val, source);
                            if (exists < 0) {
                                $(this).val("");
                                return false;
                            } else {
                                var vehicleid = $("#vehicleid").val();
                                $.ajax({
                                    url: "getpartdata",
                                    type: 'POST',
                                    dataType: 'json',
                                    data: {
                                        id: vehicleid
                                    }, success: function (data) {
                                        if (data) {
                                            for (var i = 0; i < data.length; i++) {
                                                carparts.push({
                                                    value: "" + data[i].id + "",
                                                    label: "" + data[i].partname + ""
                                                });
                                            }
                                        }
                                    }, error: function (jqXHR) {
                                        alert('error at services');
                                    }
                                });
                            }

                        }
                    });
                });
            });
            //labour auto complete            
            var labour;
            $(function () {
                labour = [
            <c:forEach var="ob" items="${services}">
                    {value: "${ob.id}", label: "${ob.name}"},
            </c:forEach>
                ];
                var source = [];
                var mapping = {};
                for (var i = 0; i < labour.length; ++i) {
                    source.push(labour[i].label);
                    mapping[labour[i].label] = labour[i].value;
                }

                $("input:text[id^='labour']").live("focus.autocomplete", null, function () {
                    var curr = $(this);
                    $(this).autocomplete({
                        source: source,
                        select: function (event, ui) {

                            curr.closest('tr').find("#serviceid").val(mapping[ui.item.value]); // display the selected text                            
                            //                                        $("#txtAllowSearchID").val(ui.item.value); // save selected id to hidden input
                        },
                        change: function () {

                            var currentelement = $(this);
                            var val = $(this).val();
                            var exists = $.inArray(val, source);
                            if (exists < 0) {

                                return false;
                            } else {
                                currentelement.closest('tr').find('option').remove();
                                var labourid = curr.closest('tr').find("#serviceid").val();
                                var carType = $("#vehicletype").val();
                                $.ajax({
                                    url: "getservicedata",
                                    dataType: 'json',
                                    type: 'POST',
                                    data: {
                                        serviceid: labourid, carid: carType
                                    },
                                    success: function (data) {
                                        if (data)
                                        {

                                            for (var i = 0; i < data.length; i++) {
                                                currentelement.closest('tr').find('.description').val(data[i].description);
                                                currentelement.closest('tr').find('.charges').val(data[i].rate);
                                            }

                                            calservicetotal();
                                            currentelement.closest('tr').find('.insurancepercent').trigger("change");
                                        }
                                    }, error: function () {
                                    }
                                });
                            }
                        }
                    });
                });
            });
        </script>
        <script>
            //after delete labour  and calculate insurance
            function deletedlabourinsuranced() {
                var companypartsum = 0;
                $(".insurancers").each(function () {
                    companypartsum += Number($(this).val());
                });
                var companyservicesum = 0;
                $(".insuranceServicers").each(function () {
                    companyservicesum += Number($(this).val());
                });

                //caclulating ins liabilty + tax
                var vattaxpercent = $(".taxpercent1").val();
                var vattaxamount = Number(companypartsum) * Number(vattaxpercent / 100);
                //alert(vattaxamount);
                var insliabilitysum = Number(companypartsum) + Number(vattaxamount);

                //caclulating Cust liabilty + tax
                var servicetaxpercent = $(".taxpercent2").val();
                var servicetaxamount = Number(companyservicesum) * Number(servicetaxpercent / 100);
                //alert(servicetaxamount);
                var custliabilitysum = Number(companyservicesum) + Number(servicetaxamount);

                var companysum = Number(insliabilitysum) + Number(custliabilitysum);
                $('#companytotal').val(companysum);
                $('#companytotalalways').val(companysum);

                //loop thru all the values and update the customer and customertotal for both parts and services                
                var customerpartsum = 0;
                $(".custinsurance").each(function () {
                    customerpartsum += Number($(this).val());
                });
                var customerservicesum = 0;
                $(".insuranceServicerscustomer").each(function () {
                    customerservicesum += Number($(this).val());
                });

                //caclulating customer part liabilty + tax
                var custvattaxamount = Number(customerpartsum) * Number(vattaxpercent / 100);
                //alert(custvattaxamount);
                var custinsliabilitysum = Number(customerpartsum) + Number(custvattaxamount);

                //caclulating Cust service liabilty + tax
                var custservicetaxamount = Number(customerservicesum) * Number(servicetaxpercent / 100);
                //alert(custservicetaxamount);
                var custliabilitysum = Number(customerservicesum) + Number(custservicetaxamount);

                var customersum = Number(custinsliabilitysum) + Number(custliabilitysum);
                $('#customertotal').val(customersum);
                //code to show invoice balance amount details 05-11-2015
                var sparesamt = $("#sparepartsfinal").val();
                var laboramt = $("#labourfinal").val();
                var vatamt = $(".taxAmount1").val();
                var serviceamt = $(".taxAmount2").val();

                var urtotal = Number(sparesamt) + Number(laboramt) + Number(vatamt) + Number(serviceamt);

                var discount = $("#discounttotal").val();
                var newtotal = Number(urtotal) - Number(discount);
                $("#amountTotal").val(newtotal.toFixed(2));

                $("#grandtotal").val(newtotal.toFixed(2));
                $('#claimcharges').keyup();
            }

            function deletedlabourinsurance() {
                $(".insurancepercent").change();
            }


            //calculate total part price
            function calculatebalance(b) {
                console.log("i m cal baalnce total");
                var tmp;
                var quantitycount = 0;
                var percent = Number($(b).closest('tr').find('.insurancepercent').val());
                if (Number(percent) >= 0) {
                    var quantity = $(b).val();
                    var amount = $(b).closest('tr').find('.sellingprice').val();
                    tmp = quantity * amount;
                    $(b).closest('tr').find('.itemtotal').val(tmp);
                    $(b).closest('tr').find('.insurancepercent').trigger("change");
                } else {
                    var quantity = $(b).val();
                    var amount = $(b).closest('tr').find('.sellingprice').val();
                    tmp = quantity * amount;
                    $(b).closest('tr').find('.itemtotal').val(tmp);
                }


                var table = document.getElementById("dataTable");
                var rowCount = table.rows.length;
                if (rowCount === 1) {
                    $("#sparepartsfinal").val(0);
                    $(".taxAmount1").val(0);
                    $("#amountTotal").val(0);
                    $("#grandtotal").val(0);
                    //MODE EXTRA TEXTBOX for liability begin here
                    $("#part-customerlb-total").val(0);
                    $("#part-customer-tax").val(0);
                    $("#part-customer-liability").val(0);
                    $("#part-insurancelb-total").val(0);
                    $("#part-insurance-tax").val(0);
                    $("#part-insurance-liability").val(0);
                    //MODE EXTRA TEXTBOX for liability ends! here
                    calservicetotal();
                    $('#claimcharges').trigger('keyup');
                } else {
                    //calculates final total of spareparts and inside is calulation of vat tax
                    for (var i = 1; i < rowCount; i++) {
                        var row = table.rows[i];
                        var qty = row.cells[8].childNodes[0];
                        quantitycount = Number(quantitycount) + Number(qty.value);
                        $("#sparepartsfinal").val(quantitycount);
                        //calculates vat percentage
                        var taxpercent = $(".taxpercent1").val();
                        var myvat = Number(quantitycount) * Number(taxpercent / 100);
                        $(".taxAmount1").val(myvat.toFixed(2));
                        //calculates your final total
                        var labourfinal = Number($("#labourfinal").val());
                        var serviceamt = Number($(".taxAmount2").val());
                        var amt = quantitycount + myvat + labourfinal + serviceamt;
                        var discount = $("#discounttotal").val();
                        var newtotal = Number(amt.toFixed(2)) - Number(discount);
                        $("#amountTotal").val(newtotal.toFixed(2));

                        $("#grandtotal").val(newtotal.toFixed(2));
                        $('#claimcharges').trigger('keyup');
                        $('#dataTable .insurancepercent').trigger('change');
                    }
                }

                quantitycount = 0;
            }

            //calculate insurance
            function calculateinsurance(b) {

                var tmp;
                var insurancepercent = $(b).val();
                var amount = $(b).closest('tr').find('.itemtotal').val();
                tmp = amount * insurancepercent / 100;
                $(b).closest('tr').find('.insurancers').val(tmp.toFixed(2));
                var atemp;
                atemp = amount - tmp;
                $(b).closest('tr').find('.custinsurance').val(atemp.toFixed(2));

                //loop thru all the values and update the company and companytotal for both parts and services                
                var companypartsum = 0;
                $(".insurancers").each(function () {
                    companypartsum += Number($(this).val());
                });
                var companyservicesum = 0;
                $(".insuranceServicers").each(function () {
                    companyservicesum += Number($(this).val());
                });

                //caclulating ins liabilty + tax
                var vattaxpercent = $(".taxpercent1").val();
                var vattaxamount = Number(companypartsum) * Number(vattaxpercent / 100);
                //alert(vattaxamount);
                var insliabilitysum = Number(companypartsum) + Number(vattaxamount);
                //code for mod 27-11-2015 for vat + ins.liab = total begins here
                $("#part-insurance-liability").val(companypartsum);
                $("#part-insurance-tax").val(vattaxamount);
                $("#part-insurancelb-total").val(insliabilitysum);

                //code for mod 27-11-2015 for vat + ins.liab = total ends! here

                //caclulating Cust liabilty + tax
                var servicetaxpercent = $(".taxpercent2").val();
                var servicetaxamount = Number(companyservicesum) * Number(servicetaxpercent / 100);
                //alert(servicetaxamount);
                var custliabilitysum = Number(companyservicesum) + Number(servicetaxamount);

                var companysum = Number(insliabilitysum) + Number(custliabilitysum);
                //code mod nitz
                var claimpart = $("#claimcharges").val();

                var cmpsumparts = Number(companysum) - Number(claimpart);

                $('#companytotal').val(companysum);
                $('#companytotalalways').val(companysum);

                //loop thru all the values and update the customer and customertotal for both parts and services                
                var customerpartsum = 0;
                $(".custinsurance").each(function () {
                    customerpartsum += Number($(this).val());
                });
                var customerservicesum = 0;
                $(".insuranceServicerscustomer").each(function () {
                    customerservicesum += Number($(this).val());
                });

                //caclulating customer part liabilty + tax
                var custvattaxamount = Number(customerpartsum) * Number(vattaxpercent / 100);
                //alert(custvattaxamount);
                var custinsliabilitysum = Number(customerpartsum) + Number(custvattaxamount);
                //code for mod 27-11-2015 for vat + ins.liab = total begins here
                //customer side
                $("#part-customer-liability").val(customerpartsum);
                $("#part-customer-tax").val(custvattaxamount);
                $("#part-customerlb-total").val(custinsliabilitysum);
                //code for mod 27-11-2015 for vat + ins.liab = total ends! here

                //caclulating Cust service liabilty + tax
                var custservicetaxamount = Number(customerservicesum) * Number(servicetaxpercent / 100);
                //alert(custservicetaxamount);
                var custliabilitysum = Number(customerservicesum) + Number(custservicetaxamount);

                var customersum = Number(custinsliabilitysum) + Number(custliabilitysum);
                var cmpsum = Number(customersum) - Number($("#claimcharges").val());

                $('#customertotal').val(cmpsum);

                $('#claimcharges').keyup();
            }

            //calculate calculateInsurancebalance(this)
            function calculateInsurancebalance(b) {
                console.log("i m labor percemnt change");
                var chgs = $(b).closest('tr').find('.charges').val();
                var percent = $(b).val();
                var tmp;
                tmp = chgs * percent / 100;
                $(b).closest('tr').find('.insuranceServicers').val(tmp.toFixed(2));
                var atemp;
                atemp = chgs - tmp;
                $(b).closest('tr').find('.insuranceServicerscustomer').val(atemp.toFixed(2));

                //loop thru all the values and update the company and companytotal for both parts and services                
                var companypartsum = 0;
                $(".insurancers").each(function () {
                    companypartsum += Number($(this).val());
                });
                var companyservicesum = 0;
                $(".insuranceServicers").each(function () {
                    companyservicesum += Number($(this).val());
                });

                //caclulating ins liabilty + tax
                var vattaxpercent = $(".taxpercent1").val();
                var vattaxamount = Number(companypartsum) * Number(vattaxpercent / 100);
                //alert(vattaxamount);
                var insliabilitysum = Number(companypartsum) + Number(vattaxamount);

                //caclulating Cust liabilty + tax
                var servicetaxpercent = $(".taxpercent2").val();
                var servicetaxamount = Number(companyservicesum) * Number(servicetaxpercent / 100);
                //alert(servicetaxamount);
                var custliabilitysum = Number(companyservicesum) + Number(servicetaxamount);
                //code for mod 27-11-2015 for vat + ins.liab = total begins here
                $("#labor-insurance-liability").val(companyservicesum);
                $("#labor-insurance-tax").val(servicetaxamount);
                $("#labor-insurancelb-total").val(custliabilitysum);

                //code for mod 27-11-2015 for vat + ins.liab = total ends! here

                var companysum = Number(insliabilitysum) + Number(custliabilitysum);

                var cmpsum = Number(companysum) - Number($("#claimcharges").val());


                $('#companytotal').val(companysum);
                $('#companytotalalways').val(companysum);

                //loop thru all the values and update the customer and customertotal for both parts and services                
                var customerpartsum = 0;
                $(".custinsurance").each(function () {
                    customerpartsum += Number($(this).val());
                });
                var customerservicesum = 0;
                $(".insuranceServicerscustomer").each(function () {
                    customerservicesum += Number($(this).val());
                });

                //caclulating customer part liabilty + tax
                var custvattaxamount = Number(customerpartsum) * Number(vattaxpercent / 100);
                //alert(custvattaxamount);
                var custinsliabilitysum = Number(customerpartsum) + Number(custvattaxamount);

                //caclulating Cust service liabilty + tax
                var custservicetaxamount = Number(customerservicesum) * Number(servicetaxpercent / 100);
                //alert(custservicetaxamount);
                var custliabilitysum = Number(customerservicesum) + Number(custservicetaxamount);

                var customersum = Number(custinsliabilitysum) + Number(custliabilitysum);
                //code for mod 27-11-2015 for vat + ins.liab = total begins here
                //customer side
                $("#labor-customer-liability").val(customerservicesum);
                $("#labor-customer-tax").val(custservicetaxamount);
                $("#labor-customerlb-total").val(custliabilitysum);
                //code for mod 27-11-2015 for vat + ins.liab = total ends! here
                $('#customertotal').val(customersum);

                $('#claimcharges').keyup();
            }

            function calservicetotal() {
                console.log("i m service total");
                var table = document.getElementById("dataTable1");
                var rowCount = table.rows.length;
                var servicecharges = 0;
                if (rowCount === 1) {
                    $("#labourfinal").val(0);
                    $(".taxAmount2").val(0);
                    $("#amountTotal").val(0);
                    $("#grandtotal").val(0);
                    $("#labor-insurance-liability").val(0);
                    $("#labor-insurance-tax").val(0);
                    $("#labor-insurancelb-total").val(0);
                    $("#labor-customer-liability").val(0);
                    $("#labor-customer-tax").val(0);
                    $("#labor-customerlb-total").val(0);
                    $(".quantity").trigger("change");

                    $('#claimcharges').trigger('keyup');
                } else {
                    for (var i = 1; i < rowCount; i++) {
                        var row = table.rows[i];
                        var qty = row.cells[6].childNodes[0];
                        servicecharges = Number(servicecharges) + Number(qty.value);
                        $("#labourfinal").val(servicecharges);
                        //calculates vat percentage
                        var taxpercent = $(".taxpercent2").val();
                        var myservice = Number(servicecharges) * Number(taxpercent / 100);
                        $(".taxAmount2").val(myservice.toFixed(2));
                        //calculates your final total
                        var sparefinal = Number($("#sparepartsfinal").val());
                        var vatamt = Number($(".taxAmount1").val());
                        var amt = servicecharges + myservice + sparefinal + vatamt;
                        var discount = $("#discounttotal").val();
                        var newtotal = Number(amt.toFixed(2)) - Number(discount);
                        $("#amountTotal").val(newtotal.toFixed(2));

                        $("#grandtotal").val(newtotal.toFixed(2));
                        $('#claimcharges').trigger('keyup');
                        $('#dataTable1 .insurancepercent').trigger('change');
                    }
                }
                servicecharges = 0;
            }
        </SCRIPT>

        <script>
            //ajax to get max selling price of mfg id
            function iambatman(a) {
                var mfgname = $(a).val();
                var partid = $(a).closest('tr').find('#prdid').val();
                var forpartname = $(a).closest('tr').find('#carparts').val();
                if (forpartname === "others") {
                    $(a).closest('tr').find('.sellingprice').val(0);
                } else {
                    $.ajax({
                        type: 'post',
                        url: 'pricelist',
                        data: {
                            mfgid: mfgname, partid: partid
                        },
                        success: function (data) {
                            $(a).closest('tr').find('.sellingprice').val(data);
                        },
                        error: function () {
                            alert("error..!");
                        }
                    });
                }
            }


            function calculateselling(n) {
                $(n).closest('tr').find('.quantity').change();
                $(n).closest('tr').find('.insurancepercent').change();
            }

            $(document).ready(function () {

//                $(".quantity").change();

//                calservicetotal();
//                calculatebalance();

                $("#claimcharges").keyup(function () {
                    console.log("i m keyup ");
                    var companyinsurance = $("#companytotalalways").val();

                    //less from companyinsurance
                    var lessinsurance = Number(companyinsurance) - Number(this.value);

                    $("#companytotal").val(lessinsurance);
                    //new modification to calucalte cust liability as on 03-11-2015 after on call discussion
                    var grandtotalfinal = $('#grandtotal').val();
                    var customerinsuranceliability = Number(grandtotalfinal) - Number(lessinsurance);
                    if (customerinsuranceliability > 1) {
                        $("#customerinsuranceliability").val(customerinsuranceliability.toFixed(2));
                    } else {
                        $("#customerinsuranceliability").val(0.00);
                    }
                });




                $('#insurancecompany').hide();
                $('#insurancetype').hide();
                $('#claimnumber').hide();
                $('.inventoryinsurance').hide();
                $('.inventorycompanyinsurance').hide();
                $('.inventorycustinsurance').hide();
                $('.labourinsurance').hide();
                $('.labourcompanyinsurance').hide();
                $('.labourcustinsurance').hide();
                $('.insurancelbsum').hide();
                $('#claimss').hide();

                $('#companyname').prop('required', false);
                $('#typeofinsurance').prop('required', false);
                $('#claimno').prop('required', false);
                $('.insurancepercent').prop('required', false);


                $('#selectinsurance').change(function () {
                    console.log("i m selectinsurance");
                    if ($(this).val() === 'Yes') {
                        $('#insurancecompany').show();
                        $('#insurancetype').show();
                        $('#claimnumber').show();
                        $('.inventoryinsurance').show();
                        $('.inventorycompanyinsurance').show();
                        $('.inventorycustinsurance').show();
                        $('.labourinsurance').show();
                        $('.labourcompanyinsurance').show();
                        $('.labourcustinsurance').show();
                        $('.insurancelbsum').show();
                        $('#claimss').show();

                        $('#companyname').prop('required', true);
                        $('#typeofinsurance').prop('required', true);
                        $('#claimno').prop('required', true);
                        $('.insurancepercent').prop('required', true);
                    } else {
                        $('#insurancecompany').hide();
                        $('#insurancetype').hide();
                        $('#claimnumber').hide();
                        $('.inventoryinsurance').hide();
                        $('.inventorycompanyinsurance').hide();
                        $('.inventorycustinsurance').hide();
                        $('.labourinsurance').hide();
                        $('.labourcompanyinsurance').hide();
                        $('.labourcustinsurance').hide();
                        $('.insurancelbsum').hide();
                        $('#claimss').hide();

                        $('#companyname').prop('required', false);
                        $('#typeofinsurance').prop('required', false);
                        $('#claimno').prop('required', false);
                        $('.insurancepercent').prop('required', false);
                    }
                }).change();
//                $(".laborpercent").change();

                //code written tp
//                var ss=$("#companytotal").val();
//                $("#companytotal").val(ss);
            });



            function calltax(a) {
                if ($(a).val() === "Yes") {
                    $(".sellingprice").change();
                    $(".charges").change();
                } else {
                    var spare, labor, result;
                    spare = $("#sparepartsfinal").val();
                    labor = $("#labourfinal").val();
                    result = Number(spare) + Number(labor);
                    $("#grandtotal").val(result);
                    $("#amountTotal").val(result);
                    $(".taxAmount1").val("0");
                    $(".taxAmount2").val("0");
                }
            }

            //code for calculating discount minus final amount
            function showgrandtotal(a) {
                console.log("Here m inside");
                var discount = $(a).val();
                console.log("Here m discount" + discount);
                //check if service or parts available
                var parttotal = $("#sparepartsfinal").val();
                var servicetotal = $("#labourfinal").val();
                var vat = $(".taxAmount1").val();
                var servicetax = $(".taxAmount2").val();
                console.log("Here m discount" + parttotal + servicetotal + vat + servicetax);

                var actualgrandtotal = Number(parttotal) + Number(servicetotal) + Number(vat) + Number(servicetax);
                var newtotal = Number(actualgrandtotal) - Number(discount);
                console.log("Here m discount" + newtotal);
                $('#grandtotal').val(newtotal.toFixed(2));
                $('#amountTotal').val(newtotal.toFixed(2));
            }

            function validateForm(formObj) {

                if (formObj.reason.value == '') {
                    alert('Please enter a reason');
                    return false;
                }

                formObj.submitButton.disabled = true;
                formObj.submitButton.value = 'Please Wait...';
                return true;

            }
        </script>
        <STYLE>
            .ui-autocomplete { height: 200px; overflow-y: scroll; overflow-x: hidden;}
        </style>
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
                z-index: 800;
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
        <a href="invoiceMasterLink" class="view">Back</a>

        <h2>Edit Invoice</h2>
        <br />
        <form action="updateInvoice" method="POST" onsubmit="return validateForm(this);">
            <!--reason box begins here-->
            <div id="modal">
                <div class="modal-content">
                    <div class="header">
                        <h2>Add reason</h2>
                        <a href="#" class="btn"><img style="margin-top: -20px; width: 20px;height: 20px" src="images/cancel.png" ></a>

                    </div>
                    <div class="copy">
                        <table cellpadding="5" width="100%">
                            <tbody>
                                <tr>
                                    <td align="left" valign="top">Description</td>
                                    <td align="left" valign="top"><textarea name="reason" required="" id="apdescription" rows="4" cols="20"></textarea></td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">&nbsp;</td>
                                    <td align="left" valign="top">
                                        <input type="submit" name="submitButton" onclick="$('#loopvalue').val($('.serviceloopcount:visible').length);" value="Update" class="view3"/>
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
            <!--reason box ends here-->
            <input type="hidden" name="id" value="${invoiceDt.id}" />
            <input type="hidden" name="userid" value="${sessionScope.USERID}" />
            <input type="hidden" name="jobno" value="${invoiceDt.jobno}" />
            <input type="hidden" name="isconvert" value="${invoiceDt.isconvert}" />
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="31%" align="left" valign="top">Invoice no.</td>
                    <td width="69%" align="left" valign="top"><label for="textfield"></label>
                        <label for="select"></label>
                        <select name="invoiceid">
                            <option>${invoiceDt.invoiceid}</option>
                            <c:forEach var="md" items="${missingiddt}">
                                <option>${md.missingid}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td width="31%" align="left" valign="top">Customer mobile number</td>
                    <td width="69%" align="left" valign="top"><label for="textfield"></label>
                        <label for="select"></label>
                        <input type="text" required="" name="customermobilenumber" value="${invoiceDt.customermobilenumber}" id="mobilenumber" />   
                    </td>
                </tr>
                <tr>
                    <td width="31%" align="left" valign="top">Customer name</td>
                    <td width="69%" align="left" valign="top"><label for="textfield"></label>
                        <label for="select"></label>
                        <input type="text" name="customer_name" value="${invoiceDt.customer_name}" required="" id="customer_name" /> 
                    </td>
                </tr>
                <tr>
                    <td align="left" valign="top">Vehicle Model</td>
                    <td align="left" valign="top"><label for="textfield3"></label>
                        <input type="text" required="" name="vehiclemodel" value="${invoiceDt.vehiclename}" id="vehicle" readonly="" /> <input type="hidden" name="vehicleid" id="vehicleid" value="${invoiceDt.vehicleid}" /><input type="hidden" name="vehicletype" id="vehicletype" value="${invoiceDt.labourChargeType}" /></td>                        
                </tr>
                <tr>
                    <td align="left" valign="top">Vehicle Number</td>
                    <td align="left" valign="top"><label for="textfield3"></label>
                        <input type="text" required="" value="${invoiceDt.vehiclenumber}" name="vehiclenumber" /></td>
                </tr>
                <tr>
                    <td align="left" valign="top">Insurance </td>
                    <td align="left" valign="top">
                        <select required="" name="isinsurance" id="selectinsurance">                            
                            <c:choose>
                                <c:when test="${invoiceDt.isinsurance=='Yes'}">
                                    <option selected="">Yes</option>
                                    <option>No</option>
                                </c:when>
                                <c:otherwise>
                                    <option>Yes</option>
                                    <option selected="">No</option>
                                </c:otherwise>
                            </c:choose>
                        </select>
                    </td>
                </tr>
                <tr id="insurancecompany">
                    <td align="left" valign="top">Insurance Company</td>
                    <td align="left" valign="top"><label for="textfield3"></label>
                        <input required="" type="text" value="${invoiceDt.insurancecompanyname}" name="insurancecompanyname" id="companyname" /><input type="hidden" name="insurancecompany" value="${invoiceDt.insurancecompanyid}" id="companyid" />
                    </td>
                </tr>
                <tr id="insurancetype">
                    <td align="left" valign="top">Insurance Type</td>
                    <td align="left" valign="top"><label for="textfield3"></label>
                        <select name="insurancetype" id="typeofinsurance" onchange="makefull(this);">                     
                            <c:choose>
                                <c:when test="${invoiceDt.insurancetype=='Depreciation'}">
                                    <option value="Depreciation" selected="">Depreciation</option>
                                    <option value="Full Payment">Full Payment</option>                                    
                                </c:when>
                                <c:otherwise>
                                    <option value="Full Payment" selected="">Full Payment</option>  
                                    <option value="Depreciation">Depreciation</option>          
                                </c:otherwise>
                            </c:choose>
                        </select>
                    </td>                    
                </tr>
                <tr id="claimnumber">
                    <td align="left" valign="top">Claim Number</td>
                    <td align="left" valign="top"><label for="textfield3"></label>
                        <input type="text" required="" value="${invoiceDt.claimnumber}" name="claimnumber" id="claimno" /></td>
                </tr>            
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
            <TABLE id="dataTable" border="0" class="CSSTableGenerator">
                <TR>
                    <TD width="" align="left">&nbsp;</TD>

                    <td width="" align="center"><strong>Name</strong></td>
                    <td width="" align="center"><strong>MFG.</strong></td>
                    <TD width="" align="center"><strong>QTY.</strong></TD>
                    <TD width="" align="center"><strong>Price</strong></TD>                
                    <TD width="23%" align="center" class="inventoryinsurance"><strong>Insurance %</strong></TD>
                    <TD width="23%" align="center" class="inventorycompanyinsurance"><strong>Ins.Liability</strong></TD>
                    <TD width="23%" align="center" class="inventorycustinsurance"><strong>Cust.Liability</strong></TD>
                    <TD width="" align="center"><strong>Amount</strong></TD>
                </TR>
                <c:forEach var="partob" items="${labourandpartdt}">
                    <tr>


                        <td align="left" valign="top">
                            <input type="hidden" name="invoicedetailid" value="${partob.id}" />
                            <INPUT type="checkbox" name="chk" value="${partob.id}"/><input type="hidden" name="partid" value="${partob.partid}" id="prdid"/></td>
                        <td align="left" valign="top"><input name="carparts" value="${partob.itemname}" readonly="" type="text" id="carparts" /></td>
                        <td align="left" valign="top">
                            <select name="manufacturerid" class="manufacturer" style="width: 100px" onchange="iambatman(this)">
                                <c:forEach var="mo" items="${allmfgdata}">
                                    <c:choose>                                    
                                        <c:when test="${mo.id==partob.manufacturerid}">
                                            <option selected="" value="${mo.id}">${mo.name}</option>
                                        </c:when>
                                        <%--<c:otherwise>
                                            <option value="${mo.id}">${mo.name}</option>
                                        </c:otherwise>  --%>
                                    </c:choose>                                      
                                </c:forEach>                            
                            </select>
                        </td>
                        <td align="left" valign="top"><input name="partQuantity" type="text" value="${partob.quantity}" class="quantity" style="width: 45px" onchange="calculatebalance(this)" onclick="calculatebalance(this)" /></td>
                        <td align="left" valign="top"><input name="sellingprice"  onchange="calculateselling(this)" value="${partob.sellingprice}" type="text" class="sellingprice" style="width: 50px"/></td>
                        <td align="left" valign="top" class="inventoryinsurance"><input name="insurancepercent" min="0" max="100" step="0.01" value="${partob.insurancepercent}" type="number" class="insurancepercent" onchange="calculateinsurance(this)" style="width: 100px" /></td>
                        <td align="left" valign="top" class="inventorycompanyinsurance"><input name="insurancecompanyamount" readonly="" type="text" value="${partob.insurancecompanyamount}" class="insurancers" style="width: 100px"/></td>
                        <td align="left" valign="top" class="inventorycustinsurance"><input name="insurancecustomeramount" readonly="" type="text" value="${partob.insurancecustomeramount}" class="custinsurance" style="width: 100px"/>

                            <input type="hidden" name="oldinvid" value="${partob.inventoryid}" /></td>
                        <td align="left" valign="top"><input name="itemtotal" readonly="" type="text" value="${partob.total}" class="itemtotal" style="width: 100px"/></td>

                    </tr>
                </c:forEach>
            </TABLE>

            <br />
            <table >
                <tbody>
                    <tr>
                        <td width="33%">Spare parts Total</td>
                        <td>
                            <input style="width: 100px" name="sparepartsfinal" readonly="" value="${invoiceDt.sparepartsfinal}" type="text" id="sparepartsfinal" />
                        </td>
                    </tr>
                    <tr>
                        <td width="33%">Discount</td>
                        <td>
                            <input style="width: 100px" name="discount_part"value="${invoiceDt.discount_part}" type="text" id="sparepartsDiscount" onchange="addtoDiscount()" />
                        </td>
                    </tr>
                    <tr class="insurancelbsum">
                        <td>Ins. liability</td>
                        <td>
                            <input style="width: 100px" name="partinsuranceliability" readonly="" value="${liabilitypartcompanysum}" type="text" id="part-insurance-liability" /> +
                            <input style="width: 60px" name="partinsurancetax" readonly="" value="${liabilitypartcompanytax}" type="text" id="part-insurance-tax" /> =
                            <input style="width: 100px" name="partinsurancelbtotal" readonly="" value="${liabilitypartcompany}" type="text" id="part-insurancelb-total" />
                        </td>
                    </tr>
                    <tr class="insurancelbsum">
                        <td>cust. liability</td>
                        <td>
                            <input style="width: 100px" name="partcustomerliability" readonly="" value="${liabilitypartcustomersum}" type="text" id="part-customer-liability" /> +
                            <input style="width: 60px" name="partcustomertax" readonly="" value="${liabilitypartcustomertax}" type="text" id="part-customer-tax" /> =
                            <input style="width: 100px" name="partcustomerlbtotal" readonly="" value="${liabilitypartcustomer}" type="text" id="part-customerlb-total" />
                        </td>
                    </tr>
                </tbody>
            </table >
            <!--<div style="float:right; margin-right:80px; margin-top:10px; font-size:16px"><strong>TOTAL: </strong><input name="total" type="text" value="0" class="resulttotal" /></div>-->
            <div>
                <INPUT type="button" value="Add Product" onclick="addRow('dataTable')"  class="view3"/>
                <INPUT type="button" value="Delete Selected" onclick="deleteInventoryRow();
                        calculatebalance(this);"  class="view3"/></div>  
            <br />
            <br />
            <br />
            <input type="hidden" name="loopvalue" id="loopvalue" value="${fn:length(labourinventorydt)}" />
            <TABLE id="dataTable1" border="0" class="CSSTableGenerator">
                <TR>
                    <TD width="4%" align="left">&nbsp;</TD> 
                    <td width="24%" align="left"><strong>Service Name</strong></td>
                    <TD width="23%" align="center"><strong>Description</strong></TD>

                    <TD width="23%" align="center" class="labourinsurance"><strong>Insurance %</strong></TD>
                    <TD width="23%" align="center" class="labourcompanyinsurance"><strong>Ins.Liability</strong></TD>
                    <TD width="23%" align="center" class="labourcustinsurance"><strong>Cust.Liability</strong></TD>
                    <TD width="23%" align="center"><strong>Labour Rs.</strong></TD>
                </TR>
                <c:forEach var="labob" items="${labourinventorydt}">                
                    <tr>
                        <td align="left" valign="top">
                            <INPUT type="checkbox" name="chk" class="serviceloopcount" value="${labob.id}" /><input type="hidden" name="serviceid" value="${labob.serviceid}" id="serviceid"/></td>
                        <td align="left" valign="top"><input name="servicename" value="${labob.name}" type="text" id="labour" /></td>
                        <td align="left" valign="top"><input name="description" value="${labob.description}" type="text" class="description" /></td>                
                        <td align="left" valign="top" class="labourinsurance"><input name="serviceinsurancepercent" type="text" class="insurancepercent laborpercent" value="${labob.serviceinsurancepercent}" onchange="calculateInsurancebalance(this)" style="width: 100px"/></td>
                        <td align="left" valign="top" class="labourcompanyinsurance"><input name="companyinsuranceservice" type="text" readonly="" value="${labob.companyinsurance}" class="insuranceServicers" style="width: 100px"/></td>
                        <td align="left" valign="top" class="labourcustinsurance"><input name="custinsuranceservice" type="text" readonly="" value="${labob.customerinsurance}" class="insuranceServicerscustomer" style="width: 100px"/></td>
                        <td align="left" valign="top"><input name="servicetotal" value="${labob.total}" onchange="calservicetotal();" type="text" class="charges" />

                            <input type="hidden" name="oldlabourinvid" value="${labob.id}" /></td>
                    </tr>
                </c:forEach>
            </TABLE>
            <br />            
            <table>
                <tbody>
                    <tr>
                        <td width="33%">Labour Total</td>
                        <td><input style="width: 100px" name="labourfinal" readonly="" value="${invoiceDt.labourfinal}" type="text" id="labourfinal" /></td>
                    </tr>
                    <tr>
                        <td width="33%">Discount</td>
                        <td><input style="width: 100px" name="discount_labour" value="${invoiceDt.discount_labour}" type="text" id="labourDiscount" onchange="addtoDiscount()" /></td>
                    </tr>
                    <tr class="insurancelbsum">
                        <td>Ins. liability</td>
                        <td>
                            <input style="width: 100px" name="laborinsuranceliability" readonly="" value="${liabilitylaborcompanysum}" type="text" id="labor-insurance-liability" /> +
                            <input style="width: 60px" name="laborinsurancetax" readonly="" value="${liabilitylaborcompanytax}" type="text" id="labor-insurance-tax" /> =
                            <input style="width: 100px" name="laborinsurancelbtotal" readonly="" value="${liabilitylaborcompany}" type="text" id="labor-insurancelb-total" />
                        </td>
                    </tr>
                    <tr class="insurancelbsum">
                        <td>Cust. liability</td>
                        <td>
                            <input style="width: 100px" name="laborcustomerliability" readonly="" value="${liabilitylaborcustomersum}" type="text" id="labor-customer-liability" /> +
                            <input style="width: 60px" name="laborcustomertax" readonly="" value="${liabilitylaborcustomertax}" type="text" id="labor-customer-tax" /> =
                            <input style="width: 100px" name="laborcustomerlbtotal" readonly="" value="${liabilitylaborcustomer}" type="text" id="labor-customerlb-total" />
                        </td>
                    </tr>
                </tbody>
            </table>

            <!--<div style="float:right; margin-right:80px; margin-top:10px; font-size:16px"><strong>TOTAL: 00.00/-</strong></div>-->
            <div>
                <INPUT type="button" value="Add Labour" onclick="addRow('dataTable1')"  class="view3"/>
                <INPUT type="button" value="Delete Selected" onclick="deleteLabourServiceRow();
                        calservicetotal();"  class="view3"/></div>  
            <br>
            <br>

            <TABLE id="dataTable2"> 
                <tr>
                    <td width="24%" align="left">
                        <strong>Add VAT @ ${invoiceDt.taxpercent1}%</strong>
                    </td>
                    <td align="left" valign="top">
                        <input name="taxpercent1" value="${invoiceDt.taxpercent1}" type="hidden" class="taxpercent1"/>
                        <input name="taxAmount1" value="${invoiceDt.taxAmount1}" type="text" readonly="" value="0" class="taxAmount1" style="width: 100px"/>
                    </td>              
                </tr>
                <tr>
                    <td width="24%" align="left">
                        <strong>Add SERVICE TAX @ ${invoiceDt.taxpercent2}%</strong>
                    </td>
                    <td align="left" valign="top">
                        <input name="taxpercent2" value="${invoiceDt.taxpercent2}" type="hidden" class="taxpercent2"/>
                        <input name="taxAmount2" value="${invoiceDt.taxAmount2}" type="text" readonly="" value="0" class="taxAmount2" style="width: 100px"/>
                    </td>              
                </tr>
            </TABLE>
            <TABLE id="claimss">
                <tr>
                    <td width="45%" align="left">
                        <strong>claim charges</strong>
                    </td>
                    <td align="left" valign="top">
                        <input name="claimcharges" value="${invoiceDt.claimcharges}" type="number" id="claimcharges" />
                    </td>                
                </tr>
                <tr>
                    <td width="45%" align="left">
                        <strong>Co. Insurance</strong>
                    </td>
                    <td align="left" valign="top">
                        <input name="companytotal" readonly="" value="${invoiceDt.companytotal}" type="number" id="companytotal" /> 
                        <input name="companytotalalways" readonly="" value="0" type="hidden" id="companytotalalways" />
                        <input name="customertotal" readonly="" value="${invoiceDt.customertotal}" type="hidden" id="customertotal" />
                    </td>                
                </tr>
                <tr>
                    <td width="45%" align="left">
                        <strong>Cust. Liability</strong>
                    </td>
                    <td align="left" valign="top">
                        <input name="customerinsuranceliability" readonly="" value="${invoiceDt.customerinsuranceliability}" type="number" id="customerinsuranceliability" />
                    </td>                
                </tr>
            </TABLE>
            <br>
            <strong>Discount</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input name="discountamount" value="${invoiceDt.discountamount}" type="text" id="discounttotal" onchange="showgrandtotal(this);" /><br>
            <strong>Your Grand Total</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="myTotal" readonly="" value="${invoiceDt.amountTotal}" type="text" id="amountTotal" /><input name="amountTotal" readonly="" value="${invoiceDt.amountTotal}" type="hidden" id="grandtotal" /><br>
            <br>
            <strong>Tax applicable</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" class="modradiobutton" name="isapplicable" onchange="calltax(this)" id="yesappicable" value="Yes"> Yes &nbsp;<input type="radio" class="modradiobutton" name="isapplicable" onchange="calltax(this)" id="noappicable" value="No"> No<br>
            <center> 
                <a href="#modal" class="btn go invoiceview">Next</a>

            </center>
            <br />    
        </form>
        <script>
            $(function () {
                console.log("ready!");
                if ('${invoiceDt.istax}' === "No") {
                    $(".taxAmount1").val("0");
                    $(".taxAmount2").val("0");
                    var parttotal = $("#sparepartsfinal").val();
                    var servicetotal = $("#labourfinal").val();
                    var resulttotal = Number(parttotal) + Number(servicetotal);
                    $("#amountTotal").val(resulttotal.toFixed(2));
                    $("#grandtotal").val(resulttotal.toFixed(2));
                    $("#noappicable").prop("checked", true);
                    $("#yesappicable").prop("checked", false);
                } else {
                    $("#yesappicable").prop("checked", true);
                    $("#noappicable").prop("checked", false);
                }
            });
        </script>
    </body>
</html>

