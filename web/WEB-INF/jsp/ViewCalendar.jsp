<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewCalendar
    Created on : 20-May-2015, 17:01:20
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Full Calendar</title>
        <link href='css/fullcalendar.css' rel='stylesheet' />
        <link href='css/fullcalendar.print.css' rel='stylesheet' media='print' />
        <script src='js/moment.min.js'></script>
        <!--<script src='js/jquery.min.js'></script>-->
        <script src='js/fullcalendar.min.js'></script>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">        
        <script src="js/jquery.dataTables.js"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery.datetimepicker.css"/>
        <script src="js/jquery.datetimepicker.js"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery-ui_1.css">
        <script src="js/jquery-ui.js"></script>
        <link href='css/jquery.qtip.css' rel='stylesheet' />
        <script src='js/jquery.qtip.min.js'></script>
        <script>

            $(document).ready(function () {

                $(".calendar_view").hide();
                $('#table_id').DataTable();
                $("#Appointmentgrid").hide();
                var fullDate = new Date()
                var twoDigitMonth = ((fullDate.getMonth().length + 1) === 1) ? (fullDate.getMonth() + 1) : '0' + (fullDate.getMonth() + 1);
                var dd = fullDate.getDate();
                var todaydate;
                var currentDate;
                if (dd < 10) {
                    todaydate = '0' + dd
                    currentDate = fullDate.getFullYear() + "-" + twoDigitMonth + "-" + todaydate;
                }else{
                    currentDate = fullDate.getFullYear() + "-" + twoDigitMonth + "-" + dd;
                }

                $('#calendar').fullCalendar({
                    header: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'month,basicWeek,basicDay'
                    },
                    eventDrop: function (event, delta, revertFunc, jsEvent, ui, view) {
                        var moddate = event.start.format();
                        var urlandidanddatetime = event.url;
                        var onlyapointmentid = urlandidanddatetime.substring(urlandidanddatetime.indexOf('=') + 1, urlandidanddatetime.indexOf('&') + 0);
                        moddate += ' ' + urlandidanddatetime.substring(urlandidanddatetime.lastIndexOf("-") + 4);

                        var res = confirm("Are you sure about this change?");
                        if (res) {
                            $.ajax({
                                url: "updateAppointmentDate",
                                dataType: 'json',
                                type: 'POST',
                                data: {
                                    datetime: moddate, apid: onlyapointmentid
                                },
                                success: function (data) {
                                    if (data) {
                                        alert("success..!!");
                                    }
                                },
                                error: function () {
                                }
                            });
                        } else {
                            revertFunc();
                        }
                    },
                    droppable: false,
                    defaultDate: currentDate,
                    editable: true,
                    eventLimit: true, // allow "more" link when too many events
                    eventMouseover: function (event, jsEvent, view) {
//                        alert("Event start: "+event.start+" title: "+event.title+" description "+event.description);
                        $('.fc-content').qtip({
                            content: '<div><h1> Subject: ' + event.title + '</h1> <span class="span_textDiv">Customer: ' + event.customername + '</span> <span class="span_textDiv">Appointment owner: ' + event.owner + '</span> <span class="span_textDiv">Description: ' + event.description + '</span> <span class="span_textDiv">Date & time: ' + event.datetime + '</span></div>'
                        });

//                        $('.fc-day', this).append('<div id=\"' + event.start + '\" class=\"hover-end\">hello</div>');
                    },
                    eventMouseout: function (event, jsEvent, view) {
                        $('#' + event.start).remove();
                    },
                    events: [
            <c:forEach var="oba" items="${calendardt}">
                        {
                            title: '${oba.subject}',
                            url: 'appointmentid=${oba.id}&datetime=${oba.datetime}',
                            start: '${oba.date}',
                            datetime: '${oba.datetime}',
                            customername: '${oba.title}',
                            description: '${oba.apdescription}',
                            owner: '${oba.appointmentowner}'
                        },
            </c:forEach>
                    ]
                });

                $('#apdatetimepicker').datetimepicker({
                    format: 'Y-m-d  H:i'
                });
                //setting current date time in appointment popup
                var monthNames = [
                    "01", "02", "03",
                    "04", "05", "06", "07",
                    "08", "09", "10",
                    "11", "12"];

                var date = new Date();
                var day = date.getDate();
                var monthIndex = date.getMonth();
                var year = date.getFullYear();
                var hours = date.getHours();
                var min = date.getMinutes();
                $('#apdatetimepicker').val(year+ "-" + monthNames[monthIndex] + "-" + day + "  " + hours + ":" + min);
                //end of setting date time for appointment
            });

        </script>
        <script>
            $(function () {
                $(".grid_view").click(function (e) {
                    e.preventDefault();
                    $("#Appointmentgrid").show();
                    $("#calendar").hide();
                    $(".grid_view").hide();
                    $(".calendar_view").show();
                });//END MODAL_LINK

                $(".calendar_view").click(function (e) {
                    e.preventDefault();
                    $("#Appointmentgrid").hide();
                    $("#calendar").show();
                    $(".calendar_view").hide();
                    $(".grid_view").show();
                });//END MODAL_LINK
            });//END FUNCTION
        </script>
        <style>

            #calendar {
                max-width: 900px;
                margin: 0 auto;
            }         


            .span_textDiv{
                padding: 2px 10px;
                font-size: 14px; 
                float: left;                    
            }

        </style>
    </head>
    <body>
        <a href="" class="view grid_view">Grid View</a>
        <a href="" class="view calendar_view">Calendar View</a>
        <div id='calendar'></div>

        <div id="Appointmentgrid">
            <h2>Appointments</h2>

            <br />
            <table class="display tablestyle" id="table_id">
                <thead>
                    <tr>
                        <td>Sr. No.</td>
                        <td>ID.</td>
                        <td>Date & time</td>
                        <td>Customer Name</td>
                        <td>Address</td>
                        <td>Subject</td>
                        <td>Appointment owner</td>
                        <td>Description</td>
                    </tr>
                </thead>
                <tbody>
                    <c:set value="1" var="count"></c:set>
                    <c:forEach var="obb" items="${datatabledtt}">
                        <tr>
                            <td align="left">${count}</td>
                            <td align="left">${obb.id}</td>
                            <td align="left">${obb.datetime}</td>
                            <td align="left">${obb.name}</td>
                            <td align="left">${obb.address}</td>
                            <td align="left">${obb.subject}</td>
                            <td align="left">${obb.appointmentowner}</td>
                            <td align="left">${obb.apdescription}</td>
                        </tr>
                        <c:set value="${count+1}" var="count"></c:set>
                    </c:forEach> 
                </tbody>
            </table>
        </div>



    </body>
</html>
