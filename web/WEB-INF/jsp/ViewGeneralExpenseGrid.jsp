<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewGeneralExpenseGrid
    Created on : 08-Jun-2015, 11:05:23
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View General Expense</title>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">        
        <script src="js/jquery.dataTables.js"></script>
        <script>
            $(document).ready(function () {
                $('#table_id').DataTable();

                //filter coding starts here
                var oTable = $('#table_id').dataTable();

                $('#searchbystatus').change(function () {
                    var val = $('#searchbystatus').val();
                    if (val == "All") {
                        fnResetAllFilters(oTable);
                    } else {
                        oTable.fnFilter("^" + $(this).val(), 6, true);
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
                        data: {id: id, deskname: "generalexpense"
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
        <a href="createGeneralExpensesLink" class="view">Create</a>
        <h2>General Expenses</h2>

        <br>
        <c:set var="Approved" value="${0}"></c:set>
        <c:set var="Pending" value="${0}"></c:set>
        <c:set var="notapproved" value="${0}"></c:set>
            <table width="100%" cellpadding="5">
                <tr>
                    <td align="left" valign="top" >
                        View Status-wise : <select name="searchbystatus" id="searchbystatus">

                        </select>
                    </td>
                    <td align="right" valign="top">
                        &nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                </tr>
            </table>
            <br>
            <table class="display tablestyle" id="table_id">
                <thead>
                    <tr>
                        <td>Sr. No.</td>
                        <td>Expense id</td>
                        <td>Bill No.</td>
                        <td>Expense Date</td>
                        <td>To</td>
                        <td>Ledger</td>
                        <td>Groups</td>
                        <td>Total</td>
                        <td>Status</td>
                        <td>&nbsp;</td>
                    </tr>
                </thead>
                <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${generalexpensedtls}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.id}</td>
                        <td align="left">
                            <c:choose>
                        <c:when test="${empty ob.expense_billnumber}">
                            N/A
                        </c:when>
                        <c:otherwise>
                            ${ob.expense_billnumber}
                        </c:otherwise>
                    </c:choose>
                        </td>
                        <td align="left">${ob.expense_date}</td>
                        <td align="left">${ob.towards}</td>
                        <td align="left">${ob.accountname}</td>
                        <td align="left">${ob.name}</td>
                        <td align="left">${ob.total}</td>
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
                            <a href="viewGeneralExpenseDetails?expenseid=${ob.id}"><img src="images/view.png" width="21" height="13" title="View expenses Details" />&nbsp;&nbsp;&nbsp;&nbsp;</a>&nbsp;&nbsp;<a onclick="confirmdelete('${ob.id}', this);"><img src="images/delete.png" width="16" height="17" /></a>
                        </td>
                    </tr>  
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>
            </tbody>
        </table>
        <script>
            $(document).ready(function () {
                $('#searchbystatus').append(' <option>All</option><option value="Approved">Approved (${Approved})</option><option value="Pending">Pending (${Pending})</option><option value="Not approved">Not approved (${notapproved})</option>');
            });
        </script>
    </body>
</html>
