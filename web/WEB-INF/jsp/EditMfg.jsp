<%-- 
    Document   : EditMfg
    Created on : 17-Mar-2015, 18:26:24
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Manufacturer</title>
    </head>
    <body>
        <a href="mfgMasterLink" class="view">Back</a>
        <h2>Manufacturer Edit</h2>
        <br />
        <form action="updateMfg" method="POST"> 
            <input type="hidden" name="id" value="${manufacturerDt.id}" />
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Manufacturer Name</td>
                    <td width="66%" align="left" valign="top"><input type="text" pattern=".{3,40}" required="" title="3 to 40 characters max name allowed" name="name" id="textfield2" value="${manufacturerDt.name}" /></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td><input type="submit" value="Save" onclick="this.disabled=true;this.form.submit()" class="view3" style="cursor: pointer" />&nbsp;&nbsp;&nbsp;</td>
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
