<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : EditSpareRequisition
    Created on : 02-May-2015, 17:31:41
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Spare Requisition</title>
        <link href="css/csstable.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <a href="viewSpareRequisitionGrid" class="view">Back</a>
        <!--<a href="#" class="view" style="margin-right:10px;">Email</a>-->
        <h2>Spares Requisition</h2>
        <br />
        <form action="updateRequisition" method="POST">
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
                    <td align="left" width="37%"><strong>Description</strong></td>
                    <td align="center" width="14%"><strong>Assign Workman</strong></td>
                    <td align="center" width="14%"><strong>Spares Requisition</strong></td>
                </tr>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${jobpartdtls}">
                    <tr>
                        <td align="center" valign="middle">${count}</td>
                        <td align="left" valign="top" ><span class="category-spacing">${ob.partname} <input type="hidden" name="jsdid" value="${ob.jsdid}" /></span></td>
                        <td align="left" valign="top">
                            <select name="mfgnames">
                                <c:forEach var="obb" items="${ob.mfglist}">
                                    <c:choose>
                                        <c:when test="${obb.id==ob.partmfgid}">
                                            <option value="${obb.id}" selected="">${obb.mfgname}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${obb.id}">${obb.mfgname}</option>
                                        </c:otherwise>
                                    </c:choose>                                    
                                </c:forEach>
                            </select>  
                        </td>
                        <td align="left" valign="top">${ob.description}</td>
                        <td align="left" valign="top">${ob.workmanname}</td>
                        <td align="left" valign="top"> 
                            <select name="partstatus2">
                                <c:choose>
                                    <c:when test="${ob.partstatus=='assigned'}">
                                        <option value="not assigned">not assigned</option>
                                        <option value="assigned" selected="">assigned</option>
                                        <option value="returned">returned</option>
                                    </c:when>
                                    <c:when test="${ob.partstatus=='not assigned'}">
                                        <option value="not assigned" selected="">not assigned</option>
                                        <option value="assigned" >assigned</option>
                                        <option value="returned">returned</option>
                                    </c:when>
                                    <c:when test="${ob.partstatus=='returned'}">
                                        <option value="not assigned">not assigned</option>
                                        <option value="assigned" >assigned</option>
                                        <option value="returned" selected="">returned</option>
                                    </c:when>
                                </c:choose>


                            </select> 
                        </td>
                    </tr>
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>
            </table>
            <center>  
                <c:if test="${empty errmsg}">
                    <input type="submit" class="view3" style="cursor: pointer" value="Update" />&nbsp;&nbsp;&nbsp;
                </c:if>
            </center>
        </form>
    </body>
</html>
