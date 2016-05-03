<%-- 
    Document   : EditBranch
    Created on : 17-Jun-2015, 11:48:09
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Branch</title>
    </head>
    <body>        
        <a href="branchMasterLink" class="view">Back</a>
        <h2>Branch Edit</h2>
        <br />
        <form action="updateBranch" method="POST">
            <input type="hidden" name="id" value="${editBranchDtls.id}" />
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Branch Name</td>
                    <td width="66%" align="left" valign="top"><input value="${editBranchDtls.name}" type="text" pattern=".{3,40}" required="" title="3 to 40 characters max name allowed" name="name" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">P/O code</td>
                    <td width="66%" align="left" valign="top"><input type="text" value="${editBranchDtls.purchase_ord_prefix}" pattern=".{3,4}" required="" title="3 to 4 characters max code allowed" name="purchase_ord_prefix" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">P/O details code</td>
                    <td width="66%" align="left" valign="top"><input type="text" value="${editBranchDtls.purchase_ord_detail_prefix}" pattern=".{3,4}" required="" title="3 to 4 characters max code allowed" name="purchase_ord_detail_prefix" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Mobile Number</td>
                    <td width="66%" align="left" valign="top"><input value="${editBranchDtls.phonenumber}" type="text" required="" pattern="^[789]\d{9}$" title="Please enter a valid mobilenumber" name="phonenumber" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Email</td>
                    <td width="66%" align="left" valign="top"><input value="${editBranchDtls.email}" type="text" required="" pattern="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?" title="Please enter a valid email" name="email" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Address</td>
                    <td width="66%" align="left" valign="top"><textarea name="address" id="address" rows="4" cols="20">${editBranchDtls.address}</textarea></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td><input type="submit" value="Update" class="view3" style="cursor: pointer" />&nbsp;&nbsp;&nbsp;</td>
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
