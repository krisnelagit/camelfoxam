<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : EditConsumable
    Created on : 28-Sep-2015, 10:14:34
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Paints</title>
        <link href="css/csstable.css" rel="stylesheet" type="text/css" />
        <script>
            $(document).ready(function () {
                $(".quantity").change();
            });
            //function to calulate total amount
            function calculateamount(b){
                $(b).closest('tr').find('.quantity').trigger("change");
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
        <!--<a href="#" class="view" style="margin-right:10px;">Email</a>-->
        <h2>Edit Paints</h2>
        <br />
        <form action="updateConsumable" method="POST">
            <c:set var="total" value="${0}" />
            <c:forEach var="ob" items="${jobdtls}">
                <c:set var="total" value="${total + 1}" />  
                <input type="hidden" name="allconsumableids" value="${ob.id}" />
            </c:forEach>
            <input type="hidden" name="consumablecount" value="${total}" />
            <table width="100%" cellpadding="5">
                <tr>
                    <td align="left" valign="top">Date</td>
                    <td align="left" valign="top">${jsuserdtls.custdate}</td>
                </tr>
                <tr>
                    <td align="left" valign="top">Job No.</td>
                    <td align="left" valign="top">${jsuserdtls.jobno} <input type="hidden" name="jobno" value="${jsuserdtls.jobno}" /> </td>
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
            <br>
            <TABLE id="dataTable" border="0" class="CSSTableGenerator">
                <TR>
                    <TD width="" align="left">&nbsp;</TD>
                    <td width="" align="center"><strong>Part</strong></td>
                    <td width="" align="center"><strong>MFG.</strong></td>
                    <TD width="" align="center"><strong>QTY.</strong></TD>
                    <TD width="" align="center"><strong>Price</strong></TD> 
                    <TD width="" align="center"><strong>Amount</strong></TD>
                </TR>
                <c:forEach var="ob" items="${jobdtls}">
                    <tr>              
                        <td align="left" valign="top"><INPUT type="checkbox" name="chk"/><input type="hidden" name="consumableid" value="${ob.id}" id="prdid"/><input type="hidden" name="newconsumableid" value="${ob.id}" id="prdid"/><input type="hidden" name="partid" value="${ob.partid}" /></td>
                        <td align="left" valign="top">${ob.partname}</td>
                        <td align="left" valign="top">${ob.mfgname}</td>
                        <td align="left" valign="top"><input name="quantity" type="number" class="quantity" style="width: 45px" value="${ob.quantity}" onchange="calculatebalance(this)" onclick="calculatebalance(this)" /></td>
                        <td align="left" valign="top"><input name="sellingprice" type="number" onchange="calculateamount(this);" value="${ob.sellingprice}" class="sellingprice" style="width: 100px"/></td>
                        <td align="left" valign="top"><input name="total" readonly="" type="number" value="${ob.total}" class="itemtotal" style="width: 100px"/></td>
                    </tr>
                </c:forEach>
            </TABLE>
            Spare parts Total :    <input name="sparepartsfinal" readonly="" value="0" type="text" id="sparepartsfinal" />
            <!--<div style="float:right; margin-right:80px; margin-top:10px; font-size:16px"><strong>TOTAL: </strong><input name="total" type="text" value="0" class="resulttotal" /></div>-->
            <div>
                <INPUT type="button" value="Delete Selected" onclick="deleteRow('dataTable');
                    calculatebalance(this)"  class="view3"/>
            </div>  
            <br />
            <center>        
                <input type="submit" onclick="$('#lo
                opvalue').val($('.serviceloopcount:visible').length);" value="update" class="view3"/>
            </center>
        </form>
    </body>
</html>
