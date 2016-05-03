<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewEstimate
    Created on : 30-Apr-2015, 12:34:12
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Estimate</title>
        <link href="css/csstable.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-1.10.2.min.js"></script>
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        <script>
            $(document).ready(function () {
                $("#dialogVoidDetail").hide();

                //popup code begin here
                $(".void_link").click(function (e) {
                    e.preventDefault();
                    $("#dialogVoidDetail").dialog({
                        modal: true,
                        effect: 'drop',
                        width: 600,
                        height: 375,
                        show: {
                            effect: "drop"
                        },
                        hide: {
                            effect: "drop"
                        }
                    });

                });
                //popup code end here!

                //form submit code begin here
                $("#voidform").submit(function (e) {
                    if (!confirm("Are you sure that you want to submit"))
                    {
                        e.preventDefault();

                        return;
                    }
                });
                //form submit code ends!! here



                //code for part total details begin here
                var sum = 0;
                $('.price').each(function () {
                    sum += parseFloat($(this).text());
                });
                var sum1 = 0;
                $('.labourcharges').each(function () {
                    sum1 += parseFloat($(this).text());
                });
                $('#labourrs').html(sum1)
                $('#partsrs').html(sum)
                var grand = sum + sum1;

                $('#grandamount').text(grand);
                //code for part total details ends here

                //code for service total details begin here
                var sum2 = 0;
                $('.labourchargesservice').each(function () {
                    sum2 += parseFloat($(this).text());
                });
                $('#servicelabourrs').html(sum2)

                $('#grandserviceamount').text(sum2);
                //code for service total details ends here

                //code for grand total begin here   
                var grandtotalend = Number(grand) + Number(sum2);
                $('#grandpartserviceamount').text(grandtotalend);
                //code for grand total ends! here
            });
        </script>
        <script>
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
        <a href="estimate" class="view">Back</a>&nbsp;<a href="#" class="view button-001" onclick="printContent('printdiv')">Print</a>&nbsp;<c:if test="${estcustdtls.approval=='No'}"><a class="void_link view" href="${param.estid}">Void </a>
        </c:if>



        <!--<a href="#" class="view" style="margin-right:10px;">Email</a>-->
        <h2>Estimate</h2>
        <br />
        <div id="printdiv">
            <table width="100%" cellpadding="5">
                <tr>
                    <td align="left" valign="top">Date</td>
                    <td align="left" valign="top">${estcustdtls.pcldate}</td>
                </tr>
                <tr>
                    <td align="left" valign="top">180 Point id</td>
                    <td align="left" valign="top">${estcustdtls.pclid} <input type="hidden" name="pclid" value="${estcustdtls.pclid}" /> </td>
                </tr>
                <tr>
                    <td width="31%" align="left" valign="top">Customer name</td>
                    <td width="69%" align="left" valign="top"><label for="textfield"></label>
                        ${estcustdtls.customername}</td>
                </tr>
                <tr>
                    <td align="left" valign="top">Vehicle Model</td>
                    <td align="left" valign="top">${estcustdtls.carmodel}</td>
                </tr>
                <tr>
                    <td>Vehicle Number</td>
                    <td>${estcustdtls.vehiclenumber}</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
            <hr>
            <!--table for part estimate view begin here-->
            <table id="dataTable" class="CSSTableGenerator" border="0">
                <tr>
                    <td align="left" width="6%"><strong>Sr.No.</strong></td>
                    <td align="left" width="31%"><strong>Name</strong></td>
                    <td align="left" width="37%"><strong>Description</strong></td>
                    <td align="left" width="37%"><strong>Qty.</strong></td>
                    <td align="center" width="14%"><strong>per item</strong></td>
                    <td align="center" width="12%"><strong>Labour Rs.</strong></td>
                    <td align="center" width="12%"><strong>Part Rs.</strong></td>
                </tr>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${estpartdtls}">
                    <tr>
                        <td align="center" valign="middle">${count}</td>
                        <td align="left" valign="top" ><span class="category-spacing">${ob.partname}</span></td>
                        <td align="left" valign="top">${ob.description}</td>
                        <td align="center" valign="middle" class="quantity">${ob.quantity}</td>
                        <td align="center" valign="middle" class="peritem">${ob.partrs}</td>
                        <td align="center" valign="middle" class="labourcharges">${ob.labourrs}</td>
                        <td align="center" valign="middle" class="price">${ob.totalpartrs}</td>
                    </tr>
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>
                <tr>
                    <td align="center" valign="middle">&nbsp;</td>
                    <td align="left" valign="top">&nbsp;</td>
                    <td align="left" valign="top">&nbsp;</td>
                    <td align="left" valign="top">&nbsp;</td>
                    <td align="left" valign="top">&nbsp;</td>
                    <td align="center" valign="middle" class="grandtotal"><strong> <label id="labourrs">  </label></strong></td>
                    <td align="center" valign="middle" class="grandtotallabour"><strong> <label id="partsrs"></label></strong></td>
                </tr>
                <!--            <tr>
                                <td align="center" valign="middle">&nbsp;</td>
                                <td align="left" valign="top">&nbsp;</td>
                                <td align="left" valign="top">&nbsp;</td>
                                <td align="left" valign="top">&nbsp;</td>
                                <td align="left" valign="top">&nbsp;</td>
                                <td align="center" valign="middle"><strong>Total</strong></td>
                                <td align="center" valign="middle"><strong><label id="grandamount"></label>/-</strong></td>
                            </tr>-->
                <tr>
                    <td align="center" valign="middle">&nbsp;</td>
                    <td align="left" valign="top">&nbsp;</td>
                    <td align="left" valign="top">&nbsp;</td>
                    <td align="left" valign="top">
                        <c:choose>
                            <c:when test="${empty estservicedtls}">
                                <strong>*Taxes extra as applicable. <c:forEach var="obva" begin="0" end="0" step="1" items="${vatDetails}">${obva.name} @ ${obva.percent}%</c:forEach></strong>
                            </c:when>
                            <c:otherwise>
                                <strong>&nbsp;</strong>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td align="left" valign="top">&nbsp;</td>
                    <td align="center" valign="middle">
                        <c:choose>
                            <c:when test="${empty estservicedtls}">
                                <strong>Grand Total</strong>
                            </c:when>
                            <c:otherwise>
                                <strong>Total</strong>
                            </c:otherwise>
                        </c:choose>                            
                    </td>
                    <td align="center" valign="middle"><strong><label id="grandamount"></label>/-</strong></td>
                    <td align="left" valign="top">&nbsp;</td>
                </tr>
            </table>
            <!--table for part estimate view ends! here-->
            <br>
            <br>
            <c:if test="${not empty estservicedtls}">
                <!--table for service estimate view begin here-->
                <table id="dataTable" class="CSSTableGenerator" border="0">
                    <tr>
                        <td align="left" width="6%"><strong>Sr.No.</strong></td>
                        <td align="left" width="31%"><strong>Service Name</strong></td>
                        <td align="left" width="37%"><strong>Description</strong></td>
                        <td align="center" width="12%"><strong>Labour Rs.</strong></td>
                    </tr>
                    <c:set value="1" var="count"></c:set>
                    <c:forEach var="ob" items="${estservicedtls}">
                        <tr>
                            <td align="center" valign="middle">${count}</td>
                            <td align="left" valign="top" ><span class="category-spacing">${ob.servicename}</span></td>
                            <td align="left" valign="top">${ob.description}</td>
                            <td align="center" valign="middle" class="labourchargesservice">${ob.labourrs}</td>
                        </tr>
                        <c:set value="${count+1}" var="count"></c:set>
                    </c:forEach>
                    <tr>
                        <td align="left" valign="top">&nbsp;</td>
                        <td align="left" valign="top">&nbsp;</td>
                        <td align="left" valign="top">&nbsp;</td>
                        <td align="center" valign="middle" class="grandtotal"><strong> <label id="servicelabourrs">  </label></strong></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">&nbsp;</td>
                        <td align="left" valign="top">&nbsp;</td>
                        <td align="center" valign="middle"><strong>Total</strong></td>
                        <td align="center" valign="middle"><strong><label id="grandserviceamount"></label>/-</strong></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">&nbsp;</td>
                        <td align="left" valign="top"><strong>*Taxes extra as applicable. <c:forEach var="obva" items="${vatDetails}">
                           ${obva.name} @ ${obva.percent}% </c:forEach> </strong></td>
                        <td align="center" valign="middle"><strong>Grand Total</strong></td>
                        <td align="center" valign="middle"><strong><label id="grandpartserviceamount"></label>/-</strong></td>
                    </tr>
                </table>
                <!--table for service estimate view ends! here-->
            </c:if>

            <!--edit void detail dialog begin here-->
            <div id="dialogVoidDetail" title="Void detail">
                <form method="POST" id="voidform" action="voidestimate">
                    <input type="hidden" name="id" value="${param.estid}" id="estimateid" />
                    <input type="hidden" name="pointchecklistid" value="${estcustdtls.pclid}" id="pointcheckList" />
                    <table cellpadding="5" width="100%">
                        <tbody>
                            <tr>
                                <td align="left" valign="top" width="25%">Reason</td>
                                <td align="left" valign="top" width="75%">
                                    <textarea name="reason" required="" maxlength="600" rows="15" cols="55">
                                    </textarea>
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
        </div>
        <!--edit  void detail dialog end here!-->
    </body>
</html>
