<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : CreateCustomerInvoice
    Created on : 18 Mar, 2015, 4:15:18 PM
    Author     : pc2
--%>

<!--**required validation before changes**
customermobilenumber
customer_name
transactionmail
vehicleid
vehiclenumber
insurancecompanyname
insurancetype
claimnumber
insurancepercent-->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="css/csstable.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="css/jquery-ui.css" />
        <script src="js/jquery-1.8.3.js" type="text/javascript"></script>
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/jquery.datetimepicker.css">
        <script src="js/jquery.datetimepicker.js"></script>
        <title>Customer Invoice</title>

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

        <SCRIPT language="javascript">
            //code for custom name here
            function copyfield(ob) {
                console.log(" the keyup text");
                var stt = $(ob).val();
                console.log(stt + " the text");
                $(ob).closest('tr').find('.serviceAction').val(stt);
            }

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
                var boolinsurance = document.getElementById("selectinsurance").value;
                var type_insurance = document.getElementById("typeofinsurance").value;
                if (type_insurance === "Full Payment") {
                    insurance_percent = "100";
                } else {
                    insurance_percent = "0";
                }

                if (tableID === "dataTable") {
                    $('#' + tableID + '').append('<tr><td align="left" valign="top"><INPUT type="checkbox" name="chk"/><input type="hidden" name="partid" value="" id="prdid"/></td><td align="left" valign="top"><input name="carparts" type="text" id="carparts" /></td><td align="left" valign="top"><select name="manufacturerid" class="manufacturer" style="width: 100px" onchange="iambatman(this)"><option>--select--</option><option></option></select></td><td align="left" valign="top"><input name="partQuantity" type="text" class="quantity" style="width: 45px" onchange="calculatebalance(this)" /></td><td align="left" valign="top"><input name="sellingprice" type="text"  onchange="calculateselling(this)" class="sellingprice" style="width: 50px"/></td><td align="left" valign="top" class="inventoryinsurance"><input name="insurancepercent" min="0" max="100"  step="0.01" value="' + insurance_percent + '" type="number" class="insurancepercent" onchange="calculateinsurance(this)" style="width: 100px" /></td><td align="left" valign="top" class="inventorycompanyinsurance"><input name="insurancecompanyamount" readonly="" type="text" value="0" class="insurancers" style="width: 100px"/></td><td align="left" valign="top" class="inventorycustinsurance"><input name="insurancecustomeramount" readonly="" type="text" value="0" class="custinsurance" style="width: 100px"/></td><td align="left" valign="top"><input name="itemtotal" readonly="" type="text" value="0" class="itemtotal" style="width: 100px"/></td></tr>');
                } else {
                    $('#' + tableID + '').append('<tr><td align="left" valign="top"><INPUT type="checkbox" name="chk"/><input type="hidden" name="serviceid" value="" id="serviceid"/><input type="hidden" name="serviceAction" class="serviceAction"/></td><td align="left" valign="top"><input name="servicename" type="text" onchange="copyfield(this)" id="labour" /></td><td align="left" valign="top"><input name="description" type="text" class="description" /></td>                <td align="left" valign="top" class="labourinsurance"><input name="serviceinsurancepercent" value="' + insurance_percent + '" type="text"  class="insurancepercent" onchange="calculateInsurancebalance(this)" style="width: 100px"/></td><td align="left" valign="top" class="labourcompanyinsurance"><input name="companyinsuranceservice" type="text" readonly="" value="0" class="insuranceServicers" style="width: 100px"/></td><td align="left" valign="top" class="labourcustinsurance"><input name="custinsuranceservice" type="text" readonly="" value="0" class="insuranceServicerscustomer" style="width: 100px"/></td><td align="left" valign="top"><input name="servicetotal" onchange="calculateLabourbalance();" type="text" class="charges" /></td></tr>');
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
                    $('.insurancelbsum').show();
                    $('#claimss').show();

//                    $('#companyname').prop('required', true);
//                    $('#typeofinsurance').prop('required', true);
//                    $('#claimno').prop('required', true);
//                    $('.insurancepercent').prop('required', true);

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
                    $('#claimss').hide();
                    $('.insurancelbsum').hide();

//                    $('#companyname').prop('required', false);
//                    $('#typeofinsurance').prop('required', false);
//                    $('#claimno').prop('required', false);
//                    $('.insurancepercent').prop('required', false);
                }
            }

            //delete rows
            function deleteRow(tableID) {
                try {
                    var table = document.getElementById(tableID);
                    var rowCount = table.rows.length;
                    for (var i = 0; i < rowCount; i++) {
                        var row = table.rows[i];
                        var chkbox = row.cells[0].childNodes[0];
                        if (null != chkbox && true == chkbox.checked) {
                            if (rowCount <= 1) {
                                alert("Cannot delete all the rows.");
                                break;
                            }
                            table.deleteRow(i);
                            rowCount--;
                            i--;
                        }
                    }
                } catch (e) {
                    alert(e);
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
                            $("#customer_id").val(splitcustomer[1]);
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
            var carparts = [];
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
                                return false;
                            } else {
                                currentelement.closest('tr').find('option').remove();
//                                var amount = a.closest('tr').find('#prdid').val();
                                var partid = a.closest('tr').find("#prdid").val();
                                var selectedpartname = a.closest('tr').find("#carparts").val();
                                if (selectedpartname === "others") {
                                    //CODE WRITTEN TO GET LIST OF ALL MANUFACTURERE AS WE ADD NEW PRODUCT
                                    $.ajax({
                                        url: "getmanufacturerdata",
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
                                                    currentelement.closest('tr').find('.manufacturer').append('<option value="' + data[i].id + '">' + data[i].name + '</option>');
                                                }
                                            }
                                        }, error: function () {
                                        }
                                    });


                                } else {
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
//                            alert(item.label);
//                            

                            // display the selected text 
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
                                            var servicename = currentelement.closest('tr').find("#labour").val(); // display the selected text 
                                            currentelement.closest('tr').find(".serviceAction").val(servicename);
                                            currentelement.closest('tr').find('.insurancepercent').trigger("change");

                                            var table = document.getElementById("dataTable1");
                                            var rowCount = table.rows.length;
                                            var servicecharges = 0;

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

                                                $("#amountTotal").val(amt.toFixed(2));
                                                var discount = $("#discounttotal").val();
                                                var newtotal = Number(amt.toFixed(2)) - Number(discount);
//                                                $('#grandtotal').val(amt.toFixed(2));
                                                $('#grandtotal').val(newtotal.toFixed(2));

                                            }
                                            servicecharges = 0;
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
                            findCarType();

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
//                                            carparts = [
//                                                {value: "1", label: "majid shaikh"}
//                                            ];
                                            for (var i = 0; i < data.length; i++) {
                                                carparts.push({
                                                    value: "" + data[i].id + "",
                                                    label: "" + data[i].partname + ""
                                                });
                                            }
                                            findCarType();

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
        </script>
        <script>
            //calculate total part price
            function calculatebalance(b) {


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
                    calculateLabourbalance();
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

                        $("#amountTotal").val(amt.toFixed(2));

                        var discount = $("#discounttotal").val();
                        var newtotal = Number(amt.toFixed(2)) - Number(discount);


                        $('#grandtotal').val(newtotal.toFixed(2));
                        $('#claimcharges').trigger('keyup');
                        $('#dataTable .insurancepercent').trigger('change');
                    }
                }

                quantitycount = 0;
            }

            //calculate labour balance / service balance
            function calculateLabourbalance() {
                var table = document.getElementById("dataTable1");
                var rowCount = table.rows.length;
                var servicecharges = 0;
                if (rowCount === 1) {
                    $("#labourfinal").val(0);
                    $("#amountTotal").val(0);
                    $("#grandtotal").val(0);
                    $(".taxAmount2").val(0);
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

                        $("#amountTotal").val(amt.toFixed(2));
                        var discount = $("#discounttotal").val();
                        var newtotal = Number(amt.toFixed(2)) - Number(discount);

                        $('#grandtotal').val(newtotal.toFixed(2));
                        $('#claimcharges').trigger('keyup');
                        $('#dataTable1 .insurancepercent').trigger('change');
                    }
                }
                servicecharges = 0;
            }


            //calculate insurance
            function calculateinsurance(b) {

                var tmp;
                var insurancepercent = $(b).val();
                var amount = $(b).closest('tr').find('.itemtotal').val();
                tmp = amount * insurancepercent / 100;
                $(b).closest('tr').find('.insurancers').val(tmp);
                var atemp;
                atemp = amount - tmp;
                $(b).closest('tr').find('.custinsurance').val(atemp);

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
                $('#customertotal').val(customersum);

                $('#claimcharges').keyup();
            }

            //calculate calculateInsurancebalance(this)
            function calculateInsurancebalance(b) {
                var chgs = $(b).closest('tr').find('.charges').val();
                var percent = $(b).val();
                var tmp;
                tmp = chgs * percent / 100;
                $(b).closest('tr').find('.insuranceServicers').val(tmp);
                var atemp;
                atemp = chgs - tmp;
                $(b).closest('tr').find('.insuranceServicerscustomer').val(atemp);

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

            //get part type 
            function findCarType() {
                var carid = $("#vehicleid").val();
                $.ajax({
                    type: 'post',
                    url: 'getCarType',
                    data: {
                        carid: carid
                    },
                    success: function (data) {
                        $("#vehicletype").val(data);
                    },
                    error: function () {
                    }
                });
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
                $('#apdatetimepicker').datetimepicker({
                    format: 'd/m/Y  H:i',
                    minDate: 0
                });

                $("#claimcharges").keyup(function () {
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

//                $('#companyname').prop('required', false);
//                $('#typeofinsurance').prop('required', false);
//                $('#claimno').prop('required', false);
//                $('.insurancepercent').prop('required', false);


                $('#selectinsurance').change(function () {
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

//                        $('#companyname').prop('required', true);
//                        $('#typeofinsurance').prop('required', true);
//                        $('#claimno').prop('required', true);
//                        $('.insurancepercent').prop('required', true);
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
                        var getamtTotal = $('#amountTotal').val();
                        var discount = $("#discounttotal").val();
                        var newtotal = Number(getamtTotal) - Number(discount);

                        $('#grandtotal').val(newtotal.toFixed(2));

//                        $('#grandtotal').val(getamtTotal);

//                        $('#companyname').prop('required', false);
//                        $('#typeofinsurance').prop('required', false);
//                        $('#claimno').prop('required', false);
//                        $('.insurancepercent').prop('required', false);



                    }
                });
            });
            
            function calltax(a) {
                if ($(a).val() === "Yes") {
                    $(".sellingprice").change();
                    $(".charges").change();
                    $("#discounttotal").change();
                } else {
                    var spare,labor,result;
                    spare=$("#sparepartsfinal").val();
                    labor=$("#labourfinal").val();
                    result=Number(spare)+Number(labor);
                    $("#grandtotal").val(result);
                    $("#amountTotal").val(result);
                    $(".taxAmount1").val("0");
                    $(".taxAmount2").val("0");
                    $("#discounttotal").change();
                }
            }

            //code for individual discount adding
            function addtoDiscount() {
                var partAmt = $("#sparepartsDiscount").val();
                var labourAmt = $("#labourDiscount").val();

                var total = Number(partAmt) + Number(labourAmt);
                $("#discounttotal").val(total);
                $('#discounttotal').trigger('change');
            }

            //code for calculating discount minus final amount
            function showgrandtotal(a) {
                var discount = $(a).val();
                //check if service or parts available
                var parttotal = $("#sparepartsfinal").val();
                var servicetotal = $("#labourfinal").val();
                var vat = $(".taxAmount1").val();
                var servicetax = $(".taxAmount2").val();

                var actualgrandtotal = Number(parttotal) + Number(servicetotal) + Number(vat) + Number(servicetax);
                var newtotal = Number(actualgrandtotal) - Number(discount);
                $('#grandtotal').val(newtotal.toFixed(2));
            }

            function validateForm(formObj) {

                if (formObj.customermobilenumber.value == '') {
                    alert('Please enter mobile number');
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
    </head>
    <body>
        <a href="#modal" class="btn go view">Add reminder</a>
        <a href="invoiceMasterLink" class="view">Back</a>
        <h2>Invoice</h2>
        <br />
        <form action="addInvoice" method="POST">
            <input type="hidden" name="loopvalue" id="loopvalue" value="" />
            <div id="modal">
                <div class="modal-content">
                    <div class="header">
                        <h2>Add Reminder</h2>
                        <a href="#" class="btn"><img style="margin-top: -20px; width: 20px;height: 20px" src="images/cancel.png" ></a>

                    </div>
                    <div class="copy">
                        <table cellpadding="5" width="100%">
                            <tbody>
                                <tr>
                                    <td align="left" valign="top" width="13%">Date Time</td>
                                    <td align="left" valign="top" width="28%">
                                        <input name="date_time" id="apdatetimepicker" type="text">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top" width="8%">Message</td>
                                    <td align="left" valign="top" width="51%"><textarea name="message" rows="4" cols="20" id="message"></textarea></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="cf footer">	
                    </div>
                </div>
                <div class="overlay"></div>
            </div>

            <table width="100%" cellpadding="5">

                <tr>
                    <td width="31%" align="left" valign="top">Customer mobile number</td>
                    <td width="69%" align="left" valign="top"><label for="textfield"></label>
                        <label for="select"></label>
                        <input type="text" name="customermobilenumber" value="" id="mobilenumber" />   
                    </td>
                </tr>
                <tr>
                    <td width="31%" align="left" valign="top">Customer name</td>
                    <td width="69%" align="left" valign="top"><label for="textfield"></label>
                        <label for="select"></label>
                        <input type="text" name="customer_name" value="" id="customer_name" />   
                        <input type="hidden" name="customer_id" id="customer_id" value="" />
                    </td>
                </tr>
                <tr>
                    <td align="left" valign="top">Vehicle Model</td>
                    <td align="left" valign="top"><label for="textfield3"></label>
                        <input type="text" name="vehiclemodel" id="vehicle" /> <input type="hidden" name="vehicleid" id="vehicleid" /><input type="hidden" name="vehicletype" id="vehicletype" value="" /></td>
                </tr>
                <tr>
                    <td align="left" valign="top">Vehicle Number</td>
                    <td align="left" valign="top"><label for="textfield3"></label>
                        <input type="text" name="vehiclenumber" /></td>
                </tr>
                <tr>
                    <td align="left" valign="top">Insurance </td>
                    <td align="left" valign="top"><select name="isinsurance" id="selectinsurance">                            
                            <option selected="">No</option>
                            <option>Yes</option>
                        </select>
                    </td>
                </tr>
                <tr id="insurancecompany">
                    <td align="left" valign="top">Insurance Company</td>
                    <td align="left" valign="top"><label for="textfield3"></label>
                        <input type="text" name="insurancecompanyname" id="companyname" /><input type="hidden" name="insurancecompany" id="companyid" /></td>
                </tr>
                <tr id="insurancetype">
                    <td align="left" valign="top">Insurance Type</td>
                    <td align="left" valign="top"><label for="textfield3"></label>
                        <select name="insurancetype" id="typeofinsurance" onchange="makefull(this);">
                            <option value="" disabled selected style="display: none">--select--</option>
                            <option value="Full Payment">Full Payment</option>
                            <option value="Depreciation">Depreciation</option>
                        </select>
                    </td>
                </tr>
                <tr id="claimnumber">
                    <td align="left" valign="top">Claim Number</td>
                    <td align="left" valign="top"><label for="textfield3"></label>
                        <input type="text"  name="claimnumber" id="claimno" /></td>
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
                    <TD width="23%" align="center" class="inventorycompanyinsurance"><strong>Ins.liability</strong></TD>
                    <TD width="23%" align="center" class="inventorycustinsurance"><strong>Cust.liability</strong></TD>
                    <TD width="" align="center"><strong>Amount</strong></TD>
                </TR>
                <tr>
                    <td align="left" valign="top"><INPUT type="checkbox" name="chk"/><input type="hidden" name="partid" value="" id="prdid"/></td>
                    <td align="left" valign="top"><input name="carparts" type="text" id="carparts" /></td>
                    <td align="left" valign="top">
                        <select name="manufacturerid" class="manufacturer" style="width: 100px" onchange="iambatman(this)">
                            <option>--select--</option>
                            <option></option>
                        </select>
                    </td>
                    <td align="left" valign="top"><input name="partQuantity" type="number" class="quantity" style="width: 45px" onchange="calculatebalance(this)" onclick="calculatebalance(this)" /></td>
                    <td align="left" valign="top"><input name="sellingprice" type="number" onchange="calculateselling(this)" class="sellingprice" style="width: 50px"/></td>
                    <td align="left" valign="top" class="inventoryinsurance"><input name="insurancepercent" min="0" max="100" value="0" step="0.01" type="number" class="insurancepercent" onchange="calculateinsurance(this)" style="width: 100px" /></td>
                    <td align="left" valign="top" class="inventorycompanyinsurance"><input name="insurancecompanyamount" readonly="" type="text" value="0" class="insurancers" style="width: 100px"/></td>
                    <td align="left" valign="top" class="inventorycustinsurance"><input name="insurancecustomeramount" readonly="" type="text" value="0" class="custinsurance" style="width: 100px"/></td>
                    <td align="left" valign="top"><input name="itemtotal" readonly="" type="number" value="0" class="itemtotal" style="width: 100px"/></td>
                </tr>
            </TABLE>
            <br />
            <table >
                <tbody>
                    <tr>
                        <td width="33%">Spare parts Total</td>
                        <td>
                            <input style="width: 100px" name="sparepartsfinal" readonly="" value="0" type="text" id="sparepartsfinal" />
                        </td>
                    </tr>
                    <tr>
                        <td width="33%">Discount</td>
                        <td>
                            <input style="width: 100px" name=""value="0" type="text" id="sparepartsDiscount" onchange="addtoDiscount()" />
                        </td>
                    </tr>
                    <tr class="insurancelbsum">
                        <td>Ins. liability</td>
                        <td>
                            <input style="width: 100px" name="partinsuranceliability" readonly="" value="0" type="text" id="part-insurance-liability" /> +
                            <input style="width: 60px" name="partinsurancetax" readonly="" value="0" type="text" id="part-insurance-tax" /> =
                            <input style="width: 100px" name="partinsurancelbtotal" readonly="" value="0" type="text" id="part-insurancelb-total" />
                        </td>
                    </tr>
                    <tr class="insurancelbsum">
                        <td>cust. liability</td>
                        <td>
                            <input style="width: 100px" name="partcustomerliability" readonly="" value="0" type="text" id="part-customer-liability" /> +
                            <input style="width: 60px" name="partcustomertax" readonly="" value="0" type="text" id="part-customer-tax" /> =
                            <input style="width: 100px" name="partcustomerlbtotal" readonly="" value="0" type="text" id="part-customerlb-total" />
                        </td>
                    </tr>
                </tbody>
            </table> 
            <!--<div style="float:right; margin-right:80px; margin-top:10px; font-size:16px"><strong>TOTAL: </strong><input name="total" type="text" value="0" class="resulttotal" /></div>-->
            <div>
                <INPUT type="button" value="Add Product" onclick="addRow('dataTable')"  class="view3"/>
                <INPUT type="button" value="Delete Selected" onclick="deleteRow('dataTable');
                        calculatebalance(this)"  class="view3"/></div>  
            <br />
            <br />
            <br />

            <TABLE id="dataTable1" border="0" class="CSSTableGenerator">
                <TR>
                    <TD width="4%" align="left">&nbsp;</TD> 
                    <td width="24%" align="left"><strong>Service Name</strong></td>
                    <TD width="23%" align="center"><strong>Description</strong></TD>

                    <TD width="23%" align="center" class="labourinsurance"><strong>Insurance %</strong></TD>
                    <TD width="23%" align="center" class="labourcompanyinsurance"><strong>Ins.liability</strong></TD>
                    <TD width="23%" align="center" class="labourcustinsurance"><strong>Cust.liability</strong></TD>
                    <TD width="23%" align="center"><strong>Labour Rs.</strong></TD>
                </TR>
            </TABLE>
            <br />

            <table>
                <tbody>
                    <tr>
                        <td width="33%">Labour Total</td>
                        <td><input style="width: 100px" name="labourfinal" readonly="" value="0" type="text" id="labourfinal" /></td>
                    </tr>
                    <tr>
                        <td width="33%">Discount</td>
                        <td><input style="width: 100px" name="" value="0" type="text" id="labourDiscount" onchange="addtoDiscount()" /></td>
                    </tr>
                    <tr class="insurancelbsum">
                        <td>Ins. liability</td>
                        <td>
                            <input style="width: 100px" name="laborinsuranceliability" readonly="" value="0" type="text" id="labor-insurance-liability" /> +
                            <input style="width: 60px" name="laborinsurancetax" readonly="" value="0" type="text" id="labor-insurance-tax" /> =
                            <input style="width: 100px" name="laborinsurancelbtotal" readonly="" value="0" type="text" id="labor-insurancelb-total" />
                        </td>
                    </tr>
                    <tr class="insurancelbsum">
                        <td>Cust. liability</td>
                        <td>
                            <input style="width: 100px" name="laborcustomerliability" readonly="" value="0" type="text" id="labor-customer-liability" /> +
                            <input style="width: 60px" name="laborcustomertax" readonly="" value="0" type="text" id="labor-customer-tax" /> =
                            <input style="width: 100px" name="laborcustomerlbtotal" readonly="" value="0" type="text" id="labor-customerlb-total" />
                        </td>
                    </tr>
                </tbody>
            </table>
            <!--<div style="float:right; margin-right:80px; margin-top:10px; font-size:16px"><strong>TOTAL: 00.00/-</strong></div>-->
            <div>
                <INPUT type="button" value="Add Labour" onclick="addRow('dataTable1')"  class="view3"/>
                <INPUT type="button" value="Delete Selected" onclick="deleteRow('dataTable1');
                        calculateLabourbalance()"  class="view3"/></div>  
            <br>
            <br>

            <TABLE id="dataTable2">   
                <c:set value="1" var="count"></c:set>
                <c:forEach var="obva" items="${vatDetails}">
                    <tr>
                        <td width="24%" align="left">
                            <strong>Add ${obva.name} @ ${obva.percent}%</strong>
                        </td>
                        <td align="left" valign="top">
                            <input name="taxAmount${count}" type="text" readonly="" value="0" class="taxAmount${count}" style="width: 100px"/>
                            <input name="taxname" type="hidden" readonly value="${obva.name}" class="taxname" />
                            <input name="taxid" type="hidden" id="taxid" value="${obva.id}"  />
                            <input name="taxpercent${count}" value="${obva.percent}" type="hidden" class="taxpercent${count}" />
                        </td>                
                    </tr>
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>
            </TABLE>
            <TABLE id="claimss">
                <tr>
                    <td width="45%" align="left">
                        <strong>claim charges</strong>
                    </td>
                    <td align="left" valign="top">
                        <input name="claimcharges" value="0" type="number" id="claimcharges" />
                    </td>                
                </tr>
                <tr>
                    <td width="24%" align="left">
                        <strong>Ins. Liability</strong>
                    </td>
                    <td align="left" valign="top">
                        <input name="companytotal" readonly="" value="0" type="number" id="companytotal" />
                        <input name="companytotalalways" readonly="" value="0" type="hidden" id="companytotalalways" />
                        <input name="customertotal" readonly="" value="0" type="hidden" id="customertotal" />
                    </td>                
                </tr>
                <tr>
                    <td width="24%" align="left">
                        <strong>Cust. Liability</strong>
                    </td>
                    <td align="left" valign="top">
                        <input name="customerinsuranceliability" readonly="" value="0" type="number" id="customerinsuranceliability" />                            
                    </td>                
                </tr>
            </TABLE>  
            <br>
            <input name="myTotal" readonly="" value="0" type="hidden" id="amountTotal" />
            <strong>Discount</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="discountamount" value="0" type="text" id="discounttotal" onchange="showgrandtotal(this);" /><br>
            <strong>Your Grand Total</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;<input name="amountTotal" readonly="" value="0" type="text" id="grandtotal" /><br>
            <br>
            <strong>Tax applicable</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" class="modradiobutton" name="isapplicable" onchange="calltax(this)" id="yesappicable" value="Yes"> Yes &nbsp;<input type="radio" class="modradiobutton" name="isapplicable" onchange="calltax(this)" id="noappicable" value="No"> No<br>
            
            <center>        
                <input type="submit" value="Save" class="view3" name="submitButton" style="cursor: pointer"/>&nbsp;&nbsp;&nbsp;<input type="reset" value="Reset" class="view3" style="cursor: pointer"/>
            </center>    
            <br /> 
        </form>
                <script>
            $(function () {
                $("#yesappicable").prop("checked", true);
            });
        </script>
    </body>
</html>
