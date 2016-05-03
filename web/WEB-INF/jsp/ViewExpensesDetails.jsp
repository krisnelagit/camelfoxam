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
        <title>View Expenses Details</title>
    </head>
    <body>
        <a href="generalExpenseLink" class="view">Back</a>&nbsp;&nbsp;&nbsp;
        <a href="editExpenseDetails?expenseid=${expensesdtls.id}" class="view">Edit</a>
        
        <h2>View General Expenses</h2>
        <br />
        <table width="100%" cellpadding="5">
            <tr>
                <td width="34%" align="left" valign="top">Date</td>
                <td width="66%" align="left" valign="top">${expensesdtls.expense_date}</td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Ledger Name</td>
                <td width="66%" align="left" valign="top">${expensesdtls.accountname}</td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Bill number</td>
                <td width="66%" align="left" valign="top">
                    <c:choose>
                        <c:when test="${empty expensesdtls.expense_billnumber}">
                            N/A
                        </c:when>
                        <c:otherwise>
                            ${expensesdtls.expense_billnumber}
                        </c:otherwise>
                    </c:choose></td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Bill date</td>
                <td width="66%" align="left" valign="top">
                    <c:choose>
                        <c:when test="${empty expensesdtls.bill_date}">
                            N/A
                        </c:when>
                        <c:otherwise>
                            ${expensesdtls.bill_date}
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Account</td>
                <td width="66%" align="left" valign="top">${expensesdtls.bank_name}</td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">To</td>
                <td width="66%" align="left" valign="top">${expensesdtls.towards}</td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Amount </td>
                <td width="66%" align="left" valign="top">${expensesdtls.amount}&nbsp;(Rs.)</td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Tax(%)</td>
                <td width="66%" align="left" valign="top">
                    ${expensesdtls.tax}&nbsp;(%)
                </td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Tax amt.(Rs.)</td>
                <td width="66%" align="left" valign="top">
                    <c:choose>
                        <c:when test="${expensesdtls.taxid=='ATX1'}">
                            ${expensesdtls.vat_tax}&nbsp;(Rs.)
                        </c:when>
                        <c:when test="${expensesdtls.taxid=='ATX2'}">
                            ${expensesdtls.service_tax}&nbsp;(Rs.)
                        </c:when>
                        <c:when test="${expensesdtls.taxid=='ATX4'}">
                            ${expensesdtls.vat_service_tax}&nbsp;(Rs.)
                        </c:when>
                        <c:when test="${expensesdtls.taxid=='ATX3'}">
                            0&nbsp;(Rs.)
                        </c:when>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Payment Mode</td>
                <td width="66%" align="left" valign="top">${expensesdtls.mode}</td>
            </tr>
            <c:choose>
                <c:when test="${expensesdtls.mode=='Online'}">
                    <tr>
                        <td width="34%" align="left" valign="top">Transaction no.</td>
                        <td width="66%" align="left" valign="top">${expensesdtls.tax}</td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Transaction date</td>
                        <td width="66%" align="left" valign="top">${expensesdtls.transactionnumber}</td>
                    </tr>
                </c:when>
                <c:when test="${expensesdtls.mode=='Cheque'}">
                    <tr>
                        <td width="34%" align="left" valign="top">Bank name</td>
                        <td width="66%" align="left" valign="top">${expensesdtls.bankname}</td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Cheque no.</td>
                        <td width="66%" align="left" valign="top">${expensesdtls.chequenumber}</td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Cheque date</td>
                        <td width="66%" align="left" valign="top">${expensesdtls.chequedate}</td>
                    </tr>
                </c:when>
                <c:when test="${expensesdtls.mode=='Card'}">
                    <tr>
                        <td width="34%" align="left" valign="top">Card details</td>
                        <td width="66%" align="left" valign="top">${expensesdtls.carddetails}</td>
                    </tr>
                </c:when>
            </c:choose>
            <tr>
                <td width="34%" align="left" valign="top">Purchase Order/Invoice No.</td>
                <td width="66%" align="left" valign="top">
                    <c:choose>
                        <c:when test="${expensesdtls.purchaseorderid==''}">
                            N/A
                        </c:when>
                        <c:otherwise>
                            ${expensesdtls.purchaseorderid}
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Voucher No.</td>
                <td width="66%" align="left" valign="top">
                    <c:choose>
                        <c:when test="${expensesdtls.vouchernumber==''}">
                            N/A
                        </c:when>
                        <c:otherwise>
                            ${expensesdtls.vouchernumber}
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Total </td>
                <td width="66%" align="left" valign="top">
                    ${expensesdtls.total}&nbsp;(Rs.)
                </td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Narration </td>
                <td width="66%" align="left" valign="top">
                    ${expensesdtls.narration}
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
