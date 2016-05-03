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
        <title>Add Car Parts</title>        
    </head>
    <body>
        <form action="insertgenericcarparts" method="post">
            <a href="viewGenericVehicleList" class="view">Back</a>
            <h2>Car Parts</h2>
            <br />

            <table width="100%" cellpadding="5">
                <tr>
                    <td align="left" valign="top">Part name</td>
                    <td align="left" valign="top"><input type="text" required="" name="name" id="textfield5" /></td>
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
                    <td>&nbsp;</td>
                    <td> 
                        <input type="hidden" name="itemtype" value="part" />
                        <input type="submit" value="Save" class="view3" /> &nbsp;&nbsp;&nbsp;
                        <input type="reset" value="Reset" class="view3" />
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </form>
    </body>
</html>
