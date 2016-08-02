<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : AddEstimate
    Created on : 27-Apr-2015, 17:17:18
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Estimate</title>
        <link href="css/csstable.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="css/jquery-ui.css" />
        <script src="js/jquery-1.8.3.js" type="text/javascript"></script>
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <SCRIPT language="javascript">
                    //add rows
                            function addRow(tableID) {
                                if (tableID === "dataTable") {
                                    $('#' + tableID + '').append('<tr><td align="left" valign="top"><INPUT type="checkbox" class="test" name="chk"/><input type="hidden" name="part_type" value="part" /><input type="hidden" name="partlistid" id="partlistid" /></td><td align="left" valign="top"><input name="partname" type="text" id="partname" /></td><td align="left" valign="top"> <select name="fivePrice" class="fivePrice" style="width: 100px" onchange="iambatman(this)"><option selected="" disabled="">--select--</option></select></td><td align="left" valign="top"><textarea name="description" maxlength="1000" id="textfield2">description..</textarea></td><td align="left" valign="top"><input name="quantity" type="number" class="quantity" style="width: 60px" value="1" onchange="calculatebalance(this)" onclick="calculatebalance(this)" /></td><td align="left" valign="top"><input name="partrs" style="width: 60px" type="number" step="0.01" required="" class="sellingprice" onchange="calculatebalance(this)" onclick="calculatebalance(this)" /></td><td align="left" valign="top"><input name="labourrs" style="width: 60px" type="number" step="0.01" id="textfield6" /></td><td align="left" valign="top"><input name="totalpartrs" readonly="" type="number" class="itemtotal" style="width: 100px"/></td></tr>');
                                } else {
                            $('#' + tableID + '').append('<tr><td align="left" valign="top"><INPUT type="checkbox" name="chk"/><input type="hidden" name="labour_type" value="service" /><input type="hidden" name="serviceid" value="" id="serviceid"/><input type="hidden" name="serviceAction" class="serviceAction"/></td><td align="left" valign="top"><input name="servicename" type="text" id="labour" /></td><td align="left" valign="top"><textarea name="labourdescription" class="labourdescription" id="textfield2">description..</textarea></td><td align="left" valign="top"><input name="servicetotal" type="text" class="charges" /></td></tr>');
                            }
                        }

                    //car parts autocomplete
                    var partlist;
                            $(function () {
                            partlist = [
            <c:forEach var="oba" items="${partdtls}">
                            {value: "${oba.id}", label: "${oba.name}"},
            </c:forEach>
                            ];
                                    var source = [];
                                    var mapping = {};
                                    for (var i = 0; i < partlist.length; ++i) {
                            source.push(partlist[i].label);
                                    mapping[partlist[i].label] = partlist[i].value;
                            }
                            $("input:text[id^='partname']").live("focus.autocomplete", null, function () {
                            var curr = $(this);
                                    $(this).autocomplete({
                            source: source,
                                    select: function (event, ui) {
                                    curr.closest('tr').find("#partlistid").val(mapping[ui.item.value]);
                                    }
                            });
                            });
                            });
                            //function to delete rows
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

                            //car parts item name auto complete will come based on car model
                            var carparts = [];
                                    $(function () {

                                    $("input:text[id^='partname']").live("focus.autocomplete", null, function () {
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
                                            a.closest('tr').find('#partlistid').val(mapping[ui.item.value]);
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
                                                    var partid = a.closest('tr').find("#partlistid").val();
                                                    $.ajax({
                                                    url: "getLastFivePricesEstimate",
                                                            dataType: 'json',
                                                            type: 'POST',
                                                            data: {
                                                            id: partid
                                                            },
                                                            success: function (data) {
                                                            if (data)
                                                            {
                                                            currentelement.closest('tr').find('.fivePrice').append('<option value="" disabled selected>--select--</option>');
                                                                    for (var i = 0; i < data.length; i++)
                                                            {
                                                            currentelement.closest('tr').find('.fivePrice').append('<option value="' + data[i].maxprice + '">' + data[i].maxprice + '</option>');
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
                                    //ajax to get max selling price of mfg id
                                            function iambatman(a) {
                                            //getting all the required inputs
                                            var amountselected = $(a).val();
                                                    var quantity = $(a).closest('tr').find('.quantity').val();
                                                    var partid = $(a).closest('tr').find('#partlistid').val();
                                                    $(a).closest('tr').find('.sellingprice').val("0");
                                                    //computing the inputs

                                                    $(a).closest('tr').find('.sellingprice').val(amountselected);
                                                    var finalpartrs = amountselected * quantity;
                                                    $(a).closest('tr').find('.itemtotal').val(finalpartrs);
                                                    //end of computing
                                            }

                                    //calculate total part price
                                    function calculatebalance(b) {
                                    var qty = Number($(b).closest('tr').find('.quantity').val());
                                            var percost = Number($(b).closest('tr').find('.sellingprice').val());
                                            var totalprice = qty * percost;
                                            $(b).closest('tr').find('.itemtotal').val(totalprice);
                                    }
                                    
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
                            curr.closest('tr').find('option').remove();
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
                                                curr.closest('tr').find('.labourdescription').val(data[i].description);
                                                curr.closest('tr').find('.charges').val(data[i].rate);
                                            }
                                            var servicename=curr.closest('tr').find("#labour").val(); // display the selected text 
                                            curr.closest('tr').find(".serviceAction").val(servicename);                                            
                                        }
                                    }, error: function () {
                                    }
                                }); 
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
                                                currentelement.closest('tr').find('.labourdescription').val(data[i].description);
                                                currentelement.closest('tr').find('.charges').val(data[i].rate);
                                            }
                                            var servicename=currentelement.closest('tr').find("#labour").val(); // display the selected text 
                                            currentelement.closest('tr').find(".serviceAction").val(servicename);                                            
                                        }
                                    }, error: function () {
                                    }
                                });
                            }
                        }
                    });
                });
            });

                                    $(document).ready(function () {
            
                                    $('form').submit(function(){
                                        $("#iamsubmit").prop('disabled', true);
                                    });
                                    
                                    $(".tabspecific").each(function (i) { $(this).attr('tabindex', i + 1); });


                                    //customer vehicle model auto complete
                                    var vehicleid = $("#vehicleid").val();
//                                            alert("ready" + vehicleid);
                                            if(vehicleid){
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
                                    });
                                                                        </SCRIPT>
    </head>
    <body>
        <input type="hidden" name="estimatestatus" id="estimatestatus" value="${param.ises}" />
        <c:choose>
            <c:when test="${param.ises=='Yes'}">
                <h2>Estimate already!! created for this 180 point.</h2>
            </c:when>
            <c:otherwise>
                
                <form action="insertestimate" method="post">
                    <input type="hidden" name="cvid" value="${pcldtncustdt.cvid}" />
                    <a href="180pointchecklistgridlink" class="view">Back</a>
                    <!--<a href="#" class="view" style="margin-right:10px;">Email</a>-->
                    <h2>Estimate</h2>
                    <br />
                    <table width="100%" cellpadding="5">
                        <input type="hidden" name="" id="vehicleid" value="${pcldtncustdt.branddetailid}" />
                        <tr>
                            <td align="left" valign="top">Date</td>
                            <td align="left" valign="top">${pcldtncustdt.pcldate}</td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">180 Point id</td>
                            <td align="left" valign="top">${pcldtncustdt.id} <input type="hidden" name="pclid" value="${pcldtncustdt.id}" /> </td>
                        </tr>
                        <tr>
                            <td width="31%" align="left" valign="top">Customer name</td>
                            <td width="69%" align="left" valign="top"><label for="textfield"></label>
                                ${pcldtncustdt.name}</td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">Vehicle Model</td>
                            <td align="left" valign="top">${pcldtncustdt.carmodel}<input type="hidden" name="vehicletype" id="vehicletype" value="${pcldtncustdt.labourChargeType}" /></td>
                        </tr>
                        <tr>
                            <td>Vehicle Number</td>
                            <td>${pcldtncustdt.vehiclenumber}</td>
                        </tr>
                        <tr>
                            <td>Additional work</td>
                            <td>
                                <c:choose>
                                    <c:when test="${empty pcldtncustdt.additionalwork}">
                                        N/A
                                    </c:when>
                                    <c:otherwise>
                                        ${pcldtncustdt.additionalwork}                                        
                                    </c:otherwise>
                                </c:choose>                                
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>

                    <hr> 

                    <TABLE id="dataTable" border="0" class="CSSTableGenerator">
                        <TR>
                            <TD width="8%" align="left">&nbsp;</TD>
                            <td width="39%" align="left"><strong>Name</strong></td>                
                            <TD width="25%" align="center"><strong>Last 5 prices.</strong></TD>
                            <TD width="25%" align="center"><strong>Description</strong></TD>
                            <TD width="25%" align="center"><strong>Qty.</strong></TD>
                            <TD width="25%" align="center"><strong>per item</strong></TD>
                            <TD width="28%" align="center"><strong>Labour Rs.</strong></TD>
                            <TD width="25%" align="center"><strong>Part Rs.</strong></TD>
                        </TR>
                        <c:forEach var="ob" items="${partlistdtls}">
                            <tr>
                                <td align="left" valign="top"><INPUT type="checkbox" class="test" name="chk"/><input type="hidden" name="part_type" value="part" /><input type="hidden" name="partlistid" id="partlistid" value="${ob.partlistid}" /></td>
                                <td align="left" valign="top"><input name="partname" value="${ob.partname}" type="text" id="partname" /></td>
                                <td align="left" valign="top"> 
                                    <select name="fivePrice" class="fivePrice" style="width: 100px" onchange="iambatman(this)">
                                        <option selected="" disabled="">--select--</option>
                                        <c:forEach var="obb" items="${ob.listofPrice}">
                                            <option value="${obb.maxprice}">${obb.maxprice}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td align="left" valign="top"><textarea name="description" maxlength="1000" id="textfield2">description..</textarea></td>
                                <td align="left" valign="top"><input name="quantity" type="number" class="quantity tabspecific" style="width: 60px" value="1" onchange="calculatebalance(this)" onclick="calculatebalance(this)" /></td>
                                <td align="left" valign="top"><input name="partrs" type="number" step="0.01" class="sellingprice tabspecific" required="" style="width: 60px" onchange="calculatebalance(this)" onclick="calculatebalance(this)" /></td>
                                    <c:choose>
                                        <c:when test="${pcldtncustdt.labourChargeType=='a'}">
                                        <td align="left" valign="top"><input name="labourrs" style="width: 60px" type="number" step="0.01" class="tabspecific" value="0" id="textfield6" /></td>
                                        </c:when>
                                        <c:when test="${pcldtncustdt.labourChargeType=='b'}">
                                        <td align="left" valign="top"><input name="labourrs" style="width: 60px" type="number" step="0.01" class="tabspecific" value="0" id="textfield6" /></td>
                                        </c:when>
                                        <c:when test="${pcldtncustdt.labourChargeType=='c'}">
                                        <td align="left" valign="top"><input name="labourrs" style="width: 60px" type="number" step="0.01" class="tabspecific" value="0" id="textfield6" /></td>
                                        </c:when>
                                        <c:otherwise>
                                        <td align="left" valign="top"><input name="labourrs" style="width: 60px" type="number" step="0.01" class="tabspecific" value="0" id="textfield6" /></td>
                                        </c:otherwise>
                                    </c:choose>
                                <td align="left" valign="top"><input name="totalpartrs" readonly="" type="number" class="itemtotal" style="width: 100px"/></td>
                            </tr>
                        </c:forEach>
                    </TABLE>
                    <!--<div style="float:right; margin-right:80px; margin-top:10px; font-size:16px"><strong>TOTAL: 3000/-</strong></div>-->
                    <div>
                        <INPUT type="button" value="Add Product" onclick="addRow('dataTable')"  class="view3"/>
                        <INPUT type="button" value="Delete Selected" onclick="deleteRow('dataTable')"  class="view3"/>
                    </div>  

                    <br />
                    <TABLE id="dataTable1" border="0" class="CSSTableGenerator">
                        <TR>
                            <TD width="4%" align="left">&nbsp;</TD> 
                            <td width="24%" align="left"><strong>Service Name</strong></td>
                            <TD width="23%" align="center"><strong>Description</strong></TD>
                            <TD width="23%" align="center"><strong>Labour Rs.</strong></TD>
                        </TR>
                        <tr>
                            <td align="left" valign="top"><INPUT type="checkbox" name="chk"/><input type="hidden" name="labour_type" value="service" /><input type="hidden" name="serviceid" value="" id="serviceid"/><input type="hidden" name="serviceAction" class="serviceAction"/></td>
                            <td align="left" valign="top"><input name="servicename" type="text" id="labour" /></td>
                            <td align="left" valign="top"><textarea name="labourdescription" class="labourdescription" id="textfield2">description..</textarea></td>
                            <td align="left" valign="top"><input name="servicetotal" type="text" class="charges" /></td>
                        </tr>
                    </TABLE>
                    <div>
                        <INPUT type="button" value="Add Labour" onclick="addRow('dataTable1')"  class="view3"/>
                        <INPUT type="button" value="Delete Selected" onclick="deleteRow('dataTable1')"  class="view3"/></div>  
                    <br>
                    <center>
                        <input type="submit" value="Save" class="view3" id="iamsubmit" style="cursor: pointer"/>
                    </center>

                    <br />
                </form>
            </c:otherwise>
        </c:choose>
    </body>
</html> 

