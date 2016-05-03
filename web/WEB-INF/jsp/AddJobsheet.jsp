<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : AddJobsheet
    Created on : 02-May-2015, 15:48:34
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Jobsheet</title>
        <link href="css/csstable.css" rel="stylesheet" type="text/css" />
        <script>
            $(document).ready(function () {
                $(".workmanid").change(function () {
                    var className = $(this).closest('tr').find('#estimate').attr('class');
                    var workman = $(this).val();
                    $(this).closest('tr').find('#estimate').removeClass();
                    $(this).closest('tr').find('#estimate').addClass(workman);
                    $(this).closest('tr').find('.allworkmanids').val(workman);
                });
            });

            function iambatman(b) {
                var MyArray = [];
                var alwmids = $('.allworkmanids');

                alwmids.each(function () {
                    MyArray.push($(".allworkmanids").val());
                });


                var unique = MyArray.filter(function (itm, i, MyArray) {
                    return i == MyArray.indexOf(itm);
                });

                var workmanidarray = unique.split(',');
                for (var a = 0; a < workmanidarray.length; a++) {

                }
            }
        </script>
    </head>
    <body>
        <a href="estimate" class="view">Back</a>
        <!--<a href="#" class="view" style="margin-right:10px;">Email</a>-->

        <c:choose>
            <c:when test="${param.jsre=='Yes'}">
                <h2>Jobsheet is already created for this estimate</h2>
            </c:when>
            <c:otherwise>

                <h2>Jobsheet</h2>
                <br />
                <form action="saveWorkman" method="POST">
                    <input type="hidden" name="myestimateid" value="${param.estid}" />
                    <input type="hidden" name="cvid" value="${estuserdtls.cvid}" />
                    <table width="100%" cellpadding="5">
                        <tr>
                            <td align="left" valign="top">Date</td>
                            <td align="left" valign="top">${estuserdtls.custdate}</td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">Estimate No.</td>
                            <td align="left" valign="top">${estuserdtls.estid} <input type="hidden" name="estimateid" value="${estuserdtls.estid}" /> </td>
                        </tr>
                        <tr>
                            <td width="31%" align="left" valign="top">Customer name</td>
                            <td width="69%" align="left" valign="top"><label for="textfield"></label>
                                ${estuserdtls.custname}</td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">Vehicle Make</td>
                            <td align="left" valign="top">${estuserdtls.carbrand}</td>
                        </tr>
                        <tr>
                            <td>License Number</td>
                            <td>${estuserdtls.licensenumber}</td>
                        </tr>
                        <tr>
                            <td>VIN No.</td>
                            <td>${estuserdtls.vinnumber}</td>
                        </tr>
                        <tr>
                            <td>Additional work</td>
                            <td>
                                <c:choose>
                                    <c:when test="${empty estuserdtls.additionalwork}">
                                        N/A
                                    </c:when>
                                    <c:otherwise>
                                        ${estuserdtls.additionalwork}                                        
                                    </c:otherwise>
                                </c:choose>  
                            </td>
                        </tr>
                    </table>

                    <br>
                    <!--table for part workman job sheet begin here--> 
                    <table id="dataTable" class="CSSTableGenerator" border="0">
                        <tr>
                            <td align="left" width="6%"><strong>Sr.No.</strong></td>
                            <td align="left" width="31%"><strong>Name</strong></td>
                            <td align="left" width="37%"><strong>Description</strong></td>
                            <td align="left" width="37%"><strong>Qty.</strong></td>
                            <td align="center" width="14%"><strong>Assign Workman</strong></td>
                            <td align="center" width="12%"><strong>Est Time(min.)</strong></td>
                        </tr>
                        <c:set value="1" var="count"></c:set>
                        <c:forEach var="ob" items="${approvedpartdtls}">
                            <tr>
                                <td align="center" valign="middle">${count}</td>
                                <td align="left" valign="top" ><span class="category-spacing">${ob.partname} <input type="hidden" name="estdid" value="${ob.estdid}" /></span></td>
                                <td align="left" valign="top">${ob.description}</td>
                                <td align="left" valign="top">${ob.quantity}</td>
                                <td align="left" valign="top"> 
                                    <input type="hidden" name="typeofpart" value="${ob.item_type}" />
                                    <select name="workmen" required="" class="workmanid">
                                        <option value="">--select--</option>
                                        <c:forEach var="obb" items="${workmandt}">
                                            <option value="${obb.id}">${obb.name}</option>
                                        </c:forEach>
                                    </select> 
                                </td>
                                <td align="center" valign="middle" class="labourcharges"><input type="number" min="0" id="estimate" onchange="iambatman(this)" name="estimatedtime" value="" /><input type="hidden" class="allworkmanids" name="" value="" /></td>
                            </tr>
                            <c:set value="${count+1}" var="count"></c:set>
                        </c:forEach>
                    </table>
                    <!--table for part workman job sheet ends here--> 
                    <br>
                    <!--table for service workman job sheet begin here--> 
                    <c:if test="${not empty approvedservicedtls}">
                        <h2>Services</h2>
                        <br />
                        <table id="dataTable" class="CSSTableGenerator" border="0">
                            <tr>
                                <td align="left" width="6%"><strong>Sr.No.</strong></td>
                                <td align="left" width="31%"><strong>Name</strong></td>
                                <td align="left" width="37%"><strong>Description</strong></td>
                                <td align="center" width="14%"><strong>Assign Workman</strong></td>
                                <td align="center" width="12%"><strong>Est Time</strong></td>
                            </tr>
                            <c:set value="1" var="count"></c:set>
                            <c:forEach var="ob" items="${approvedservicedtls}">
                                <tr>
                                    <td align="center" valign="middle">${count}</td>
                                    <td align="left" valign="top" ><span class="category-spacing">${ob.servicename} <input type="hidden" name="estdid" value="${ob.estdid}" /></span></td>
                                    <td align="left" valign="top">${ob.description}</td>
                                    <td align="left" valign="top"> 
                                        <input type="hidden" name="typeofpart" value="${ob.item_type}" />
                                        <select name="workmen" required="" class="workmanid">
                                            <option value="">--select--</option>
                                            <c:forEach var="obb" items="${workmandt}">
                                                <option value="${obb.id}">${obb.name}</option>
                                            </c:forEach>
                                        </select> 
                                    </td>
                                    <td align="center" valign="middle" class="labourcharges"><input type="number" required="" min="0" id="estimate" onchange="iambatman(this)" name="estimatedtime" value="" /><input type="hidden" class="allworkmanids" name="" value="" /></td>
                                </tr>
                                <c:set value="${count+1}" var="count"></c:set>
                            </c:forEach>
                        </table>
                    </c:if>
                    <!--table for part workman job sheet ends here--> 
                    <center> 
                        <input type="submit" class="view3" style="cursor: pointer" value="Save" />&nbsp;&nbsp;&nbsp;
                    </center>
                </form>
            </c:otherwise>
        </c:choose>
    </body>
</html>
