<%-- 
    Document   : AddApprovalLimit
    Created on : 05-Jun-2015, 12:51:17
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Approval Limit</title>
    </head>
    <body>
        <a href="brandMasterLink" class="view">Back</a>
        <h2>Approval Create</h2>
        <br />
        <form action="addApprovalLimit" method="POST">
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Limit Name</td>
                    <td width="66%" align="left" valign="top"><input type="text" required name="name" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Amount(Rs.)</td>
                    <td width="66%" align="left" valign="top"><input type="text" required name="amount" id="textfield2" /></td>
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
