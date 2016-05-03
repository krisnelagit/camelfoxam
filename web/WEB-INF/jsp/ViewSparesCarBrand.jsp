<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewSparesCarBrand
    Created on : 07-Jul-2015, 11:06:18
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Spares Car Brands</title>

        <script src="js/jquery.dataTables.js"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
        <script>
            $(document).ready(function () {
                $('#table_id').DataTable();
            });
        </script>
    </head>
    <body>
        <a href="CreateCarParts" class="view">Create</a>
        <h2>Brands</h2>
        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td >Sr No.</td>
                    <td>Id</td>
                    <td>Name</td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>
            <c:set var="count" value="1"></c:set>
            <c:forEach var="ob" items="${sparesCarBrandetails}">
                <tr>
                    <td align="left">${count}</td>
                    <td align="left">${ob.id}</td>
                    <td align="left">${ob.name}</td>
                    <td align="left"> <a href="viewVehicleList?id=${ob.id}"><img src="images/Enter_Left.png" width="16" height="17" /></a>
                        
                    </td>
                </tr>
                <c:set var="count" value="${count+1}"></c:set>
            </c:forEach>
        </tbody>
    </table>


</body>
</html>
