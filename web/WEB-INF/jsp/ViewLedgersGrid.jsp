<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewLedgersGrid
    Created on : 05-Jun-2015, 17:17:35
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Ledgers</title>
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
                        data: {id: id, deskname: "ledger"
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
        <a href="ledgerCreateLink" class="view">Create</a>
        <h2>Ledgers</h2>
        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Sr. No.</td>
                    <td>ID.</td>
                    <td>Name</td>
                    <td>Groups</td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${ledgerdt}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.id}</td>
                        <td align="left">${ob.accountname}</td>
                        <td align="left">${ob.groupname}</td>
                        <td align="left"><a class="email_link" href="editLedgerLink?laid=${ob.id}"><img src="images/edit.png" width="16" height="15"></a>&nbsp;&nbsp;<a onclick="confirmdelete('${ob.id}', this);"><img src="images/delete.png" width="16" height="17" /></a></td>
                    </tr>  
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>                
            </tbody>
        </table>
    </body>
</html>
