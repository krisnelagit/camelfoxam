<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewAllPayments
    Created on : 20-Nov-2015, 17:39:17
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View All Payments</title>    
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
        <script src="js/jquery.dataTables.js"></script>  
        <script>
            $(document).ready(function () {
                $('#table_id').DataTable();
            });
        </script>
    </head>
    <body>
        <a href="viewCustomerDetailsLink?customerid=${param.customerid}" class="view">Back</a>
        <h2>View All Payments</h2>

        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Sr. No.</td>
                    <td>Date</td>
                    <td>Name</td>
                    <td>Vehicle number</td>
                    <td>Mode</td>
                    <td>Total(Rs.)</td>
                </tr>
            </thead>
            <tbody>

                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${customerListDt}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.income_date}</td>
                        <td align="left">${ob.towards}</td>
                        <td align="left">${ob.vehiclenumber}</td>
                        <td align="left">${ob.mode}</td>
                        <td align="left">${ob.total}</td>
                    </tr>  
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach> 
            </tbody>
        </table>
    </body>
</html>
