<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewRequisitionDetails
    Created on : 02-May-2015, 18:46:51
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Requisition Details</title>
        <link href="css/csstable.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <a href="viewSpareRequisitionGrid" class="view">Back</a>
        <!--<a href="#" class="view" style="margin-right:10px;">Email</a>-->
        <h2>Paints</h2>
        <br />
            <table width="100%" cellpadding="5">
                <tr>
                    <td align="left" valign="top">Date</td>
                    <td align="left" valign="top">${jsuserdtls.custdate}</td>
                </tr>
                <tr>
                    <td align="left" valign="top">Job No.</td>
                    <td align="left" valign="top">${jsuserdtls.jobno} <input type="hidden" name="jobno" value="${estcustdtls.jobno}" /> </td>
                </tr>
                <tr>
                    <td width="31%" align="left" valign="top">Customer name</td>
                    <td width="69%" align="left" valign="top"><label for="textfield"></label>
                        ${jsuserdtls.custname}</td>
                </tr>
                <tr>
                    <td align="left" valign="top">Vehicle Make</td>
                    <td align="left" valign="top">${jsuserdtls.carbrand}</td>
                </tr>
                <tr>
                    <td>License Number</td>
                    <td>${jsuserdtls.licensenumber}</td>
                </tr>
                <tr>
                    <td>VIN No.</td>
                    <td>${jsuserdtls.vinnumber}</td>
                </tr>
            </table>
            <br>
            <table id="dataTable" class="CSSTableGenerator" border="0">
                <tr>
                    <td align="left" width="6%"><strong>Sr.No.</strong></td>
                    <td align="left" width="31%"><strong>Name</strong></td>
                    <td align="left" width="22%"><strong>Manufacturer</strong></td>
                    <td align="left" width="37%"><strong>Quantity</strong></td>
                    <td align="center" width="14%"><strong>Price</strong></td>
                    <td align="center" width="14%"><strong>Amount</strong></td>
                </tr>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${jobdtls}">
                    <tr>
                        <td align="center" valign="middle">${count}</td>
                        <td align="left" valign="top" ><span class="category-spacing">${ob.partname} <input type="hidden" name="jsdid" value="${ob.id}" /></span></td>
                        <td align="left" valign="top"><span class="category-spacing">${ob.mfgname}</span></td>
                        <td align="left" valign="top">${ob.quantity}</td>
                        <td align="left" valign="top">${ob.sellingprice}</td>
                        <td align="left" valign="top">${ob.total}</td>
                    </tr>
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>
            </table>
                <c:if test="${!sessionScope.USERTYPE.equals('crm')}">
            <center>        
                <a class="view2" href="editConsumablePage?jsid=${jsuserdtls.jobno}">Edit</a>
            </center>
                </c:if>
    </body>
</html>
