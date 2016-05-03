<%-- 
    Document   : AddCustomer
    Created on : 18-Mar-2015, 16:37:43
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Customer</title>
    </head>
    <body>
        <a href="<%=request.getHeader("referer").toString()%>" class="view">Back</a>
        <h2>Customer Create</h2>
        <br />
        <form action="addCustomer" method="POST" onsubmit="var text = document.getElementById('address').value; if(text.length > 100) { alert('only 100 characters allowed for address'); return false; } return true;">        
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Customer Name</td>
                    <td width="66%" align="left" valign="top"><input type="text" pattern=".{3,20}" required="" title="3 to 20 characters max name allowed" name="name" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Address</td>
                    <td width="66%" align="left" valign="top"><textarea name="address" id="address" maxlength="120" rows="4" cols="20"></textarea></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Mobile Number</td>
                    <td width="66%" align="left" valign="top"><input type="text" required="" pattern="^[789]\d{9}$" title="Please enter a valid mobilenumber" name="mobilenumber" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Email</td>
                    <td width="66%" align="left" valign="top"><input type="text" required="" pattern="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?" title="Please enter a valid email" name="email" id="textfield2" /></td>
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
