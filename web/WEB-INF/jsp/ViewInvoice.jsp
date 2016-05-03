<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewInvoice
    Created on : 20-Mar-2015, 13:48:41
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Invoice</title>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">        
        <script src="js/jquery.dataTables.js"></script>
        <script>
            $(document).ready(function () {
                $('#table_id').DataTable();
            });
        </script>
        <script>
            function confirmdelete(id, ob)
            {
                var res = confirm('Are you sure to delete?');
                if (res == true)
                {
                    $(ob).closest('tr').find('td').fadeOut(600,
                            function () {
                                $(ob).parents('tr:first').remove();
                            });

                    $.ajax({
                        type: "post",
                        url: "deleteinvoicerecord",
                        data: {id: id, deskname: "invoice"
                        },
                        success: function (data) {
                        },
                        error: function () {
                        }
                    });
                }
            }
        </script>
    </head>
    <body>
        <c:if test="${!sessionScope.USERTYPE.equals('spares') && !sessionScope.USERTYPE.equals('crm')}">
            <a href="createcustomerinvoice" class="view">Create</a>
        </c:if>
            <a href="paidcustomerinvoice" class="view">Paid invoice</a>&nbsp;
        <a href="viewInvoiceReasonsLink" class="view">Reasons</a>
        <h2>Invoice</h2>

        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Date</td>
                    <td>Id.</td>
                    <td>Customer name</td>
                    <td>Mobile no.</td>
                    <td>Vehicle Number</td>
                    <td>Balance Outstanding</td>
                    <td>Total</td>
                    <td>Payment</td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="ob" items="${invoiceListDt}">
                    <tr>
                        <td align="left">${ob.invoicedate}</td>
                        <td align="left">${ob.invoiceid}</td>
                        <td align="left">${ob.name}</td>
                        <td align="left">${ob.customermobilenumber}</td>
                        <td align="left">${ob.vehiclenumber}</td>
                        <td align="left">${ob.balanceamount}</td>
                        <td align="left">${ob.amountTotal}</td>
                        <td align="left">
                            <c:choose>
                                <c:when test="${ob.ispaid=='No'}">
                                    Not paid
                                </c:when>
                                <c:otherwise>
                                    Paid
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td align="left">
                            <c:if test="${!sessionScope.USERTYPE.equals('spares') && !sessionScope.USERTYPE.equals('crm')}">
                                <c:choose>
                                    <c:when test="${ob.ispaid=='No'}">
                                        <!--condition to edit invoice changes-->
                                        <c:choose>
                                            <c:when test="${sessionScope.USERTYPE.equals('admin')}">
                                                <a href="editInvoiceDetailsLink?invoiceid=${ob.id}"  title="Edit invoice"><img src="images/edit.png" width="16" height="15" /></a>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:if test="${ob.monthcheck==currentmonth}">
                                                    <a href="editInvoiceDetailsLink?invoiceid=${ob.id}" title="Edit invoice"><img src="images/edit.png" width="16" height="15" /></a>
                                                    </c:if>                                            
                                                </c:otherwise>
                                            </c:choose>
                                        <!--condition to edit invoice changes-->

                                        <a href="makePaymentLink?invoiceid=${ob.id}&custno=${ob.customermobilenumber}" title="Make Payment"><img src="images/Bill_with_dollar_sign_and_coins_24.png" width="22" height="19" /></a>
                                        </c:when>
                                    </c:choose>
                                <a onclick="confirmdelete('${ob.id}', this);" title="Delete Invoice"><img src="images/delete.png" width="16" height="17" /></a>
                                </c:if>
                            <a href="viewCustomerInvoice?invoiceid=${ob.id}" title="View Invoice"><img src="images/view.png" width="21" height="13" /></a>
                            <a href="viewProformaInvoice?invoiceid=${ob.id}" title="View Proforma Invoice"><img src="images/proforma.png" width="21" height="13" /></a>
                                <c:choose>
                                    <c:when test="${ob.isinsurance=='Yes'}">
                                    <a href="viewLiabilityInvoice?invoiceid=${ob.id}" title="View Liability Invoice"><img src="images/transport.png" width="21" height="13" /></a>
                                    </c:when>
                                    <c:otherwise>
                                    </c:otherwise>
                                </c:choose>

                            
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
