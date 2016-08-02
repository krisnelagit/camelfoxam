<%-- 
    Document   : EditCustomer
    Created on : 18-Mar-2015, 16:43:42
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Customer</title>
    </head>
    <body>
        <a href="customerMasterLink" class="view">Back</a>
        <h2>Customer Edit</h2>
        <br />
        <form action="updateCustomer" method="POST">
            <input type="hidden" name="id" value="${customerDt.id}" />
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Customer Name</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="name" id="textfield2" value="${customerDt.name}" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Address</td>
                    <td width="66%" align="left" valign="top"><textarea id="textfield2" name="address" maxlength="120" id="address" rows="4" cols="20">${customerDt.address}</textarea></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Mobile Number</td>
                    <td width="66%" align="left" valign="top"><input type="text" required="" pattern="^[789]\d{9}$" title="Please enter a valid mobilenumber" name="mobilenumber" id="textfield2" value="${customerDt.mobilenumber}" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Email</td>
                    <td width="66%" align="left" valign="top"><input type="email" name="email" id="textfield2" value="${customerDt.email}" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Password</td>
                    <td width="66%" align="left" valign="top"><input type="text" value="${customerDt.password}" pattern=".{3,10}" required="" title="3 to 10 characters max password allowed" name="password" id="textfield2" /></td>
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
