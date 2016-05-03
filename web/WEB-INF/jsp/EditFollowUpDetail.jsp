<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : EditFollowUpDetail
    Created on : 19-May-2015, 18:33:44
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit FollowUp Detail</title>
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />        
        <script src="js/jquery-ui.js"></script>
        <script>
            $(document).ready(function () {
                $(function () {
                    $("#fpdatepicker").datepicker({dateFormat: 'yy-mm-dd'});
                    $("#fpdatepicker").datepicker("option", "showAnim", 'drop');
                });

                $(function () {
                    $("#fpdatepicker2").datepicker({dateFormat: 'yy-mm-dd'});
                    $("#fpdatepicker2").datepicker("option", "showAnim", 'drop');
                });
            });
        </script>
    </head>
    <body>
        <form action="updateFollowUp" method="POST">
            <input type="hidden" name="enquirieid" value="${editFollowupdt.enquirieid}" />
            <input type="hidden" name="id" value="${editFollowupdt.id}" />
            <h2>Lead Details</h2>
            <br>
            <br>
            <table cellpadding="5" width="100%">
                <tbody>
                    <tr>
                        <td align="left" valign="top" width="13%">Followed by</td>
                        <td align="left" valign="top" width="28%">
                            <input name="followedby" value="${editFollowupdt.followedby}" id="datepicker1" id="textfield2" type="text">
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" width="8%">Last Follow up</td>
                        <td align="left" valign="top" width="51%"><input name="lastfollowup" value="${editFollowupdt.lastfollowup}" id="fpdatepicker"  type="text"></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Next Follow up</td>
                        <td align="left" valign="top"><input name="nextfollowup" value="${editFollowupdt.nextfollowup}" id="fpdatepicker2"  type="text"></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Title</td>
                        <td align="left" valign="top"><input name="title" value="${editFollowupdt.title}" id="textfield3" type="text"></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Description</td>
                        <td align="left" valign="top"><input name="fpdescription" value="${editFollowupdt.fpdescription}" id="textfield3" type="text"></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Status</td>
                        <td align="left" valign="top">
                            <select name="fpstatus" class="select">
                                <c:choose>
                                    <c:when test="${editFollowupdt.fpstatus=='Incomplete'}">
                                        <option selected="">Incomplete</option>
                                        <option>complete</option>
                                        <option>In Progress</option>
                                    </c:when>
                                    <c:when test="${editFollowupdt.fpstatus=='complete'}">
                                        <option>Incomplete</option>
                                        <option selected="">complete</option>
                                        <option>In Progress</option>
                                    </c:when>
                                    <c:when test="${editFollowupdt.fpstatus=='In Progress'}">
                                        <option>Incomplete</option>
                                        <option>complete</option>
                                        <option selected="">In Progress</option>
                                    </c:when>
                                </c:choose>


                            </select>
                        </td>
                    </tr>
                </tbody>
            </table>
            <center>
                <input type="submit" class="view2" value="Update" /> &nbsp;&nbsp;
            </center>
        </form>
    </body>
</html>
