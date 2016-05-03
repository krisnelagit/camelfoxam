<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : EditAttendance
    Created on : 10-Jul-2015, 15:17:43
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Attendance</title>
        <link href="css/csstable.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <!--<a href="service_checklist_grid.html" class="view">Back</a>-->
        <h2>Edit Attendance</h2>
        <br>
        <br>

        <form method="POST" action="updateAttendance">
            <input type="hidden" name="datedetail" value="${datedetails}" />
            <table id="dataTable" class="CSSTableGenerator" border="0">
                <tr>
                    <td align="center" valign="middle"><strong>Sr.No.</strong></td>
                    <td align="center" valign="middle"><strong>ID</strong></td>
                    <td align="center" valign="middle"><strong>Employee name</strong></td>
                    <td align="center" valign="middle"><strong>Status</strong></td>
                </tr>
                <tr> 
                    <c:set value="1" var="count"></c:set>
                    <c:forEach var="ob" items="${editAttendnaceDetails}">
                        <td align="center" valign="middle">${count}</td>
                        <td align="center" valign="middle">${ob.employee_id}<input type="hidden" name="id" value="${ob.id}" /></td>
                        <td align="left" valign="middle">${ob.employee_name}</td>
                        <td align="center" valign="middle">
                            <select name="attendanceStatus">
                                <c:choose>
                                    <c:when test="${ob.status=='P'}">
                                        <option value="N/A">N/A</option>
                                        <option value="Present" selected="">Present</option>
                                        <option value="Absent">Absent</option>
                                        <option value="Half-day">Half-day</option>
                                        <option value="Overtime">Overtime</option>
                                        <option value="Holiday">Holiday</option>
                                    </c:when>
                                    <c:when test="${ob.status=='A'}">
                                        <option value="N/A">N/A</option>
                                        <option value="Present">Present</option>
                                        <option value="Absent" selected="">Absent</option>
                                        <option value="Half-day">Half-day</option>
                                        <option value="Overtime">Overtime</option>
                                        <option value="Holiday">Holiday</option>
                                    </c:when>
                                    <c:when test="${ob.status=='N/A'}">
                                        <option value="N/A" selected="">N/A</option>
                                        <option value="Present">Present</option>
                                        <option value="Absent">Absent</option>
                                        <option value="Half-day">Half-day</option>
                                        <option value="Overtime">Overtime</option>
                                        <option value="Holiday">Holiday</option>
                                    </c:when>
                                    <c:when test="${ob.status=='H'}">
                                        <option value="N/A">N/A</option>
                                        <option value="Present">Present</option>
                                        <option value="Absent">Absent</option>
                                        <option value="Half-day" selected="">Half-day</option>
                                        <option value="Overtime">Overtime</option>
                                        <option value="Holiday">Holiday</option>
                                    </c:when>
                                    <c:when test="${ob.status=='O'}">
                                        <option value="N/A">N/A</option>
                                        <option value="Present">Present</option>
                                        <option value="Absent">Absent</option>
                                        <option value="Half-day">Half-day</option>
                                        <option value="Overtime" selected="">Overtime</option>
                                        <option value="Holiday">Holiday</option>
                                    </c:when>
                                    <c:when test="${ob.status=='OF'}">
                                        <option value="N/A">N/A</option>
                                        <option value="Present">Present</option>
                                        <option value="Absent">Absent</option>
                                        <option value="Half-day">Half-day</option>
                                        <option value="Overtime">Overtime</option>
                                        <option value="Holiday" selected="">Holiday</option>
                                    </c:when>
                                </c:choose>
                            </select>
                        </td>                
                    </tr>
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>
            </table>
            <br>
            <br>
            <center>
                <input value="Update" class="view3" style="cursor: pointer" type="submit">
            </center>
        </form>
    </body>
</html>
