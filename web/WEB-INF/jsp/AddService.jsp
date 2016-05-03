<%-- 
    Document   : AddService
    Created on : 24-Mar-2015, 12:00:44
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Service</title>
    </head>
    <body>
        <a href="serviceMasterLink" class="view">Back</a>
        <h2>Service Create</h2>
        <br />
        <form action="addService" method="POST" onsubmit="var text = document.getElementById('description').value; if(text.length > 60) { alert('only 60 characters allowed for Description'); return false; } return true;">
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Service Name</td>
                    <td width="66%" align="left" valign="top"><input required="" type="text" name="name" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Rate A</td>
                    <td width="66%" align="left" valign="top"><input type="number" name="rate_a" required="" step="0.01" max="10000000" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Rate B</td>
                    <td width="66%" align="left" valign="top"><input type="number" name="rate_b" required=""  step="0.01" max="10000000" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Rate C</td>
                    <td width="66%" align="left" valign="top"><input type="number" name="rate_c" required=""  step="0.01" max="10000000" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Rate D</td>
                    <td width="66%" align="left" valign="top"><input type="number" name="rate_d" required=""  step="0.01" max="10000000" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Description</td>
                    <td width="66%" align="left" valign="top"><textarea name="description" required="" id="description" rows="4" cols="20"></textarea></td>
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
