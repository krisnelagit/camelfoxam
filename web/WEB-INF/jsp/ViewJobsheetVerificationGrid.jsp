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
        <h2>Jobsheet Verification</h2>
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
                            <c:if test="${!sessionScope.USERTYPE.equals('spares')}">
                                <a href="converttoinovice?jsid=${ob.jsid}&carbrandid=${ob.branddetailid}&isinc=${ob.isinvoiceconverted}"><img src="images/c_invoiceh.png" width="17" height="17" /></a>&nbsp;&nbsp;
                                <a href="jobVerificationView?jsid=${ob.jsid}&istkdone=${ob.istaskcompleted}"><img src="images/verify.png" width="17" height="17" /></a>&nbsp;&nbsp;
                                </c:if>
                        </td>
                    </tr>  
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>                
            </tbody>
        </table>
    </body>
</html>
