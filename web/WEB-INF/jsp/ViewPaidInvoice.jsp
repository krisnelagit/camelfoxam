<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewPaidInvoice
    Created on : 20-Mar-2015, 13:48:41
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Invoice</title>
        <link rel="stylesheet" type="text/css" href="css/jquery-ui_1.css">
        <script src="js/jquery-ui.js"></script>
        <script>
            $(function () {
                $("#dialog").hide();
                $("#dialognkEditDetail").hide();

                if ('${param.isexist}' === "Yes") {
                    $("#dialog").show();
                    $("#dialog").dialog({
                        modal: true,
                        effect: 'drop',
                        show: {
                            effect: "drop"
                        },
                        hide: {
                            effect: "drop"
                        }
                    });
                }
                //on click of hard delete
                $(".email_link3").click(function (e) {
                    e.preventDefault();
                    var fsid = $(this).attr('href');
                    $("#brid").val('');
                    $("#brandname").text('');
                    $("#brid").val(fsid);
                    $("#dialognkEditDetail").dialog({
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
            });//END FUNCTION
        </script>
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
            <a href="invoiceMasterLink" class="view">Back</a>
        
        <h2>Paid Invoice</h2>

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
                            <a href="viewCustomerInvoice?invoiceid=${ob.id}" title="View Invoice"><img src="images/view.png" width="21" height="13" /></a>&nbsp;
                            <c:if test="${!sessionScope.USERTYPE.equals('spares')}">
                            <c:choose>
                                <c:when test="${ob.ispaid=='No'}">
                                    <a href="editInvoiceDetailsLink?invoiceid=${ob.id}"><img src="images/edit.png" width="16" height="15" /></a>&nbsp;
                                    <a href="makePaymentLink?invoiceid=${ob.id}&custno=${ob.customermobilenumber}"><img src="images/Bill_with_dollar_sign_and_coins_24.png" width="22" height="19" /></a>&nbsp;
                                    </c:when>
                                </c:choose>
                                    <a onclick="confirmdelete('${ob.id}', this);" style="cursor: pointer" title="Delete"><img src="images/delete.png" width="16" height="17" /></a>&nbsp;
                                    <c:choose>
                                        <c:when test="${sessionScope.USERTYPE.equals('admin')}">
                                        <a href="${ob.id}" style="cursor: pointer" class="email_link3" title="Permanent Delete"><img src="images/pdelete.png" width="16" height="17" /></a>
                                        </c:when>
                                    </c:choose>
                            </c:if>
                            <!--<a href="viewCustomerInvoice?invoiceid=$ {ob.id}"><img src="images/view.png" width="21" height="13" /></a>&nbsp;&nbsp;-->
                            
                            
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <!--code for password dialog begin here-->
        <div id="dialognkEditDetail" title="Enter password">
            <form action="permanentdeleteinvoice" method="POST">        
                <table width="100%" cellpadding="5">
                    <tr>
                    <input type="hidden" name="id" id="brid" value="" />
                    <td width="34%" align="left" valign="top">Password</td>
                    <td width="66%" align="left" valign="top"><input type="password" maxlength="20" required name="password" id="brandname" value="" /></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td><input type="submit" value="Delete" class="view3" style="cursor: pointer" />&nbsp;&nbsp;&nbsp;</td>
                    </tr>
                    <tr>    
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
                <br>
            </form>
        </div>
        <!--code for password dialog ends! here-->

        <div id="dialog" title="Message">
            <br/>
            <br/>
            <center><b>Incorrect password!</b></center>                    
        </div>
    </body>
</html>
