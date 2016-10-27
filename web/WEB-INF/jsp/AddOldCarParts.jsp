<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : AddCarParts
    Created on : 01-Apr-2015, 11:55:40
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Parts</title>        
    </head>
    <body>
        <form action="insertoldcarparts" method="post">
            <a href="viewOldPartVehicleList" class="view">Back</a>
            <h2>Old Parts</h2>
            <br />

            <table width="100%" cellpadding="5">
                <tr>
                    <td align="left" valign="top">Part name</td>
                    <td align="left" valign="top"><input type="text" required="" name="name" id="textfield5" /></td>
                </tr>
                <tr>
                    <td align="left" valign="top">OEM Part No.</td>
                    <td align="left" valign="top"><input type="text" name="oempartnumber" id="textfield5" /></td>
                </tr>
                <tr>
                    <td align="left" valign="top">Part location</td>
                    <td align="left" valign="top"><input type="text" name="partlocation" id="textfield5" /></td>
                </tr>
                <tr>
                    <td align="left" valign="top">Category name</td>
                    <td align="left" valign="top">                
                        <select name="categoryid" required="">
                            <option value="">--select--</option>
                            <c:forEach var="ob" items="${catdtls}">
                                <option value="${ob.id}">${ob.name}</option>
                            </c:forEach>                        
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="left" valign="top">Type A cost: </td>
                    <td align="left" valign="top"><input type="text" required="" name="a" id="textfield5" /></td>
                </tr>
                <tr>
                    <td align="left" valign="top">Type B cost: </td>
                    <td align="left" valign="top"><input type="text" required="" name="b" id="textfield5" /></td>
                </tr>
                <tr>
                    <td align="left" valign="top">Type C cost: </td>
                    <td align="left" valign="top"><input type="text" required="" name="c" id="textfield5" /></td>
                </tr>
                <tr>
                    <td align="left" valign="top">Type D cost: </td>
                    <td align="left" valign="top"><input type="text" required="" name="d" id="textfield5" /></td>
                </tr>
                <tr>
                    <td align="left" valign="top">Show in 180: </td>
                    <td align="left" valign="top">
                        <select required="" name="showIn180">
                            <option value="">--Select--</option>
                            <option>Yes</option>
                            <option>No</option>
                        </select>
                        <input type="hidden" name="isOld" value="Yes" />
                        <input type="hidden" name="itemtype" value="part" />
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td><input type="submit" value="Save" class="view3" /> &nbsp;&nbsp;&nbsp;<input type="reset" value="Reset" class="view3" /></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </form>
    </body>
</html>
