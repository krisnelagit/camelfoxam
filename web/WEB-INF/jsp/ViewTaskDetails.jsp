<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewTaskDetails
    Created on : 15-May-2015, 10:56:52
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Tasks</title>
        <link href="css/csstable.css" rel="stylesheet" type="text/css" />
        <script>
            $(document).ready(function () {

                $(".timeconsumed").each(function (i, obj) {
                    var minutes = $(this).text();
                    var realmin = minutes % 60
                    var hours = Math.floor(minutes / 60);
                    $(this).text(hours + "hr " + realmin + "min");
                });

            });

            function confirmplay(id, status, ob)
            {
                var res = confirm('Are you sure you want to play?');
                if (res == true)
                {


                    var dt = new Date();
                    var hours = dt.getHours();
                    var min = dt.getMinutes() / 100;
                    var time = dt.getHours() + ":" + dt.getMinutes();

                    $.ajax({
                        type: "post",
                        url: "playtask",
                        data: {id: id, status: status, starttime: time, deskname: "taskboard"
                        },
                        success: function (data) {
                            if (data === 'stop') {
                                alert("This task is already stopped you cannot! start again");
                            } else {
                                $(ob).closest(".track-play-stop").find(".play").attr('src', 'images/arrow_green.png');
                                $(ob).closest(".track-play-stop").find(".pause").attr('src', 'images/pause_grey.png');
                                $(ob).closest(".track-play-stop").find(".stop").attr('src', 'images/tick_grey.png');
                                $(ob).closest(".track-play-stop").find(".timeconsumed").text('');
                            }
                        },
                        error: function () {
                        }
                    });
                }
            }

            function confirmpause(id, status, ob)
            {
                var res = confirm('Are you sure you want to pause?');
                if (res == true)
                {

                    var dt = new Date();
                    var hours = dt.getHours();
                    var min = dt.getMinutes() / 100;
                    var time = dt.getHours() + ":" + dt.getMinutes();

                    $.ajax({
                        type: "post",
                        url: "pausetask",
                        data: {id: id, status: status, endtime: time, deskname: "taskboard"
                        },
                        success: function (data) {
                            var splitvar = data.split(',');
                            if (splitvar[0] === 'stop') {
                                alert("This task is already! finished");
                            } else {
                                $(ob).closest(".track-play-stop").find(".play").attr('src', 'images/arrow_grey.png');
                                $(ob).closest(".track-play-stop").find(".pause").attr('src', 'images/pause_green.png');
                                $(ob).closest(".track-play-stop").find(".stop").attr('src', 'images/tick_grey.png');
                                var realmin1 = splitvar[1] % 60
                                var hours1 = Math.floor(splitvar[1] / 60);
                                $(ob).closest(".track-play-stop").find(".timeconsumed").text(hours1 + "hr " + realmin1 + "min");
                            }
                        },
                        error: function () {
                        }
                    });
                }
            }

            function confirmtask(id, status, ob)
            {
                var res = confirm('Are you sure task is complete?');
                if (res == true)
                {
                    $(ob).closest(".track-play-stop").find(".play").attr('src', 'images/arrow_grey.png');
                    $(ob).closest(".track-play-stop").find(".pause").attr('src', 'images/pause_grey.png');
                    $(ob).closest(".track-play-stop").find(".stop").attr('src', 'images/tick_green.png');
                    var dt = new Date();
                    var hours = dt.getHours();
                    var min = dt.getMinutes() / 100;
                    var time = dt.getHours() + ":" + dt.getMinutes();
                    var jobid = $("#jobno").val();
//                    alert(jobid);

                    $.ajax({
                        type: "post",
                        url: "showtaskdetail",
                        data: {id: id, status: status, endtime: time, deskname: "taskboard", jobid: jobid
                        },
                        success: function (data) {
                            if (data) {
                                var realmin1 = data % 60
                                var hours1 = Math.floor(data / 60);
                                $(ob).closest(".track-play-stop").find(".timeconsumed").text(hours1 + "hr " + realmin1 + "min");
                            }
                        },
                        error: function () {
                        }
                    });
                }
            }
            function printContent(el) {
                var restorepage = document.body.innerHTML;
                var printcontent = document.getElementById(el).innerHTML;
                document.body.innerHTML = printcontent;
                window.print();
                document.body.innerHTML = restorepage;
            }
        </script>
        <style type="text/css">
            @media print{
                #printdiv *
                {
                    font-size: 6px !important;
                }
            }  
        </style>
    </head>
    <body>
        <a href="viewJobsheetGridLink" class="view">Back</a><a href="#" class="view button-001" onclick="printContent('printdiv')">Print</a>
        <!--<a href="#" class="view" style="margin-right:10px;">Email</a>-->
        <h2>Task Board</h2>
        <br />
        <div id="printdiv">
            <form action="insertverification" method="POST">
                <table width="100%" cellpadding="5">
                    <tr>
                        <td align="left" valign="top">Date</td>
                        <td align="left" valign="top">${jsuserdtls.custdate}</td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Job No.</td>
                        <td align="left" valign="top">${jsuserdtls.jobno} <input type="hidden" id="jobno" name="jobno" value="${jsuserdtls.jobno}" /> </td>
                    </tr>
                    <tr>
                        <td width="31%" align="left" valign="top">Customer name</td>
                        <td width="69%" align="left" valign="top"><label for="textfield"></label>
                            ${jsuserdtls.custname}</td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Vehicle Make</td>
                        <td align="left" valign="top">${jsuserdtls.carbrand}</td>
                    </tr>
                    <tr>
                        <td>License Number</td>
                        <td>${jsuserdtls.licensenumber}</td>
                    </tr>
                    <tr>
                        <td>VIN No.</td>
                        <td>${jsuserdtls.vinnumber}</td>
                    </tr>
                    <tr>
                        <td>Additional work</td>
                        <td>
                            <c:choose>
                                <c:when test="${empty jsuserdtls.additionalwork}">
                                    N/A
                                </c:when>
                                <c:otherwise>
                                    ${jsuserdtls.additionalwork}                                        
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </table>
                <h2>Car parts</h2>
                <br />
                <table id="dataTable" class="CSSTableGenerator" border="0">
                    <tr>
                        <td align="left" width="6%"><strong>Sr.No.</strong></td>
                        <td align="left" width="20%"><strong>Name</strong></td>
                        <td align="left" width="30%"><strong>Description</strong></td>
                        <td align="center" width="10%"><strong>Assign Workman</strong></td>
                        <td align="center" width="14%"><strong>Estimate Time</strong></td>
                    </tr>
                    <c:set value="1" var="count"></c:set>
                    <c:forEach var="ob" items="${jobdtls}">
                        <tr>
                            <td align="center" valign="middle">${count}</td>
                            <td align="left" valign="top" ><span class="category-spacing">${ob.partname} <input type="hidden" name="jsdid" value="${ob.jsdid}" /></span></td>
                            <td align="left" valign="top">${ob.description}</td>
                            <td align="left" valign="top">${ob.workmanname}</td>
                            <td align="left" valign="top">${ob.estimatetime} &nbsp; min.</td>
                        </tr>
                        <c:set value="${count+1}" var="count"></c:set>
                    </c:forEach>
                </table>
                <br>
                <c:if test="${not empty servicedtls}">
                    <h2>Services</h2>
                    <br />
                    <table id="dataTable" class="CSSTableGenerator" border="0">
                        <tr>
                            <td align="left" width="6%"><strong>Sr.No.</strong></td>
                            <td align="left" width="20%"><strong>Name</strong></td>
                            <td align="left" width="30%"><strong>Description</strong></td>
                            <td align="center" width="10%"><strong>Assign Workman</strong></td>
                            <td align="center" width="14%"><strong>Estimate Time</strong></td>
                        </tr>
                        <c:set value="1" var="count"></c:set>
                        <c:forEach var="ob" items="${servicedtls}">
                            <tr>
                                <td align="center" valign="middle">${count}</td>
                                <td align="left" valign="top" ><span class="category-spacing">${ob.servicename} <input type="hidden" name="jsdid" value="${ob.jsdid}" /></span></td>
                                <td align="left" valign="top">${ob.description}</td>
                                <td align="left" valign="top">${ob.workmanname}</td>
                                <td align="left" valign="top">${ob.estimatetime} &nbsp; min.</td>
                            </tr>
                            <c:set value="${count+1}" var="count"></c:set>
                        </c:forEach>
                    </table>
                </c:if>
                <%--<c:forEach var="obtask" items="${taskdtls}">
                    <div class="track-time">
                        <div class="track-person">${obtask.name}</div>
                        <div class="track-est-time">${obtask.totalestimatetime} &nbsp; min.</div>
                        <div class="track-play-stop">
                            <c:choose>
                                <c:when test="${obtask.status==null}">
                                    <a onclick="confirmplay('${obtask.id}', 'play', this);"><img src="images/arrow_grey.png" class="play" height="15" width="16" >&nbsp;</a>
                                    <a onclick="confirmpause('${obtask.id}', 'pause', this);"><img src="images/pause_grey.png" class="pause" height="15" width="16" >&nbsp;</a>
                                    <a onclick="confirmtask('${obtask.id}', 'stop', this);"><img src="images/tick_grey.png" class="stop" height="16" width="16" >&nbsp;</a><br>
                                    <centre><label class="timeconsumed" name="totaltime"></label></centre>
                                    </c:when>
                                    <c:when test="${obtask.status eq 'play'}">
                                    <a onclick="confirmplay('${obtask.id}', 'play', this);"><img src="images/arrow_green.png" class="play" height="15" width="16" >&nbsp;</a>
                                    <a onclick="confirmpause('${obtask.id}', 'pause', this);"><img src="images/pause_grey.png" class="pause" height="15" width="16" >&nbsp;</a>
                                    <a onclick="confirmtask('${obtask.id}', 'stop', this);"><img src="images/tick_grey.png" class="stop" height="16" width="16" >&nbsp;</a><br>
                                    <centre><label class="timeconsumed" name="totaltime"></label></centre>
                                    </c:when>
                                    <c:when test="${obtask.status eq 'pause'}">
                                    <a onclick="confirmplay('${obtask.id}', 'play', this);"><img src="images/arrow_grey.png" class="play" height="15" width="16" >&nbsp;</a>
                                    <a onclick="confirmpause('${obtask.id}', 'pause', this);"><img src="images/pause_green.png" class="pause" height="15" width="16" >&nbsp;</a>
                                    <a onclick="confirmtask('${obtask.id}', 'stop', this);"><img src="images/tick_grey.png" class="stop" height="16" width="16" >&nbsp;</a><br>
                                    <centre><label class="timeconsumed" name="totaltime"></label></centre>
                                    </c:when>
                                    <c:when test="${obtask.status eq 'stop'}">
                                    <a onclick="confirmplay('${obtask.id}', 'play', this);"><img src="images/arrow_grey.png" class="play" height="15" width="16" >&nbsp;</a>
                                    <a onclick="confirmpause('${obtask.id}', 'pause', this);"><img src="images/pause_grey.png" class="pause" height="15" width="16" >&nbsp;</a>
                                    <a onclick="confirmtask('${obtask.id}', 'stop', this);"><img src="images/tick_green.png" class="stop" height="16" width="16" >&nbsp;</a><br>
                                    <centre><label class="timeconsumed" name="totaltime">${obtask.timeconsumed}</label></centre>
                                    </c:when>
                                </c:choose>                        
                        </div>
                    </div>
                </c:forEach>--%>
            </form>
        </div>
    </body>
</html>
