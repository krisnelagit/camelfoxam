<%-- 
    Document   : EditTaxes
    Created on : 24-Mar-2015, 12:55:59
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Taxes</title>
        <script>
            $('#numberbox').keyup(function () {
                if ($(this).val() < 100) {
                    alert("No numbers above 100");
                    $(this).val('100');
                }
            });
        </script>
    </head>
    <body>
        <a href="taxMasterLink" class="view">Back</a>
        <h2>Taxes Edit</h2>
        <br />
        <form action="updateTaxes" method="POST">
            <input type="hidden" name="id" value="${taxesDt.id}" />
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Tax Name</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="name" id="textfield2" value="${taxesDt.name}" pattern=".{3,20}" required="" title="3 to 20 characters max name allowed"/></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Percentage</td>
                    <td width="66%" align="left" valign="top"><input id="numberbox" type='number' step="0.01" name="percent" value="${taxesDt.percent}"></td>
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
