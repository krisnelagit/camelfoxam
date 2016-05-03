<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : EnquiriesGrid
    Created on : 18-May-2015, 13:45:18
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Enquiries Grid</title>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">        
        <script src="js/jquery.dataTables.js"></script>
        <script>
            $(document).ready(function () {
                $('#table_id').DataTable();
            });
        </script>
    </head>
    <body>
        <a href="create_Enquiries" class="view">Create</a>
        <h2>New Enquiries</h2>

        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Sr. No.</td>
                    <td >Id</td>
                    <td >Date</td>
                    <td >Customer Name</td>
                    <td >Mobile</td>
                    <td>Location</td>
                    <td>lead source</td>
                    <td>Status</td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>
            <c:set value="1" var="count"></c:set>
            <c:forEach var="ob" items="${enquiriesDt}">
                <tr>
                    <td align="left">${count}</td>
                    <td align="left">${ob.id}</td>
                    <td align="left">${ob.date}</td>
                    <td align="left">${ob.name}</td>
                    <td align="left">${ob.mobile}</td>
                    <td align="left">${ob.location}</td>
                    <td align="left">${ob.leadsource}</td>
                    <td align="left">${ob.status}</td>
                    <td align="left"> 
                        <a href="viewConvertToCustomerPage?enquiryid=${ob.id}&iscu=${ob.iscustomer}"><img src="images/converttocustomer.png" width="16" height="17" title="Convert to customer" />&nbsp;&nbsp;&nbsp;&nbsp;</a><a href="viewEnquiriyDetailPage?enquiryid=${ob.id}"><img src="images/view.png" width="21" height="13" title="View Enquiriy Details" />&nbsp;&nbsp;&nbsp;&nbsp;</a>
                    </td>
                </tr>  
                <c:set value="${count+1}" var="count"></c:set>
            </c:forEach>

        </tbody>
    </table>


</body>
</html>
