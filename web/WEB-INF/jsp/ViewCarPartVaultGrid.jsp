<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewCarPartVaultGrid
    Created on : 22-Jul-2015, 11:12:22
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Car Part Vault</title>
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
                        url: "deletePartRecord",
                        data: {id: id, deskname: "carpartvault"
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
        <h2>Part Vault</h2>

        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Sr. No.</td>
                    <td>Id.</td>
                    <td>Part Name</td>
                    <td>Category</td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${vaultDetails}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.cpvid}</td>
                        <td align="left">${ob.carpartvaultname}</td>
                        <td align="left">${ob.categoryname}</td>
                        <td align="left">
                            <a href="viewspareparts?id=${ob.cpvid}"><img src="images/view.png" width="16" height="13" /></a>&nbsp;&nbsp;<a href="editspareparts?id=${ob.cpvid}"><img src="images/edit.png" width="16" height="13" /></a>&nbsp;&nbsp;<a onclick="confirmdelete('${ob.cpvid}', this);"><img src="images/delete.png" width="16" height="17" /></a>
                        </td>
                    </tr>
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
