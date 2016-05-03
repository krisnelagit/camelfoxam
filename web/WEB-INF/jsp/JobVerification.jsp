<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : JobVerification
    Created on : 02-May-2015, 17:00:57
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Job Verification</title>
        <link href="css/csstable.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <a href="viewJobsheetVerificationGridLink" class="view">Back</a>
        <!--<a href="#" class="view" style="margin-right:10px;">Email</a>-->
        <h2>Job Verification</h2>
        <br />
        <form action="insertverification" method="POST">
            <table width="100%" cellpadding="5">
                <tr>
                    <td align="left" valign="top">Date</td>
                    <td align="left" valign="top">${jsuserdtls.custdate}</td>
                </tr>
                <tr>
                    <td align="left" valign="top">Job No.</td>
                    <td align="left" valign="top">${jsuserdtls.jobno} <input type="hidden" name="jobno" value="${jsuserdtls.jobno}" /> </td>
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
                    <td>KM. in</td>
                    <td>
                        <c:choose>
                            <c:when test="${jsuserdtls.km_in==''}">
                                N/A
                            </c:when>
                            <c:otherwise>
                                ${jsuserdtls.km_in}
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <td>KM. out</td>
                    <td><input type="text" name="km_out" value="${jsuserdtls.km_out}" /></td>
                </tr>
            </table>
            <br>
            <hr>
            <h2>Car parts</h2>
            <br />
            <table id="dataTable" class="CSSTableGenerator" border="0">
                <tr>
                    <td align="left" width="6%"><strong>Sr.No.</strong></td>
                    <td align="left" width="31%"><strong>Name</strong></td>
                    <td align="left" width="37%"><strong>Description</strong></td>
                    <td align="center" width="14%"><strong>Assign Workman</strong></td>
                    <td align="center" width="14%"><strong>Estimate Time(minutes)</strong></td>
                    <td align="center" width="14%"><strong>Status</strong></td>
                </tr>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${jobdtls}">
                    <tr>
                        <td align="center" valign="middle">${count}</td>
                        <td align="left" valign="top" ><span class="category-spacing">${ob.partname} <input type="hidden" name="jsdid" value="${ob.jsdid}" /></span></td>
                        <td align="left" valign="top">${ob.description}</td>
                        <td align="left" valign="top">${ob.workmanname}</td>
                        <td align="left" valign="top">${ob.estimatetime}</td>
                        <td align="left" valign="top">
                            <c:choose>
                                <c:when test="${ob.verified=='Yes'}">
                                    verified
                                </c:when>
                                <c:otherwise>
                                    <input type="checkbox" name="verifiedids" value="${ob.jsdid}">
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>
            </table>  
            <c:if test="${not empty jobservicedtls}">
                <h2>Services</h2>
                <br />
                <table id="dataTable" class="CSSTableGenerator" border="0">
                    <tr>
                        <td align="left" width="6%"><strong>Sr.No.</strong></td>
                        <td align="left" width="31%"><strong>Name</strong></td>
                        <td align="left" width="37%"><strong>Description</strong></td>
                        <td align="center" width="14%"><strong>Assign Workman</strong></td>
                        <td align="center" width="14%"><strong>Estimate Time(minutes)</strong></td>
                        <td align="center" width="14%"><strong>Status</strong></td>
                    </tr>
                    <c:set value="1" var="count"></c:set>
                    <c:forEach var="ob" items="${jobservicedtls}">
                        <tr>
                            <td align="center" valign="middle">${count}</td>
                            <td align="left" valign="top" ><span class="category-spacing">${ob.servicename} <input type="hidden" name="jsdid" value="${ob.jsdid}" /></span></td>
                            <td align="left" valign="top">${ob.description}</td>
                            <td align="left" valign="top">${ob.workmanname}</td>
                            <td align="left" valign="top">${ob.estimatetime}</td>
                            <td align="left" valign="top">
                                <c:choose>
                                    <c:when test="${ob.verified=='Yes'}">
                                        verified
                                    </c:when>
                                    <c:otherwise>
                                        <input type="checkbox" name="verifiedids" value="${ob.jsdid}">
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <c:set value="${count+1}" var="count"></c:set>
                    </c:forEach>
                </table> 
            </c:if>
            <BR>
            <h2>Cleaning list</h2>
            <br />
            <HR>
            <table cellpadding="5" width="100%">
                <tbody>
                    <tr>
                        <td align="left" valign="top" width="40%">Car Washing</td>
                        <td align="left" valign="top" width="60%">
                            <c:choose>
                                <c:when test="${jsuserdtls.car_washing=='done'}">
                                    <input type="radio" name="car_washing" class="car_washing" checked="" value="done">done<br>
                                    <input type="radio" name="car_washing" class="car_washing" value="not done">not done
                                </c:when>
                                <c:otherwise>
                                    <input type="radio" name="car_washing" class="car_washing" value="done">done<br>
                                    <input type="radio" name="car_washing" class="car_washing" checked="" value="not done">not done
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" width="40%">Car Vacuuming</td>
                        <td align="left" valign="top" width="60%">
                            <c:choose>
                                <c:when test="${jsuserdtls.car_vacuuming=='done'}">
                                    <input type="radio" name="car_vacuuming" class="car_vacuuming" checked=""  value="done">done<br>
                                    <input type="radio" name="car_vacuuming" class="car_vacuuming" value="not done">not done
                                </c:when>
                                <c:otherwise>
                                    <input type="radio" name="car_vacuuming" class="car_vacuuming" value="done">done<br>
                                    <input type="radio" name="car_vacuuming" class="car_vacuuming" checked="" value="not done">not done
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" width="40%">Tyre Polish</td>
                        <td align="left" valign="top" width="60%">
                            <c:choose>
                                <c:when test="${jsuserdtls.tyre_polish=='done'}">
                                    <input type="radio" name="tyre_polish" class="tyre_polish" checked="" value="done">done<br>
                                    <input type="radio" name="tyre_polish" class="tyre_polish" value="not done">not done
                                </c:when>
                                <c:otherwise>
                                    <input type="radio" name="tyre_polish" class="tyre_polish" value="done">done<br>
                                    <input type="radio" name="tyre_polish" class="tyre_polish" checked="" value="not done">not done
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" width="40%">Dashboard Polish</td>
                        <td align="left" valign="top" width="60%">
                            <c:choose>
                                <c:when test="${jsuserdtls.dashboard_polish=='done'}">
                                    <input type="radio" name="dashboard_polish" class="dashboard_polish" checked="" value="done">done<br>
                                    <input type="radio" name="dashboard_polish" class="dashboard_polish" value="not done">not done
                                </c:when>
                                <c:otherwise>
                                    <input type="radio" name="dashboard_polish" class="dashboard_polish" value="done">done<br>
                                    <input type="radio" name="dashboard_polish" class="dashboard_polish" checked="" value="not done">not done
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" width="40%">Engine Cleaning</td>
                        <td align="left" valign="top" width="60%">
                            <c:choose>
                                <c:when test="${jsuserdtls.engine_cleaning=='done'}">
                                    <input type="radio" name="engine_cleaning" class="engine_cleaning" checked="" value="done">done<br>
                                    <input type="radio" name="engine_cleaning" class="engine_cleaning" value="not done">not done
                                </c:when>
                                <c:otherwise>
                                    <input type="radio" name="engine_cleaning" class="engine_cleaning" value="done">done<br>
                                    <input type="radio" name="engine_cleaning" class="engine_cleaning" checked="" value="not done">not done
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" width="40%">Underchassis Cleaning</td>
                        <td align="left" valign="top" width="60%">
                            <c:choose>
                                <c:when test="${jsuserdtls.underchasis_cleaning=='done'}">
                                    <input type="radio" name="underchasis_cleaning" checked="" class="underchasis_cleaning" value="done">done<br>
                                    <input type="radio" name="underchasis_cleaning" class="underchasis_cleaning" value="not done">not done
                                </c:when>
                                <c:otherwise>
                                    <input type="radio" name="underchasis_cleaning" class="underchasis_cleaning" value="done">done<br>
                                    <input type="radio" name="underchasis_cleaning" checked="" class="underchasis_cleaning" value="not done">not done
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" width="40%">Trunk & Spare wheel Cleaning</td>
                        <td align="left" valign="top" width="60%">
                            <c:choose>
                                <c:when test="${jsuserdtls.trunk_cleaning=='done'}">
                                    <input type="radio" name="trunk_cleaning" class="trunk_cleaning" checked="" value="done">done<br>
                                    <input type="radio" name="trunk_cleaning" class="trunk_cleaning" value="not done">not done
                                </c:when>
                                <c:otherwise>
                                    <input type="radio" name="trunk_cleaning" class="trunk_cleaning" value="done">done<br>
                                    <input type="radio" name="trunk_cleaning" class="trunk_cleaning" checked="" value="not done">not done
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </tbody>
            </table>

            <%--<c:choose>
                <c:when test="${jsuserdtls.istaskcompleted=='Yes'}">--%>
                    <c:choose>
                        <c:when test="${jsuserdtls.verified=='No' || jsuserdtls.cleaning=='not done' || jsuserdtls.car_washing=='not done' || jsuserdtls.car_vacuuming=='not done' || jsuserdtls.tyre_polish=='not done' || jsuserdtls.dashboard_polish=='not done' || jsuserdtls.engine_cleaning=='not done' || jsuserdtls.underchasis_cleaning=='not done' || jsuserdtls.trunk_cleaning=='not done'}">
                            <center>
                                <input type="submit" class="view3" style="cursor: pointer" value="Save" />&nbsp;&nbsp;&nbsp;
                            </center>
                        </c:when>
                        <c:when test="${jsuserdtls.verified=='Yes' && jsuserdtls.cleaning=='done' && jsuserdtls.car_washing=='done' && jsuserdtls.car_vacuuming=='done' && jsuserdtls.tyre_polish=='done' && jsuserdtls.dashboard_polish=='done' && jsuserdtls.engine_cleaning=='done' && jsuserdtls.underchasis_cleaning=='done' && jsuserdtls.trunk_cleaning=='done'}">
                            <center>        
                                <h2>This Jobsheet is verified</h2>
                            </center>
                        </c:when>
                    </c:choose>
                <%--</c:when>
                <c:when test="${jsuserdtls.istaskcompleted=='No'}">
                    <center>        
                        <h2>Tasks are yet to be completed.</h2>
                    </center>
                </c:when>
            </c:choose>--%>


        </form>
    </body>
</html>
