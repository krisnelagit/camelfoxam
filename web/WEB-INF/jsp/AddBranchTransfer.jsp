<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : AddBranchTransfer
    Created on : 18-Sep-2015, 15:52:06
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Branch Transfer</title>
        <script>
            function checkTransfer() {
                var oldquantity = $("#prevqty").val();
                var enteredAmount = $("#amtentered").val();
                var actualBalance = $("#balqty").val;

                if (Number(enteredAmount) > Number(actualBalance)) {
                    alert("Please enter quantity less! than available balance.");
                    return false;
                } else {
                    if (Number(enteredAmount) > Number(oldquantity)) {
                        alert("Entered quantity cannot be greater than the inward quantity");
                        return false;
                    }
                }

            }
        </script>
    </head>
    <body>
        <a href="inventoryqty?id=${param.partid}&carmodel=${param.carmodel}" class="view">Back</a>
        <h2>Branch Transfer</h2>
        <br />
        <form action="addbranchTransfer" onsubmit="return checkTransfer()" method="POST"> 
            <input type="hidden" name="inventoryid" value="${param.id}" />
            <input type="hidden" name="oldpartid" value="${inventorydetails.partid}" />
            <table width="100%" cellpadding="5">

                <tr>
                    <td width="34%" align="left" valign="top">To branch</td>
                    <td width="66%" align="left" valign="top">
                        <select required="" name="branchid">
                            <option value="">--Select--</option>
                            <c:forEach var="ob" items="${branchlist}">
                                <option value="${ob.id}">${ob.name}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Brand</td>
                    <td width="66%" align="left" valign="top">${carnamedetails.vehiclename}<input type="hidden" name="branddetailid" value="${carnamedetails.id}" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Part Name</td>
                    <td width="66%" align="left" valign="top">${carpartvailtdt.name}<input type="hidden" name="vaultid" value="${carpartvailtdt.vaultid}" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Inward Qty.</td>
                    <td width="66%" align="left" valign="top"><input type="number" name="oldquantity" id="prevqty" readonly="" value="${inventorydetails.quantity}" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Available balance Qty.</td>
                    <td width="66%" align="left" valign="top"><input type="number" name="actualbalancequantity" id="balqty" readonly="" value="${partbalancedetails.balancequantity}" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Enter Qty.</td>
                    <td width="66%" align="left" valign="top"><input type="number" required="" name="transferquantity" id="amtentered" onchange="checkTransfer()" value="" /></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td><input type="submit" value="Save" class="view3" onsubmit="checkTransfer()" style="cursor: pointer" />&nbsp;&nbsp;&nbsp;</td>
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

