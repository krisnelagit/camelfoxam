<%-- 
    Document   : AddTax
    Created on : 26-May-2015, 17:40:40
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Tax</title>
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
        <h2>Tax Create</h2>
        <br />
        <form action="addTaxes" method="POST"> 
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Tax Name</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="name" id="textfield2" pattern=".{3,20}" required="" title="3 to 20 characters max name allowed" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Percentage</td>
                    <td width="66%" align="left" valign="top"><input id="numberbox" type='number' step="0.01" name="percent" ></td>
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
