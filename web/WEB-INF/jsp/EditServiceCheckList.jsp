<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : EditServiceCheckList
    Created on : 24 Apr, 2015, 1:12:36 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Service CheckList</title>

        <script src="js/jquery-1.8.3.js" type="text/javascript"></script>
        <!--<script src="js/jquery.tools.min.js"></script>-->
        <script src="js/jquery-ui.js" type="text/javascript"></script>

        <!--<link rel="stylesheet" type="text/css" href="css/tabs-accordion.css"/>-->
        <link rel="stylesheet" href="css/jquery-ui_1.css" />

        <script>
            //customer mobile number auto complete

            jQuery(document).ready(function () {
//                $("#mobilenumber").change();
                //old brand and brand detail autocompl;ete  data comes here
                //
                //old autocmplete sdata end here
                // getcarmodels();

                //vehicle number gets all the vehicle details starts! here
                var vehiclenumber = [];
                console.log("Thisis vehiclenumber legnth : " + vehiclenumber.length);
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
                                            $('#carbrand').val(data[0].brandid);
                                            getcarmodels();
                                            $('#licensenumber').val(data[0].license);
                                            $('#vinnumber').val(data[0].vinno);
                                            $('#vid').val(data[0].id);
                                            $('#carmodel').val(data[0].branddetailid);
                                            //the name for the respective brand and branddetail
                                            $("#brandid").val(data[0].brand);
                                            $("#branddetailid").val(data[0].model);
                                        }, error: function () {
                                            alert('Error');
                                        }

                                    });
                                }
                            }
                        });
                    });
                });

                //on doc load load vehicle number list begin  here
                var custtt = $("#custid").val();
                vehiclenumber = [];
                $.ajax({
                    url: "getcustvehicles",
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        custid: custtt
                    }, success: function (data1) {
                        if (data1.length === 0) {
                            $('#existing').val('no');
                        }

                        for (var i = 0; i < data1.length; i++) {
                            vehiclenumber.push(data1[i].vehicle);
                        }
                    }, error: function () {
                        alert('error1');
                    }

                });
                //on doc load load vehicle number list ends!!  here

                //mobilenumber autocomplete comes here
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

                                            for (var i = 0; i < data1.length; i++) {
                                                vehiclenumber.push(data1[i].vehicle);
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

                jQuery(function () {
//                $(".datepicker").datepicker({dateFormat: 'yy/mm/dd'});
                    jQuery(".datepicker").datepicker({dateFormat: 'mm/dd/yy'});
                    jQuery("#datepickr").datepicker({dateFormat: 'mm/dd/yy'});
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

                                        for (var i = 0; i < data1.length; i++) {
                                            vehiclenumber.push(data1[i].vehicle);
                                        }
                                    }, error: function () {
                                        alert('error1');
                                    }
                                });
                            }
                        });
                    });

                });


                $(function () {
                    $("#accordion").accordion({
                        heightStyle: "content"
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
        </script>
    </head>
    <body>
        <form action="updateservicechecklist" method="post">
            <c:choose>
                <c:when test="${servicedtls.is180ready=='Yes'}">
                    <input type="hidden" name="is180ready" id="existing" value="Yes" />
                </c:when>
            </c:choose>

            <input type="hidden" name="existing" id="existing" value="no" />
            <input type="hidden" name="vid" id="vid" value="no" />

            <a href="service_checklist_grid.html" class="view">Back</a>
            <h2>Edit Service Check List</h2>

            <br />

            <table width="100%" cellpadding="5">

                <tr>
                    <td align="left" valign="top">Date</td>
                    <td align="left" valign="top">
                        <input type="text" name="date" id="textfield2" class="datepicker" value="${servicedtls.date}" />
                    </td>
                    <td align="left" valign="top">Customer No</td>
                    <td align="left" valign="top"><input name="textfield8" type="text"  id="mobilenumber" value="${servicedtls.cusmobile}" /> </td>
                </tr>

                <tr>
                    <td align="left" valign="top">Customer Name</td>
                    <td align="left" valign="top"><input type="text" name="textfield4" readonly="" id="custname" value="${servicedtls.custname}" />   <input type="hidden" name="custid" value="${servicedtls.custid}" id="custid" /></td>


                    <td width="13%" align="left" valign="top">Vehicle No.</td>
                    <td width="26%" align="left" valign="top">
                        <label for="textfield"></label>
                        <input type="text" name="vehiclenumber" id="vehiclenumber" value="${servicedtls.vehiclenumber}"/></td>
                </tr>

                <tr>
                    <td width="13%" align="left" valign="top">Car brand</td>
                    <td width="26%" align="left" valign="top"><label for="textfield"></label>
                        <!--changes nitz begin here-->
                        <select name="brandid" required="" id="carbrand" onchange="getcarmodels()">
                            <c:forEach var="ob" items="${brand}">
                                <c:choose>
                                    <c:when test="${ob.id==servicedtls.brandid}">
                                        <option value="${ob.id}" selected="">${ob.name}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${ob.id}">${ob.name}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>

                        <input type="hidden" name="carbrand" id="brandid" value="${servicedtls.carbrand}" />
                        <!--changes nitz end here-->
                        <!--<input type="text" required="" name="carbrand" id="carbrand" />-->
                    </td>
                    <td width="23%" align="left" valign="top">Vehicle Model</td>
                    <td width="38%" align="left" valign="top">
                        <!--changes nitz begin here-->
                        <select onchange="setcarmodelname()" name="branddetailid" required="" id="carmodel">
                            <c:forEach var="ob" items="${branddetails}">
                                <c:choose>
                                    <c:when test="${ob.id==servicedtls.branddetailid}">
                                        <option value="${ob.id}" selected="">${ob.vehiclename}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${ob.id}">${ob.vehiclename}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>
                        <input type="hidden" name="carmodel" id="branddetailid" value="${servicedtls.carmodel}" />
                        <!--changes nitz end here-->
                        <!--<input type="text" required="" name="carmodel" id="carmodel" />-->
                    </td>
                </tr>

                <!--                <tr>
                                    <td width="13%" align="left" valign="top">Vehicle Brand</td>
                                    <td width="26%" align="left" valign="top"><label for="textfield"></label>
                                        <input type="text" name="carbrand" id="carbrand" value=""/>
                                    </td>
                                    <td width="23%" align="left" valign="top">Vehicle Model</td>
                                    <td width="38%" align="left" valign="top"><input type="text" name="carmodel" id="carmodel" value=""/></td>
                                </tr>-->

                <tr>
                    <td width="13%" align="left" valign="top">KM. in</td>
                    <td width="26%" align="left" valign="top">
                        <label for="textfield"></label>
                        <input type="number" name="km_in" value="${servicedtls.km_in}" />
                    </td>
                    <td width="23%" align="left" valign="top">VIN No.</td>
                    <td width="38%" align="left" valign="top"><input type="text" name="vinnumber" id="vinnumber" value="${servicedtls.vinnumber}"/></td>
                </tr>

                <tr>
                    <td width="13%" align="left" valign="top">Serviec Booklet</td>
                    <td width="26%" align="left" valign="top">
                        <label for="textfield"></label>
                        <input class="modtabcheckbox" type="checkbox" name="servicebooklet" value="checked" ${servicedtls.servicebooklet}/>    
                    </td>
                    <td width="23%" align="left" valign="top">Documents Reg Paper</td>
                    <td width="38%" align="left" valign="top">
                        <input class="modtabcheckbox" type="checkbox" name="docregpaper" value="checked" ${servicedtls.docregpaper}/>
                    </td>
                </tr>

                <tr>
                    <td width="13%" align="left" valign="top">Rim Lock</td>
                    <td width="26%" align="left" valign="top">
                        <label for="textfield"></label>
                        <input class="modtabcheckbox" type="checkbox" name="rimlock" value="checked" ${servicedtls.rimlock}/>    
                    </td>
                    <td width="23%" align="left" valign="top">Tool Kit</td>
                    <td width="38%" align="left" valign="top">
                        <input class="modtabcheckbox" type="checkbox" name="toolkit" value="checked" ${servicedtls.toolkit}/>
                    </td>
                </tr>

                <tr>
                    <td width="13%" align="left" valign="top">Old Parts Request</td>
                    <td width="26%" align="left" valign="top">
                        <label for="textfield"></label>
                        <input class="modtabcheckbox" type="checkbox" name="oldpartsrequest" value="checked" ${servicedtls.oldpartsrequest}/>
                    </td>
                    <td width="23%" align="left" valign="top">Fuel Level</td>
                    <td width="38%" align="left" valign="top">
                        <select name="fuellevel">
                            <c:choose>
                                <c:when test="${servicedtls.fuellevel=='Res'}">
                                    <option selected="">Res</option>
                                    <option>1/4</option>
                                    <option>1/2</option>
                                    <option>3/4</option>
                                    <option>Full</option>
                                </c:when>
                                <c:when test="${servicedtls.fuellevel=='1/4'}">
                                    <option >Res</option>
                                    <option selected="">1/4</option>
                                    <option>1/2</option>
                                    <option>3/4</option>
                                    <option>Full</option>
                                </c:when>
                                <c:when test="${servicedtls.fuellevel=='1/2'}">
                                    <option>Res</option>
                                    <option>1/4</option>
                                    <option selected="">1/2</option>
                                    <option>3/4</option>
                                    <option>Full</option>
                                </c:when>
                                <c:when test="${servicedtls.fuellevel=='3/4'}">
                                    <option >Res</option>
                                    <option>1/4</option>
                                    <option>1/2</option>
                                    <option selected=""> 3/4</option>
                                    <option>Full</option>
                                </c:when>
                                <c:when test="${servicedtls.fuellevel=='Full'}">
                                    <option >Res</option>
                                    <option>1/4</option>
                                    <option>1/2</option>
                                    <option>3/4</option>
                                    <option selected="">Full</option>
                                </c:when>
                            </c:choose>


                        </select>
                    </td>
                </tr>

                <tr>
                    <td width="13%" align="left" valign="top">Driver name</td>
                    <td width="26%" align="left" valign="top">
                        <label for="textfield"></label>                        
                        <input type="text" name="drivername" value="${servicedtls.drivername}" />
                    </td>
                    <td width="23%" align="left" valign="top">Driver number</td>
                    <td width="38%" align="left" valign="top">
                        <label for="textfield"></label>
                        <input type="number" name="drivernumber" value="${servicedtls.drivernumber}" />
                    </td>
                </tr>
                <!--                <tr>
                                    <td align="left" valign="top">Licence No.</td>
                                    <td align="left" valign="top"><input type="text" name="licensenumber" id="licensenumber" value="$ {servicedtls.licensenumber}"/></td>
                                    
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
                                <input class="modtabcheckbox" type="checkbox" name="nomicrofilter" value="checked" ${servicedtls.nomicrofilter}/>
                            </td>
                            <td width="23%" align="left" valign="top">Instrument Lighting</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="instrumentlighting" value="checked" ${servicedtls.instrumentlighting}/>
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Steering </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="steering" value="checked" ${servicedtls.steering} />
                            </td>
                            <td width="23%" align="left" valign="top">Micro Filter</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="microfilter" value="checked" ${servicedtls.microfilter} />
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Handbrake </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="handbrake" value="checked" ${servicedtls.handbrake} />
                            </td>
                            <td width="23%" align="left" valign="top">Pedal-noise</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="pedalnoise" value="checked"${servicedtls.pedalnoise} />
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
                                <input class="modtabcheckbox" type="checkbox" name="coolingsystem" value="checked" ${servicedtls.coolingsystem}/>
                            </td>
                            <td width="23%" align="left" valign="top">Brake Fluid</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="brakefluid" value="checked" ${servicedtls.brakefluid}/>
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Steering Fluid </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="steeringfluid" value="checked" ${servicedtls.steeringfluid}/>
                            </td>
                            <td width="23%" align="left" valign="top">V-belt / Poly V-belt</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="vbelt" value="checked" ${servicedtls.vbelt}/>
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Last Inspection </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input type="text" name="lastinspection" id="textfield" placeholder="KM" value="${servicedtls.lastinspection}"/>
                            </td>
                            <td width="23%" align="left" valign="top">Cleanwise</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input type="text" name="cleanwise" id="datepickr" placeholder="Date " value="${servicedtls.cleanwise}"/>
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Noticeable Leaks </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="noticableleaks" value="checked" ${servicedtls.noticableleaks}/>
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
                                <input class="modtabcheckbox" type="checkbox" name="Vcoolingsystem" value="checked" ${servicedtls.Vcoolingsystem}/>
                            </td>
                            <td width="23%" align="left" valign="top">Wiper Blades</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="wiperblades" value="checked" ${servicedtls.wiperblades}/>
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Window Glass </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="windowglass" value="checked" ${servicedtls.windowglass}/>
                            </td>
                            <td width="23%" align="left" valign="top">Body</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="body" value="checked" ${servicedtls.body}/>
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
                                <input class="modtabcheckbox" type="checkbox" name="headlights" value="checked" ${servicedtls.headlights}/>
                            </td>
                            <td width="23%" align="left" valign="top">Shockabsorber</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="shockabsorber" value="checked" ${servicedtls.shockabsorber}/>
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Tyre Tread </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="tyretread" value="checked" ${servicedtls.tyretread}/>
                            </td>
                            <td width="23%" align="left" valign="top">Front Brake pads / Discs</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="frontbrake" value="checked" ${servicedtls.frontbrake}/>
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Brake Lines / Hoses </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="hoses" value="checked" ${servicedtls.hoses}/>
                            </td>
                            <td width="23%" align="left" valign="top">Rear Brake Pads / Discs</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="rearbrake" value="checked" ${servicedtls.rearbrake}/>
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
                                <input class="modtabcheckbox" type="checkbox" name="exhaustsystem" value="checked" ${servicedtls.exhaustsystem}/>
                            </td>
                            <td width="23%" align="left" valign="top">Rear Axle</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="rearaxle" value="checked" ${servicedtls.rearaxle}/>
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Gear Box / Leaking </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="gearbox" value="checked" ${servicedtls.gearbox}/>
                            </td>
                            <td width="23%" align="left" valign="top">Fuel Tank / Lines</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="fueltank" value="checked" ${servicedtls.fueltank}/>
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Cooling System </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="Vfullyraisedcoolingsystem" value="checked" ${servicedtls.Vfullyraisedcoolingsystem}/>
                            </td>
                            <td width="23%" align="left" valign="top">Final Drive / Leaking</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="finaldrive" value="checked" ${servicedtls.finaldrive}/>
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Front Axle </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="frontaxle" value="checked" ${servicedtls.frontaxle}/>
                            </td>
                            <td width="23%" align="left" valign="top">Engine Leaks</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="engineleaks" value="checked" ${servicedtls.engineleaks}/>
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
                                <input class="modtabcheckbox" type="checkbox" name="carwashcoolingsystem" value="checked" ${servicedtls.carwashcoolingsystem}/>
                            </td>
                            <td width="23%" align="left" valign="top">Exterior Polish</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="exteriorpolish" value="checked" ${servicedtls.exteriorpolish}/>
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Interior Cleaning </td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="interiorcleaning" value="checked" ${servicedtls.interiorcleaning}/>
                            </td>
                            <td width="23%" align="left" valign="top">Wheel Rim Cleaning</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="wheelrimcleaning" value="checked" ${servicedtls.wheelrimcleaning}/>
                            </td>
                        </tr>
                        <tr>
                            <td width="13%" align="left" valign="top">Body Protection</td>
                            <td width="26%" align="left" valign="top">
                                <label for="textfield"></label>                        
                                <input class="modtabcheckbox" type="checkbox" name="bodyprotection" value="checked" ${servicedtls.bodyprotection}/>
                            </td>
                            <td width="23%" align="left" valign="top">Anti-Rust Treatment</td>
                            <td width="38%" align="left" valign="top">
                                <label for="textfield"></label>
                                <input class="modtabcheckbox" type="checkbox" name="antirust" value="checked" ${servicedtls.antirust}/>
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
                                <textarea name="additionalwork" cols="100" rows="10">${servicedtls.additionalwork}</textarea>
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
                <INPUT type="submit" value="Update" class="view3" style="cursor: pointer"/>&nbsp;&nbsp;
            </center> 
            <input type="hidden" name="id" value="${servicedtls.cvid}" />
            <input type="hidden" name="cvdid" value="${servicedtls.cvdid}" />
        </form>
    </body>
</html>
