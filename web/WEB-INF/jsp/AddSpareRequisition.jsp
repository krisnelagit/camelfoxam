<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : AddSpareRequisition
    Created on : 16-May-2015, 17:38:01
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Spare Requisition</title>
        <link href="css/csstable.css" rel="stylesheet" type="text/css" />
        <script>
            $(document).ready(function () {
                console.log("ready!");
            });
            function getManufacturerList(){
                var modelid=$("#carmodel").val();
                
            }
        </script>
    </head>
    <body>
        <a href="viewSpareRequisitionGrid" class="view">Back</a>
        <!--<a href="#" class="view" style="margin-right:10px;">Email</a>-->
        <c:choose>
            <c:when test="${param.isrre=='Yes'}">
                <h2>Requisition already!! created for this.</h2>
            </c:when>
            <c:otherwise>

                <h2>Spares Requisition</h2>
                <br />
                <form action="saveRequisition" method="POST">
                    <input type="hidden" name="myjsid" value="${param.jsid}" />
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
                                    <select name="mfgnames" id="mfgname">
                                        <option value="">--select--</option>
                                        <c:forEach var="obb" items="${ob.mfglist}">
                                            <option value="${obb.id}">${obb.mfgname}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td align="left" valign="top">${ob.description}</td>
                                <td align="left" valign="top">${ob.workmanname}</td>
                                <td align="left" valign="top"> 
                                    <select name="partstatus2">
                                        <option value="not assigned">not assigned</option>
                                        <option value="assigned">assigned</option>
                                        <option value="returned">returned</option>
                                    </select> 
                                </td>
                            </tr>
                            <c:set value="${count+1}" var="count"></c:set>
                        </c:forEach>
                    </table>
                    <center>        
                        <input type="submit" class="view3" style="cursor: pointer" value="Save" />&nbsp;&nbsp;&nbsp;
                    </center>
                </form>
            </c:otherwise>
        </c:choose>
    </body>
</html>
