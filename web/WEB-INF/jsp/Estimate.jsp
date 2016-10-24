<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ServiceCheckList
    Created on : 24 Apr, 2015, 12:55:26 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Service CheckList</title>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">        
        <script src="js/jquery.dataTables.js"></script>
        <script>
            $(document).ready(function () {
                $('#table_id').DataTable();
            });
        </script>
    </head>
    <body>
        <h2>Estimate</h2>
        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Date</td>
                    <td>Estimate</td>
                    <td>Customer name</td>
                    <td>Vehicle Model</td>
                    <td>Vehicle No.</td>
                    <td>Cust. Approval</td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="ob" items="${estimatedtls}">
                    <tr>
                        <td align="left">
                            <fmt:formatDate type="date" value="${ob.savedate}" /> 
                        </td>
                        <td align="left">${ob.estid}</td>
                        <td align="left">${ob.custname}</td>
                        <td align="left">${ob.carmodel}</td>
                        <td align="left">${ob.vehiclenumber}</td>
                        <td align="left">${ob.approval}</td>
                        <td align="left">
                            <c:choose>
                                <c:when test="${ob.isjobsheetready=='No' && ob.approval=='Yes' && ob.confirm_estimate=='Yes'}">
                                    <c:if test="${!sessionScope.USERTYPE.equals('spares')}">
                                        <a href="jobsheet-add?estid=${ob.estid}&jsre=${ob.isjobsheetready}"><img src="images/psjs.png" width="14" height="16" title="Create Job Sheet"/></a> &nbsp;
                                        </c:if>
                                    </c:when>
                                </c:choose>

                            <c:if test="${sessionScope.USERTYPE.equals('admin') || sessionScope.USERTYPE.equals('crm') || sessionScope.USERTYPE.equals('floor manager')}">
                                <c:if test="${ob.approval=='No'}">
                                    <a href="estimategridlink?estimateid=${ob.estid}&jsre=${ob.isjobsheetready}"><img src="images/Accept_file_or_checklist_24.png" width="16" height="15" />&nbsp;</a>
                                    </c:if>                                            
                                </c:if>
                                <c:if test="${sessionScope.USERTYPE.equals('admin') || sessionScope.USERTYPE.equals('spares') || sessionScope.USERTYPE.equals('crm') || sessionScope.USERTYPE.equals('floor manager')}">
                                    <c:if test="${ob.isjobsheetready=='No'}">
                                    <a href="editEstimatePage?estid=${ob.estid}"><img src="images/edit.png" width="16" height="15" />&nbsp;</a>
                                    </c:if>
                                </c:if>
                            <a href="estimate-view?estid=${ob.estid}"><img src="images/view.png" width="21" height="13" /></a>&nbsp; 
                            <a href="estimate-viewmail?estid=${ob.estid}"><img src="images/email.png" width="15" /></a>&nbsp; 
                                <c:choose>
                                    <c:when test="${ob.enableDelete=='Yes'}">
                                    <a onclick="confirmdelete('${ob.estid}', this);"><img src="images/delete.png" width="16" height="17" /></a>
                                    </c:when>
                                </c:choose>

                            <!--<img src="images/delete.png" width="16" height="17" />-->
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

    </body>
</html>
