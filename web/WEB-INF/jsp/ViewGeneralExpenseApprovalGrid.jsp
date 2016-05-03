<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewGeneralExpenseApprovalGrid
    Created on : 08-Jun-2015, 17:32:56
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View General Expense Approval</title>            
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        
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

                //popup for addng category begin here
                $("#dialognk").hide();
                //on click of edit
                $(".email_link").click(function (e) {
                    e.preventDefault();
                    var geid = $(this).attr('href');
                    $(".limitid").val('');
                    $(".limitname").val('');
                    $(".limitamount").val('');
                    $("#message").html("");
                    $.ajax({
                        url: "getGeneralExpenseLimitDetails",
                        datatype: 'json',
                        type: 'POST',
                        data: {
                            geid: geid
                        },
                        cache: false,
                        success: function (data) {
                            if (data) {
                                $(".limitid").val(data[0].id);
                                $(".limitname").val(data[0].total);

                                $("#dialognk").dialog({
                                    modal: true,
                                    effect: 'drop'
                                });
                            }
                        }
                    });
                });

            });
        </script>

    </head>
    <body>
        <h2>General Expense Approval</h2>

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
                        <td>Date</td>
                        <td>To</td>
                        <td>Ledger</td>
                        <td>Groups</td>
                        <td>Total</td>
                        <td>Status</td>
                    </tr>
                </thead>
                <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${generalexpensedtls}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.savedate}</td>
                        <td align="left">${ob.towards}</td>
                        <td align="left">${ob.accountname}</td>
                        <td align="left">${ob.name}</td>
                        <td align="left">${ob.total}</td>
                        <td align="left">
                            <c:choose>
                                <c:when test="${ob.status=='Approved'}">
                                    <a class="email_link" href="${ob.id}">${ob.status}</a>                                    
                                    <c:set var="Approved" value="${Approved+1}"></c:set>
                                </c:when>
                                <c:when test="${ob.status=='Pending'}">
                                    <a class="email_link" href="${ob.id}">${ob.status}</a>                                    
                                    <c:set var="Pending" value="${Pending+1}"></c:set>
                                </c:when>
                                <c:when test="${ob.status=='Not approved'}">
                                    <a class="email_link" href="${ob.id}">${ob.status}</a>                                    
                                    <c:set var="notapproved" value="${notapproved+1}"></c:set>
                                </c:when>
                            </c:choose>                            
                        </td>
                    </tr>  
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>
            </tbody>
        </table>

        <div id="dialognk" title="Action">
            <form action="addGEApprovalStatus" method="POST">
                <input type="hidden" name="id" class="limitid" value="" />
                <table width="100%" cellpadding="5">
                    <tr>    
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Total Amount(Rs.)&nbsp;&nbsp;</td>
                        <td width="66%" align="left" valign="top"><input readonly="" type="text" name="finaltotal" class="limitname" id="textfield2" /></td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Status&nbsp;&nbsp;</td>
                        <td width="66%" align="left" valign="top">
                            <select name="status" required="" id="allstatus">
                                <option value="">--select--</option>
                                <option value="Approved">Approved</option>
                                <option value="Pending">Pending</option>
                                <option value="Not approved">Not approved</option>
                            </select> 
                        </td>
                    </tr>
                    <tr>    
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td><input type="submit" id="ibutton" value="Save" class="btn btn-success" />&nbsp;&nbsp;&nbsp;</td>
                    </tr>
                    <tr>    
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
                <br><font face="verdana" size="2"><div id="message"></div></font>
                <br>
            </form>
        </div>


        <script>
            $(document).ready(function () {
                $('#searchbystatus').append(' <option>All</option><option value="Approved">Approved (${Approved})</option><option value="Pending">Pending (${Pending})</option><option value="Not approved">Not approved (${notapproved})</option>');
            });
        </script>
    </body>
</html>
