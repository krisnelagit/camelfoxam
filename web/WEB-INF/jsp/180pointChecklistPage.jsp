<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : 180pointChecklistPage
    Created on : 24-Apr-2015, 13:27:26
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>180point Checklist</title>
        <link rel="stylesheet" type="text/css" href="css/tablet-checkbox-button.css">  
        <link href="css/other_style.css" rel="stylesheet" type="text/css" />
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <link href="css/csstable.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        <script>
            $(document).ready(function () {
                $("#180pointchecklists").submit(function () {
                    var checkedAtLeastOne = false;
                    $('input[type="checkbox"]').each(function () {
                        if ($(this).is(":checked")) {
                            checkedAtLeastOne = true;
                        }
                    });

                    if (checkedAtLeastOne == false) {
                        alert("Atleast one item should be checked");
                        return checkedAtLeastOne;
                    }
                });
            });
        </script>
        <script>
            $(function () {
                $(".datepicker").datepicker({dateFormat: 'yy-mm-dd'});
                var currentDate = new Date();
                $(".datepicker").datepicker("setDate", currentDate);
            });

            $(function () {
                $("#accordion").accordion({
                    heightStyle: "content"
                });
            });
        </script>
    </head>
    <body>
        <c:choose>
            <c:when test="${param.isr=='Yes'}">
                <h2>180 Point Check-List already!! created for this Check list</h2>
            </c:when>
            <c:otherwise>
                <a href="service_checklist_grid.html" class="view">Back</a>
                <h2>180 Point Check-List</h2>

                <br />
                <form action="add180pointchecklist" id="180pointchecklists" method="post">
                    <input type="hidden" name="cvid" value="${param.cvid}" />

                    <table width="100%" cellpadding="5">

                        <tr>
                            <td align="left" valign="top">Date</td>
                            <td align="left" valign="top">
                                <input type="text" required="" name="date" class="datepicker" id="textfield2" />
                                <input type="hidden" name="customervehiclesid" value="${custdt.cvid}" />
                            </td>
                        </tr>

                        <tr>
                            <td align="left" valign="top">Service Checklist No.</td>
                            <td align="left" valign="top"><input name="servicechecklistid" type="text" readonly="" id="textfield8" value="${custdt.cvid}" /></td>
                        </tr>

                        <tr>
                            <td width="31%" align="left" valign="top">Vehicle No.</td>
                            <td width="69%" align="left" valign="top"><label for="textfield"></label>
                                <input type="text" name="textfield" id="textfield" readonly="" value="${custdt.vehiclenumber}" /></td>
                        </tr>

                        <tr>
                            <td width="31%" align="left" valign="top">Model</td>
                            <td width="69%" align="left" valign="top"><label for="textfield"></label>
                                <input type="text" value="${custdt.carmodel}" readonly="" name="textfield" id="textfield" /></td>
                        </tr>

                        <tr>
                            <td width="31%" align="left" valign="top">KM. in</td>
                            <td width="69%" align="left" valign="top">
                                <label for="textfield">${custdt.km_in}</label>
                            </td>
                        </tr>

                        <tr>
                            <td width="31%" align="left" valign="top">Fuel Level</td>
                            <td width="69%" align="left" valign="top">
                                <label for="textfield">${custdt.fuellevel}</label>
                            </td>
                        </tr>

                        <tr>
                            <td width="31%" align="left" valign="top">Additional Work(comments).</td>
                            <td width="69%" align="left" valign="top">
                                <label for="textfield">${custdt.additionalwork}</label>
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
                                    <c:forEach var="nii" items="${ni.listofcpv}" varStatus="loop">
                                        <c:if test="${not loop.first and loop.index % 2 == 0}">
                                        </tr><tr>
                                    </c:if>
                                    <td width="26%" align="left" valign="top">
                                        <label for="textfield"></label>      
                                        <div id="ck-button">
                                            <label>
                                                <input type="checkbox" value="1" name="carpartvaultchecks" value="${nii.categoryname[0].cpiid}"><span>${nii.categoryname[0].partname}</span>
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
                <input type="submit" value="Save" class="view3" style="cursor: pointer" />
            </center>  
        </form>
    </c:otherwise>
</c:choose>

<br />
<br />
<br />

</body>
</html>
