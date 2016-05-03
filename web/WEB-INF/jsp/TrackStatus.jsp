<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : TrackStatus
    Created on : 23 Mar, 2016, 9:53:00 AM
    Author     : manish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Track Status</title>
        <link href="css/csstable2.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <a href="viewCustomerSearchLink?customerid=${param.custid}" class="view">Back</a>
        <table width="56%" border="0" cellpadding="5" class="CSSTableGenerator">
            <tr>
                <td width="70%" align="left" valign="top" bgcolor="#1bb2e9" style="color:#FFF"><strong>Process</strong></td>
                <td width="30%" align="left" valign="top" bgcolor="#1bb2e9" style="color:#FFF"><strong>Status</strong></td>
            </tr>
            <tr>
                <td align="left" valign="top" bgcolor="#f4f4f4">Service Checklist</td>
                <td align="left" valign="top" bgcolor="#f4f4f4">
                    <c:choose>
                        <c:when test="${trackdt.servicechecklist=='Yes'}">
                            <img src="images/done.png"/> &nbsp;<a href="viewServiceCheckList.html?id=${trackdt.checklistid}&bdid=${trackdt.brandid}"><img src="images/view.png" width="21" height="13" title="View Service CheckList" /></a>
                        </c:when>
                        <c:otherwise>
                            <img src="images/notdone.png"/>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td align="left" valign="top" bgcolor="#f4f4f4">180 Point Checklist</td>
                <td align="left" valign="top" bgcolor="#f4f4f4">
                    <c:choose>
                        <c:when test="${trackdt.pointready=='Yes'}">
                            <img src="images/done.png"/> &nbsp;<a href="180pointchecklistviewdetails?pclid=${trackdt.pointid}"><img src="images/view.png" width="21" height="13" title="View 180 Point Checklist" /></a>
                        </c:when>
                        <c:otherwise>
                            <img src="images/notdone.png"/>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td align="left" valign="top" bgcolor="#f4f4f4">Estimate</td>
                <td align="left" valign="top" bgcolor="#f4f4f4">
                    <c:choose>
                        <c:when test="${trackdt.estimate=='Yes'}">
                            <img src="images/done.png"/>&nbsp;<a href="estimate-view?estid=${trackdt.estimateid}"><img src="images/view.png" width="21" height="13" title="View Estimate" /></a>
                        </c:when>
                        <c:otherwise>
                            <img src="images/notdone.png"/>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td align="left" valign="top" bgcolor="#f4f4f4">Jobsheet</td>
                <td align="left" valign="top" bgcolor="#f4f4f4">
                    <c:choose>
                        <c:when test="${trackdt.jobsheet=='Yes'}">
                            <img src="images/done.png"/>&nbsp;<a href="viewTaskLink?jsid=${trackdt.jobid}"><img src="images/view.png" width="21" height="13" title="View Jobsheet" /></a>
                        </c:when>
                        <c:otherwise>
                            <img src="images/notdone.png"/>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td align="left" valign="top" bgcolor="#f4f4f4">Spare Requisition</td>
                <td align="left" valign="top" bgcolor="#f4f4f4">
                    <c:choose>
                        <c:when test="${trackdt.sparepart=='Yes'}">
                            <img src="images/done.png"/>&nbsp;<a href="viewRequisitionDetailsLink?jsid=${trackdt.jobid}"><img src="images/view.png" width="21" height="13" title="View Spare Requisition" /></a>
                        </c:when>
                        <c:otherwise>
                            <img src="images/notdone.png"/>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td align="left" valign="top" bgcolor="#f4f4f4">Jobsheet Verification</td>
                <td align="left" valign="top" bgcolor="#f4f4f4">
                    <c:choose>
                        <c:when test="${trackdt.cleaning=='Yes'}">
                            <img src="images/done.png"/>&nbsp;<a href="jobVerificationView?jsid=${trackdt.jobid}"><img src="images/view.png" width="21" height="13" title="View Verification" /></a>
                        </c:when>
                        <c:otherwise>
                            <img src="images/notdone.png"/>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td align="left" valign="top" bgcolor="#f4f4f4">Invoice</td>
                <td align="left" valign="top" bgcolor="#f4f4f4">
                    <c:choose>
                        <c:when test="${trackdt.invoice=='Yes'}">
                            <img src="images/done.png"/>&nbsp;<a href="viewCustomerInsuranceInvoice?invoiceid=${trackdt.invoiceid}"><img src="images/view.png" width="21" height="13" title="View Invoice" /></a>
                        </c:when>
                        <c:otherwise>
                            <img src="images/notdone.png"/>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </table>

    </body>
</html>
