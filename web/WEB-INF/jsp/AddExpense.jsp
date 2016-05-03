<%-- 
    Document   : AddExpense
    Created on : 06-Jun-2015, 19:05:55
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Expense</title>
    </head>
    <body>
        <a href="brandMasterLink" class="view">Back</a>
        <h2>Expense Create</h2>
        <br />
        <form action="addBrand" method="POST">
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Ledger Name</td>
                    <td width="66%" align="left" valign="top"><input type="text" required name="name" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Amount</td>
                    <td width="66%" align="left" valign="top"><input type="text" required name="name" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Tax</td>
                    <td width="66%" align="left" valign="top"><input type="text" required name="name" id="textfield2" /></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td><input type="submit" value="Save" class="view2" />&nbsp;&nbsp;&nbsp;</td>
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
