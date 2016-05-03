<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewJobsheetGrid
    Created on : 01-May-2015, 17:38:26
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Jobsheet Grid</title>
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
                        data: {id: id, deskname: "jobsheet"
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
        <h2>Jobsheet</h2>
        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Sr. No.</td>
                    <td>Job No.</td>
                    <td>Customer Name</td>
                    <td>Car Model</td>
                    <td>Vehicle No.</td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${jobdtls}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.jsid}</td>
                        <td align="left">${ob.custname}</td>
                        <td align="left">${ob.carmodel}</td>
                        <td align="left">${ob.vehiclenumber}</td>
                        <td align="left">
                            <a href="viewTaskLink?jsid=${ob.jsid}"><img src="images/task.png" width="17" height="17" /></a>&nbsp;&nbsp;
                            <c:if test="${!sessionScope.USERTYPE.equals('spares') && !sessionScope.USERTYPE.equals('crm')}">
                                <c:choose>
                                    <c:when test="${ob.isinvoiceconverted=='No'}">
                                    <a href="editJobDetailsLink?jsid=${ob.jsid}"><img src="images/edit.png" width="16" height="15"></a>&nbsp;&nbsp;
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
