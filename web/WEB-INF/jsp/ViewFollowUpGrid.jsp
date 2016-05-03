<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%-- 
    Document   : ViewFollowUpGrid
    Created on : 19-May-2015, 11:47:21
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View FollowUp</title>
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
                        data: {id: id, deskname: "followups"
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
        <!--<a href="create_Enquiries" class="view">Create</a>-->
        <h2>Follow up</h2>

        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Id</td>
                    <td>Date</td>
                    <td>Customer Name</td>
                    <td>Next Followup</td>
                    <td>Status</td>
                    <td>Followed by</td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${followupdt}">
                    <tr>
                        <td align="left">${ob.id}</td>
                        <td align="left">${ob.date}</td>
                        <td align="left">${ob.name}</td>
                        <td align="left">${ob.nextfollowup}</td>
                        <td align="left">${ob.fpstatus}</td>
                        <td align="left">${ob.followedby}</td>
                        <td align="left"> 
                            <a href="viewFollowUpDetails?followupid=${ob.id}"><img src="images/view.png" width="21" height="13" title="View FollowUp Details" />&nbsp;&nbsp;&nbsp;&nbsp;</a>&nbsp;&nbsp;<a onclick="confirmdelete('${ob.id}', this);"><img src="images/delete.png" width="16" height="17" /></a>
                        </td>
                    </tr>  
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
