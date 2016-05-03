<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewReceivedPurchaseOrderDetails
    Created on : 01-Jun-2015, 17:26:20
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Receive Purchase Order</title>
        <link href="css/csstable.css" rel="stylesheet" type="text/css" /> 
        <script src="js/jquery-1.8.3.js" type="text/javascript"></script>
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        <link href='css/jquery.qtip.css' rel='stylesheet' />
        <script src='js/jquery.qtip.min.js'></script>
        <script>
            $(document).ready(function () {
                $('.selection').change(function () {
                    $(this).closest('tr').find('.oldpodsid').attr('disabled', !this.checked);
                    $(this).closest('tr').find('.manufacturer').attr('disabled', !this.checked);
                    $(this).closest('tr').find('.costprice').attr('disabled', !this.checked);
                    $(this).closest('tr').find('.sellingprice').attr('disabled', !this.checked);
                    $(this).closest('tr').find('.quantity').attr('disabled', !this.checked);
                    $(this).closest('tr').find('.billnumber').attr('disabled', !this.checked);
                });

                //on form submit
                $("#itemsreceivedbyuser").submit(function () {
                    var checkedAtLeastOne = false;
                    $('input[type="checkbox"]').each(function () {
                        if ($(this).is(":checked")) {
                            checkedAtLeastOne = true;
                        }
                    });

                    if (checkedAtLeastOne == false) {
                        alert("Atleast one item should be checked");
                        return checkedAtLeastOne;
                    }
                });
            });
        </script>
    </head>
    <body>
        <a href="PurchaseOrderGridLink" class="view">Back</a>
        <h2>Receive Purchase Order</h2>
        <br />
        <form action="receivePurchaseOrder" id="itemsreceivedbyuser" method="post"> 
            <input type="hidden" name="poid" value="${purchasedetailsdt.id}" />
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Date</td>
                    <td width="66%" align="left" valign="top">${purchasedetailsdt.date}</td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Vendor name</td>
                    <td width="66%" align="left" valign="top">
                        <c:forEach var="obb" items="${vendordt}">
                            <c:choose>
                                <c:when test="${obb.id==purchasedetailsdt.vendorid}">${obb.name}
                                    <input type="hidden" name="vendor" value="${obb.id}" />
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </td>
                </tr>
                <tr>    
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
            <input type="hidden" name="totalitems" id="loopvalue" value="" />

            <TABLE id="dataTable" border="0" class="CSSTableGenerator">
                <TR>
                    <TD width="" align="left">&nbsp;</TD>
                    <td width="" align="center"><strong>Vehicle Model</strong></td>
                    <td width="" align="center"><strong>Car part name</strong></td>
                    <td width="" align="center"><strong>Manufacturer</strong></td>
                    <TD width="" align="center"><strong>Quantity</strong></TD>
                    <TD width="" align="center"><strong>Chalan No.</strong></TD>
                </TR>
                <c:forEach var="obd" items="${purchaseorderdetailsdt}">
                    <tr>
                        <td align="left" valign="top">
                            <c:choose>
                                <c:when test="${purchasedetailsdt.status=='Approved'}">
                                    <INPUT type="checkbox" class="selection" name="partids" value="${obd.partid}"/>
                                    <input type="hidden"  class="oldpodsid" readonly="" name="oldpodsid" value="${obd.id}" />
                                </c:when>
                            </c:choose>
                        </td>
                        <td align="left" valign="top">${obd.vehiclename}</td>
                        <td align="left" valign="top">${obd.partname}</td>
                        <td align="left" valign="top">
                            ${obd.mfgname}<input type="hidden" name="manufacturerids"disabled=""  class="manufacturer" value="${obd.manufacturerid}" />
                            <input name="costprices" value="${obd.costprice}"disabled=""   type="hidden" readonly="" class="costprice" />
                            <input name="sellingprices" value="${obd.sellingprice}"disabled=""   type="hidden" readonly="" class="sellingprice"/>
                        </td>
                        <td align="left" valign="top"><input name="quantitys" type="text"disabled=""  class="quantity"  value="${obd.partQuantity}" readonly="" style="width: 100px" /></td>
                        <td align="left" valign="top"><input name="billnumber" required=""disabled=""   class="billnumber" style="width: 100px"/></td>
                    </tr>
                </c:forEach>
            </TABLE>
            <br>
            <center>${errmsg}</center>
            <table width="100%" cellpadding="5">
                <c:choose>
                    <c:when test="${purchasedetailsdt.acceptance=='Approved'}">
                        <tr>    
                            <td>Comment</td>
                            <td>${purchasedetailsdt.comment}</td>
                        </tr>
                        <tr>    
                            <td>&nbsp;</td>
                            <td>
                                <c:if test="${not empty purchaseorderdetailsdt[0].expense_billnumber}">
                                    
                                
                                <c:if test="${empty errmsg}">
                                    <input type="submit" onclick="$('#loopvalue').val($('.selection:visible').length);" value="Save" class="view3" style="cursor: pointer" />
                                </c:if>
                                    </c:if>
                            </td>
                        </tr>
                    </c:when>
                    <c:when test="${purchasedetailsdt.isreceived=='Not received'}">
                        <tr>    
                            <td>&nbsp;</td>
                            <td><h2>This purchase order is yet to be approved</h2></td>
                        </tr>
                    </c:when>
                </c:choose>


            </table>
        </form>
    </body>
</html>
