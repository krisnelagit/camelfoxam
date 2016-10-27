<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewSparesCarList
    Created on : 07-Jul-2015, 11:31:51
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Car List</title>

        <script src="js/jquery.dataTables.js"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
        <script>
            $(document).ready(function () {
                $('#table_id').DataTable();
            });
        </script>
    </head>
    <body><a href="createOldCarParts" class="view">Create</a>
        <h2>Vehicle list</h2>
        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <th>Sr No.</th>
                    <th>Brand id</th>
                    <th>&nbsp;</th>
                    <th>Car name</th>
                    <th>&nbsp;</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="count" value="1"></c:set>
                <c:forEach var="ob" items="${sparesVehicleDetails}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.id}</td>
                        <td align="left">${ob.name}</td>
                        <td align="left">${ob.vehiclename}</td>
                        <td align="left"> 
                            <a href="viewOldSparesList?id=${ob.branddetailid}"><img src="images/Enter_Left.png" width="16" height="17" /></a>                        
                        </td>
                    </tr>
                    <c:set var="count" value="${count+1}"></c:set>
                </c:forEach>
            </tbody>
        </table>
        <script>
            $(document).ready(function () {
                var table = $('#table_id').DataTable();

                $("#table_id thead th").each(function (i) {
                    if (i == 2) {


                        var select = $('<select><option value="">--Brands--</option><option value="">All</option></select>')
                                .appendTo($(this))
                                .on('change', function () {
                                    table.column(i)
                                            .search($(this).val())
                                            .draw();
                                });

                        table.column(i).data().unique().sort().each(function (d, j) {
                            select.append('<option value="' + d + '">' + d + '</option>')
                        });

                    }
                });
            });
        </script>


    </body>
</html>
