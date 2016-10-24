<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%-- 
    Document   : Edit180pointChecklistPage
    Created on : 25-Apr-2015, 15:33:52
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit 180point Checklist</title>
        <link rel="stylesheet" type="text/css" href="css/tablet-checkbox-button.css">
        <link href="css/other_style.css" rel="stylesheet" type="text/css" />
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <link href="css/csstable.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        <script>
            $(function () {
                $(".datepicker").datepicker({dateFormat: 'yy-mm-dd'});
            });

            $(function () {
                $("#accordion").accordion({
                    heightStyle: "content"
                });
            });
        </script>
    </head>
    <body>
        <a href="180pointchecklistgridlink" class="view">Back</a>
        <h2>180 Point  Check-List Edit</h2>
        <br />
        <form action="update180pointchecklist" method="post">

            <table width="100%" cellpadding="5">

                <tr>
                    <td align="left" valign="top">Date</td>
                    <td align="left" valign="top">
                        <input type="text" value="${pcldt.pcldate}" name="date" class="datepicker" id="textfield2" />
                        <input type="hidden" name="pointchecklistid" value="${pcldt.id}" />
                    </td>
                </tr>
                <tr>
                    <td align="left" valign="top">Service Checklist No.</td>
                    <td align="left" valign="top"><input name="servicechecklistid" type="text" readonly="" id="textfield8" value="${pcldt.customervehiclesid}" /></td>
                </tr>
                <tr>
                    <td width="31%" align="left" valign="top">Vehicle No.</td>
                    <td width="69%" align="left" valign="top"><label for="textfield"></label>
                        <input type="text" name="textfield" id="textfield" readonly="" value="${pcldt.vehiclenumber}" /></td>
                </tr>
                <tr>
                    <td width="31%" align="left" valign="top">Model</td>
                    <td width="69%" align="left" valign="top"><label for="textfield"></label>
                        <input type="text" value="${pcldt.carmodel}" readonly="" name="textfield" id="textfield" /></td>
                </tr>

                <tr>
                    <td width="31%" align="left" valign="top">KM. in</td>
                    <td width="69%" align="left" valign="top">
                        <label for="textfield">${pcldt.km_in}</label>
                    </td>
                </tr>

                <tr>
                    <td width="31%" align="left" valign="top">Fuel Level</td>
                    <td width="69%" align="left" valign="top">
                        <label for="textfield">${pcldt.fuellevel}</label>
                    </td>
                </tr>

                <tr>
                    <td width="31%" align="left" valign="top">Additional Work(comments).</td>
                    <td width="69%" align="left" valign="top">
                        <label for="textfield">${pcldt.additionalwork}</label>
                    </td>
                </tr>
            </table>
            <br />
            <hr/>
            <br />
            <div id="accordion">
                <c:forEach var="ni" items="${allpartdetails}">
                    <h3>${ni.categoryname}</h3>
                    <div>
                        <table width="100%" cellpadding="5">
                            <c:forEach var="nii" items="${ni.notmatchpartlist}" varStatus="loop">
                                <c:if test="${not loop.first and loop.index % 2 == 0}">
                                    <tr>
                                    </c:if>
                                    <td width="26%" align="left" valign="top">
                                        <label for="textfield"></label>     
                                        <div id="ck-button">
                                            <label>
                                                <input type="checkbox" name="carpartvaultchecks" value="${nii.id}"><span>${nii.name}</span>
                                            </label>
                                        </div> 
                                    </td>
                                </c:forEach>
                            </tr>
                            <c:forEach var="nii" items="${ni.matchpartlist}" varStatus="loop">
                                <c:if test="${not loop.first and loop.index % 2 == 0}">
                                    <tr>
                                    </c:if>
                                    <td width="26%" align="left" valign="top">
                                        <label for="textfield"></label>
                                        <div id="ck-button">
                                            <label>
                                                <input type="checkbox" checked="" name="carpartvaultchecks" value="${nii.id}"><span>${nii.name}</span>
                                            </label>
                                        </div>
                                    </td>
                                </c:forEach>
                        </table>
                    </div>
                </c:forEach>                     
            </div>
            <br />
            <center>
                <input type="submit" value="Update" class="save_butn" />&nbsp;&nbsp;&nbsp;
                <!--                <a href="60_point_checklist_grid.html"><INPUT type="button" value="Save" class="save_butn"/></a>&nbsp;&nbsp;&nbsp;
                                <a href="60_point_checklist_grid.html"><INPUT type="button" value="Delete" class="save_butn"/></a>&nbsp;&nbsp;&nbsp;
                                <a href="estimate-edit-service-checklist.html"><INPUT type="button" value="Save & Create Estimate" class="save_butn"/></a>-->
            </center>  
        </form>

        <br />
        <br />
        <br />
    </div>
</div>


</body>
</html>
