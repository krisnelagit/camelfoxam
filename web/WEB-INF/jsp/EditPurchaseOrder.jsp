<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : EditPurchaseOrder
    Created on : 27-May-2015, 13:17:46
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Purchase Order</title>
        <link href="css/csstable.css" rel="stylesheet" type="text/css" /> 
        <script src="js/jquery-1.8.3.js" type="text/javascript"></script>
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        <link href='css/jquery.qtip.css' rel='stylesheet' />
        <script src='js/jquery.qtip.min.js'></script>
        <script>

            $(document).ready(function () {
                var sourcek = [];
                var mappingk = {};
                $(function () {
                    var currentDate = new Date();
                    $(".datepicker").datepicker({dateFormat: 'yy-mm-dd'});
                    $(".datepicker").datepicker("option", "showAnim", 'drop');
                    $(".datepicker").datepicker("setDate", currentDate);
                });

                //car parts item name auto complete will come based on model
//                var carparts = [];
                $(function () {

                    $("input:text[id^='carparts']").live("focus.autocomplete", null, function () {


                        var a = $(this);
                        $(this).autocomplete({
                            source: sourcek,
                            select: function (event, ui) {
                                a.closest('tr').find('#prdid').val(mappingk[ui.item.value]);

                                //for tab key to work edited from here
                                var TABKEY = 9;
                                this.value = ui.item.value;

                                if (event.keyCode == TABKEY) {
                                    event.preventDefault();
                                    this.value = this.value + " ";
                                    $('#carparts').focus();
                                }

                                return false;
//                            $("#prdid").val(mapping[ui.item.value]); // display the selected text
//                                        $("#txtAllowSearchID").val(ui.item.value); // save selected id to hidden input
                            },
                            change: function () {

                                var currentelement = $(this);
                                var val = $(this).val();
                                var exists = $.inArray(val, sourcek);
                                if (exists < 0) {
                                    $(this).val("");
                                    return false;
                                } else {
                                    currentelement.closest('tr').find('.manufacturer').val('');
                                    currentelement.closest('tr').find('.mfgnames').val('');
                                }
                            }
                        }).focus(function () {
                            $(this).autocomplete('search');
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

                    $("input:text[class^='vehicle']").live("focus.autocomplete", null, function () {
                        var curr = $(this);
                        $(this).autocomplete({
                            source: source,
                            select: function (event, ui) {

                                curr.closest('tr').find('.vehicleid').val(mapping[ui.item.value]);



                            },
                            change: function () {

//                            var currentelement = $(this);
                                var val = $(this).val();
                                var exists = $.inArray(val, source);
                                if (exists < 0) {
                                    $(this).val("");
                                    return false;
                                } else {
                                    var vehicleid = curr.closest('tr').find('.vehicleid').val();
                                    $.ajax({
                                        url: "getpartdata",
                                        type: 'POST',
                                        dataType: 'json',
                                        data: {
                                            id: vehicleid
                                        }, success: function (data) {
                                            if (data) {

                                                sourcek.length = 0;
                                                mappingk.length = 0;
                                                curr.closest('tr').find('#carparts').val("");
                                                curr.closest('tr').find('.costprice').val("");
                                                curr.closest('tr').find('.sellingprice').val("");
                                                curr.closest('tr').find('.quantity').val("");
                                                curr.closest('tr').find('.itemtotal').val("");

                                                for (var i = 0; i < data.length; ++i) {
                                                    sourcek.push(data[i].partname);
                                                    mappingk[data[i].partname] = data[i].id;
                                                }


                                                vehicle.length = 0;
                                            }
                                        }, error: function (jqXHR) {
                                            alert('error at services');
                                        }
                                    });
                                }

                            }
                        }).focus(function () {
//                            $('#carparts').autocomplete('search');
                        });
                    });
                });

                //manufactuer coding beign here
                var manufactuer;
                $(function () {
                    manufactuer = [
            <c:forEach var="ob" items="${manufacturerdtls}">
                        {value: "${ob.id}", label: "${ob.name}"},
            </c:forEach>
                    ];

                    var source = [];
                    var mapping = {};

                    for (var i = 0; i < manufactuer.length; ++i) {
                        source.push(manufactuer[i].label);
                        mapping[manufactuer[i].label] = manufactuer[i].value;
                    }

                    $("input:text[class^='mfgnames']").live("focus.autocomplete", null, function () {
                        var curr = $(this);
                        $(this).autocomplete({
                            source: source,
                            select: function (event, ui) {

                                curr.closest('tr').find('.manufacturer').val(mapping[ui.item.value]);
                                $('.manufacturer').trigger("change");

                            }
                        });
                    });

                });
                //manufacturer coding end here


                //calling vendo dt to get vandor payment terms
                $("#selectedvendor").change(function () {
                    var vendorid = $(this).val();
                    $.ajax({
                        url: "getVendorDetailsurl",
                        dataType: 'json',
                        type: 'POST',
                        data: {
                            vendorid: vendorid
                        },
                        success: function (data) {
                            if (data) {
                                $("#paymentterms").val(data[0].paymentterms);
                            }
                        }, error: function () {
                        }
                    });
                });
                //end of calling payment terms

            });
        </script>
        <script>
            //ajax to get max selling price of mfg id
            function iambatman(a) {
                var mfgname = $(a).val();
                var partid = $(a).closest('tr').find('#prdid').val();
                $.ajax({
                    type: 'post',
                    url: 'pricelist',
                    data: {
                        mfgid: mfgname, partid: partid
                    },
                    success: function (data) {
                        if (data != "no") {
                            $(a).closest('tr').find('.costprice').val(data);
                            var sp = Number(data) * 30 / 100;
                            var finalsp = Number(sp) + Number(data);
                            $(a).closest('tr').find('.sellingprice').val(finalsp);
                        }
                    },
                    error: function () {
                    }
                });
            }

            //ajax to get previous selling price of mfg id for partid
            function previousrates(a) {
                var curr = $(this);
                var mfgname = $(a).val();

                var partid = $(a).closest('tr').find('#prdid').val();
                var vendorid = $('#selectedvendor').val();
                $.ajax({
                    url: 'pricelistvendorwisehistory',
                    dataType: 'json',
                    type: 'post',
                    data: {
                        mfgid: mfgname, partid: partid, vendorid: vendorid
                    },
                    success: function (data) {
                        if (data) {
                            var t = "<table><tr><th>Selling</th><th>QTY.</th><th>Date</th></tr>";
                            for (var i = 0; i < data.length; i++) {
                                t = t + "<tr><td>" + data[i].sellingprice + "</td><td>" + data[i].quantity + "</td><td>" + data[i].modifydate + "</td></tr>";
                            }
                            t = t + "</table>";


                            $(a).closest('tr').find('.history').qtip({
                                content: {
                                    text: t,
                                    title: function (event, api) {
                                        return $(this).attr('alt');
                                    }
                                }
                            });

                        }
                    },
                    error: function () {
                        
                    }
                });
            }

            //ajax to get previous selling price of mfg id for partid
            function previouspartsrates(a) {
                var curr = $(this);
                var mfgname = $(a).val();

                var partid = $(a).closest('tr').find('#prdid').val();
                $.ajax({
                    url: 'pricelistpartwisehistory',
                    dataType: 'json',
                    type: 'post',
                    data: {
                        mfgid: mfgname, partid: partid
                    },
                    success: function (data) {
                        if (data) {
                            var t = "<table><tr><th>Selling</th><th>QTY.</th><th>Date</th></tr>";
                            for (var i = 0; i < data.length; i++) {
                                t = t + "<tr><td>" + data[i].sellingprice + "</td><td>" + data[i].quantity + "</td><td>" + data[i].modifydate + "</td></tr>";
                            }
                            t = t + "</table>";


                            $(a).closest('tr').find('.Parthistory').qtip({
                                content: {
                                    text: t,
                                    title: function (event, api) {
                                        return $(this).attr('alt');
                                    }
                                }
                            });

                        }
                    },
                    error: function () {
                        
                    }
                });
            }



            //calculate total part price on quantity change
            function calculatebalance(b) {
                var tmp;
                var quantitycount = 0;
                var quantity = $(b).val();
                var amount = $(b).closest('tr').find('.costprice').val();
                tmp = quantity * amount;
                $(b).closest('tr').find('.itemtotal').val(tmp);

                var table = document.getElementById("dataTable");
                var rowCount = table.rows.length;
                //calculates final total of spareparts and inside is calulation of vat tax
                for (var i = 1; i < rowCount; i++) {
                    var row = table.rows[i];
                    var qty = row.cells[7].childNodes[0];
                    quantitycount = Number(quantitycount) + Number(qty.value);
                    $("#sparepartsfinal").val(quantitycount);

                    //calculates vat percentage
                    var taxpercent = $("#taxes").val();
                    var myvat = Number(quantitycount) * Number(taxpercent / 100);
                    $("#taxamount").val(myvat.toFixed(2));
                }
                quantitycount = 0;
            }

            //calculate total part price on quantity change
            function calculatebalanceonCostPrice(b) {
                var tmp;
                var quantitycount = 0;
                var amount = $(b).val();
                var quantity = $(b).closest('tr').find('.quantity').val();
                tmp = quantity * amount;
                $(b).closest('tr').find('.itemtotal').val(tmp);

                var table = document.getElementById("dataTable");
                var rowCount = table.rows.length;
                //calculates final total of spareparts and inside is calulation of vat tax
                for (var i = 1; i < rowCount; i++) {
                    var row = table.rows[i];
                    var qty = row.cells[7].childNodes[0];
                    quantitycount = Number(quantitycount) + Number(qty.value);
                    $("#sparepartsfinal").val(quantitycount);

                    //calculates vat percentage
                    var taxpercent = $("#taxes").val();
                    var myvat = Number(quantitycount) * Number(taxpercent / 100);
                    $("#taxamount").val(myvat.toFixed(2));
                }
                quantitycount = 0;
                var cp = $(b).closest('tr').find('.costprice').val();
                var sp = Number(cp) * 30 / 100;
                var finalsp = Number(sp) + Number(cp);
                $(b).closest('tr').find('.sellingprice').val(finalsp.toFixed(2));
            }

            function addRow(tableID) {
                $('#' + tableID + '').append('<tr><td align="left" valign="top"><INPUT type="checkbox" name="chk"/><input type="hidden" name="partid" value="" id="prdid"/></td><td align="left" valign="top"><input name="vehiclemodel" type="text" class="vehicle" /><input type="hidden" name="branddetailid" class="vehicleid" /></td><td align="left" valign="top"><input name="carparts" type="text" id="carparts" /></td><td align="left" valign="top"><input type="hidden" name="manufacturerid" class="manufacturer" value="" onchange="iambatman(this);previousrates(this);previouspartsrates(this);" /><input type="text" name="mfgname" class="mfgnames" /></td><td align="left" valign="top"><input name="costprice" type="text" class="costprice" onchange="calculatebalanceonCostPrice(this)" onclick="calculatebalanceonCostPrice(this)" style="width: 65px"/>&nbsp;&nbsp;<a href="#" alt="*Vendorwise Price history" class="history"><img src="images/helmet6.png" width="18" height="13" /></a>&nbsp;&nbsp;<a href="#" alt="*Partwise Price history" class="Parthistory"><img src="images/gear39.png" width="16" height="13" /></a></td><td align="left" valign="top"><input name="sellingprice" type="text" class="sellingprice" style="width: 65px"/></td><td align="left" valign="top"><input name="partQuantity"  type="number" max="999999" class="quantity" style="width: 45px" onchange="calculatebalance(this)" onclick="calculatebalance(this)" /></td><td align="left" valign="top"><input name="itemtotal" readonly="" type="number" value="0" class="itemtotal" style="width: 100px"/></td></tr>');
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

            //give grand total
            function getGrandTotal() {
                var mytotal = Number($('#taxamount').val()) + Number($('#sparepartsfinal').val());
                $('#finaltotal').val(mytotal.toFixed(2));
            }

            //gives tax calulation on change of tax
            function taxchange() {
                //calculates vat percentage
                var taxpercent = $("#taxes").val();
                var quantitycount = $("#sparepartsfinal").val();
                var myvat = Number(quantitycount) * Number(taxpercent / 100);
                $("#taxamount").val(myvat.toFixed(2));
            }


        </script>
    </head>
    <body>
        <a href="PurchaseOrderGridLink" class="view">Back</a>
        <h2>Purchase Order Edit</h2>
        <br />
        <form action="editPurchaseOrder" method="POST"> 
            <input type="hidden" name="id" value="${purchasedetailsdt.id}" />
            <input type="hidden" name="purchaseorderid" value="${purchasedetailsdt.id}" />
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Branch</td>
                    <td width="66%" align="left" valign="top">
                        <select name="branchid" id="branchid">
                            <c:forEach var="obb" items="${branchdtls}">
                                <c:choose>
                                    <c:when test="${obb.id==purchasedetailsdt.branchid}">
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
                    <td width="34%" align="left" valign="top">Date</td>
                    <td width="66%" align="left" valign="top"><input required class="datepicker" value="${purchasedetailsdt.date}" type="text" name="date" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Vendor name</td>
                    <td width="66%" align="left" valign="top">
                        <select name="vendorid" id="selectedvendor">
                            <c:forEach var="obb" items="${vendordt}">
                                <c:choose>
                                    <c:when test="${obb.id==purchasedetailsdt.vendorid}">
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
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>

            <c:forEach var="obd" items="${purchaseorderdetailsdt}">
                <input type="hidden" name="allpodids" value="${obd.id}" />
            </c:forEach>
            <TABLE id="dataTable" border="0" class="CSSTableGenerator">
                <TR>
                    <TD width="" align="left">&nbsp;</TD>
                    <td width="" align="center"><strong>Vehicle Model</strong></td>
                    <td width="" align="center"><strong>Car part name</strong></td>
                    <td width="" align="center"><strong>MFG.</strong></td>
                    <TD width="" align="center"><strong>Cost Price</strong></TD>
                    <TD width="" align="center"><strong>Selling Price</strong></TD>
                    <TD width="" align="center"><strong>QTY.</strong></TD>
                    <TD width="" align="center"><strong>Amount</strong></TD>
                </TR>
                <c:forEach var="obd" items="${purchaseorderdetailsdt}">
                    <tr>
                        <td align="left" valign="top"><INPUT type="checkbox" class="serviceloopcount" name="chk"/><input type="hidden" id="oldpartid" name="oldpartid" value="${obd.partid}" id="prdid"/><input type="hidden" name="oldpodsid" value="${obd.id}" /></td>
                        <td align="left" valign="top"><input name="oldvehiclemodel" readonly="" type="text" value="${obd.vehiclename}" class="vehicle" /><input type="hidden" value="${obd.branddetailid}" name="oldbranddetailid" class="vehicleid" /></td>
                        <td align="left" valign="top"><input name="carparts" readonly="" value="${obd.partname}" type="text" id="carparts" /></td>
                        <td align="left" valign="top">
                            <input type="hidden" name="oldmanufacturerid" class="manufacturer" value="${obd.manufacturerid}" onchange="iambatman(this);
                                    previousrates(this);
                                    previouspartsrates(this);" />
                            <input type="text" name="mfgname" value="${obd.mfgname}" readonly="" class="mfgnames" />
                        </td>
                        <td align="left" valign="top"><input name="oldcostprice" value="${obd.costprice}" type="text" readonly="" class="costprice" onchange="calculatebalanceonCostPrice(this)" onclick="calculatebalanceonCostPrice(this)" style="width: 65px"/></td>
                        <td align="left" valign="top"><input name="oldsellingprice" value="${obd.sellingprice}" type="text" readonly="" class="sellingprice" style="width: 65px"/></td>
                        <td align="left" valign="top"><input name="oldpartQuantity" type="number" max="999999" class="quantity" value="${obd.partQuantity}" readonly="" style="width: 45px" onchange="calculatebalance(this)" onclick="calculatebalance(this)" /></td>                        
                        <td align="left" valign="top"><input name="olditemtotal" readonly="" value="${obd.itemtotal}" type="number" value="0" class="itemtotal" style="width: 100px"/></td>
                    </tr>
                </c:forEach>
            </TABLE>
            Spare parts Total :    <input name="oldsparepartsfinal" readonly="" value="0" type="text" id="sparepartsfinal" />
            <div>
                <INPUT type="button" value="Add Product" onclick="addRow('dataTable')"  class="view3"/>
                <INPUT type="button" value="Delete Selected" onclick="deleteRow('dataTable');
                        calculatebalance(this)"  class="view3"/>
            </div>  
            <br>

            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Tax type</td>
                    <td width="66%" align="left" valign="top">
                        <input type="hidden" name="tax" id="taxes" value="${taxdt.percent}" />${taxdt.name}
                        <input type="hidden" name="taxid" id="taxid" value="${taxdt.id}" />
                    </td>
                </tr>
                <tr>    
                    <td>Tax amount</td>
                    <td>
                        <input  type="number" step="0.01" min="0" readonly="" id="taxamount" name="taxamount" value="${purchasedetailsdt.taxamount}" />
                        <input type="hidden" name="finaltotal" value="${purchasedetailsdt.finaltotal}" id="finaltotal" />                        
                        <input type="hidden" id="paymentterms" name="paymentterms" value="${purchasedetailsdt.paymentterms}" />
                    </td>
                </tr>
                <tr>    
                    <td>Comment</td>
                    <td>
                        <textarea name="comment" rows="4" maxlength="1000" cols="20">${purchasedetailsdt.comment}
                        </textarea>
                    </td>
                </tr>
                <tr>    
                    <td>&nbsp;</td>
                    <td><input type="submit" value="Update" class="view3" style="cursor: pointer" onclick="getGrandTotal();" /></td>
                </tr>
            </table>
        </form>
    </body>
</html>
