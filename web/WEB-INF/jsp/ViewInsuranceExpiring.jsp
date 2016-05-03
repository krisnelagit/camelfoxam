<%-- 
    Document   : ViewInsuranceExpiring
    Created on : 25-May-2015, 18:45:31
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Insurance Expiring</title>
    </head>
    <body>
        <h2>Insurance Expiring Details</h2>
        <br>
        <br>
        <table cellpadding="5" width="100%">
            <tbody>
                <tr>
                    <td align="left" valign="top" width="13%">id</td>
                    <td align="left" valign="top" width="28%">
                        ${insurancedetailsdt.id}
                    </td>
                </tr>
                 <tr>
                    <td width="34%" align="left" valign="top">Mobile no.</td>
                    <td width="66%" align="left" valign="top">${insurancedetailsdt.mobilenumber}</td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Customer Name</td>
                    <td width="66%" align="left" valign="top">${insurancedetailsdt.custname}</td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Email id.</td>
                    <td width="66%" align="left" valign="top">${insurancedetailsdt.email}</td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Address</td>
                    <td width="66%" align="left" valign="top">${insurancedetailsdt.address}</td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Policy no.</td>
                    <td width="66%" align="left" valign="top">${insurancedetailsdt.policyno}</td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Current Ins Company</td>
                    <td width="66%" align="left" valign="top">${insurancedetailsdt.insurancecompanyname}</td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Policy Type</td>
                    <td width="66%" align="left" valign="top">${insurancedetailsdt.type}</td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Expiry Date</td>
                    <td width="66%" align="left" valign="top">${insurancedetailsdt.expirydate}</td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">IDV of Vehicle</td>
                    <td width="66%" align="left" valign="top">${insurancedetailsdt.idv}</td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Vehicle Make</td>
                    <td width="66%" align="left" valign="top">
                        ${insurancedetailsdt.brandname}
                    </td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Vehicle Model</td>
                    <td width="66%" align="left" valign="top">
                        ${insurancedetailsdt.vehiclename}
                    </td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Year of Manufacturer</td>
                    <td width="66%" align="left" valign="top">${insurancedetailsdt.yearofmanufacturer}</td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Engine CC</td>
                    <td width="66%" align="left" valign="top">${insurancedetailsdt.enginecc}</td>
                </tr>
            </tbody>
        </table>
    <center>
        <a href="editInsuranceDetailsLink?insuranceid=${insurancedetailsdt.id}&brandid=${insurancedetailsdt.brandid}" class="view">Edit</a> &nbsp;&nbsp;
    </center>
</body>
</html>