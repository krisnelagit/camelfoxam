<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewInsuranceExpiringGrid
    Created on : 25-May-2015, 10:38:13
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Insurance Expiring</title>
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
                        data: {id: id, deskname: "insurance"
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
        <a href="create_Cust_Insurance" class="view">Create</a>
        <h2>Insurance Expiring</h2>

        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Sr. No.</td>
                    <td>Id.</td>
                    <td>Customer Name</td>
                    <td>Email id</td>
                    <td>Mobile no.</td>
                    <td>Policy No.</td>
                    <td>Insurance co.</td>
                    <td>Vehicle name</td>
                    <td>Expiry Date</td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${insurancedtls}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.id}</td>
                        <td align="left">${ob.custname}</td>
                        <td align="left">${ob.email}</td>
                        <td align="left">${ob.mobilenumber}</td>
                        <td align="left">${ob.policyno}</td>
                        <td align="left">${ob.insurancecompany}</td>
                        <td align="left">${ob.vehiclename}</td>
                        <td align="left">${ob.expirydate}</td>
                        <td align="left"> 
                            <a href="viewInsuranceDetails?insuranceid=${ob.id}"><img src="images/view.png" width="21" height="13" title="View FollowUp Details" />&nbsp;&nbsp;&nbsp;&nbsp;</a>&nbsp;&nbsp;<a onclick="confirmdelete('${ob.id}', this);"><img src="images/delete.png" width="16" height="17" /></a>
                        </td>
                    </tr>  
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
