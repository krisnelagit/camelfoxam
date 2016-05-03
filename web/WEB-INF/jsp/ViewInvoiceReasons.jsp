<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewTaxes
    Created on : 24-Mar-2015, 12:47:46
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
        <script src="js/jquery.dataTables.js"></script>
        <script>
            $(document).ready(function () {
                $('#table_id').DataTable();
            });
        </script>
<!--        <script>
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
                        data: {id: id, deskname: "labourservices"
                        },
                        success: function (data) {
                        },
                        error: function () {
                        }
                    });
                }
            }
        </script>-->
    </head>
    <body>
        <!--<a href="taxMasterCreateLink" class="view">Create</a>-->
        <h2>Invoice Reason's</h2>
    <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Sr. No.</td>
                    <td>Id</td>
                    <td>Invoice Id</td>
                    <td>Reason</td>
                    <td>Modify date</td>
                    <td>Modify by</td>
                    <td>User Type</td>
                </tr>
            </thead>
            <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${reasonsdt}">
                <tr>
                    <td align="left">${count}</td>
                    <td align="left">${ob.id}</td>
                    <td align="left">${ob.invoiceid}</td>
                    <td align="left">${ob.reason}</td>
                    <td align="left">${ob.modifydate}</td>
                    <td align="left">${ob.name}</td>
                    <td align="left">${ob.type}</td>
                </tr>  
                <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>                
            </tbody>
        </table>
    </body>
</html>

