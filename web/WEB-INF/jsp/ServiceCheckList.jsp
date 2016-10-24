    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ServiceCheckList
    Created on : 24 Apr, 2015, 12:55:26 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Service CheckList</title>
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
                        url: "deleterecord",
                        data: {id: id, deskname: "customervehicles"
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
        <c:if test="${!sessionScope.USERTYPE.equals('spares') && !sessionScope.USERTYPE.equals('crm')}"><a href="create_service_checklist.html" class="view">Create</a></c:if>
        <h2>Service Check List</h2>

        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Sr. No.</td>
                    <td>Checklist id.</td>
                    <td >Date</td>
                    <td >Customer Name</td>
                    <td>Brand</td>
                    <td>Model </td>
                    <td>Vehicle N0. </td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${servicedtls}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.cvid}</td>
                        <td align="left">${ob.date}</td>
                        <td align="left">${ob.name}</td>
                        <td align="left">${ob.carbrand}</td>
                        <td align="left">${ob.carmodel}</td>
                        <td align="left">${ob.vehiclenumber}</td>
                        <td align="left"> 
                            <a href="viewServiceCheckList.html?id=${ob.id}&bdid=${ob.brandid}"><img src="images/view.png" width="21" height="13" title="View Service CheckList" />&nbsp;&nbsp;</a>
                            <c:if test="${!sessionScope.USERTYPE.equals('spares') && !sessionScope.USERTYPE.equals('crm')}">
                            <c:choose>
                                    <c:when test="${ob.is180ready=='No'}">
                                    <a href="180pointchecklist?id=${ob.cvdid}&branddetailid=${ob.branddetailid}&cvid=${ob.id}&isr=${ob.is180ready}"><img src="images/180_icon.png" width="16" height="14"  title="180 point Check List" />&nbsp;</a>
                                    <a onclick="confirmdelete('${ob.id}', this);"><img src="images/delete.png" width="16" height="17" /></a>
                                    </c:when>
                                </c:choose>
                            </c:if>
                        </td>
                    </tr>  
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>

            </tbody>
        </table>


    </body>
</html>
