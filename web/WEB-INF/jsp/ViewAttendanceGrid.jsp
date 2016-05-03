<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewAttendanceGrid
    Created on : 03-Jul-2015, 18:47:13
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Attendance</title>
        <link href="css/csstable.css" rel="stylesheet" type="text/css" />
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        <script>
            $(document).ready(function () {
                $('#modps').css('width', 1034);
                $("#datepicker").datepicker();
                //popup for addng followups begin here
                $("#dialognk").hide();
                //on click of edit
                $(".edit_attendance_modal").click(function (e) {
                    e.preventDefault();
                    $("#dialognk").dialog({
                        modal: true,
                        effect: 'drop',
                        show: {
                            effect: "drop"
                        },
                        hide: {
                            effect: "drop"
                        }
                    });
                });
            });
        </script>
    </head>
    <body>
        <table width="100%" cellpadding="5">
            <tr>
                <td align="left" valign="top" >
                    <form action="showattendance" method="POST">
                        Month : 
                        <select name="months" id="months" onchange="this.form.submit()">
                            <c:forEach var="oa" items="${monthdetails}">
                                <option value="${oa.month}">${oa.month}</option>
                            </c:forEach>
                        </select>
                    </form>
                </td>
                <td align="right" valign="top">
                    <a href="" class="view edit_attendance_modal">Edit Attendance</a>
                </td>
            </tr>
        </table>
        <br>

        <table id="dataTable" class="CSSTableGenerator" border="0">
            <tbody>
                <tr>
                    <td></td>
                    <c:forEach var="i" begin="1" end="31">
                        <td>${i}</td>
                    </c:forEach>
                </tr>
                <tr>
                    <c:forEach var="ob" items="${getMonthlyattendance}">
                        <td>${ob.employee_name}</td>
                        <td>${ob.one}</td>
                        <td>${ob.two}</td>
                        <td>${ob.three}</td>
                        <td>${ob.four}</td>
                        <td>${ob.five}</td>
                        <td>${ob.six}</td>
                        <td>${ob.seven}</td>
                        <td>${ob.eight}</td>
                        <td>${ob.nine}</td>
                        <td>${ob.ten}</td>
                        <td>${ob.eleven}</td>
                        <td>${ob.tweleve}</td>
                        <td>${ob.thirteen}</td>
                        <td>${ob.fourteen}</td>
                        <td>${ob.fifteen}</td>
                        <td>${ob.sixteen}</td>
                        <td>${ob.seventeen}</td>
                        <td>${ob.eighteen}</td>
                        <td>${ob.nineteen}</td>
                        <td>${ob.twenty}</td>
                        <td>${ob.twentyone}</td>
                        <td>${ob.twentytwo}</td>
                        <td>${ob.twentythree}</td>
                        <td>${ob.twentyfour}</td>
                        <td>${ob.twentyfive}</td>
                        <td>${ob.twentysix}</td>
                        <td>${ob.twentyseven}</td>
                        <td>${ob.twentyeight}</td>
                        <td>${ob.twentynine}</td>
                        <td>${ob.thirty}</td>
                        <td>${ob.thirtyone}</td>
                    </tr>
                </c:forEach> 
            </tbody>
        </table>
        
        <!--Select date dialog begin here-->
        <div id="dialognk" title="Select Date">
            <form method="POST" action="getAttendanceDetails">

                <table cellpadding="5" width="100%">
                    <tbody>
                        <tr>
                            <td align="left" valign="top" width="25%">Date</td>
                            <td align="left" valign="top" width="75%">
                                <input type="text" id="datepicker" name="date">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">&nbsp;</td>
                            <td align="left" valign="top" width="75%"><input type="submit" class="view3" value="Submit" style="cursor: pointer" /></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
        <!--add foloowup dialog end here!-->
    </body>
</html>
