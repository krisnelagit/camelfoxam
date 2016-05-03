<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : ViewGeneralIncomeGrid
    Created on : 31-Jul-2015, 11:03:55
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View General Income Grid</title>
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
                        url: "deleteIncomerecord",
                        data: {id: id, deskname: "generalincome"
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
        <a href="createGeneralIncomeLink" class="view">Create</a>
        <h2>General Income</h2>

        <br>
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Sr. No.</td>
                    <td>Date</td>
                    <td>Invoice no.</td>
                    <td>To</td>
                    <td>Groups</td>
                    <td>Total</td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${generalincomedtls}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left"><fmt:formatDate pattern="yyyy-MM-dd" value="${ob.savedate}" /></td>
                        <td align="left">
                            <c:choose>
                                <c:when test="${empty ob.invoiceid}">
                                    N/A
                                </c:when>
                                <c:otherwise>
                                    ${ob.invoiceid}
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td align="left">${ob.towards}</td>
                        <td align="left">${ob.name}</td>
                        <td align="left">${ob.total}</td>
                        <td align="left"> 
                            <a href="viewGeneralIncomeDetails?incomeid=${ob.id}"><img src="images/view.png" width="21" height="13" title="View expenses Details" />&nbsp;&nbsp;&nbsp;&nbsp;</a>&nbsp;&nbsp;<a onclick="confirmdelete('${ob.id}', this);"><img src="images/delete.png" width="16" height="17" /></a>
                        </td>
                    </tr>  
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
