<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : AddFeedback
    Created on : 19-Jun-2015, 16:01:28
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Feedback</title>
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        <script>
            $(function () {
                //popup for Edit followup details
                $("#dialognkEditDetail").hide();
                //on click of edit
                $(".email_link3").click(function (e) {
                    e.preventDefault();
                    var fsid = $(this).attr('href');
                    $("#followupids").val('');
                    $("#followby").text('');
                    $("#lastfollow").text('');
                    $("#nextfollow").text('');
                    $("#followuptitle").text('');
                    $("#descfollowup").text('');
                    $.ajax({
                        url: "getFollowupDetails",
                        datatype: 'json',
                        type: 'POST',
                        data: {
                            fsid: fsid
                        },
                        cache: false,
                        success: function (data) {
                            $("#followupids").val(data[0].id);
                            $("#followby").val(data[0].followedby);
                            $("#lastfollow").val(data[0].lastfollowup);
                            $("#nextfollow").val(data[0].nextfollowup);
                            $("#followuptitle").val(data[0].title);
                            $("#descfollowup").text(data[0].fpdescription);
                            $("#followupstatus").val(data[0].fpstatus);

                            //required validations here

                            $("#followby").prop("required", true);
                            $("#lastfollow").prop("required", true);
                            $("#nextfollow").prop("required", true);
                            $("#followuptitle").prop("required", true);
                            $("#descfollowup").prop("required", true);
                            $("#followupstatus").prop("required", true);

                            //our edit dialog
                            $("#dialognkEditDetail").dialog({
                                modal: true,
                                effect: 'drop',
                                width: 600,
                                height: 450,
                                show: {
                                    effect: "drop"
                                },
                                hide: {
                                    effect: "drop"
                                }
                            });
                        }
                    });
                });
            });//END FUNCTION
        </script>
        <link rel="stylesheet" type="text/css" href="css/jquery.datetimepicker.css"/>
        <script src="js/jquery.datetimepicker.js"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
        <script src="js/jquery.dataTables.js"></script>
        <script>
            $(document).ready(function () {
                //feedback textarea javascript code written here
                var text_max = 600;
//                $('#textarea_feedback').html(text_max + ' characters remaining');

                $('#textarea').keyup(function () {
                    var text_length = $('#textarea').val().length;
                    var text_remaining = text_max - text_length;

//                    $('#textarea_feedback').html(text_remaining + ' characters remaining');
                });
                //history table initailised
                $('#table_id2').DataTable();
                //datepicke required or followup
                var currentDate = new Date();
                $(function () {
                    $(".fpdatepicker").datepicker({dateFormat: 'yy-mm-dd'});
                    $(".fpdatepicker").datepicker("option", "showAnim", 'drop');
                    $(".fpdatepicker").datepicker("setDate", currentDate);
                });

                $(function () {
                    $(".fpdatepicker2").datepicker({dateFormat: 'yy-mm-dd'});
                    $(".fpdatepicker2").datepicker("option", "showAnim", 'drop');
                    $(".fpdatepicker2").datepicker("setDate", currentDate);
                });

                $('#apdatetimepicker').datetimepicker({
                    format: 'd/m/Y  H:i'
                });

                //popup for addng followups begin here
                $("#dialognk").hide();
                //on click of edit
                $(".email_link").click(function (e) {
                    e.preventDefault();
                    $("#dialognk").dialog({
                        modal: true,
                        effect: 'drop',
                        width: 600,
                        height: 450,
                        show: {
                            effect: "drop"
                        },
                        hide: {
                            effect: "drop"
                        }
                    });

                    //required validations here
                    $("#datepicker1").prop("required", true);
                    $("#newLastfollowup").prop("required", true);
                    $("#newNextfollowup").prop("required", true);
                    $("#newtitle").prop("required", true);
                    $("#newDesc").prop("required", true);
                    $("#newStatus").prop("required", true);
                });

                //popup for followup details
                //popup for view followups begin here
                $("#dialognkDetail").hide();
                //on click of edit
                $(".email_link2").click(function (e) {
                    e.preventDefault();
                    var fsid = $(this).attr('href');
                    $("#followedby").text('');
                    $("#lastfollowup").text('');
                    $("#nextfollowup").text('');
                    $("#title").text('');
                    $("#fpdescription").text('');
                    $("#fpstatus").text('');
                    $.ajax({
                        url: "getFollowupDetails",
                        datatype: 'json',
                        type: 'POST',
                        data: {
                            fsid: fsid
                        },
                        cache: false,
                        success: function (data) {
                            $("#followedby").text(data[0].followedby);
                            $("#lastfollowup").text(data[0].lastfollowup);
                            $("#nextfollowup").text(data[0].nextfollowup);
                            $("#title").text(data[0].title);
                            $("#fpdescription").text(data[0].fpdescription);
                            $("#fpstatus").text(data[0].fpstatus);

                            //our view dialog
                            $("#dialognkDetail").dialog({
                                modal: true,
                                effect: 'drop',
                                show: {
                                    effect: "drop"
                                },
                                hide: {
                                    effect: "drop"
                                }
                            });
                        }
                    });

                });

                //on form submit
                $("#questionaire").submit(function () {
                    var checkedAtLeastOne = false;
                    $('input[type="radio"]').each(function () {
                        if ($(this).is(":checked")) {
                            checkedAtLeastOne = true;
                        }
                    });

                    if (checkedAtLeastOne == false) {
                        alert("Atleast one Question should be answered should be checked");
                        return checkedAtLeastOne;
                    }
                });


            });
        </script>
    </head>
    <body>
<!--        
        <c:choose>
            <c:when test="${invoicedtls.fbstatus=='incomplete'}">
                <a href="#" class="view email_link">Follow up</a>
            </c:when>
        </c:choose>
                -->
        <h2>Feedback</h2>
        <br>
        <table cellpadding="5" width="100%">
            <tbody>
                <tr>
                    <td align="left" valign="top" width="13%">Date</td>
                    <td align="left" valign="top" width="28%">
                        ${invoicedtls.savedate}
                    </td>
                    <td align="left" valign="top" width="8%">Name</td>
                    <td align="left" valign="top" width="51%">${invoicedtls.customername}</td>
                </tr>
                <tr>
                    <td align="left" valign="top">Mobile number</td>
                    <td align="left" valign="top">${invoicedtls.customermobilenumber}</td>
                    <td align="left" valign="top">Brand</td>
                    <td align="left" valign="top">${invoicedtls.brand}</td>
                </tr>
                <tr>
                    <td align="left" valign="top">Car model</td>
                    <td align="left" valign="top">
                        ${invoicedtls.model}
                    </td>
                    <td align="left" valign="top">Invoice id:</td>
                    <td align="left" valign="top">${invoicedtls.id}</td>
                </tr>
            </tbody>
        </table>
        <br>        
        <br>
        <br>
        <h2>Questionnaire</h2>
        <br>
        <form action="insertFeedback" id="questionaire" method="POST">
            <input type="hidden" name="id" value="${invoicedtls.fbid}" />
            <input type="hidden" name="invoiceid" value="${invoicedtls.id}" />
            <table cellpadding="5" width="100%">
                <tbody>
                    <tr>
                        <td align="left" valign="top" width="50%">How well were your queries handled by the service advisor?</td>
                        <td align="left" valign="top" width="28%">
                            <input type="radio" name="question1" checked="" value="">${invoicedtls.question1}
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" width="50%">Was the car repaired in the time frame suggested by the advisor?</td>
                        <td align="left" valign="top" width="28%">
                            <input type="radio" name="question2" checked="" value="">${invoicedtls.question2}
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" width="50%">Was the price estimate discussed with and approved by you?</td>
                        <td align="left" valign="top" width="28%">
                            <input type="radio" name="question3" checked="" value="">${invoicedtls.question3}
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" width="50%">Are you happy with the quality and overall service at Kar-Worx?</td>
                        <td align="left" valign="top" width="28%">
                            <input type="radio" name="question4" checked="" value="">${invoicedtls.question4}
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" width="50%">Would you recommend us to your friends and family?</td>
                        <td align="left" valign="top" width="28%">
                            <input type="radio" name="question5" checked="" value="">${invoicedtls.question5}
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" width="50%">What changes would you suggest if any to better our services?</td>
                        <td align="left" valign="top" width="28%">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" colspan="2" ><textarea name="question6" maxlength="600" id="textarea" rows="8" cols="90">${invoicedtls.question6}</textarea><div id="textarea_feedback"></div></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" width="50%">&nbsp;</td>
                        <td align="left" valign="top" width="28%">
                            <c:choose>
                                <c:when test="${invoicedtls.fbstatus=='incomplete'}">
                                    <input type="submit" value="Submit" class="view3" style="cursor: pointer" />
                                </c:when>
                            </c:choose>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>

<!--        <h2>History</h2>
        <br>
        <table class="display tablestyle" id="table_id2">
            <thead>
                <tr>
                    <th align="left">Date</th>
                    <th align="left">Followed by</th>
                    <th align="left">Last follow up</th>
                    <th align="left">Next follow up</th>
                    <th align="left">Title</th>
                    <th align="left">&nbsp;</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="obj" items="${followuphistorydetails}">
                    <tr>
                        <td>${obj.modifydate}</td>
                        <td>${obj.followedby}</td>
                        <td>${obj.lastfollowup}</td>
                        <td>${obj.nextfollowup}</td>
                        <td>${obj.title}</td>
                        <td><a class="email_link2" href="${obj.id}"><img src="images/view.png" alt="" width="16" height="14" title="View Detail"/></a>&nbsp;&nbsp;<a class="email_link3" href="${obj.id}"><img src="images/edit.png" alt="" width="16" height="14" title="View Detail"/></a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>-->

        <!--add followup dialog begin here-->
        <div id="dialognk" title="New Followup">
            <form method="POST" action="insertFeedbackFollowups">
                <input type="hidden" name="type" value="feedback" />
                <input type="hidden" name="feedbackid" value="${invoicedtls.fbid}" />
                <table cellpadding="5" width="100%">
                    <tbody>
                        <tr>
                            <td align="left" valign="top" width="25%">Followed by</td>
                            <td align="left" valign="top" width="75%">
                                <input name="followedby" id="datepicker1" pattern=".{3,20}" title="3 to 20 characters max name allowed" type="text">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">Last Follow up</td>
                            <td align="left" valign="top" width="75%"><input name="lastfollowup" class="fpdatepicker" id="newLastfollowup"   type="text"></td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">Next Follow up</td>
                            <td align="left" valign="top" width="75%"><input name="nextfollowup"  class="fpdatepicker2" id="newNextfollowup"  type="text"></td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">Title</td>
                            <td align="left" valign="top" width="75%"><input name="title" id="newtitle" pattern=".{3,20}" title="3 to 20 characters max name allowed" type="text"></td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">Description</td>
                            <td align="left" valign="top" width="75%"><textarea name="fpdescription" maxlength="600" id="newDesc" rows="4" cols="35"></textarea></td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">Status</td>
                            <td align="left" valign="top" width="75%">
                                <select name="fpstatus" id="newStatus" class="select">
                                    <option>Incomplete</option>
                                    <option>complete</option>
                                    <option>In Progress</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">&nbsp;</td>
                            <td align="left" valign="top" width="75%"><input type="submit" class="view3" value="Save" style="cursor: pointer" /></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
        <!--add foloowup dialog end here!-->

        <!--add followup detail dialog begin here-->
        <div id="dialognkDetail" title="Followup detail">
            <table cellpadding="5" width="100%">
                <tbody>
                    <tr>
                        <td align="left" valign="top" width="13%">Followed by</td>
                        <td align="left" valign="top" width="28%">
                            <span id="followedby"></span>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" width="8%">Last Follow up</td>
                        <td align="left" valign="top" width="51%"><span id="lastfollowup"></span></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Next Follow up</td>
                        <td align="left" valign="top"><span id="nextfollowup"></span></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Title</td>
                        <td align="left" valign="top"><span id="title"></span></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Description</td>
                        <td align="left" valign="top"><span id="fpdescription"></span></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Status</td>
                        <td align="left" valign="top">
                            <span id="fpstatus"></span>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <!--add foloowup detail dialog end here!-->

        <!--edit followup detail dialog begin here-->
        <div id="dialognkEditDetail" title="Edit followup detail">
            <form method="POST" action="editFollowups">
                <input type="hidden" name="type" value="feedback" />
                <input type="hidden" name="id" id="followupids" />
                <input type="hidden" name="feedbackid" value="${invoicedtls.fbid}" />
                <table cellpadding="5" width="100%">
                    <tbody>
                        <tr>
                            <td align="left" valign="top" width="25%">Followed by</td>
                            <td align="left" valign="top" width="75%">
                                <input name="followedby" id="followby" pattern=".{3,20}" title="3 to 20 characters max name allowed" type="text">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">Last Follow up</td>
                            <td align="left" valign="top" width="75%"><input name="lastfollowup" class="fpdatepicker" id="lastfollow"  type="text"></td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">Next Follow up</td>
                            <td align="left" valign="top" width="75%"><input name="nextfollowup"  class="fpdatepicker2" id="nextfollow"  type="text"></td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">Title</td>
                            <td align="left" valign="top" width="75%"><input name="title" id="followuptitle" pattern=".{3,20}" title="3 to 20 characters max name allowed" type="text"></td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">Description</td>
                            <td align="left" valign="top" width="75%"><textarea name="fpdescription" maxlength="600" rows="4" id="descfollowup" cols="35"></textarea></td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">Status</td>
                            <td align="left" valign="top" width="75%">
                                <select name="fpstatus" id="followupstatus" class="select">
                                    <option value="Incomplete">Incomplete</option>
                                    <option value="complete">complete</option>
                                    <option value="In Progress">In Progress</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">&nbsp;</td>
                            <td align="left" valign="top" width="75%"><input type="submit" class="view3" value="Save" style="cursor: pointer" /></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
        <!--edit foloowup detail dialog end here!-->
    </body>
</html>
