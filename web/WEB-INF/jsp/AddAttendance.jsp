<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
+<%-- 
    Document   : AddAttendance
    Created on : 03-Jul-2015, 12:12:34
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Attendance</title>
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        <script>
            $(document).ready(function () {

                
            });
        </script>
    </head>
    <body>
        <form method="POST" action="insertAttendance">
            <table width="100%" cellpadding="5">
                <tr>
                    <td align="left" valign="top" >
                        Date : <input name="date" class="fpdatepicker" value="${todaysDate}" readonly="" id="newLastfollowup"   type="text">
                    </td>
                    <td align="right" valign="top">
                        <a href="viewAttendance" class="view">View Attendance</a>
                    </td>
                </tr>
            </table>
            <br>
            <br>
            <table  width="100%" cellpadding="5">
                <tbody>
                    <c:forEach var="ob" items="${employeedetails}">
                        <tr>
                            <td>${ob.employee_name}<input type="hidden" name="employee_ids" value="${ob.employee_id}" /></td>
                            <td>
                                <select name="attendanceStatus">
                                    <option value="N/A" selected="">N/A</option>
                                    <option value="Present">Present</option>
                                    <option value="Absent">Absent</option>
                                    <option value="Half-day">Half-day</option>
                                    <option value="Overtime">Overtime</option>
                                    <option value="Holiday">Holiday</option>
                                </select>
                            </td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td>&nbsp;</td>
                        <td><input type="submit" value="Save" class="view3" style="cursor: pointer" /></td>
                    </tr>
                </tbody>
            </table>

        </form>
    </body>
</html>
