<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewCustomerAdvanceGrid
    Created on : 16-Jul-2015, 13:33:36
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Customer Advance Grid</title>
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
                        url: "deleteAdvanceRecord",
                        data: {id: id, deskname: "customer_advance"
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
        <a href="createcustomeradvance" class="view">Create</a>
        <h2>Customer Advance</h2>

        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Sr. No.</td>
                    <td>Date</td>
                    <td>Id.</td>
                    <td>Customer name</td>
                    <td>Mobile no.</td>
                    <td>Brand</td>
                    <td>Model</td>
                    <td>Amount</td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${advancedetails}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.savedate}</td>
                        <td align="left">${ob.caid}</td>
                        <td align="left">${ob.custname}</td>
                        <td align="left">${ob.mobilenumber}</td>
                        <td align="left">${ob.brandname}</td>
                        <td align="left">${ob.modelname}</td>
                        <td align="left">${ob.advance_amount}</td>
                        <td align="left">
                            <a href="editAdvanceLink?advanceid=${ob.caid}&brandid=${ob.brandid}"><img src="images/edit.png" width="16" height="15" /></a>&nbsp;&nbsp;
                            <!--<a href="viewCustomerInvoice?invoiceid="><img src="images/view.png" width="21" height="13" /></a>&nbsp;&nbsp;-->
                            <a onclick="confirmdelete('${ob.caid}', this);"><img src="images/delete.png" width="16" height="17" /></a>
                        </td>
                    </tr>
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
