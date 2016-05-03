<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : EditVendor
    Created on : 17-Mar-2015, 17:40:10
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <a href="vendorMasterLink" class="view">Back</a>
        <h2>Vendor Edit</h2>
        <br />
        <form action="updateVendor" method="POST">  
            <input type="hidden" name="id" value="${vendorDt.id}" />
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Vendor Name</td>
                    <td width="66%" align="left" valign="top"><input type="text" required name="name" id="textfield2" value="${vendorDt.name}" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Address</td>
                    <td width="66%" align="left" valign="top"><input type="text" required name="address" id="textfield2" value="${vendorDt.address}" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Contact Person</td>
                    <td width="66%" align="left" valign="top"><input type="text" required name="contactperson" id="textfield2" value="${vendorDt.contactperson}" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Mobile Number</td>
                    <td width="66%" align="left" valign="top"><input type="number" required pattern=".{10,}" maxlength="10" name="mobilenumber" id="textfield2" value="${vendorDt.mobilenumber}" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Email</td>
                    <td width="66%" align="left" valign="top"><input type="email" name="email" id="textfield2" value="${vendorDt.email}" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">VAT Number</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="vat_number" value="${vendorDt.vat_number}" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">TIN Number</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="tin_number" value="${vendorDt.tin_number}" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Branch name</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="branch_name" value="${vendorDt.branch_name}" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Bank name</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="bank_name" value="${vendorDt.bank_name}" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">IFSC code</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="ifsc_code" value="${vendorDt.ifsc_code}" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Payment terms</td>
                    <td width="66%" align="left" valign="top">
                        <select id="paymentterms" name="paymentterms">
                            <c:choose>
                                <c:when test="${vendorDt.paymentterms=='7'}">
                                    <option value="7" selected="">7</option>
                                    <option value="15">15</option>
                                    <option value="30">30</option>
                                    <option value="60">60</option>
                                    <option value="90">90</option>
                                </c:when>
                                <c:when test="${vendorDt.paymentterms=='15'}">
                                    <option value="7">7</option>
                                    <option value="15" selected="">15</option>
                                    <option value="30">30</option>
                                    <option value="60">60</option>
                                    <option value="90">90</option>
                                </c:when>
                                <c:when test="${vendorDt.paymentterms=='30'}">
                                    <option value="7">7</option>
                                    <option value="15">15</option>
                                    <option value="30" selected="">30</option>
                                    <option value="60">60</option>
                                    <option value="90">90</option>
                                </c:when>
                                <c:when test="${vendorDt.paymentterms=='60'}">
                                    <option value="7">7</option>
                                    <option value="15">15</option>
                                    <option value="30">30</option>
                                    <option value="60" selected="">60</option>
                                    <option value="90">90</option>
                                </c:when>
                                <c:when test="${vendorDt.paymentterms=='90'}">
                                    <option value="7">7</option>
                                    <option value="15">15</option>
                                    <option value="30">30</option>
                                    <option value="60">60</option>
                                    <option value="90" selected="">90</option>
                                </c:when>
                            </c:choose>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td><input type="submit" value="Save" class="view3" style="cursor: pointer" />&nbsp;&nbsp;&nbsp;</td>
                </tr>
                <tr>    
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
            <br>
        </form>
    </body>
</html>
