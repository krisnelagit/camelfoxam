<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : CreateServiceCheckList
    Created on : 24 Apr, 2015, 1:12:36 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Service Check List</title>

        <script src="js/jquery-1.8.3.js" type="text/javascript"></script>
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <link rel="stylesheet" href="css/jquery-ui_1.css" />
        <script>
            //customer mobile number auto complete

            jQuery(document).ready(function () {
                getcarmodels();

                //popup for Add Cutomer details start here
                $("#dialogCustomer").hide();
                //on click of add
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
                //popup for Add customer details end here


                //old brand and brand detail autocompl;ete  data comes here
                //
                //old autocmplete sdata end here

                //vehicle number gets all the vehicle details starts! here
                var vehiclenumber = [];
                $(function () {

                    $("input:text[id^='vehiclenumber']").live("focus.autocomplete", null, function () {


                        $(this).autocomplete({
                            source: vehiclenumber,
                            change: function () {
                                var val = $(this).val();
                                var exists = $.inArray(val, vehiclenumber);
                                if (exists < 0) {
//                                    $(this).val("");
                                    $('#existing').val('no');
                                    return false;
                                } else {
                                    $('#existing').val('yes');
                                    $.ajax({
                                        url: "getvehicledetails",
                                        dataType: 'json',
                                        type: 'POST',
                                        data: {
                                            vno: val
                                        },
                                        success: function (data) {
                                            //mod nitz 04-11-2015
                                            var carmodel = data[0].model;
                                            var carbrandid = data[0].brandid;
                                            var carbranddetailid = data[0].branddetailid;

                                            //mod nitz 04-11-2015
                                            $('#licensenumber').val(data[0].license);
                                            $('#vinnumber').val(data[0].vinno);
                                            $('#vid').val(data[0].id);
                                            $("#brandid").val(data[0].brand);
                                            $('#carbrand').val(data[0].brandid);
//                                            var carmodel = $("#branddetailid").val(data[0].model);
//                                            var carbranddetailid = $('#carmodel').val(data[0].branddetailid);

                                            $.ajax({
                                                url: "getModelDetails",
                                                dataType: 'json',
                                                type: 'POST',
                                                data: {
                                                    brandid: carbrandid
                                                },
                                                success: function (data) {
                                                    if (data) {
                                                        var brandname = $("#carbrand option:selected").text();
                                                        $("#brandid").val(brandname);
                                                        $('#carmodel option').remove();
                                                        for (var i = 0; i < data.length; i++) {
                                                            $("#carmodel").append('<option value="' + data[i].id + '">' + data[i].vehiclename + '</option>');
                                                        }
                                                        $("#branddetailid").val(carmodel);
                                                        $('#carmodel').val(carbranddetailid);
                                                    }
                                                }, error: function () {
                                                }
                                            });
                                            //the name for the respective brand and branddetail

                                        }, error: function () {
                                            alert('Error');
                                        }

                                    });
                                }
                            }
                        });
                    });
                });
                //vehicle number gets all the vehicle details end!! here

                //mobile number autocomplete gets customer data
                jQuery(function () {
                    //getting data from controller
                    var person = [
            <c:forEach var="occ" items="${custdtls}">
                        {custname: "${occ.name}", custid: "${occ.id}", custMobile: "${occ.mobilenumber}"},
            </c:forEach>
                    ];

                    var source = [];
                    var mapping = {};
                    //mapping customer mobile number to id and customer id to name
                    for (var i = 0; i < person.length; ++i) {
                        source.push(person[i].custMobile);
                        mapping[person[i].custMobile] = person[i].custid + ',' + person[i].custname;
                    }

                    jQuery("input:text[id^='mobilenumber']").live("focus.autocomplete", null, function () {
//                    alert('h20');
                        jQuery(this).autocomplete({
                            source: source,
                            select: function (event, ui) {
                                var data = mapping[ui.item.value];
                                var splitvar = data.split(',');
                                $("#custid").val(splitvar[0]);
                                $("#custname").val(splitvar[1]);
                                var modelname = $("#carmodel option:selected").text();
                                $("#branddetailid").val(modelname);
                            },
                            change: function () {
                                var val = jQuery(this).val();
                                var exists = jQuery.inArray(val, source);
                                if (exists < 0) {
                                    jQuery(this).val("");
                                    vehiclenumber = [];
                                    $('#vehiclenumber').val('');
                                    return false;
                                } else {
                                    var custt = $("#custid").val();
                                    vehiclenumber = [];
                                    $('#vehiclenumber').val('');
                                    $.ajax({
                                        url: "getcustvehicles",
                                        type: 'POST',
                                        dataType: 'json',
                                        data: {
                                            custid: custt
                                        }, success: function (data1) {
                                            if (data1.length === 0) {
                                                $('#existing').val('no');
                                            }
                                            $("#extracardetails").find('option').remove();
                                            $("#extracardetails").append('<option value="" selected disabled>--select--</option>');
                                            console.log(data1.length);

                                            for (var i = 0; i < data1.length; i++) {
                                                vehiclenumber.push(data1[i].vehicle);
                                                //code to show customer vehicles in dropdown begin here
                                                console.log("hey :"+data1[i].vehiclename);
                                                $("#extracardetails").append('<option value="' + data1[i].vehicle + '">' + data1[i].vehiclename + ' * ' + data1[i].vehicle + '</option>');
                                                //code to show customer vehicles in dropdown ends! here
                                            }

                                        }, error: function () {
                                            alert('error1');
                                        }

                                    });

                                }
                            }
                        });
                    });

                });
                //mobile number autocomplete gets customer data end here!

                jQuery(function () {
                    //THIS CODE SETS CURTRENT DATE AS DATE ON PAGE LOAD
                    jQuery(".datepicker").datepicker({dateFormat: 'mm/dd/yy'});
                    var currentDate = new Date();
                    jQuery(".datepicker").datepicker("setDate", currentDate);
                    jQuery("#datepickr").datepicker({dateFormat: 'mm/dd/yy'});
                    jQuery("#datepickr").datepicker("setDate", currentDate);
                });

                //customerwise search begin here
                $(function () {
                    //getting data from controller
                    var person = [
            <c:forEach var="occ" items="${custdtls}">
                        {custname: "${occ.name}", custid: "${occ.id}", custMobile: "${occ.mobilenumber}"},
            </c:forEach>
                    ];

                    var source = [];
                    var mapping = {};
                    //mapping customer mobile number to id and customer id to name
                    for (var i = 0; i < person.length; ++i) {
                        source.push(person[i].custname);
                        mapping[person[i].custname] = person[i].custid + ',' + person[i].custMobile;
                    }

                    $("input:text[id^='custname']").live("focus.autocomplete", null, function () {
                        $(this).autocomplete({
                            source: source,
                            select: function (event, ui) {
                                var data = mapping[ui.item.value];
                                var splitvar = data.split(',');
                                $("#custid").val(splitvar[0]);
                                $("#mobilenumber").val(splitvar[1]);

                                //ajax call voe vehicle list for this customers.
                                vehiclenumber = [];
                                $('#vehiclenumber').val('');
                                $.ajax({
                                    url: "getcustvehicles",
                                    type: 'POST',
                                    dataType: 'json',
                                    data: {
                                        custid: splitvar[0]
                                    }, success: function (data1) {
                                        if (data1.length === 0) {
                                            $('#existing').val('no');
                                        }
                                        $("#extracardetails").find('option').remove();
                                        $("#extracardetails").append('<option value="" selected disabled>--select--</option>');
                                        console.log(data1.length);

                                        for (var i = 0; i < data1.length; i++) {
                                            vehiclenumber.push(data1[i].vehicle);
                                            //code to show customer vehicles in dropdown begin here
                                            $("#extracardetails").append('<option value="' + data1[i].vehicle + '">' + data1[i].vehiclename + ' * ' + data1[i].vehicle + '</option>');
                                            //code to show customer vehicles in dropdown ends! here
                                        }
                                    }, error: function () {
                                        alert('error1');
                                    }
                                });
                            }
                        });
                    });

                });
                //custome wise search end here

                $(function () {
                    $("#accordion").accordion({
                        heightStyle: "content",
                        active: -1,
                    });
                });
                var brandname = $("#carbrand option:selected").text();
                $("#brandid").val(brandname);

                var elements = document.querySelectorAll('input,select,textarea');

                for (var i = elements.length; i--; ) {
                    elements[i].addEventListener('invalid', function () {
                        this.scrollIntoView(false);
                    });
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
                            var brandname = $("#carbrand option:selected").text();
                            $("#brandid").val(brandname);
                            $('#carmodel option').remove();
                            for (var i = 0; i < data.length; i++) {
                                $("#carmodel").append('<option value="' + data[i].id + '">' + data[i].vehiclename + '</option>');
                            }
                            var modelname = $("#carmodel option:selected").text();
                            $("#branddetailid").val(modelname);
                        }
                    }, error: function () {
                    }
                });
            }

            function setcarmodelname() {
                var modelname = $("#carmodel option:selected").text();
                $("#branddetailid").val(modelname);
            }

            function getcardetails() {
                var val = $('#extracardetails').val();
                $("#vehiclenumber").val(val);
                $.ajax({
                    url: "getvehicledetails",
                    dataType: 'json',
                    type: 'POST',
                    data: {
                        vno: val
                    },
                    success: function (data) {
                        //mod nitz 04-11-2015
                        var carmodel = data[0].model;
                        var carbrandid = data[0].brandid;
                        var carbranddetailid = data[0].branddetailid;

                        //mod nitz 04-11-2015
                        $('#licensenumber').val(data[0].license);
                        $('#vinnumber').val(data[0].vinno);
                        $('#vid').val(data[0].id);
                        $("#brandid").val(data[0].brand);
                        $('#carbrand').val(data[0].brandid);
//                                            var carmodel = $("#branddetailid").val(data[0].model);
//                                            var carbranddetailid = $('#carmodel').val(data[0].branddetailid);

                        $.ajax({
                            url: "getModelDetails",
                            dataType: 'json',
                            type: 'POST',
                            data: {
                                brandid: carbrandid
                            },
                            success: function (data) {
                                if (data) {
                                    var brandname = $("#carbrand option:selected").text();
                                    $("#brandid").val(brandname);
                                    $('#carmodel option').remove();
                                    for (var i = 0; i < data.length; i++) {
                                        $("#carmodel").append('<option value="' + data[i].id + '">' + data[i].vehiclename + '</option>');
                                    }
                                    $("#branddetailid").val(carmodel);
                                    $('#carmodel').val(carbranddetailid);
                                }
                            }, error: function () {
                            }
                        });
                        //the name for the respective brand and branddetail

                    }, error: function () {
                        alert('Error');
                    }

                });

            }

        </script>
    </head>
    <body>
        <form action="insertservicechecklist" method="post">
            <input type="hidden" name="existing" id="existing" value="no" />
            <input type="hidden" name="vid" id="vid" value="no" />

            <a href="service_checklist_grid.html" class="view ">Back</a>
            <h2>Service Check List</h2>

            <br />

            <table width="100%" cellpadding="5">

                <tr>
                    <td align="left" valign="top">Date</td>
                    <td align="left" valign="top">
                        <input type="text" name="date" required="" id="textfield2" class="datepicker" />
                    </td>
                    <td align="left" valign="top">Customer mobile no.</td>
                    <td align="left" valign="top"><input name="textfield8" required="" type="text"  id="mobilenumber" value="" /> <a href="customerMasterCreateLink" title="Add new Customer" class="view customer_link3">Add Customer</a></td>
                </tr>


                <tr>
                    <td align="left" valign="top">Customer Name</td>
                    <td align="left" valign="top"><input type="text" required="" name="textfield4" id="custname" />   <input type="hidden" name="custid" id="custid" /></td>


                    <td width="13%" align="left" valign="top">Vehicle No.(eg: DL 01 C AA 1155)</td>
                    <td width="26%" align="left" valign="top">
                        <label for="textfield"></label>
                        <input type="text" style="width: 120px" name="vehiclenumber" id="vehiclenumber" /> 
                        <select name="extracardetails" id="extracardetails" onchange="getcardetails();">
                        </select>
                    </td>
                </tr>

                <tr>
                    <td width="13%" align="left" valign="top">Car brand</td>
                    <td width="26%" align="left" valign="top"><label for="textfield"></label>
                        <!--changes nitz begin here-->
                        <select name="brandid" required="" id="carbrand" onchange="getcarmodels()">
                            <option disabled="">--select--</option>
                            <c:forEach var="ob" items="${carbranddetails}">
                                <option value="${ob.id}">${ob.name}</option>
                            </c:forEach>
                        </select>

                        <input type="hidden" name="carbrand" id="brandid" value="" />
                        <!--changes nitz end here-->
                        <!--<input type="text" required="" name="carbrand" id="carbrand" />-->
                    </td>
                    <td width="23%" align="left" valign="top">Vehicle Model</td>
                    <td width="38%" align="left" valign="top">
                        <!--changes nitz begin here-->
                        <select onchange="setcarmodelname()" name="branddetailid" required="" id="carmodel">
                        </select>
                        <input type="hidden" name="carmodel" id="branddetailid" value="" />
                        <!--changes nitz end here-->
                        <!--<input type="text" required="" name="carmodel" id="carmodel" />-->
                    </td>
                </tr>

                <tr><td width="13%" align="left" valign="top">KM. in</td>
                    <td width="26%" align="left" valign="top">
                        <label for="textfield"></label>
                        <input type="number" name="km_in" value="" />
                    </td>
                    <td width="23%" align="left" valign="top">VIN No.</td>
                    <td width="38%" align="left" valign="top"><input type="text" pattern="^[a-zA-Z0-9]*$" title="Please enter a valid VIN No." name="vinnumber" maxlength="17" id="vinnumber" /></td>
                </tr>

                <tr>
                    <td width="13%" align="left" valign="top">Service Booklet</td>
                    <td width="26%" align="left" valign="top">
                        <label for="textfield"></label>
                        <input class="modtabcheckbox" type="checkbox" name="servicebooklet" value="checked" />    
                    </td>
                    <td width="23%" align="left" valign="top">Documents Reg Paper</td>
                    <td width="38%" align="left" valign="top">
                        <input class="modtabcheckbox" type="checkbox" name="docregpaper" value="checked" />
                    </td>
                </tr>

                <tr>
                    <td width="13%" align="left" valign="top">Rim Lock</td>
                    <td width="26%" align="left" valign="top">
                        <label for="textfield"></label>
                        <input class="modtabcheckbox" type="checkbox" name="rimlock" value="checked" />    
                    </td>
                    <td width="23%" align="left" valign="top">Tool Kit</td>
                    <td width="38%" align="left" valign="top">
                        <input class="modtabcheckbox" type="checkbox" name="toolkit" value="checked" />
                    </td>
                </tr>

                <tr>
                    <td width="13%" align="left" valign="top">Old Parts Request</td>
                    <td width="26%" align="left" valign="top">
                        <label for="textfield"></label>
                        <input class="modtabcheckbox" type="checkbox" name="oldpartsrequest" value="checked" />
                    </td>
                    <td width="23%" align="left" valign="top">Fuel Level</td>
                    <td width="38%" align="left" valign="top">
                        <select name="fuellevel">
                            <option>Res</option>
                            <option>1/4</option>
                            <option>1/2</option>
                            <option>3/4</option>
                            <option>Full</option>
                        </select></td>
                </tr>

                <tr>
                    <td width="13%" align="left" valign="top">Driver name</td>
                    <td width="26%" align="left" valign="top">
                        <label for="textfield"></label>                        
                        <input type="text" name="drivername" value="" />
                    </td>
                    <td width="23%" align="left" valign="top">Driver number</td>
                    <td width="38%" align="left" valign="top">
                        <label for="textfield"></label>
                        <input type="number" name="drivernumber" value="" />
                    </td>
                </tr>

                <!--                <tr>
                                    
                                    <td align="left" valign="top">Licence No.</td>
                                    <td align="left" valign="top"><input type="text" pattern="^[a-zA-Z0-9]*$" title="Please enter a valid Licence No." maxlength="17" name="licensenumber" id="licensenumber" /></td>
                                    <td width="23%" align="left" valign="top">&nbsp;</td>
                                    <td width="38%" align="left" valign="top">&nbsp;</td>
                                </tr>-->
            </table>
            <br />
            <hr/>
            <br />

            <div id="accordion">
                <h3>Inside Check</h3>
                <div>
                    <table width="100%" cellpadding="5">
                        <tr>
                            <td width="13%" align="left" valign="top">No Micro Filter </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="nomicrofilter" value="checked" />
                            </td>
                            <td width="23%" align="left" valign="top">Instrument Lighting</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="instrumentlighting" value="checked" />
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Steering </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="steering" value="checked" />
                            </td>
                            <td width="23%" align="left" valign="top">Micro Filter</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="microfilter" value="checked" />
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Handbrake </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="handbrake" value="checked" />
                            </td>
                            <td width="23%" align="left" valign="top">Pedal-noise</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="pedalnoise" value="checked" />
                            </td>
                        </tr>
                    </table>
                </div>
                <h3>Engine Check</h3>
                <div>
                    <table width="100%" cellpadding="5">
                        <tr>
                            <td width="13%" align="left" valign="top">Cooling System </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="coolingsystem" value="checked" />
                            </td>
                            <td width="23%" align="left" valign="top">Brake Fluid</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="brakefluid" value="checked" />
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Steering Fluid </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="steeringfluid" value="checked" />
                            </td>
                            <td width="23%" align="left" valign="top">V-belt / Poly V-belt</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="vbelt" value="checked" />
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Last Inspection </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input type="text" name="lastinspection" id="textfield" placeholder="KM" />
                            </td>
                            <td width="23%" align="left" valign="top">Cleanwise</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input type="text" name="cleanwise" id="datepickr" placeholder="Date " />
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Noticeable Leaks </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="noticableleaks" value="checked" />
                            </td>
                            <td width="23%" align="left" valign="top">&nbsp;</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </div>
                <h3>Vehicle Check</h3>
                <div>
                    <table width="100%" cellpadding="5">
                        <tr>
                            <td width="13%" align="left" valign="top">Cooling System </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="Vcoolingsystem" value="checked" />
                            </td>
                            <td width="23%" align="left" valign="top">Wiper Blades</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="wiperblades" value="checked" />
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Window Glass </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="windowglass" value="checked" />
                            </td>
                            <td width="23%" align="left" valign="top">Body</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="body" value="checked" />
                            </td>
                        </tr>
                    </table>
                </div>
                <h3>Vehicle Check (Half Raised)</h3>
                <div>
                    <table width="100%" cellpadding="5">
                        <tr>
                            <td width="13%" align="left" valign="top">Rear lights / Headlights</td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="headlights" value="checked" />
                            </td>
                            <td width="23%" align="left" valign="top">Shockabsorber</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="shockabsorber" value="checked" />
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Tyre Tread </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="tyretread" value="checked" />
                            </td>
                            <td width="23%" align="left" valign="top">Front Brake pads / Discs</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="frontbrake" value="checked" />
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Brake Lines / Hoses </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="hoses" value="checked" />
                            </td>
                            <td width="23%" align="left" valign="top">Rear Brake Pads / Discs</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="rearbrake" value="checked" />
                            </td>
                        </tr>
                    </table>
                </div>
                <h3>Vehicle Check (Fully Raised)</h3>
                <div>
                    <table width="100%" cellpadding="5">
                        <tr>
                            <td width="13%" align="left" valign="top">Exhaust System</td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="exhaustsystem" value="checked" />
                            </td>
                            <td width="23%" align="left" valign="top">Rear Axle</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="rearaxle" value="checked" />
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Gear Box / Leaking </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="gearbox" value="checked" />
                            </td>
                            <td width="23%" align="left" valign="top">Fuel Tank / Lines</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="fueltank" value="checked" />
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Cooling System </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="Vfullyraisedcoolingsystem" value="checked" />
                            </td>
                            <td width="23%" align="left" valign="top">Final Drive / Leaking</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="finaldrive" value="checked" />
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Front Axle </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="frontaxle" value="checked" />
                            </td>
                            <td width="23%" align="left" valign="top">Engine Leaks</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="engineleaks" value="checked" />
                            </td>
                        </tr>
                    </table>
                </div>
                <h3>Car Wash</h3>
                <div>
                    <table width="100%" cellpadding="5">
                        <tr>
                            <td width="13%" align="left" valign="top">Cooling System</td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="carwashcoolingsystem" value="checked" />
                            </td>
                            <td width="23%" align="left" valign="top">Exterior Polish</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="exteriorpolish" value="checked" />
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Interior Cleaning </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="interiorcleaning" value="checked" />
                            </td>
                            <td width="23%" align="left" valign="top">Wheel Rim Cleaning</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="wheelrimcleaning" value="checked" />
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Body Protection</td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="bodyprotection" value="checked" />
                            </td>
                            <td width="23%" align="left" valign="top">Anti-Rust Treatment</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="antirust" value="checked" />
                            </td>
                        </tr>
                    </table>
                </div>
                <h3>Additional Work</h3>
                <div>
                    <table width="100%" cellpadding="5">
                        <tr>
                            <td width="13%" align="left" valign="top">Comment the addition task done</td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <textarea name="additionalwork" cols="100" rows="10"></textarea>
                            </td>
                            <td width="23%" align="left" valign="top">&nbsp;</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <br />
            <center>
                <INPUT type="submit" value="Save" class="view3" style="cursor: pointer"/>&nbsp;&nbsp;
            </center> 


        </form>

        <!--modal popup to add customer begin here-->        
        <div id="dialogCustomer" title="Add Customer">
            <form action="addCustomerChecklist" method="POST" onsubmit="var text = document.getElementById('address').value;
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
