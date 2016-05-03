<%-- 
    Document   : AddVendor
    Created on : 17-Mar-2015, 16:02:11
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Vendor</title>        
    </head>
    <body>
        <a href="vendorMasterLink" class="view">Back</a>
        <h2>Vendor Create</h2>
        <br />
        <form action="addVendor" method="POST" onsubmit="var text = document.getElementById('address').value;
                if (text.length > 50) {
                    alert('only 50 characters allowed for address');
                    return false;
                }
                return true;">        
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Vendor Name</td>
                    <td width="66%" align="left" valign="top"><input type="text"  pattern=".{3,40}" required="" title="3 to 40 characters max name allowed" name="name" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Address</td>
                    <td width="66%" align="left" valign="top"><textarea name="address" required="" id="address" rows="4" cols="20"></textarea></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Contact Person</td>
                    <td width="66%" align="left" valign="top"><input type="text" pattern=".{3,40}" required="" title="3 to 40 characters max name allowed" name="contactperson" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Mobile Number</td>
                    <td width="66%" align="left" valign="top"><input type="number" required="" pattern="^[789]\d{9}$" title="Please enter a valid mobilenumber" name="mobilenumber" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Email</td>
                    <td width="66%" align="left" valign="top"><input type="text" required="" pattern="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?" title="Please enter a valid email" name="email" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">VAT Number</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="vat_number" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">TIN Number</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="tin_number" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Branch name</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="branch_name" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Bank name</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="bank_name" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">IFSC code</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="ifsc_code" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Payment terms</td>
                    <td width="66%" align="left" valign="top">
                        <select id="paymentterms" name="paymentterms">
                            <option value="7">7</option>
                            <option value="15">15</option>
                            <option value="30">30</option>
                            <option value="60">60</option>
                            <option value="90">90</option>
                        </select>
                    </td>
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
