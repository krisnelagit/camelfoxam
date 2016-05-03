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
            <h2>Estimate to P.O</h2>
            <br />
            <table class="display tablestyle" id="table_id">
                <thead>
                    <tr>
                        <td>Sr. No.</td>
                        <td>Estimate No.</td>
                        <td>Part Name</td>
                        <td>Car brand</td>
                        <td>Car model</td>
                        <td>P.O created</td>
                    </tr>
                </thead>
                <tbody>
                    <c:set value="1" var="count"></c:set>
                    <c:forEach var="ob" items="${partdetails}">
                        <tr>
                            <td align="left">${count}</td>
                            <td align="left">${ob.estimateid}</td>
                            <td align="left">${ob.partname}</td>
                            <td align="left">${ob.brandname}</td>
                            <td align="left">${ob.carmodel}</td>
                            <td align="left">${ob.ispurchaseorder_ready}</td>
                        </tr>  
                        <c:set value="${count+1}" var="count"></c:set>
                    </c:forEach>                
                </tbody>
            </table>
    </body>
</html>
