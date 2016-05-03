<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewSpareRequisitionGrid
    Created on : 02-May-2015, 17:24:23
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Spare Requisition Grid</title>
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
        <h2>Spares Requisition</h2>
        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Sr. No.</td>
                    <td>Job No.</td>
                    <td>Customer Name</td>
                    <td>Car Model</td>
                    <td>Car No.</td>
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
                            <a href="viewConsumablePage?jsid=${ob.jsid}" title="View Paints"><img src="images/shopping111.png" width="16" height="15" /></a>&nbsp;&nbsp;
                                <c:if test="${!sessionScope.USERTYPE.equals('crm')}">
                                <a href="addConsumablePage?jsid=${ob.jsid}&isrre=${ob.isrequisitionready}" title="Add Paints"><img src="images/shopping100.png" width="16" height="15" /></a>&nbsp;&nbsp;                            
                                <a href="addRequisitionPage?jsid=${ob.jsid}&isrre=${ob.isrequisitionready}" title="Add requisition"><img src="images/addh.png" width="16" height="15" /></a>&nbsp;&nbsp;
                                <a href="editRequisitionPage?jsid=${ob.jsid}" title="Edit requisition"><img src="images/edit.png" width="16" height="15" /></a>&nbsp;&nbsp;
                                <a href="viewRequisitionDetailsLink?jsid=${ob.jsid}" title="View requisition"><img src="images/view.png" width="21" height="13"></a>
                                </c:if>

                        </td>
                    </tr>  
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>                
            </tbody>
        </table>
    </body>
</html>
