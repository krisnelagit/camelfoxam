<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : AddConsumable
    Created on : 24-Sep-2015, 12:46:34
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Paints</title>
        <link href="css/csstable.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="css/jquery-ui.css" />
        <script src="js/jquery-1.8.3.js" type="text/javascript"></script>
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <script>

            $(document).ready(function () {
                
            });
            
            //function to calulate total amount
            function calculateamount(b){
                $(b).closest('tr').find('.quantity').trigger("change");
            }

            //add rows
            function addRow(tableID) {
                $('#' + tableID + '').append('<tr><td align="left" valign="top"><INPUT type="checkbox" name="chk"/><input type="hidden" name="partid" value="" id="prdid"/></td><td align="left" valign="top"><input name="carparts" required="" type="text" id="carparts" /></td><td align="left" valign="top"><select name="manufacturerid" class="manufacturer" required="" style="width: 100px" onchange="iambatman(this)"><option value="">--select--</option><option></option></select></td><td align="left" valign="top"><input name="quantity" min="0" required="" type="number" class="quantity" style="width: 45px" onchange="calculatebalance(this)" onclick="calculatebalance(this)" /></td><td align="left" valign="top"><input name="sellingprice" required="" onchange="calculateamount(this);" type="number" class="sellingprice" style="width: 100px"/></td><td align="left" valign="top"><input name="total" readonly="" type="number" value="0" class="itemtotal" style="width: 100px"/></td></tr>');
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

            //code for parts autocomplete begin here
            var carparts = [
            <c:forEach var="ob" items="${consumablepartdt}">
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

//            var vehicleid = "$ {jsuserdtls.branddetailid}";
//            $.ajax({
//                url: "getconsumabledata",
//                type: 'POST',
//                dataType: 'json',
//                data: {
//                    id: vehicleid
//                }, success: function (data) {
//                    if (data) {
//                        for (var i = 0; i < data.length; i++) {
//                            carparts.push({
//                                value: "" + data[i].id + "",
//                                label: "" + data[i].partname + ""
//                            });
//                        }
//                    }
//                }, error: function (jqXHR) {
//                    alert('error at services');
//                }
//            });

            //code on manufacture select begin here
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
                $(".quantity").trigger("change");
            }
            //custom calculate balance
            function calculatebalance(b) {
                //calculate item total amount begin here
                var quantity = $(b).val();
                var amount = $(b).closest('tr').find('.sellingprice').val();
                var tmp = quantity * amount;
                var quantitycount = 0;
                $(b).closest('tr').find('.itemtotal').val(tmp);
                //calculate item total amount ends! here
                
                //calculate grand total begin
                var table = document.getElementById("dataTable");
                var rowCount = table.rows.length;
                
                for (var i = 1; i < rowCount; i++) {
                    var row = table.rows[i];
                    var qty = row.cells[5].childNodes[0];
                    quantitycount = Number(quantitycount) + Number(qty.value);
                    $("#sparepartsfinal").val(quantitycount);
                }
                quantitycount = 0;
                
            }
        </script>
    </head>
    <body>  
        <a href="viewSpareRequisitionGrid" class="view">Back</a>      
        <h2>Paints</h2>
        <br />
        <form action="saveConsumable" method="POST">
            <input type="hidden" name="myjsid" value="${param.jsid}" />
            <table width="100%" cellpadding="5">
                <tr>
                    <td align="left" valign="top">Date</td>
                    <td align="left" valign="top">${jsuserdtls.custdate}</td>
                </tr>
                <tr>
                    <td align="left" valign="top">Job No.</td>
                    <td align="left" valign="top">${jsuserdtls.jobno} <input type="hidden" name="jobno" value="${estcustdtls.jobno}" /> </td>
                </tr>
                <tr>
                    <td width="31%" align="left" valign="top">Customer name</td>
                    <td width="69%" align="left" valign="top"><label for="textfield"></label>
                        ${jsuserdtls.custname}</td>
                </tr>
                <tr>
                    <td align="left" valign="top">Vehicle Make</td>
                    <td align="left" valign="top">${jsuserdtls.carbrand}</td>
                </tr>
                <tr>
                    <td>License Number</td>
                    <td>${jsuserdtls.licensenumber}</td>
                </tr>
                <tr>
                    <td>VIN No.</td>
                    <td>${jsuserdtls.vinnumber}</td>
                </tr>
            </table>

            <TABLE id="dataTable" border="0" class="CSSTableGenerator">
                <TR>
                    <TD width="" align="left">&nbsp;</TD>
                    <td width="" align="center"><strong>Part</strong></td>
                    <td width="" align="center"><strong>MFG.</strong></td>
                    <TD width="" align="center"><strong>QTY.</strong></TD>
                    <TD width="" align="center"><strong>Price</strong></TD> 
                    <TD width="" align="center"><strong>Amount</strong></TD>
                </TR>
                <tr>
                    <td align="left" valign="top"><INPUT type="checkbox" name="chk"/><input type="hidden" name="partid" value="" id="prdid"/></td>
                    <td align="left" valign="top"><input name="carparts" required="" type="text" id="carparts" /></td>
                    <td align="left" valign="top">
                        <select name="manufacturerid" class="manufacturer" required="" style="width: 100px" onchange="iambatman(this)">
                            <option value="">--select--</option>
                            <option></option>
                        </select>
                    </td>
                    <td align="left" valign="top"><input name="quantity" min="0" type="number" required="" class="quantity" style="width: 45px" onchange="calculatebalance(this)" onclick="calculatebalance(this)" /></td>
                    <td align="left" valign="top"><input name="sellingprice" type="number" required="" onchange="calculateamount(this);" class="sellingprice" style="width: 100px"/></td>
                    <td align="left" valign="top"><input name="total" readonly="" type="number" value="0" class="itemtotal" style="width: 100px"/></td>
                </tr>
            </TABLE>
            Spare parts Total :    <input name="sparepartsfinal" readonly="" value="0" type="text" id="sparepartsfinal" />
            <!--<div style="float:right; margin-right:80px; margin-top:10px; font-size:16px"><strong>TOTAL: </strong><input name="total" type="text" value="0" class="resulttotal" /></div>-->
            <div>
                <INPUT type="button" value="Add Product" onclick="addRow('dataTable')"  class="view3"/>
                <INPUT type="button" value="Delete Selected" onclick="deleteRow('dataTable');
                        calculatebalance(this)"  class="view3"/>
            </div>  
            <br />
            <center>        
                <input type="submit" onclick="$('#loopvalue').val($('.serviceloopcount:visible').length);" value="Save" class="view3"/>&nbsp;&nbsp;&nbsp;<input type="reset" value="Reset" class="view3"/>
            </center>
        </form>
    </body>
</html>


