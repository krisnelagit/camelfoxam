<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewFollowUpDetails
    Created on : 19-May-2015, 18:10:10
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View FollowUp Details</title>
    </head>
    <body>
        <a href="followupgridlink" class="view">Back</a>
        <h2>Follow up details</h2>
        <br>
        <br>
            <input type="hidden" name="" value="${followupdt.id}" />
            <table cellpadding="5" width="100%">
                <tbody>
                    <tr>
                        <td align="left" valign="top" width="13%">Followed by</td>
                        <td align="left" valign="top" width="28%">
                            ${followupdt.followedby}
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" width="8%">Last Follow up</td>
                        <td align="left" valign="top" width="51%">${followupdt.lastfollowup}</td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Next Follow up</td>
                        <td align="left" valign="top">${followupdt.nextfollowup}</td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Title</td>
                        <td align="left" valign="top">${followupdt.title}</td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Description</td>
                        <td align="left" valign="top">${followupdt.fpdescription}</td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">Status</td>
                        <td align="left" valign="top">
                            ${followupdt.fpstatus}
                        </td>
                    </tr>
                </tbody>
            </table>
            <center>
                <a href="editFollowupDetailsLink?followupid=${followupdt.id}" class="view">Edit</a> &nbsp;&nbsp;
            </center>
    </body>
</html>
