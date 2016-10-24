<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : View180PointCheckListGrid
    Created on : 25-Apr-2015, 09:52:34
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View 180Point CheckList Grid</title>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
        <script src="js/jquery-1.10.2.min.js"></script>
        <script src="js/jquery.dataTables.js"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery-ui.css">
        <script src="js/jquery-ui.js"></script>
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
                        url: "deleterecord",
                        data: {id: id, deskname: "pointchecklist"
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
        <h2>180 Point  Check-List</h2>
        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <!--<td>Sr. No.</td>-->
                    <td>Date</td>
                    <td>180 point id</td>
                    <td>Service Checklist No.</td>
                    <td>Vehicle No: </td>
                    <td>Model</td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${pointchecklistdt}">
                    <tr>
                        <!--<td align="left">${count}</td>-->
                        <td align="left">${ob.pcldate}</td>
                        <td align="left">${ob.id}</td>
                        <td align="left">${ob.cvid}</td>
                        <td align="left">${ob.vehiclenumber}</td>
                        <td align="left">${ob.carmodel}</td>
                        <td align="left">
                            <c:if test="${!sessionScope.USERTYPE.equals('spares')}">
                                <c:choose>
                                    <c:when test="${ob.estimatestatus=='No'}">
                                        <a href="addEstimatePage?pclid=${ob.id}&ises=${ob.estimatestatus}"><img src="images/eslitmate_icon.png" alt="" width="14" height="16" title="Create Estimate"/></a> &nbsp;
                                        <a href="edit180pointchecklist?id=${ob.id}&brandid=${ob.branddetailid}" title="Edit 180 point" class="email_link3"><img src="images/edit.png" width="16" height="15"></a>&nbsp;
                                    </c:when>
                                </c:choose>
                            </c:if>
                            <c:if test="${!sessionScope.USERTYPE.equals('spares') && !sessionScope.USERTYPE.equals('crm')}">
                                <c:choose>
                                    <c:when test="${ob.estimatestatus=='No'}">
                                        <a onclick="confirmdelete('${ob.id}', this);"><img src="images/delete.png" width="16" height="17" /></a>&nbsp;
                                        </c:when>
                                    </c:choose>
                                </c:if>

                            <a href="180pointchecklistviewdetails?pclid=${ob.id}"><img src="images/view.png" width="21" height="13" />&nbsp;</a>

                        </td>
                    </tr>
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
