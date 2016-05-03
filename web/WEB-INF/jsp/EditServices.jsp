<%-- 
    Document   : EditServices
    Created on : 24-Mar-2015, 12:08:32
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Services</title>
    </head>
    <body>
        <a href="serviceMasterLink" class="view">Back</a>
        <h2>Services Edit</h2>
        <br />
        <form action="updateServices" method="POST" onsubmit="var text = document.getElementById('address').value; if(text.length > 60) { alert('only 60 characters allowed for Description'); return false; } return true;">
            <input type="hidden" name="id" value="${servicesDt.id}" />
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Service Name</td>
                    <td width="66%" align="left" valign="top"><input type="text" required="" name="name" id="textfield2" value="${servicesDt.name}" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Rate A</td>
                    <td width="66%" align="left" valign="top"><input type="number" name="rate_a" id="textfield2" required="" maxlength="7" value="${servicesDt.rate_a}" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Rate B</td>
                    <td width="66%" align="left" valign="top"><input type="number" name="rate_b" id="textfield2" required="" maxlength="7" value="${servicesDt.rate_b}" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Rate C</td>
                    <td width="66%" align="left" valign="top"><input type="number" name="rate_c" id="textfield2" required="" maxlength="7" value="${servicesDt.rate_c}" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Rate D</td>
                    <td width="66%" align="left" valign="top"><input type="number" name="rate_d" id="textfield2" required="" maxlength="7" value="${servicesDt.rate_d}" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Description</td>
                    <td width="66%" align="left" valign="top"><textarea name="description" required="" id="description" rows="4" cols="20">${servicesDt.description}</textarea></td>
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
