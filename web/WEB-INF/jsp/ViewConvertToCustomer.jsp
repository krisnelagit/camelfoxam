<%-- 
    Document   : ViewConvertToCustomer
    Created on : 02-Jul-2015, 11:53:30
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Convert to customer</title>
    </head>
    <body>
        <h2>Lead Details</h2>
        <br>
        <br>
        <form method="POST" action="addConvertCustomer">
            <input type="hidden" name="name" value="${enquirydtl.custname}" />
            <input type="hidden" name="enquiryid" value="${param.enquiryid}" />
            <input type="hidden" name="mobilenumber" value="${enquirydtl.mobile}" />
            <input type="hidden" name="email" value="${enquirydtl.email}" />
            <textarea hidden="" name="address">${enquirydtl.location}</textarea>
            <table cellpadding="5" width="100%">
                <tbody>
                    <tr>
                        <td align="left" valign="top" width="13%">Date</td>
                        <td align="left" valign="top" width="28%">
                            ${enquirydtl.date}
                        </td>
                        <td align="left" valign="top" width="8%">Name</td>
                        <td align="left" valign="top" width="51%">${enquirydtl.custname}</td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Email</td>
                        <td align="left" valign="top">${enquirydtl.email}</td>
                        <td align="left" valign="top">Mobile</td>
                        <td align="left" valign="top">${enquirydtl.mobile}</td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Car brand</td>
                        <td align="left" valign="top">${enquirydtl.name}</td>
                        <td align="left" valign="top">Car model</td>
                        <td align="left" valign="top">${enquirydtl.vehiclename}</td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Lead Source</td>
                        <td align="left" valign="top">
                            ${enquirydtl.leadsource}
                        </td>
                        <td align="left" valign="top">Location</td>
                        <td align="left" valign="top">${enquirydtl.location}</td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Lead Owner</td>
                        <td align="left" valign="top">${enquirydtl.leadowner}</td>
                        <td align="left" valign="top">Status</td>
                        <td align="left" valign="top">
                            ${enquirydtl.status}
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Requirement</td>
                        <td colspan="3" align="left" valign="top">${enquirydtl.requirement}</td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">&nbsp;</td>
                        <td align="left" valign="top">&nbsp;</td>
                        <td align="left" valign="top">&nbsp;</td>
                        <td align="left" valign="top"><input type="submit" value="Convert" class="view3" style="cursor: pointer" /></td>
                    </tr>
                </tbody>
            </table>                
        </form>
    </body>
</html>
