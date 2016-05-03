<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewPurchaseOrderGrid
    Created on : 26-May-2015, 12:54:44
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Purchase Order</title>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">        
        <script src="js/jquery.dataTables.js"></script>
        <script>
            $(document).ready(function () {
                $('#table_id').DataTable();

                //filter coding starts here fo po approval status
                var oTable = $('#table_id').dataTable();

                $('#searchbystatus').change(function () {
                    var val = $('#searchbystatus').val();
                    if (val === "All") {
                        fnResetAllFilters(oTable);
                    } else {
                        oTable.fnFilter("^" + $(this).val(), 5, true);
                    }
                    //oTable.fnFilter("");
                });

                function fnResetAllFilters(oTable) {
                    var oSettings = oTable.fnSettings();
                    for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
                        oSettings.aoPreSearchCols[iCol].sSearch = '';
                    }
                    oSettings.oPreviousSearch.sSearch = '';
                    oTable.fnDraw();
                }
                //filter coding ends here

                //filter coding starts here fo po receive status

                $('#receivebystatus').change(function () {
                    var val = $('#receivebystatus').val();
                    if (val == "All") {
                        fnResetAllFilters(oTable);
                    } else {
                        oTable.fnFilter("^" + $(this).val(), 6, true);
                    }
                    //oTable.fnFilter("");
                });
                
                $('#vendorss').change(function () {
                    var val = $('#vendorss').val();
                    if (val === "All") {
                        fnResetAllFilters(oTable);
                    } else {
                        oTable.fnFilter("^" + $(this).val(), 3, true);
                    }
                    //oTable.fnFilter("");
                });
                //filter coding ends here
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
                        url: "deleterecord",
                        data: {id: id, deskname: "purchaseorder"
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
        <c:choose>
            <c:when test="${sessionScope.BRANCHNAME=='MPO'}">
                <a href="create_PurchaseOrderLink" class="view">Create custom</a>
            </c:when>
        </c:choose>

        <h2>Purchase Order</h2>
        <br>
        <c:set var="Approved" value="${0}"></c:set>
        <c:set var="Pending" value="${0}"></c:set>
        <c:set var="notapproved" value="${0}"></c:set>
        <c:set var="Notreceived" value="${0}"></c:set>
        <c:set var="Received" value="${0}"></c:set>
        <c:set var="Partialreceived" value="${0}"></c:set>
            <table width="100%" cellpadding="5">
                <tr>
                    <td align="left" valign="top" >
                        Approval Status-wise : <select name="searchbystatus" id="searchbystatus">

                        </select>
                    </td>
                    <td align="right" valign="top">
                        Receive Status-wise : <select name="receivebystatus" id="receivebystatus">

                        </select>
                    </td>
                    <td align="right" valign="top">
                        Vendor-wise : <select name="vendorss" id="vendorss">
                            <option>All</option>
                        <c:forEach var="ob" items="${vendordt}">
                            <option>${ob.name}</option>
                        </c:forEach>
                            
                        </select>
                    </td>
                </tr>
            </table>
            <br>
            <table class="display tablestyle" id="table_id">
                <thead>
                    <tr>
                        <td>Sr. No.</td>
                        <td>ID.</td>
                        <td>Date</td>
                        <td>Vendor Name</td>
                        <td>Payment terms</td>
                        <td>Approval Status</td>
                        <td>Receive Status</td>
                        <td>&nbsp;</td>
                    </tr>
                </thead>
                <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${purchaseorderdt}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.id}</td>
                        <td align="left">${ob.date}</td>
                        <td align="left">${ob.vendorname}</td>
                        <td align="left">${ob.paymentterms}</td>
                        <td align="left">
                            <c:choose>
                                <c:when test="${ob.acceptance=='Approved'}">
                                    ${ob.acceptance}                            
                                    <c:set var="Approved" value="${Approved+1}"></c:set>
                                </c:when>
                                <c:when test="${ob.acceptance=='Pending'}">
                                    ${ob.acceptance}                              
                                    <c:set var="Pending" value="${Pending+1}"></c:set>
                                </c:when>
                                <c:when test="${ob.acceptance=='Not approved'}">
                                    ${ob.acceptance}                                 
                                    <c:set var="notapproved" value="${notapproved+1}"></c:set>
                                </c:when>
                            </c:choose>
                        </td>
                        <td align="left">
                            <c:choose>
                                <c:when test="${ob.isreceived=='Not received'}">
                                    ${ob.isreceived}                            
                                    <c:set var="Notreceived" value="${Notreceived+1}"></c:set>
                                </c:when>
                                <c:when test="${ob.isreceived=='Received'}">
                                    ${ob.isreceived}                              
                                    <c:set var="Received" value="${Received+1}"></c:set>
                                </c:when>
                                <c:when test="${ob.isreceived=='Partial received'}">
                                    ${ob.isreceived}                                 
                                    <c:set var="Partialreceived" value="${Partialreceived+1}"></c:set>
                                </c:when>
                            </c:choose>
                        </td>
                        <td align="left"> 
                            <a href="ViewReceivedPurchaseOrderDetails?poid=${ob.id}"><img src="images/incomes1.png" width="18" height="17" title="Receive PO" />&nbsp;&nbsp;&nbsp;&nbsp;</a>
                            <a href="ViewPurchaseOrderBillDetails?poid=${ob.id}"><img src="images/bill.png" width="18" height="17" title="Add Bill number" />&nbsp;&nbsp;&nbsp;&nbsp;</a>
                            <c:if test="${!sessionScope.USERTYPE.equals('spares')}">
                            <c:choose>
                                    <c:when test="${sessionScope.BRANCHNAME=='MPO'}">
                                    <a href="ViewPurchaseOrderDetails?poid=${ob.id}"><img src="images/view.png" width="21" height="13" title="View FollowUp Details" />&nbsp;&nbsp;&nbsp;&nbsp;</a>
                                    </c:when>
                                </c:choose>
                                    &nbsp;&nbsp;<a href="" onclick="confirmdelete('${ob.id}', this);"><img src="images/delete.png" width="16" height="17" /></a>
                            </c:if>
                        </td>
                    </tr>  
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>
            </tbody>
        </table>
        <script>
            $(document).ready(function () {
                $('#searchbystatus').append(' <option>All</option><option value="Approved">Approved (${Approved})</option><option value="Pending">Pending (${Pending})</option><option value="Not approved">Not approved (${notapproved})</option>');
                $('#receivebystatus').append(' <option>All</option><option value="Not received">Not received (${Notreceived})</option><option value="Received">Received (${Received})</option><option value="Partial received">Partial received (${Partialreceived})</option>');
            });
        </script>
    </body>
</html>
