<%-- 
    Document   : AddBranch
    Created on : 16-Jun-2015, 19:12:20
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Branch</title>
    </head>
    <body>
        <a href="branchMasterLink" class="view">Back</a>
        <h2>Branch Create</h2>
        <br />
        <form action="addBranch" method="POST">        
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Branch Name</td>
                    <td width="66%" align="left" valign="top"><input type="text" pattern=".{3,40}" required="" title="3 to 40 characters max name allowed" name="name" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">P/O code</td>
                    <td width="66%" align="left" valign="top"><input type="text" pattern=".{3,4}" required="" title="3 to 4 characters max code allowed" name="purchase_ord_prefix" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">P/O details code</td>
                    <td width="66%" align="left" valign="top"><input type="text" pattern=".{3,4}" required="" title="3 to 4 characters max code allowed" name="purchase_ord_detail_prefix" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Mobile Number</td>
                    <td width="66%" align="left" valign="top"><input type="text" required="" pattern="^[789]\d{9}$" title="Please enter a valid mobilenumber" name="phonenumber" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Email</td>
                    <td width="66%" align="left" valign="top"><input type="text" required="" pattern="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?" title="Please enter a valid email" name="email" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Address</td>
                    <td width="66%" align="left" valign="top"><textarea name="address" id="address" rows="4" cols="20"></textarea></td>
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
