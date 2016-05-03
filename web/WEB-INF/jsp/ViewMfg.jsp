1<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewMfg
    Created on : 17-Mar-2015, 18:06:44
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Manufacturers</title>
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
                        data: {id: id, deskname: "manufacturer"
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
        <a href="mfgMasterCreateLink" class="view">Create</a>
        <h2>Manufacturer List</h2>
        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Sr. No.</td>
                    <td>Id</td>
                    <td>Manufacturer Name</td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${mfgListDt}">
                <tr>
                    <td align="left">${count}</td>
                    <td align="left">${ob.id}</td>
                    <td align="left">${ob.name}</td>
                    <td align="left"> <a title="edit manufacturer" href="editMfgDetailsLink?mfgid=${ob.id}"><img src="images/edit.png" width="16" height="15"></a>&nbsp;&nbsp;<a href="" title="delete manufacturer" onclick="confirmdelete('${ob.id}', this);"><img src="images/delete.png" width="16" height="17" /></a></td>
                </tr>  
                <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>                
            </tbody>
        </table>
    </body>
</html>
