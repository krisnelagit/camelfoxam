<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewFeedbackGrid
    Created on : 19-Jun-2015, 13:42:34
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Feedback</title>
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
                        oTable.fnFilter("^" + $(this).val(), 8, true);
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
                        data: {id: id, deskname: "feedback"
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
        <h2>Feedback List</h2>
        <br />
        <c:set var="complete" value="${0}"></c:set>
        <c:set var="incomplete" value="${0}"></c:set>
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
                        <td>Id.</td>
                        <td>Invoice Id.</td>
                        <td>Date</td>
                        <td>Customer Name</td>
                        <td>Mobile number</td>
                        <td>Brand</td>
                        <td>Model</td>
                        <td>Status</td>
                        <td>&nbsp;</td>
                    </tr>
                </thead>
                <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${fbListDetails}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.fbid}</td>
                        <td align="left">${ob.id}</td>
                        <td align="left">${ob.savedate}</td>
                        <td align="left">${ob.customername}</td>
                        <td align="left">${ob.customermobilenumber}</td>
                        <td align="left">${ob.brand}</td>
                        <td align="left">${ob.model}</td>
                        <td align="left">
                            <c:choose>
                                <c:when test="${ob.fbstatus=='complete'}">
                                    ${ob.fbstatus}                               
                                    <c:set var="complete" value="${complete+1}"></c:set>
                                </c:when>
                                <c:when test="${ob.fbstatus=='incomplete'}">
                                    ${ob.fbstatus}                                 
                                    <c:set var="incomplete" value="${incomplete+1}"></c:set>
                                </c:when>
                            </c:choose>
                        </td>
                        <td align="left"> <a href="userFeedbackLink?fbid=${ob.fbid}"><img src="images/chat57.png" width="16" height="15"></a>&nbsp;&nbsp;<a onclick="confirmdelete('${ob.fbid}', this);"><img src="images/delete.png" width="16" height="17" /></a></td>
                    </tr>  
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>                
            </tbody>
        </table>
        <script>
            $(document).ready(function () {
                $('#searchbystatus').append(' <option>All</option><option value="complete">complete (${complete})</option><option value="incomplete">incomplete (${incomplete})</option>');
            });
        </script>
    </body>
</html>