<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewExpensesDetails
    Created on : 08-Jun-2015, 17:46:11
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Income Details</title>
    </head>
    <body>
        <a href="generalIncomeLink" class="view">Back</a>&nbsp;&nbsp;&nbsp;<a href="editIncomeDetails?incomeid=${incomedtls.id}" class="view">Edit</a>
        <h2>View General Income</h2>
        <br />
        <table width="100%" cellpadding="5">
            <tr>
                <td width="34%" align="left" valign="top">Date</td>
                <td width="66%" align="left" valign="top">${incomedtls.income_date}</td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Ledger Name</td>
                <td width="66%" align="left" valign="top">${incomedtls.accountname}</td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Account</td>
                <td width="66%" align="left" valign="top">${incomedtls.bank_name}</td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">To</td>
                <td width="66%" align="left" valign="top">${incomedtls.towards}</td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Amount </td>
                <td width="66%" align="left" valign="top">${incomedtls.amount}&nbsp;(Rs.)</td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Tax(%)</td>
                <td width="66%" align="left" valign="top">
                    ${incomedtls.tax}&nbsp;(%)
                </td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Tax amt.(Rs.)</td>
                <td width="66%" align="left" valign="top">
                    <c:choose>
                        <c:when test="${incomedtls.taxid=='ATX1'}">
                            ${incomedtls.vat_tax}&nbsp;(Rs.)
                        </c:when>
                        <c:when test="${incomedtls.taxid=='ATX2'}">
                            ${incomedtls.service_tax}&nbsp;(Rs.)
                        </c:when>
                        <c:when test="${incomedtls.taxid=='ATX4'}">
                            ${incomedtls.vat_service_tax}&nbsp;(Rs.)
                        </c:when>
                        <c:when test="${incomedtls.taxid=='ATX3'}">
                            0&nbsp;(Rs.)
                        </c:when>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Payment Mode</td>
                <td width="66%" align="left" valign="top">${incomedtls.mode}</td>
            </tr>
            <c:choose>
                <c:when test="${incomedtls.mode=='Online'}">
                    <tr>
                        <td width="34%" align="left" valign="top">Transaction no.</td>
                        <td width="66%" align="left" valign="top">${incomedtls.tax}</td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Transaction date</td>
                        <td width="66%" align="left" valign="top">${incomedtls.transactionnumber}</td>
                    </tr>
                </c:when>
                <c:when test="${incomedtls.mode=='Cheque'}">
                    <tr>
                        <td width="34%" align="left" valign="top">Bank name</td>
                        <td width="66%" align="left" valign="top">${incomedtls.bankname}</td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Cheque no.</td>
                        <td width="66%" align="left" valign="top">${incomedtls.chequenumber}</td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Cheque date</td>
                        <td width="66%" align="left" valign="top">${incomedtls.chequedate}</td>
                    </tr>
                </c:when>
            </c:choose>
            <tr>
                <td width="34%" align="left" valign="top">Purchase Order/Invoice No.</td>
                <td width="66%" align="left" valign="top">
                    <c:choose>
                        <c:when test="${incomedtls.invoiceid==''}">
                            N/A
                        </c:when>
                        <c:otherwise>
                            ${incomedtls.invoiceid}
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Voucher No.</td>
                <td width="66%" align="left" valign="top">
                    <c:choose>
                        <c:when test="${incomedtls.vouchernumber==''}">
                            N/A
                        </c:when>
                        <c:otherwise>
                            ${incomedtls.vouchernumber}
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Total </td>
                <td width="66%" align="left" valign="top">
                    ${incomedtls.total}&nbsp;(Rs.)
                </td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Narration </td>
                <td width="66%" align="left" valign="top">
                    ${incomedtls.narration}
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>    
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <br>
    </body>
</html>
